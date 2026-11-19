program db;

uses
  Forms,
  FMain in 'FMain.pas' {frmMain},
  uConnector in 'uConnector.pas',
  uBuffer in '..\Common\uBuffer.pas',
  uDBProvider in '..\Common\uDBProvider.pas',
  uUtil in '..\Common\uUtil.pas',
  uPackets in '..\Common\uPackets.pas',
  uCrypt in '..\Common\uCrypt.pas',
  uKeyClass in '..\Common\uKeyClass.pas',
  uRecordDef in 'uRecordDef.pas',
  deftype in '..\1000ydef\deftype.pas',
  uCBasicConnector in '..\Common\uCBasicConnector.pas',
  uSBasicConnector in '..\Common\uSBasicConnector.pas',
  uSRemoteConnector in 'uSRemoteConnector.pas',
  uCRemoteConnector in 'uCRemoteConnector.pas',
  uSItemRemoteConnector in 'uSItemRemoteConnector.pas',
  uCItemRemoteConnector in 'uCItemRemoteConnector.pas',
  uRemoteDef in '..\Common\uRemoteDef.pas',
  uIpChecker in 'uIpChecker.pas',
  uCookie in '..\Common\uCookie.pas',
  uLevelExp in '..\1000ydef\uLevelExp.pas',
  AUtil32 in '..\1000ydef\AUtil32.pas',
  AnsUnit in '..\Common\AnsUnit.pas',
  uDBFile in 'uDBFile.pas',
  uDBAdapter in 'uDBAdapter.pas',
  UserSdb in '..\Common\Usersdb.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
