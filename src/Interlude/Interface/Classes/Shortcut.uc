class Shortcut extends UICommonAPI;

const CHAT_WINDOW_NORMAL = 0;
const CHAT_WINDOW_TRADE = 1;
const CHAT_WINDOW_PARTY = 2;
const CHAT_WINDOW_CLAN = 3;
const CHAT_WINDOW_ALLY = 4;
const CHAT_WINDOW_COUNT = 5;
const CHAT_WINDOW_SYSTEM = 5;

var bool m_chatstateok;
var bool UseBind1;
var bool UseBind2;
var bool UseBind3;
var int Panel1;
var int Panel2;
var int Panel3;
var MenuWnd MenuWnd;

function OnLoad()
{
    RegisterEvent(90);
    LoadData();
    MenuWnd = MenuWnd(GetScript("MenuWnd"));
    return;
}

function LoadData()
{
    local int IntUseBind1, IntUseBind2, IntUseBind3;

    GetINIInt("Key", "Panel1", Panel1, "Option");
    GetINIInt("Key", "Panel2", Panel2, "Option");
    GetINIInt("Key", "Panel3", Panel3, "Option");
    GetINIBool("Key", "UseBind1", IntUseBind1, "Option");
    GetINIBool("Key", "UseBind2", IntUseBind2, "Option");
    GetINIBool("Key", "UseBind3", IntUseBind3, "Option");
    UseBind1 = bool(IntUseBind1);
    UseBind2 = bool(IntUseBind2);
    UseBind3 = bool(IntUseBind3);
    // End:0x102
    if(Panel1 <= 0)
    {
        Panel1 = 1;
    }
    // End:0x114
    if(Panel2 <= 0)
    {
        Panel2 = 1;
    }
    // End:0x126
    if(Panel3 <= 0)
    {
        Panel3 = 1;
    }
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x1A
        case 90:
            HandleShortcutCommand(a_Param);
            // End:0x1D
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnExitState(name a_NextStateName)
{
    // End:0x1A
    if(a_NextStateName == 'GamingState')
    {
        m_chatstateok = true;        
    }
    else
    {
        m_chatstateok = false;
    }
    return;
}

function ResetParam(bool EnterChat, bool Bind1, bool Bind2, bool Bind3, int Panels1, int Panels2, int Panels3)
{
    UseBind1 = Bind1;
    UseBind2 = Bind2;
    UseBind3 = Bind3;
    Panel1 = Panels1;
    Panel2 = Panels2;
    Panel3 = Panels3;
    SetOptionBool("Game", "EnterChatting", EnterChat);
    SetINIBool("Key", "UseBind1", Bind1, "Option");
    SetINIBool("Key", "UseBind2", Bind2, "Option");
    SetINIBool("Key", "UseBind3", Bind3, "Option");
    SetINIInt("Key", "Panel1", Panels1, "Option");
    SetINIInt("Key", "Panel2", Panels2, "Option");
    SetINIInt("Key", "Panel3", Panels3, "Option");
    return;
}

function HandleShortcutCommand(string a_Param)
{
    local string Command;

    // End:0xD6
    if(ParseString(a_Param, "Command", Command))
    {
        switch(Command)
        {
            // End:0x3F
            case "CloseAllWindow":
                HandleCloseAllWindow();
                // End:0xB0
                break;
            // End:0x5B
            case "ShowChatWindow":
                HandleShowChatWindow();
                // End:0xB0
                break;
            // End:0x78
            case "SetPrevChatType":
                HandleSetPrevChatType();
                // End:0xB0
                break;
            // End:0x95
            case "SetNextChatType":
                HandleSetNextChatType();
                // End:0xB0
                break;
            // End:0xAD
            case "SelfTarget":
                RequestSelfTarget();
                // End:0xB0
                break;
            // End:0xFFFF
            default:
                break;
        }
        // End:0xD6
        if(Left(Command, 11) == "UserShorcut")
        {
            ShorcutKey(Command);
        }
    }
    return;
}

function OpenHideWindow(string param)
{
    // End:0x1C
    if(IsShowWindow(param))
    {
        HideWindow(param);        
    }
    else
    {
        ShowWindow(param);
    }
    return;
}

function ShorcutKey(string Parametr)
{
    switch(Parametr)
    {
        // End:0x4C
        case "UserShorcutKey_1":
            // End:0x49
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 1");
            }
            // End:0x1510
            break;
        // End:0x91
        case "UserShorcutKey_2":
            // End:0x8E
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 2");
            }
            // End:0x1510
            break;
        // End:0xD6
        case "UserShorcutKey_3":
            // End:0xD3
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 3");
            }
            // End:0x1510
            break;
        // End:0x11B
        case "UserShorcutKey_4":
            // End:0x118
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 4");
            }
            // End:0x1510
            break;
        // End:0x160
        case "UserShorcutKey_5":
            // End:0x15D
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 5");
            }
            // End:0x1510
            break;
        // End:0x1A5
        case "UserShorcutKey_6":
            // End:0x1A2
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 6");
            }
            // End:0x1510
            break;
        // End:0x1EA
        case "UserShorcutKey_7":
            // End:0x1E7
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 7");
            }
            // End:0x1510
            break;
        // End:0x22F
        case "UserShorcutKey_8":
            // End:0x22C
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 8");
            }
            // End:0x1510
            break;
        // End:0x274
        case "UserShorcutKey_9":
            // End:0x271
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 9");
            }
            // End:0x1510
            break;
        // End:0x2BB
        case "UserShorcutKey_10":
            // End:0x2B8
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 10");
            }
            // End:0x1510
            break;
        // End:0x302
        case "UserShorcutKey_11":
            // End:0x2FF
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 11");
            }
            // End:0x1510
            break;
        // End:0x349
        case "UserShorcutKey_12":
            // End:0x346
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel1)) $ " 12");
            }
            // End:0x1510
            break;
        // End:0x38E
        case "UserShorcutKey_Q":
            // End:0x38B
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 1");
            }
            // End:0x1510
            break;
        // End:0x3D3
        case "UserShorcutKey_W":
            // End:0x3D0
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 2");
            }
            // End:0x1510
            break;
        // End:0x418
        case "UserShorcutKey_E":
            // End:0x415
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 3");
            }
            // End:0x1510
            break;
        // End:0x45D
        case "UserShorcutKey_R":
            // End:0x45A
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 4");
            }
            // End:0x1510
            break;
        // End:0x4A2
        case "UserShorcutKey_T":
            // End:0x49F
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 5");
            }
            // End:0x1510
            break;
        // End:0x4E7
        case "UserShorcutKey_Y":
            // End:0x4E4
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 6");
            }
            // End:0x1510
            break;
        // End:0x52C
        case "UserShorcutKey_U":
            // End:0x529
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 7");
            }
            // End:0x1510
            break;
        // End:0x571
        case "UserShorcutKey_I":
            // End:0x56E
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 8");
            }
            // End:0x1510
            break;
        // End:0x5B6
        case "UserShorcutKey_O":
            // End:0x5B3
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 9");
            }
            // End:0x1510
            break;
        // End:0x5FC
        case "UserShorcutKey_P":
            // End:0x5F9
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 10");
            }
            // End:0x1510
            break;
        // End:0x642
        case "UserShorcutKey_[":
            // End:0x63F
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 11");
            }
            // End:0x1510
            break;
        // End:0x688
        case "UserShorcutKey_]":
            // End:0x685
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel2)) $ " 12");
            }
            // End:0x1510
            break;
        // End:0x6CE
        case "UserShorcutKey_F1":
            // End:0x6CB
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 1");
            }
            // End:0x1510
            break;
        // End:0x714
        case "UserShorcutKey_F2":
            // End:0x711
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 2");
            }
            // End:0x1510
            break;
        // End:0x75A
        case "UserShorcutKey_F3":
            // End:0x757
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 3");
            }
            // End:0x1510
            break;
        // End:0x7A0
        case "UserShorcutKey_F4":
            // End:0x79D
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 4");
            }
            // End:0x1510
            break;
        // End:0x7E6
        case "UserShorcutKey_F5":
            // End:0x7E3
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 5");
            }
            // End:0x1510
            break;
        // End:0x82C
        case "UserShorcutKey_F6":
            // End:0x829
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 6");
            }
            // End:0x1510
            break;
        // End:0x872
        case "UserShorcutKey_F7":
            // End:0x86F
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 7");
            }
            // End:0x1510
            break;
        // End:0x8B8
        case "UserShorcutKey_F8":
            // End:0x8B5
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 8");
            }
            // End:0x1510
            break;
        // End:0x8FE
        case "UserShorcutKey_F9":
            // End:0x8FB
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 9");
            }
            // End:0x1510
            break;
        // End:0x946
        case "UserShorcutKey_F10":
            // End:0x943
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 10");
            }
            // End:0x1510
            break;
        // End:0x98E
        case "UserShorcutKey_F11":
            // End:0x98B
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 11");
            }
            // End:0x1510
            break;
        // End:0x9D6
        case "UserShorcutKey_F12":
            // End:0x9D3
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcut " $ string(Panel3)) $ " 12");
            }
            // End:0x1510
            break;
        // End:0xA25
        case "UserShorcutKeyForce_1":
            // End:0xA22
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 1");
            }
            // End:0x1510
            break;
        // End:0xA74
        case "UserShorcutKeyForce_2":
            // End:0xA71
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 2");
            }
            // End:0x1510
            break;
        // End:0xAC3
        case "UserShorcutKeyForce_3":
            // End:0xAC0
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 3");
            }
            // End:0x1510
            break;
        // End:0xB12
        case "UserShorcutKeyForce_4":
            // End:0xB0F
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 4");
            }
            // End:0x1510
            break;
        // End:0xB61
        case "UserShorcutKeyForce_5":
            // End:0xB5E
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 5");
            }
            // End:0x1510
            break;
        // End:0xBB0
        case "UserShorcutKeyForce_6":
            // End:0xBAD
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 6");
            }
            // End:0x1510
            break;
        // End:0xBFF
        case "UserShorcutKeyForce_7":
            // End:0xBFC
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 7");
            }
            // End:0x1510
            break;
        // End:0xC4E
        case "UserShorcutKeyForce_8":
            // End:0xC4B
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 8");
            }
            // End:0x1510
            break;
        // End:0xC9D
        case "UserShorcutKeyForce_9":
            // End:0xC9A
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 9");
            }
            // End:0x1510
            break;
        // End:0xCEE
        case "UserShorcutKeyForce_10":
            // End:0xCEB
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 10");
            }
            // End:0x1510
            break;
        // End:0xD3F
        case "UserShorcutKeyForce_11":
            // End:0xD3C
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 11");
            }
            // End:0x1510
            break;
        // End:0xD90
        case "UserShorcutKeyForce_12":
            // End:0xD8D
            if(UseBind1)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel1)) $ " 12");
            }
            // End:0x1510
            break;
        // End:0xDDF
        case "UserShorcutKeyForce_Q":
            // End:0xDDC
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 1");
            }
            // End:0x1510
            break;
        // End:0xE2E
        case "UserShorcutKeyForce_W":
            // End:0xE2B
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 2");
            }
            // End:0x1510
            break;
        // End:0xE7D
        case "UserShorcutKeyForce_E":
            // End:0xE7A
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 3");
            }
            // End:0x1510
            break;
        // End:0xECC
        case "UserShorcutKeyForce_R":
            // End:0xEC9
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 4");
            }
            // End:0x1510
            break;
        // End:0xF1B
        case "UserShorcutKeyForce_T":
            // End:0xF18
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 5");
            }
            // End:0x1510
            break;
        // End:0xF6A
        case "UserShorcutKeyForce_Y":
            // End:0xF67
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 6");
            }
            // End:0x1510
            break;
        // End:0xFB9
        case "UserShorcutKeyForce_U":
            // End:0xFB6
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 7");
            }
            // End:0x1510
            break;
        // End:0x1008
        case "UserShorcutKeyForce_I":
            // End:0x1005
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 8");
            }
            // End:0x1510
            break;
        // End:0x1057
        case "UserShorcutKeyForce_O":
            // End:0x1054
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 9");
            }
            // End:0x1510
            break;
        // End:0x10A7
        case "UserShorcutKeyForce_P":
            // End:0x10A4
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 10");
            }
            // End:0x1510
            break;
        // End:0x10F7
        case "UserShorcutKeyForce_[":
            // End:0x10F4
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 11");
            }
            // End:0x1510
            break;
        // End:0x1147
        case "UserShorcutKeyForce_]":
            // End:0x1144
            if(UseBind2)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel2)) $ " 12");
            }
            // End:0x1510
            break;
        // End:0x1197
        case "UserShorcutKeyForce_F1":
            // End:0x1194
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 1");
            }
            // End:0x1510
            break;
        // End:0x11E7
        case "UserShorcutKeyForce_F2":
            // End:0x11E4
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 2");
            }
            // End:0x1510
            break;
        // End:0x1237
        case "UserShorcutKeyForce_F3":
            // End:0x1234
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 3");
            }
            // End:0x1510
            break;
        // End:0x1287
        case "UserShorcutKeyForce_F4":
            // End:0x1284
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 4");
            }
            // End:0x1510
            break;
        // End:0x12D7
        case "UserShorcutKeyForce_F5":
            // End:0x12D4
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 5");
            }
            // End:0x1510
            break;
        // End:0x1327
        case "UserShorcutKeyForce_F6":
            // End:0x1324
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 6");
            }
            // End:0x1510
            break;
        // End:0x1377
        case "UserShorcutKeyForce_F7":
            // End:0x1374
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 7");
            }
            // End:0x1510
            break;
        // End:0x13C7
        case "UserShorcutKeyForce_F8":
            // End:0x13C4
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 8");
            }
            // End:0x1510
            break;
        // End:0x1417
        case "UserShorcutKeyForce_F9":
            // End:0x1414
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 9");
            }
            // End:0x1510
            break;
        // End:0x1469
        case "UserShorcutKeyForce_F10":
            // End:0x1466
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 10");
            }
            // End:0x1510
            break;
        // End:0x14BB
        case "UserShorcutKeyForce_F11":
            // End:0x14B8
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 11");
            }
            // End:0x1510
            break;
        // End:0x150D
        case "UserShorcutKeyForce_F12":
            // End:0x150A
            if(UseBind3)
            {
                ExecuteCommand(("/useshortcutforce " $ string(Panel3)) $ " 12");
            }
            // End:0x1510
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleShowChatWindow()
{
    local WindowHandle Handle;

    Handle = GetHandle("ChatWnd");
    // End:0x73
    if(Handle.IsShowWindow())
    {
        Handle.HideWindow();
        // End:0x70
        if(GetOptionBool("Game", "SystemMsgWnd"))
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemMsgWnd");
        }        
    }
    else
    {
        Handle.ShowWindow();
        // End:0xBC
        if(GetOptionBool("Game", "SystemMsgWnd"))
        {
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("SystemMsgWnd");
        }
    }
    return;
}

function HandleSetPrevChatType()
{
    local ChatWnd chatWndScript;

    chatWndScript = ChatWnd(GetScript("ChatWnd"));
    switch(chatWndScript.m_chatType)
    {
        // End:0xD0
        case 0:
            chatWndScript.ChatTabCtrl.MergeTab(1);
            chatWndScript.ChatTabCtrl.MergeTab(2);
            chatWndScript.ChatTabCtrl.MergeTab(3);
            chatWndScript.ChatTabCtrl.MergeTab(4);
            chatWndScript.ChatTabCtrl.SetTopOrder(4, true);
            chatWndScript.HandleTabClick("ChatTabCtrl4");
            // End:0x369
            break;
        // End:0x175
        case 1:
            chatWndScript.ChatTabCtrl.MergeTab(0);
            chatWndScript.ChatTabCtrl.MergeTab(2);
            chatWndScript.ChatTabCtrl.MergeTab(3);
            chatWndScript.ChatTabCtrl.MergeTab(4);
            chatWndScript.ChatTabCtrl.SetTopOrder(0, true);
            chatWndScript.HandleTabClick("ChatTabCtrl0");
            // End:0x369
            break;
        // End:0x21A
        case 2:
            chatWndScript.ChatTabCtrl.MergeTab(0);
            chatWndScript.ChatTabCtrl.MergeTab(1);
            chatWndScript.ChatTabCtrl.MergeTab(3);
            chatWndScript.ChatTabCtrl.MergeTab(4);
            chatWndScript.ChatTabCtrl.SetTopOrder(1, true);
            chatWndScript.HandleTabClick("ChatTabCtrl1");
            // End:0x369
            break;
        // End:0x2C0
        case 3:
            chatWndScript.ChatTabCtrl.MergeTab(0);
            chatWndScript.ChatTabCtrl.MergeTab(1);
            chatWndScript.ChatTabCtrl.MergeTab(2);
            chatWndScript.ChatTabCtrl.MergeTab(3);
            chatWndScript.ChatTabCtrl.SetTopOrder(2, true);
            chatWndScript.HandleTabClick("ChatTabCtrl2");
            // End:0x369
            break;
        // End:0x366
        case 4:
            chatWndScript.ChatTabCtrl.MergeTab(0);
            chatWndScript.ChatTabCtrl.MergeTab(1);
            chatWndScript.ChatTabCtrl.MergeTab(2);
            chatWndScript.ChatTabCtrl.MergeTab(3);
            chatWndScript.ChatTabCtrl.SetTopOrder(3, true);
            chatWndScript.HandleTabClick("ChatTabCtrl3");
            // End:0x369
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleSetNextChatType()
{
    local ChatWnd chatWndScript;

    chatWndScript = ChatWnd(GetScript("ChatWnd"));
    switch(chatWndScript.m_chatType)
    {
        // End:0xCF
        case 0:
            chatWndScript.ChatTabCtrl.MergeTab(0);
            chatWndScript.ChatTabCtrl.MergeTab(2);
            chatWndScript.ChatTabCtrl.MergeTab(3);
            chatWndScript.ChatTabCtrl.MergeTab(4);
            chatWndScript.ChatTabCtrl.SetTopOrder(1, true);
            chatWndScript.HandleTabClick("ChatTabCtrl1");
            // End:0x369
            break;
        // End:0x174
        case 1:
            chatWndScript.ChatTabCtrl.MergeTab(0);
            chatWndScript.ChatTabCtrl.MergeTab(1);
            chatWndScript.ChatTabCtrl.MergeTab(3);
            chatWndScript.ChatTabCtrl.MergeTab(4);
            chatWndScript.ChatTabCtrl.SetTopOrder(2, true);
            chatWndScript.HandleTabClick("ChatTabCtrl2");
            // End:0x369
            break;
        // End:0x21A
        case 2:
            chatWndScript.ChatTabCtrl.MergeTab(0);
            chatWndScript.ChatTabCtrl.MergeTab(1);
            chatWndScript.ChatTabCtrl.MergeTab(2);
            chatWndScript.ChatTabCtrl.MergeTab(4);
            chatWndScript.ChatTabCtrl.SetTopOrder(3, true);
            chatWndScript.HandleTabClick("ChatTabCtrl3");
            // End:0x369
            break;
        // End:0x2C0
        case 3:
            chatWndScript.ChatTabCtrl.MergeTab(0);
            chatWndScript.ChatTabCtrl.MergeTab(1);
            chatWndScript.ChatTabCtrl.MergeTab(2);
            chatWndScript.ChatTabCtrl.MergeTab(3);
            chatWndScript.ChatTabCtrl.SetTopOrder(4, true);
            chatWndScript.HandleTabClick("ChatTabCtrl4");
            // End:0x369
            break;
        // End:0x366
        case 4:
            chatWndScript.ChatTabCtrl.MergeTab(1);
            chatWndScript.ChatTabCtrl.MergeTab(2);
            chatWndScript.ChatTabCtrl.MergeTab(3);
            chatWndScript.ChatTabCtrl.MergeTab(4);
            chatWndScript.ChatTabCtrl.SetTopOrder(0, true);
            chatWndScript.HandleTabClick("ChatTabCtrl0");
            // End:0x369
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleCloseAllWindow()
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemMenuWnd");
    return;
}
