class InterfaceAI_KeySettingWnd extends UICommonAPI;

var WindowHandle Me;
var Shortcut script;
var bool UseEnterChat;
var int ShortcutBindType;
var ButtonHandle b_Vertical;
var ButtonHandle b_Horizontal;

function OnLoad()
{
    InitHandle();
    InitLayout();
    LoadData();
    return;
}

function OnShow()
{
    LoadData();
    return;
}

function InitHandle()
{
    Me = GetHandle("InterfaceAI_KeySettingWnd");
    script = Shortcut(GetScript("Shortcut"));
    b_Vertical = ButtonHandle(GetHandle("ShortcutWnd.ShortcutWndVertical.btnKeyOption"));
    b_Vertical.SetTooltipCustomType(SetTooltip("Shortcut's Settings"));
    b_Horizontal = ButtonHandle(GetHandle("ShortcutWnd.ShortcutWndHorizontal.btnKeyOption"));
    b_Horizontal.SetTooltipCustomType(SetTooltip("Shortcut's Settings"));
    return;
}

function InitLayout()
{
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("InterfaceAI_KeySettingWnd.Title", "Shortcut Binds");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("InterfaceAI_KeySettingWnd.Head_Keys", "Preset:");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("InterfaceAI_KeySettingWnd.txtEnterChat", "Enter chat");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd.Head_Sockets");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd.txtCheckBind1");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd.txtCheckBind2");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd.txtCheckBind3");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd.checkUseBind1");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd.checkUseBind2");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd.checkUseBind3");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd.comboPanel2");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd.comboPanel3");
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("InterfaceAI_KeySettingWnd.Head_Keys", "InterfaceAI_KeySettingWnd.Tex", "TopLeft", "TopLeft", 21, 90);
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("InterfaceAI_KeySettingWnd.comboPanel1", "InterfaceAI_KeySettingWnd.Tex", "TopLeft", "TopLeft", 21, 111);
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("InterfaceAI_KeySettingWnd.comboPanel1", 120, 20);
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("InterfaceAI_KeySettingWnd.comboPanel1");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("InterfaceAI_KeySettingWnd.comboPanel1", "F / 1 / Q");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("InterfaceAI_KeySettingWnd.comboPanel1", "F / 1");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("InterfaceAI_KeySettingWnd.comboPanel1", "Q / 1 / F");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("InterfaceAI_KeySettingWnd.comboPanel1", "1 / F / Q");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("InterfaceAI_KeySettingWnd.comboPanel1", "1 / F");
    return;
}

function LoadData()
{
    ShortcutBindType = GetOptionInt("Game", "ShortcutBindType");
    // End:0x1F
    if(ShortcutBindType < 0)
    {
        ShortcutBindType = 0;
    }
    // End:0x31
    if(ShortcutBindType > 4)
    {
        ShortcutBindType = 0;
    }
    UseEnterChat = GetOptionBool("Game", "EnterChatting");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("InterfaceAI_KeySettingWnd.checkEnterChat", UseEnterChat);
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel1", ShortcutBindType);
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        case "btnKeyOK":
            OnClickKeyOk();
            break;
        case "btnKeyCancel":
            OnClickKeyCancel();
            break;
        default:
            break;
    }
    return;
}

function OnClickKeyCancel()
{
    Me.HideWindow();
    return;
}

function OnClickKeyOk()
{
    ShortcutBindType = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel1");
    script.SetShortcutBindType(UseEnterChat, ShortcutBindType);
    Me.HideWindow();
    return;
}

function OnClickCheckBox(string strID)
{
    switch(strID)
    {
        case "checkEnterChat":
            UseEnterChat = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_KeySettingWnd.checkEnterChat");
            break;
        default:
            break;
    }
    return;
}

function CustomTooltip SetTooltip(string Text)
{
    local CustomTooltip ToolTip;
    local DrawItemInfo Info;

    ToolTip.DrawList.Length = 1;
    Info.eType = DIT_TEXT;
    Info.t_strText = Text;
    ToolTip.DrawList[0] = Info;
    return ToolTip;
}
