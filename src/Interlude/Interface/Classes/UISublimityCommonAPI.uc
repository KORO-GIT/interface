class UISublimityCommonAPI extends UICommonAPI;

const EV_ShortcutDelete = 631;
const EV_GlobalTick = 25000;
const EV_MouseEvent = 25001;
const EV_KeyboardEvent = 25002;
const EV_CameraPosition = 25003;
const EV_MouseMoveEvent = 25004;
const EV_BuffListStart = 25100;
const EV_BuffListItem = 25101;
const EV_BuffListEnd = 25102;
const Ev_PinCheckRequest = 100000;
const EV_PinCheckFail = 100001;
const EV_PinCheckSuccess = 100002;
const EV_PinCreateRequest = 100003;
const EV_PinCreateFail = 100004;
const EV_PinCreateSuccess = 100005;
const EV_BotCheckRequest = 100006;
const EV_BotCheckFail = 100007;
const EV_BotCheckSuccess = 100008;
const EV_SkillCastStart = 100009;
const EV_SkillCastCancel = 100010;
const EV_UnReadMessageCount = 100011;
const EV_PeaceZoneEnter = 100012;
const EV_PeaceZoneLeave = 100013;
const EV_MouseLock = 100014;
const EV_MouseUnlock = 100015;
const EV_ShowCountdown = 100016;
const EV_HideCountdown = 100017;
const EV_SuccessCountdown = 100018;
const EV_FailCountdown = 100019;
const EV_TutorialPacket = 100020;
const EV_PartyMatchingState = 100021;
const EV_ShowPartyMatching = 100022;
const EV_ClanOnlineUpdate = 200000;

struct PosButton
{
    var int X;
    var int Y;
};

var SublimityTimerActor m_TimerActor;

function SpawnTimerActor()
{
    m_TimerActor = new (none, "SublimityTimerActor") Class'Interface.SublimityTimerActor';
    return;
}

function TestPlayerSkillGauge(int a_SkillID, int a_Time)
{
    local string param;

    ParamAdd(param, "SkillID", "" $ string(a_SkillID));
    ParamAdd(param, "CastTime", "" $ string(a_Time));
    ExecuteEvent(100009, param);
    return;
}

function TestPlayerSkillCastCancel()
{
    ExecuteEvent(100010);
    return;
}

function RequestPinCheck(int a_PinValue)
{
    RequestBypassToServer("request_pin?pin=" $ string(a_PinValue));
    return;
}

function RequestPinCreate(int a_PinValue)
{
    RequestBypassToServer("create_pin?pin=" $ string(a_PinValue));
    return;
}

function RequestBotCheck(int a_PinValue)
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SublimityBotCheckWnd");
    RequestBypassToServer("request_bot_check?pin=" $ string(a_PinValue));
    return;
}

function int GetPcOptionInt(string a_Section, string a_Name)
{
    local UserInfo Info;

    // End:0x33
    if(GetPlayerInfo(Info))
    {
        return GetOptionInt(a_Section, (Info.Name $ "_") $ a_Name);        
    }
    else
    {
        return 0;
    }
    return 0;
}

function bool GetPcOptionBool(string a_Section, string a_Name)
{
    local UserInfo Info;

    // End:0x30
    if(GetPlayerInfo(Info))
    {
        return GetOptionBool(a_Section, (Info.Name $ "_") $ a_Name);
    }
    return false;
}

function SetPcOptionInt(string a_Section, string a_Name, int a_Value)
{
    local UserInfo Info;

    // End:0x34
    if(GetPlayerInfo(Info))
    {
        SetOptionInt(a_Section, (Info.Name $ "_") $ a_Name, a_Value);
    }
    return;
}

function SetPcOptionBool(string a_Section, string a_Name, bool a_Value)
{
    local UserInfo Info;

    // End:0x35
    if(GetPlayerInfo(Info))
    {
        SetOptionBool(a_Section, (Info.Name $ "_") $ a_Name, a_Value);
    }
    return;
}
