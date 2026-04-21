class SystemMenuWnd extends UICommonAPI;

var WindowHandle Me;

function OnLoad()
{
    Me = GetHandle("SystemMenuWnd");
    RegisterEvent(1710);
    RegisterEvent(3030);
    function1();
    return;
}

function OnShow()
{
    Me.SetFocus();
    Class'NWindow.UIAPI_WINDOW'.static.SetAlwaysOnTop("SystemMenuWnd", true);
    return;
}

function OnDefaultPosition()
{
    Me.SetAnchor("", "BottomRight", "BottomRight", 2, -59);
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x21
        case "BtnCommunity":
            HandleShowBoardWnd();
            // End:0x2CA
            break;
        // End:0x37
        case "BtnMacro":
            HandleShowMacroListWnd();
            // End:0x2CA
            break;
        // End:0x6C
        case "BtnOption":
            HandleShowOptionWnd();
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemMenuWnd");
            // End:0x2CA
            break;
        // End:0xCC
        case "BtnRestart":
            // End:0xAC
            if(UnknownFunction243(GetOptionBool("Unload", "ReportWnd"), true))
            {
                ExecuteEvent(2930);                
            }
            else
            {
                DialogHide();
                DialogShow(DIALOG_Warning, GetSystemMessage(126));
                DialogSetID(0);
            }
            // End:0x2CA
            break;
        // End:0x129
        case "BtnQuit":
            // End:0x109
            if(UnknownFunction243(GetOptionBool("Unload", "ReportWnd"), true))
            {
                ExecuteEvent(2940);                
            }
            else
            {
                DialogHide();
                DialogShow(DIALOG_Warning, GetSystemMessage(125));
                DialogSetID(1);
            }
            // End:0x2CA
            break;
        // End:0x146
        case "BtnPrivateStore":
            ToggleOpenStoreWnd();
            // End:0x2CA
            break;
        // End:0x15E
        case "BtnMailBox":
            ToggleOpenPostBoxWnd();
            // End:0x2CA
            break;
        // End:0x173
        case "BtnClan":
            ToggleOpenClanWnd();
            // End:0x2CA
            break;
        // End:0x189
        case "BtnParty":
            ToggleOpenPartyMatchWnd();
            // End:0x2CA
            break;
        // End:0x1A0
        case "BtnFriend":
            ToggleMsnWindow();
            // End:0x2CA
            break;
        // End:0x1BC
        case "BtnAddFunction":
            ToggleAddWindow();
            // End:0x2CA
            break;
        // End:0x1D4
        case "BtnService":
            ToggleServicWindow();
            // End:0x2CA
            break;
        // End:0x1ED
        case "BtnShortcut":
            ToggleShortcutWindow();
            // End:0x2CA
            break;
        // End:0x204
        case "BtnSell":
            DoAction(10);
            // End:0x2CA
            break;
        // End:0x21A
        case "BtnBuy":
            DoAction(28);
            // End:0x2CA
            break;
        // End:0x25C
        case "BtnBatch":
            DoAction(10);
            Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("PrivateShopWnd.CheckBulk", true);
            // End:0x2CA
            break;
        // End:0x273
        case "BtnFind":
            DoAction(57);
            // End:0x2CA
            break;
        // End:0x28B
        case "BtnVideo":
            DoAction(55);
            // End:0x2CA
            break;
        // End:0x2A4
        case "BtnReplay":
            DoAction(55);
            // End:0x2CA
            break;
        // End:0x2B9
        case "BtnHelp":
            HandleShowHelpHtmlWnd();
            // End:0x2CA
            break;
        // End:0x2C7
        case "BtnWeb":
            // End:0x2CA
            break;
        // End:0xFFFF
        default:
            break;
    }
    // End:0x32D
    if(UnknownFunction130(UnknownFunction130(UnknownFunction123(strID, "BtnPrivateStore"), UnknownFunction123(strID, "BtnAddFunction")), UnknownFunction123(strID, "BtnService")))
    {
        HideWithBranch();
    }
    return;
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

function ToggleOpenStoreWnd()
{
    // End:0x44
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("SystemStoreWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemStoreWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("SystemStoreWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemAddWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemServiceWnd");
    }
    return;
}

function ToggleAddWindow()
{
    // End:0x40
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("SystemAddWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemAddWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("SystemAddWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemStoreWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemServiceWnd");
    }
    return;
}

function ToggleServicWindow()
{
    // End:0x48
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("SystemServiceWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemServiceWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("SystemServiceWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemStoreWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemAddWnd");
    }
    return;
}

function ToggleShortcutWindow()
{
    // End:0x5A
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("InterfaceAI_KeySettingWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("InterfaceAI_KeySettingWnd");
    }
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

function ToggleOpenPartyMatchWnd()
{
    // End:0x97
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("PartyMatchWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("PartyMatchWnd");
        PlaySound("InterfaceSound.charstat_close_01");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PartyMatchWnd.PartyText", "OFF");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("PartyMatchWnd");
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("PartyMatchWnd");
        PlaySound("InterfaceSound.charstat_open_01");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PartyMatchWnd.PartyText", "ON");
    }
    return;
}

function HideWithBranch()
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemMenuWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemStoreWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemAddWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemServiceWnd");
    return;
}

function OnEvent(int Event_ID, string string_1)
{
    // End:0x59
    if(UnknownFunction154(Event_ID, 1710))
    {
        // End:0x59
        if(DialogIsMine())
        {
            // End:0x53
            if(UnknownFunction154(DialogGetID(), 0))
            {
                Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SystemMenuWnd");
                ExecRestart();                
            }
            else
            {
                ExecQuit();
            }
        }
    }
    // End:0x72
    if(UnknownFunction154(Event_ID, 3030))
    {
        function1();
    }
    return;
}

function HandleShowBoardWnd()
{
    local string strParam;

    ParamAdd(strParam, "Init", "1");
    ExecuteEvent(1190, strParam);
    return;
}

function HandleShowHelpHtmlWnd()
{
    local string strParam;

    ParamAdd(strParam, "FilePath", "..L2texthelp.htm");
    ExecuteEvent(1210, strParam);
    return;
}

function HandleShowMacroListWnd()
{
    // End:0x40
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("MacroListWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroListWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroListWnd");
    }
    return;
}

function HandleShowPetitionBegin()
{
    // End:0x46
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("UserPetitionWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("UserPetitionWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("UserPetitionWnd");
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("UserPetitionWnd");
    }
    return;
}

function HandleShowOptionWnd()
{
    // End:0x3A
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("OptionWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("OptionWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("OptionWnd");
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("OptionWnd");
    }
    return;
}

function function1()
{
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtCommunity", "Community");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtMacro", "Macro");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.txtHelpHtml", "Help");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtOption", "Options");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtRestart", "Restart");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtQuit", "Exit Game");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtShortcut", "Shortcut");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtService", "Service");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtAddFunction", "Additional Function");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtFriend", "Friend Manager");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtParty", "Party");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtClanEntry", "Clan Entry");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtMailBox", "Mailbox");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.TxtPrivateStore", "Private Store");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.HeadSell", "Sell in Private Store");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.HeadBuy", "Purchase in Private Store");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.HeadBatch", "Sell as Batch");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.HeadFind", "Find Private Store");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.HeadVideo", "Record Video");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.HeadReplay", "Record Replay");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.HeadHelp", "Help");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SystemMenuWnd.HeadWeb", "Website");
    return;
}
