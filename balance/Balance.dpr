program Balance;

uses
  Forms,
  FMain in 'FMain.pas' {frmMain},
  uUtil in '..\Common\uUtil.pas',
  uBuffer in '..\Common\uBuffer.pas',
  uCrypt in '..\Common\uCrypt.pas',
  uPackets in '..\Common\uPackets.pas',
  deftype in '..\1000ydef\deftype.pas',
  uConnect in 'uConnect.pas',
  uGateConnector in 'uGateConnector.pas',
  AUtil32 in '..\1000ydef\AUtil32.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
