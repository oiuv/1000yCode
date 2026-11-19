[CmdletBinding()]
param(
    [string]$Project = 'all',
    [string]$CompilerPath,
    [string]$OutputRoot,
    [switch]$Help
)

$ErrorActionPreference = 'Stop'
if (-not $OutputRoot) { $OutputRoot = Join-Path $PSScriptRoot 'build-output' }
$projects = [ordered]@{
    balance = 'balance/Balance.dpr'
    gate = 'gate/gate.dpr'
    login = 'login/login.dpr'
    db = 'db/db.dpr'
    tgs = 'tgs1000/tgs1000.dpr'
    client = 'client/Client.dpr'
}
$sourceDirectories = @('Common', '1000ydef', 'Lib')
$clientDirectories = @('client/ZLibEx', 'client/Lib/ALib', 'client/Lib/DirectX', 'client/Lib/undelphix/Source')
$buildFiles = @('*.pas', '*.dpr', '*.dcu', '*.dcp', '*.inc', '*.dfm', '*.res', '*.obj', '*.cfg', '*.rc', '*.dcr', '*.def')

if ($Help) {
    Write-Host 'Usage: build_all.bat [-Project NAME] [-CompilerPath DCC32.EXE] [-OutputRoot PATH] [-Help]'
    Write-Host ("Projects: all, " + ($projects.Keys -join ', '))
    Write-Host 'Requires Delphi 7 and Windows PowerShell. Outputs: build-output/<run>/<project>.'
    Write-Host 'Client controls are included in client/Lib.'
    exit 0
}
if ($Project -eq 'all') {
    $requested = $projects.Keys
} elseif ($projects.Contains($Project)) {
    $requested = @($Project)
} else {
    throw "Unknown project '$Project'. Run build_all.bat -Help."
}

function Copy-BuildFiles {
    param([string]$Source, [string]$Destination)
    $arguments = @($Source, $Destination) + $buildFiles + @(
        '/E', '/XJ', '/R:0', '/W:0', '/NFL', '/NDL', '/NJH', '/NJS', '/NP', '/XD',
        '.git', '__history', 'Demos', 'Samples', 'Examples', 'build-output'
    )
    $copyReport = & robocopy.exe @arguments
    if ($LASTEXITCODE -ge 8) {
        throw "Could not copy '$Source'.`n$($copyReport -join [Environment]::NewLine)"
    }
}

if (-not $CompilerPath) {
    $compilerCommand = Get-Command DCC32.EXE -CommandType Application -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if ($compilerCommand) {
        $CompilerPath = $compilerCommand.Source
    } else {
        $CompilerPath = Join-Path ${env:ProgramFiles(x86)} 'Borland/Delphi7/Bin/DCC32.EXE'
    }
}
$compiler = (Get-Item -LiteralPath $CompilerPath -ErrorAction Stop).FullName
$delphiLib = Join-Path (Split-Path -Parent (Split-Path -Parent $compiler)) 'lib'
$codePage = [Text.Encoding]::GetEncoding(936)
$runID = [guid]::NewGuid().ToString('N').Substring(0, 8)
$runName = "$(Get-Date -Format 'yyyyMMdd-HHmmss')-$runID"
$tempRoot = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
$stage = [IO.Path]::GetFullPath((Join-Path $tempRoot "1000y-build-$runID"))
$runOutput = Join-Path $OutputRoot $runName
$runOutput = (New-Item -ItemType Directory -Path $runOutput -Force).FullName
New-Item -ItemType Directory -Path $stage -ErrorAction Stop | Out-Null

try {
    Copy-BuildFiles $PSScriptRoot $stage
    $failures = @()
    foreach ($name in $requested) {
        $directories = $sourceDirectories
        if ($name -eq 'client') { $directories += $clientDirectories }
        $inputs = $directories | ForEach-Object { Join-Path $stage $_ } |
            Where-Object { Test-Path -LiteralPath $_ -PathType Container }
        $resourcePath = $inputs -join ';'
        $unitPath = (@($inputs) + @($delphiLib, (Join-Path $delphiLib 'Obj'))) -join ';'
        $projectFile = Get-Item -LiteralPath (Join-Path $stage $projects[$name])
        $output = (New-Item -ItemType Directory -Path (Join-Path $runOutput $name)).FullName
        $dcu = (New-Item -ItemType Directory -Path (Join-Path $stage "compiled/$name") -Force).FullName
        $config = [IO.Path]::ChangeExtension($projectFile.FullName, 'cfg')
        if (Test-Path -LiteralPath $config) {
            # Preserve defines and compiler settings. Replace machine-specific paths.
            $settings = [IO.File]::ReadAllLines($config, $codePage) | Where-Object {
                $_ -match '^\s*-(\$|A|D|C[CG]|H|W|K)'
            }
            [IO.File]::WriteAllLines($config, [string[]]$settings, $codePage)
        }
        $info = New-Object Diagnostics.ProcessStartInfo
        $info.FileName = $compiler
        $info.WorkingDirectory = $projectFile.DirectoryName
        $info.Arguments = '-Q -B -U"{0}" -R"{1}" -I"{1}" -O"{1}" -E"{2}" -N"{3}" "{4}"' -f (
            "$($projectFile.DirectoryName);$unitPath"), $resourcePath, $output, $dcu, $projectFile.Name
        $info.UseShellExecute = $false
        $info.RedirectStandardOutput = $true
        $info.RedirectStandardError = $true
        $info.StandardOutputEncoding = $codePage
        $info.StandardErrorEncoding = $codePage

        $process = [Diagnostics.Process]::Start($info)
        try {
            $stdout = $process.StandardOutput.ReadToEndAsync()
            $stderr = $process.StandardError.ReadToEndAsync()
            $process.WaitForExit()
            $status = $process.ExitCode
            $log = $stdout.GetAwaiter().GetResult() + $stderr.GetAwaiter().GetResult()
        } finally {
            $process.Dispose()
        }
        $logPath = Join-Path $output 'build.log'
        $log | Set-Content -LiteralPath $logPath -Encoding UTF8
        $exe = Join-Path $output ($projectFile.BaseName + '.exe')
        if ($status -eq 0 -and (Test-Path -LiteralPath $exe -PathType Leaf)) {
            Write-Host "[OK] $name $exe"
        } else {
            $failures += $name
            Write-Host "[FAIL] $name ($status). $logPath"
            $log -split '\r?\n' | Where-Object { $_ -match '\b(Error|Fatal):' } | Select-Object -Last 5
        }
    }

    Write-Host "Build output: $runOutput"
    if ($failures.Count -gt 0) {
        Write-Host ("Failed: " + ($failures -join ', '))
        exit 1
    }
} finally {
    if ((Split-Path -Leaf $stage) -eq "1000y-build-$runID" -and
        (Split-Path -Parent $stage).TrimEnd('\') -eq $tempRoot.TrimEnd('\')) {
        Remove-Item -LiteralPath $stage -Recurse -Force -ErrorAction SilentlyContinue
    }
}
