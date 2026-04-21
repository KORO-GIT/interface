class StatusWnd extends UIScript;

var int m_UserID;
var bool m_bReceivedUserInfo;
var TextureHandle tex_hero;

function OnLoad()
{
    RegisterEvent(70);
    RegisterEvent(180);
    RegisterEvent(190);
    RegisterEvent(200);
    RegisterEvent(210);
    RegisterEvent(220);
    RegisterEvent(230);
    RegisterEvent(240);
    tex_hero = TextureHandle(GetHandle("StatusWnd.ed_texHero"));
    return;
}

function OnEnterState(name a_PreStateName)
{
    m_bReceivedUserInfo = false;
    UpdateUserInfo();
    return;
}

function UpdateUserInfo()
{
    local UserInfo UserInfo;
    local string HeroTexture;
    local bool bHero, bNobless;

    HeroTexture = "";
    // End:0x205
    if(GetPlayerInfo(UserInfo))
    {
        m_bReceivedUserInfo = true;
        m_UserID = UserInfo.nID;
        Class'NWindow.UIAPI_STATUSBARCTRL'.static.SetPoint("StatusWnd.CPBar", UserInfo.nCurCP, UserInfo.nMaxCP);
        Class'NWindow.UIAPI_STATUSBARCTRL'.static.SetPoint("StatusWnd.HPBar", UserInfo.nCurHP, UserInfo.nMaxHP);
        Class'NWindow.UIAPI_STATUSBARCTRL'.static.SetPoint("StatusWnd.MPBar", UserInfo.nCurMP, UserInfo.nMaxMP);
        Class'NWindow.UIAPI_STATUSBARCTRL'.static.SetPointExp("StatusWnd.EXPBar", UserInfo.nCurExp, UserInfo.nLevel);
        Class'NWindow.UIAPI_NAMECTRL'.static.SetName("StatusWnd.UserName", UserInfo.Name, NCT_Normal, TA_Left);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("StatusWnd.StatusWnd_LevelTextBox", UserInfo.nLevel);
        bHero = UserInfo.bHero;
        bNobless = UserInfo.bNobless;
        // End:0x1CB
        if(bHero)
        {
            HeroTexture = "L2UI_CH3.PlayerStatusWnd.myinfo_heroicon";            
        }
        else
        {
            // End:0x205
            if(bNobless)
            {
                HeroTexture = "L2UI_CH3.PlayerStatusWnd.myinfo_nobleicon";
            }
        }
    }
    tex_hero.SetTexture(HeroTexture);
    return;
}

function OnLButtonDown(WindowHandle a_WindowHandle, int X, int Y)
{
    local Rect rectWnd;

    rectWnd = Class'NWindow.UIAPI_WINDOW'.static.GetRect("StatusWnd");
    // End:0x64
    if((X > (rectWnd.nX + 13)) && X < ((rectWnd.nX + rectWnd.nWidth) - 10))
    {
        RequestSelfTarget();
    }
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x15
        case 180:
            UpdateUserInfo();
            // End:0x8D
            break;
        // End:0x28
        case 200:
            HandleUpdateInfo(a_Param);
            // End:0x8D
            break;
        // End:0x3B
        case 210:
            HandleUpdateInfo(a_Param);
            // End:0x8D
            break;
        // End:0x4E
        case 220:
            HandleUpdateInfo(a_Param);
            // End:0x8D
            break;
        // End:0x61
        case 230:
            HandleUpdateInfo(a_Param);
            // End:0x8D
            break;
        // End:0x74
        case 240:
            HandleUpdateInfo(a_Param);
            // End:0x8D
            break;
        // End:0x87
        case 70:
            HandleRegenStatus(a_Param);
            // End:0x8D
            break;
        // End:0xFFFF
        default:
            // End:0x8D
            break;
            break;
    }
    return;
}

function HandleUpdateInfo(string param)
{
    local int ServerID;

    ParseInt(param, "ServerID", ServerID);
    // End:0x3C
    if((m_UserID == ServerID) || !m_bReceivedUserInfo)
    {
        UpdateUserInfo();
    }
    return;
}

function HandleRegenStatus(string a_Param)
{
    local int Type, Duration, ticks;
    local float Amount;

    ParseInt(a_Param, "Type", Type);
    // End:0x99
    if(Type == 1)
    {
        ParseInt(a_Param, "Duration", Duration);
        ParseInt(a_Param, "Ticks", ticks);
        ParseFloat(a_Param, "Amount", Amount);
        Class'NWindow.UIAPI_STATUSBARCTRL'.static.SetRegenInfo("StatusWnd.HPBar", Duration, ticks, Amount);
    }
    return;
}
