program login;

uses
  Forms,
  FMain in 'FMain.pas' {frmMain},
  uConnector in 'uConnector.pas',
  uBuffer in '..\Common\uBuffer.pas',
  uUtil in '..\Common\uUtil.pas',
  uPackets in '..\Common\uPackets.pas',
  uCrypt in '..\Common\uCrypt.pas',
  uEasyList in '..\Common\uEasyList.pas',
  uKeyClass in '..\Common\uKeyClass.pas',
  deftype in '..\1000ydef\deftype.pas',
  //uEmaildata in '..\tgs1000\uEmaildata.pas',
  uDBFile in 'uDBFile.pas',
  uDBAdapter in 'uDBAdapter.pas',
  frmLogin in 'frmLogin.pas' {FormLogin},
  AUtil32 in '..\1000ydef\AUtil32.pas';

{$R *.RES}

begin
    Application.Initialize;
    Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

