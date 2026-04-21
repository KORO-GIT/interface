class MenuWnd extends UICommonAPI;

const TIMER_1 = 1000;

var bool bool_1;
var array<string> string_1;
var string string_2;
var int int_1;
var TextBoxHandle UserNameH;

function OnLoad()
{
    local Color Color;

    Color.R = byte(255);
    Color.G = 0;
    Color.B = 0;
    Color.A = byte(255);
    RegisterEvent(180);
    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("MenuWnd", 1000, 1000);
    function1();
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("MenuWnd.Chaos", Color);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("MenuWnd.Chaos", "Chaos Interface");
    UserNameH = TextBoxHandle(GetHandle("MenuWnd.Username"));
    return;
}

function OnEvent(int a_event, string a_Param)
{
    // End:0x12
    if(a_event == 180)
    {
        HandleCount();
    }
    return;
}

function HandleCount()
{
    local int DualCount, PKCount, Karma;
    local UserInfo Info;

    GetPlayerInfo(Info);
    DualCount = Info.nDualCount;
    PKCount = Info.nPKCount;
    Karma = Info.nCriminalRate;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("MenuWnd.PVP1", (((((((((("PvP / PK / KARMA: " $ string(DualCount)) $ " ") $ "/") $ " ") $ "") $ string(PKCount)) $ " ") $ "/") $ " ") $ "") $ string(Karma));
    return;
}

function OnTimer(int a_Time)
{
    switch(a_Time)
    {
        // End:0x74
        case 1000:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("MenuWnd", 1000);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("MenuWnd.Time", GetTimeString());
            Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("MenuWnd", 1000, 1000);
            // End:0x77
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function function1()
{
    local ButtonHandle BtnCharInfo;

    BtnCharInfo = ButtonHandle(GetHandle("MenuWnd.BtnCharInfo"));
    BtnCharInfo.SetTooltipCustomType(MakeTooltipSimpleText("Character Status (Alt+T)"));
    return;
}

function OnDefaultPosition()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("MenuWnd", "", "BottomRight", "BottomRight", 5, -18);
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x20
        case "BtnCharInfo":
            ToggleOpenCharInfoWnd();
            // End:0x6C
            break;
        // End:0x3A
        case "BtnInventory":
            ToggleOpenInventoryWnd();
            // End:0x6C
            break;
        // End:0x4E
        case "BtnMap":
            ToggleOpenMinimapWnd();
            // End:0x6C
            break;
        // End:0x69
        case "BtnSystemMenu":
            ToggleOpenSystemMenuWnd();
            // End:0x6C
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function ToggleOpenCharInfoWnd()
{
    // End:0x4C
    if(IsShowWindow("MainWnd"))
    {
        HideWindow("MainWnd");
        PlaySound("InterfaceSound.charstat_close_01");        
    }
    else
    {
        ShowWindowWithFocus("MainWnd");
        PlaySound("InterfaceSound.charstat_open_01");
    }
    return;
}

function ToggleOpenInventoryWnd()
{
    // End:0x57
    if(IsShowWindow("InventoryWnd"))
    {
        HideWindow("InventoryWnd");
        PlaySound("InterfaceSound.inventory_close_01");        
    }
    else
    {
        ShowWindowWithFocus("InventoryWnd");
        PlaySound("InterfaceSound.inventory_open_01");
    }
    return;
}

function ToggleOpenMinimapWnd()
{
    RequestOpenMinimap();
    return;
}

function ToggleOpenSystemMenuWnd()
{
    // End:0x56
    if(IsShowWindow("SystemMenuWnd"))
    {
        HideWindow("SystemMenuWnd");
        PlaySound("InterfaceSound.system_close_01");        
    }
    else
    {
        ShowWindowWithFocus("SystemMenuWnd");
        PlaySound("InterfaceSound.system_open_01");
    }
    return;
}

function OnEnterState(name a_PreStateName)
{
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    UserNameH.SetText(UserInfo.Name @ "");
    return;
}
