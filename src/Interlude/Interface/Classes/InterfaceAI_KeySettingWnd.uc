class InterfaceAI_KeySettingWnd extends UICommonAPI;

var WindowHandle Me;
var Shortcut script;
var bool UseEnterChat;
var int Panel1;
var int Panel2;
var int Panel3;
var ButtonHandle b_Vertical;
var ButtonHandle b_Horizontal;
var bool bUpdatingPanelCombos;

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
    if(Panel1 == 0)
    {
        Panel1 = 2;
    }
    if(Panel1 > 6)
    {
        Panel1 = 6;
    }
    // End:0x136
    if(Panel2 == 0)
    {
        Panel2 = 3;
    }
    if(Panel2 > 6)
    {
        Panel2 = 6;
    }
    // End:0x148
    if(Panel3 == 0)
    {
        Panel3 = 1;
    }
    if(Panel3 > 6)
    {
        Panel3 = 6;
    }
    EnsureUniquePanels(0);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("InterfaceAI_KeySettingWnd.checkEnterChat", UseEnterChat);
    UpdatePanelCombos();
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
    Panel1 = GetPanelFromComboIndex(Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel1"));
    Panel2 = GetPanelFromComboIndex(Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel2"));
    Panel3 = GetPanelFromComboIndex(Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel3"));
    EnsureUniquePanels(0);
    UpdatePanelCombos();
    script.ResetParam(UseEnterChat, true, true, true, Panel1, Panel2, Panel3);
    Me.HideWindow();
    return;
}

function OnComboBoxItemSelected(string strID, int Index)
{
    if(bUpdatingPanelCombos)
    {
        return;
    }
    switch(strID)
    {
        case "ComboPanel1":
        case "comboPanel1":
            Panel1 = GetPanelFromComboIndex(Index);
            EnsureUniquePanels(1);
            UpdatePanelCombos();
            break;
        case "ComboPanel2":
        case "comboPanel2":
            Panel2 = GetPanelFromComboIndex(Index);
            EnsureUniquePanels(2);
            UpdatePanelCombos();
            break;
        case "ComboPanel3":
        case "comboPanel3":
            Panel3 = GetPanelFromComboIndex(Index);
            EnsureUniquePanels(3);
            UpdatePanelCombos();
            break;
        default:
            break;
    }
    return;
}

function UpdatePanelCombos()
{
    bUpdatingPanelCombos = true;
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel1", GetComboIndexFromPanel(Panel1));
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel2", GetComboIndexFromPanel(Panel2));
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("InterfaceAI_KeySettingWnd.comboPanel3", GetComboIndexFromPanel(Panel3));
    bUpdatingPanelCombos = false;
    return;
}

function int GetPanelFromComboIndex(int Index)
{
    if(Index >= 6)
    {
        return -1;
    }
    return NormalizePanel(Index + 1);
}

function int GetComboIndexFromPanel(int PanelIndex)
{
    if(PanelIndex < 1)
    {
        return 6;
    }
    return NormalizePanel(PanelIndex) - 1;
}

function int FindFreePanel(int UsedPanel1, int UsedPanel2, int UsedPanel3)
{
    local int PanelIndex;

    PanelIndex = 1;
    while(PanelIndex <= 6)
    {
        if((PanelIndex != UsedPanel1) && (PanelIndex != UsedPanel2) && (PanelIndex != UsedPanel3))
        {
            return PanelIndex;
        }
        PanelIndex++;
    }
    return 1;
}

function EnsureUniquePanels(int ChangedBind)
{
    Panel1 = NormalizePanel(Panel1);
    Panel2 = NormalizePanel(Panel2);
    Panel3 = NormalizePanel(Panel3);
    switch(ChangedBind)
    {
        case 1:
            if((Panel1 > 0) && (Panel2 == Panel1))
            {
                Panel2 = FindFreePanel(Panel1, Panel3, 0);
            }
            if((Panel3 > 0) && ((Panel3 == Panel1) || (Panel3 == Panel2)))
            {
                Panel3 = FindFreePanel(Panel1, Panel2, 0);
            }
            break;
        case 2:
            if((Panel2 > 0) && (Panel1 == Panel2))
            {
                Panel1 = FindFreePanel(Panel2, Panel3, 0);
            }
            if((Panel3 > 0) && ((Panel3 == Panel1) || (Panel3 == Panel2)))
            {
                Panel3 = FindFreePanel(Panel1, Panel2, 0);
            }
            break;
        case 3:
            if((Panel3 > 0) && (Panel1 == Panel3))
            {
                Panel1 = FindFreePanel(Panel2, Panel3, 0);
            }
            if((Panel2 > 0) && ((Panel2 == Panel1) || (Panel2 == Panel3)))
            {
                Panel2 = FindFreePanel(Panel1, Panel3, 0);
            }
            break;
        default:
            if((Panel1 > 0) && (Panel2 == Panel1))
            {
                Panel2 = FindFreePanel(Panel1, Panel3, 0);
            }
            if((Panel3 > 0) && ((Panel3 == Panel1) || (Panel3 == Panel2)))
            {
                Panel3 = FindFreePanel(Panel1, Panel2, 0);
            }
            break;
    }
    return;
}

function int NormalizePanel(int PanelIndex)
{
    if(PanelIndex < 0)
    {
        return -1;
    }
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
