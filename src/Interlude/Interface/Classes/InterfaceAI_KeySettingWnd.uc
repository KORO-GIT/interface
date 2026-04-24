class InterfaceAI_KeySettingWnd extends UICommonAPI;

var WindowHandle Me;
var Shortcut script;
var bool UseEnterChat;
var int Panel1;
var int Panel2;
var int Panel3;
var ButtonHandle b_Vertical;
var ButtonHandle b_Horizontal;

function OnLoad()
{
    InitHandle();
    LoadData();
    return;
}

function LoadData()
{
    GetINIInt("Key", "Panel1", Panel1, "Option");
    GetINIInt("Key", "Panel2", Panel2, "Option");
    GetINIInt("Key", "Panel3", Panel3, "Option");
    UseEnterChat = GetOptionBool("Game", "EnterChatting");
    // End:0x124
    if(Panel1 <= 0)
    {
        Panel1 = 1;
    }
    if(Panel1 > 6)
    {
        Panel1 = 6;
    }
    // End:0x136
    if(Panel2 <= 0)
    {
        Panel2 = 1;
    }
    if(Panel2 > 6)
    {
        Panel2 = 6;
    }
    // End:0x148
    if(Panel3 <= 0)
    {
        Panel3 = 1;
    }
    if(Panel3 > 6)
    {
        Panel3 = 6;
    }
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("InterfaceAI_KeySettingWnd.checkEnterChat", UseEnterChat);
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel1", Panel1 - 1);
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel2", Panel2 - 1);
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel3", Panel3 - 1);
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

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1D
        case "btnKeyOK":
            OnClickKeyOk();
            // End:0x3A
            break;
        // End:0x37
        case "btnKeyCancel":
            OnClickKeyCancel();
            // End:0x3A
            break;
        // End:0xFFFF
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
    Panel1 = NormalizePanel(Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel1") + 1);
    Panel2 = NormalizePanel(Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel2") + 1);
    Panel3 = NormalizePanel(Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel3") + 1);
    script.ResetParam(UseEnterChat, true, true, true, Panel1, Panel2, Panel3);
    Me.HideWindow();
    return;
}

function int NormalizePanel(int PanelIndex)
{
    if(PanelIndex < 1)
    {
        return 1;
    }
    if(PanelIndex > 6)
    {
        return 6;
    }
    return PanelIndex;
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
