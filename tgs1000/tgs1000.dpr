program tgs1000;

uses
  Forms,
  SVMain in 'SVMain.pas' {FrmMain},
  UUser in 'UUser.pas',
  svClass in 'svClass.pas',
  fieldmsg in 'fieldmsg.pas',
  BasicObj in 'BasicObj.pas',
  MapUnit in 'MapUnit.pas',
  SubUtil in 'SubUtil.pas',
  uSendCls in 'uSendCls.pas',
  uMonster in 'uMonster.pas',
  uNpc in 'uNpc.pas',
  uUserSub in 'uUserSub.pas',
  uGuild in 'uGuild.pas',
  FSockets in 'FSockets.pas' {FrmSockets},
  uGuildSub in 'uGuildSub.pas',
  uLetter in 'uLetter.pas',
  uAIPath in 'uAIPath.pas',
  uManager in 'uManager.pas',
  uSkills in 'uSkills.pas',
  FGate in 'FGate.pas' {frmGate},
  uGConnect in 'uGConnect.pas',
  uConnect in 'uConnect.pas',
  uItemLog in 'uItemLog.pas',
  uDoorGen in 'uDoorGen.pas',
  uMopSub in 'uMopSub.pas',
  uObjectEvent in 'uObjectEvent.pas',
  uItemDeal in 'uItemDeal.pas',
  uEvent in 'uEvent.pas',
  uScriptManager in 'uScriptManager.pas',
  uWorkBox in 'uWorkBox.pas',
  FTrace in 'FTrace.pas' {frmTrace},
  FLog in 'FLOg.pas' {frmLog},
  uArena in 'uArena.pas',
  uZhuang in 'uZhuang.pas',
  deftype in '..\1000ydef\deftype.pas',
  uCharCheck in '..\Common\uCharCheck.pas',
  uCookie in '..\Common\uCookie.pas',
  uUtil in '..\Common\uUtil.pas',
  ScriptBasic in '..\Common\ScriptBasic.pas',
  ScriptCls in '..\Common\ScriptCls.pas',
  BSCommon in '..\Common\BSCommon.pas',
  uDBRecordDef in '..\Common\uDBRecordDef.pas',
  uPackets in '..\Common\uPackets.pas',
  uCrypt in '..\Common\uCrypt.pas',
  uKeyClass in '..\Common\uKeyClass.pas',
  uBuffer in '..\Common\uBuffer.pas',
  uImage in '..\Common\uImage.pas',
  uFuck in '..\Common\uFuck.pas',
  uAnsTick in '..\Common\uAnsTick.pas',
  AnsImg2 in '..\Common\AnsImg2.pas',
  BmpUtil in '..\Common\BmpUtil.pas',
  uRandomManager in 'uRandomManager.pas' {FrmRandomManager},
  AnsStringCls in '..\Common\AnsStringCls.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmSockets, FrmSockets);
  Application.CreateForm(TfrmGate, frmGate);
  Application.CreateForm(TfrmTrace, frmTrace);
  Application.CreateForm(TfrmLog, frmLog);
  Application.CreateForm(TFrmRandomManager, FrmRandomManager);
  Application.Run;
end.

