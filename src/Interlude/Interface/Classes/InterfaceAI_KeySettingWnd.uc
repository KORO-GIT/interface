class InterfaceAI_KeySettingWnd extends UICommonAPI;

var WindowHandle Me;
var Shortcut script;
var bool UseEnterChat;
var bool UseBind1;
var bool UseBind2;
var bool UseBind3;
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
    UseEnterChat = GetOptionBool("Game", "EnterChatting");
    // End:0x124
    if(Panel1 <= 0)
    {
        Panel1 = 1;
    }
    // End:0x136
    if(Panel2 <= 0)
    {
        Panel2 = 1;
    }
    // End:0x148
    if(Panel3 <= 0)
    {
        Panel3 = 1;
    }
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("InterfaceAI_KeySettingWnd.checkUseBind1", UseBind1);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("InterfaceAI_KeySettingWnd.checkUseBind2", UseBind2);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("InterfaceAI_KeySettingWnd.checkUseBind3", UseBind3);
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
    Panel1 = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel1") + 1;
    Panel2 = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel2") + 1;
    Panel3 = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel3") + 1;
    script.ResetParam(UseEnterChat, UseBind1, UseBind2, UseBind3, Panel1, Panel2, Panel3);
    return;
}

function OnClickCheckBox(string strID)
{
    switch(strID)
    {
        // End:0x6C
        case "checkEnterChat":
            // End:0x61
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_KeySettingWnd.checkEnterChat"))
            {
                UseEnterChat = true;                
            }
            else
            {
                UseEnterChat = false;
            }
            // End:0x198
            break;
        // End:0xCF
        case "checkUseBind1":
            // End:0xC4
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_KeySettingWnd.checkUseBind1"))
            {
                UseBind1 = true;                
            }
            else
            {
                UseBind1 = false;
            }
            // End:0x198
            break;
        // End:0x132
        case "checkUseBind2":
            // End:0x127
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_KeySettingWnd.checkUseBind2"))
            {
                UseBind2 = true;                
            }
            else
            {
                UseBind2 = false;
            }
            // End:0x198
            break;
        // End:0x195
        case "checkUseBind3":
            // End:0x18A
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_KeySettingWnd.checkUseBind3"))
            {
                UseBind3 = true;                
            }
            else
            {
                UseBind3 = false;
            }
            // End:0x198
            break;
        // End:0xFFFF
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
