class Menu extends UISublimityCommonAPI;

var string m_WindowName;
var int m_UserID;
var int int_1;
var int int_2;
var bool m_bReceivedUserInfo;
var bool m_bShow;
var TextBoxHandle UserNameH;
var bool bClanMember;
var TextBoxHandle m_hClanText;
var TextBoxHandle m_hClanText2;
var TextureHandle m_hClanIcon;
var TextBoxHandle m_hAdenaTextBox;
var TextBoxHandle m_hMessageCountText;
var ItemWindowHandle m_invenItem;
var ButtonHandle btnQuit;

function OnLoad()
{
    RegisterEvent(70);
    RegisterEvent(180);
    RegisterEvent(1710);
    RegisterEvent(1900);
    RegisterEvent(320);
    RegisterEvent(420);
    RegisterEvent(580);
    RegisterEvent(150);
    RegisterEvent(2610);
    RegisterEvent(2620);
    RegisterEvent(9999);
    RegisterEvent(200000);
    UserNameH = TextBoxHandle(GetHandle("Menu.Username"));
    btnQuit = ButtonHandle(GetHandle("Menu.btnQuit"));
    bClanMember = false;
    InitHandle();
    return;
}

function SetPartyText(string a_Text)
{
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PartyText", a_Text);
    return;
}

function SetUnReadMessage(int Value)
{
    m_hMessageCountText.SetText(string(Value));
    return;
}

function HandleUnReadMessage(string a_Param)
{
    local int MessageCount;

    ParseInt(a_Param, "MessageCount", MessageCount);
    SetUnReadMessage(MessageCount);
    return;
}

function HandleSystemMessage(string a_Param)
{
    local int SystemMsgIndex;
    local string ParamString1;

    ParseInt(a_Param, "Index", SystemMsgIndex);
    // End:0x52
    if(SystemMsgIndex == 1227)
    {
        ParseString(a_Param, "Param1", ParamString1);
        m_hMessageCountText.SetText(ParamString1);
    }
    return;
}

function SetAdenaText()
{
    local string adenaString;

    adenaString = MakeCostString(string(GetAdena()));
    m_hAdenaTextBox.SetText(adenaString);
    m_hAdenaTextBox.SetTooltipString(ConvertNumToText(string(GetAdena())));
    return;
}

function InitHandle()
{
    m_hAdenaTextBox = TextBoxHandle(GetHandle(m_WindowName $ ".AdenaText"));
    m_hClanText = TextBoxHandle(GetHandle(m_WindowName $ ".ClanText"));
    m_hClanText2 = TextBoxHandle(GetHandle(m_WindowName $ ".ClanText2"));
    m_hClanIcon = TextureHandle(GetHandle(m_WindowName $ ".ClanIcon"));
    m_hMessageCountText = TextBoxHandle(GetHandle(m_WindowName $ ".MessageCountText"));
    m_invenItem = ItemWindowHandle(GetHandle(m_WindowName $ ".InventoryItem"));
    btnQuit.SetTooltipCustomType(MakeTooltipSimpleText("Exit"));
    return;
}

function OnEnterState(name a_PreStateName)
{
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    UserNameH.SetText(UserInfo.Name @ ":");
    m_bReceivedUserInfo = false;
    UpdateUserInfo();
    bClanMember = false;
    return;
}

function OnShow()
{
    HandleUpdateUserInfo();
    m_bShow = true;
    SetAdenaText();
    return;
}

function UpdateUserInfo()
{
    local UserInfo info_2;

    // End:0x1F2
    if(GetPlayerInfo(info_2))
    {
        // End:0x131
        if((info_2.nCriminalRate > 0))
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("Menu.ExpBar");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("Menu.KarmaBar");
            // End:0x84
            if((info_2.nCriminalRate > int_2))
            {
                int_2 = info_2.nCriminalRate;
            }
            int_1 = info_2.nCriminalRate;
            Class'NWindow.UIAPI_STATUSBARCTRL'.static.SetPointPercent("Menu.KarmaBar", Int2Int64(int_1), Int2Int64(0), Int2Int64(int_2));
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("Menu.XP", "Karma");
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("Menu.KarmaBar", (("Karma " $ string(info_2.nCriminalRate)) $ ""));
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("Menu.KarmaBar");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("Menu.ExpBar");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("Menu.XP", "XP");
            Class'NWindow.UIAPI_STATUSBARCTRL'.static.SetPointExp("Menu.EXPBar", info_2.nCurExp, info_2.nLevel);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("Menu.ExpBar", (("SP " $ string(info_2.nSP)) $ ""));
        }
    }
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1C
        case "BtnClan":
            ToggleOpenClanWnd();
            // End:0xA5
            break;
        // End:0x36
        case "BtnCommunity":
            ToggleOpenPostBoxWnd();
            // End:0xA5
            break;
        // End:0xA2
        case "PartyMatchingBtn":
            // End:0x90
            if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("PartyMatchWnd") == true)
            {
                Class'NWindow.UIAPI_WINDOW'.static.HideWindow("PartyMatchWnd");
            }
            else
            {
                Class'NWindow.PartyMatchAPI'.static.RequestOpenPartyMatch();
            }
            // End:0xA5
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function bool GetMyUserInfo(out UserInfo a_MyUserInfo)
{
    return GetPlayerInfo(a_MyUserInfo);
}

function HandleUpdateUserInfo()
{
    local int DualCount, limit, Count;
    local TextBoxHandle Handle;
    local UserInfo Info;

    // End:0x4F
    if(GetMyUserInfo(Info))
    {
        m_UserID = Info.nID;
        DualCount = Info.nDualCount;
        Count = m_invenItem.GetItemNum();
        limit = GetMyInventoryLimit();
    }
    m_hAdenaTextBox = TextBoxHandle(GetHandle(m_WindowName $ ".AdenaText"));
    m_hClanText = TextBoxHandle(GetHandle(m_WindowName $ ".ClanCurrentNum"));
    m_hClanText2 = TextBoxHandle(GetHandle(m_WindowName $ ".ClanCurrentNum2"));
    Handle = TextBoxHandle(GetHandle(m_WindowName $ ".ItemCount"));
    Handle.SetText(((("(" $ string(Count)) $ "/") $ string(limit)) $ ")");
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    // End:0x33
    if(a_EventID == 1710)
    {
        // End:0x33
        if(DialogIsMine())
        {
            // End:0x2D
            if((DialogGetID()) == 0)
            {
                ExecRestart();
            }
            else
            {
                ExecQuit();
            }
        }
    }
    // End:0x45
    if(a_EventID == 180)
    {
        HandleUpdateUserInfo();
    }
    switch(a_EventID)
    {
        // End:0x5A
        case 180:
            UpdateUserInfo();
            // End:0x11B
            break;
        // End:0x6D
        case 320:
            bClanMember = true;
            // End:0x11B
            break;
        // End:0x7E
        case 420:
            Clean();
            // End:0x11B
            break;
        // End:0x94
        case 580:
            HandleSystemMessage(a_Param);
            // End:0x11B
            break;
        // End:0xA2
        case 150:
            Clean();
            // End:0x11B
            break;
        // End:0xAA
        case 2620:
        // End:0xBB
        case 2610:
            SetAdenaText();
            // End:0x11B
            break;
        // End:0x115
        case 200000:
            HandleClanOnlineUpdate(a_Param);
            m_hClanText2.SetText("Clan Online:");
            m_hClanIcon.SetTexture("Was.NPHRN_BeltWnd_Clan");
            // End:0x11B
            break;
        // End:0xFFFF
        default:
            // End:0x11B
            break;
            break;
    }
    return;
}

function Clean()
{
    m_hClanText.SetText("Join Clan");
    m_hClanText2.SetText("");
    m_hClanIcon.SetTexture("Was.NPHRN_BeltWnd_Staff");
    return;
}

function HandleClanOnlineUpdate(string a_Param)
{
    local int m_Count;

    ParseInt(a_Param, "Count", m_Count);
    m_hClanText.SetText(string(m_Count - 1));
    return;
}

function ToggleOpenClanWnd()
{
    // End:0x36
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("MainWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MainWnd");
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MainWnd");
        Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("MainWnd.MainTabCtrl", 3, true);
    }
    return;
}

function int GetMyInventoryLimit()
{
    local int val;

    val = Class'NWindow.UIDATA_PLAYER'.static.GetInventoryLimit();
    // End:0x28
    if(val == 0)
    {
        val = 80;
    }
    return val;
}

function ToggleOpenPostBoxWnd()
{
    // End:0x38
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("BoardWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BoardWnd");
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BoardWnd");
        Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("BoardWnd.TabCtrl", 5, true);
    }
    return;
}

defaultproperties
{
    m_WindowName="Menu"
}
