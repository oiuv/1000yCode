program gate;

uses
  Forms,
  FMain in 'FMain.pas' {frmMain},
  uConnector in 'uConnector.pas',
  uBuffer in '..\Common\uBuffer.pas',
  uUtil in '..\Common\uUtil.pas',
  uLGRecordDef in '..\Common\uLGRecordDef.pas',
  uDBRecordDef in '..\Common\uDBRecordDef.pas',
  uPackets in '..\Common\uPackets.pas',
  uEasyList in '..\Common\uEasyList.pas',
  uCrypt in '..\Common\uCrypt.pas',
  uKeyClass in '..\Common\uKeyClass.pas',
  deftype in '..\1000ydef\deftype.pas',
  Common in '..\Common\Common.pas',
  uCharCheck in '..\Common\uCharCheck.pas',
  AUtil32 in '..\1000ydef\AUtil32.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
