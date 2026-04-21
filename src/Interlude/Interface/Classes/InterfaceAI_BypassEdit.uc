class InterfaceAI_BypassEdit extends UICommonAPI;

var WindowHandle Me;
var WindowHandle RefOption;
var WindowHandle UnRefOption;
var CheckBoxHandle checkIsCrypt;
var CheckBoxHandle checkUseRefBypass;
var CheckBoxHandle checkUseUnRefBypass;
var CheckBoxHandle checkUseRefBypass_1;
var CheckBoxHandle checkUseRefBypass_2;
var CheckBoxHandle checkUseRefBypass_3;
var CheckBoxHandle checkUseUnRefBypass_1;
var CheckBoxHandle checkUseUnRefBypass_2;
var CheckBoxHandle checkUseUnRefBypass_3;
var EditBoxHandle editBypassRef_1;
var EditBoxHandle editBypassRef_2;
var EditBoxHandle editBypassRef_3;
var EditBoxHandle editBypassUnRef_1;
var EditBoxHandle editBypassUnRef_2;
var EditBoxHandle editBypassUnRef_3;
var string RefBypass_1;
var string RefBypass_2;
var string RefBypass_3;
var string UnRefBypass_1;
var string UnRefBypass_2;
var string UnRefBypass_3;
var bool UseRefinedBypass_1;
var bool UseRefinedBypass_2;
var bool UseRefinedBypass_3;
var bool UseUnRefinedBypass_1;
var bool UseUnRefinedBypass_2;
var bool UseUnRefinedBypass_3;
var bool UseRefinedBypass;
var bool UseUnRefinedBypass;
var bool UseCryptBypass;
var EnchantAIWnd script;

function OnLoad()
{
    InitHandle();
    LoadData();
    return;
}

function LoadData()
{
    local int IntUseCryptBypass, IntUseRefinedBypass, IntUseRefinedBypass_1, IntUseRefinedBypass_2, IntUseRefinedBypass_3, IntUseUnRefinedBypass,
	    IntUseUnRefinedBypass_1, IntUseUnRefinedBypass_2, IntUseUnRefinedBypass_3;

    GetINIString("AutoRefinery", "RefinedBypass_1", RefBypass_1, "Option");
    GetINIString("AutoRefinery", "RefinedBypass_2", RefBypass_2, "Option");
    GetINIString("AutoRefinery", "RefinedBypass_3", RefBypass_3, "Option");
    GetINIString("AutoRefinery", "UnRefinedBypass_1", UnRefBypass_1, "Option");
    GetINIString("AutoRefinery", "UnRefinedBypass_2", UnRefBypass_2, "Option");
    GetINIString("AutoRefinery", "UnRefinedBypass_3", UnRefBypass_3, "Option");
    GetINIBool("AutoRefinery", "UseCryptBypass", IntUseCryptBypass, "Option");
    GetINIBool("AutoRefinery", "UseRefinedBypass", IntUseRefinedBypass, "Option");
    GetINIBool("AutoRefinery", "UseUnRefinedBypass", IntUseUnRefinedBypass, "Option");
    GetINIBool("AutoRefinery", "UseRefinedBypass_1", IntUseRefinedBypass_1, "Option");
    GetINIBool("AutoRefinery", "UseRefinedBypass_2", IntUseRefinedBypass_2, "Option");
    GetINIBool("AutoRefinery", "UseRefinedBypass_3", IntUseRefinedBypass_3, "Option");
    GetINIBool("AutoRefinery", "UseUnRefinedBypass_1", IntUseUnRefinedBypass_1, "Option");
    GetINIBool("AutoRefinery", "UseUnRefinedBypass_2", IntUseUnRefinedBypass_2, "Option");
    GetINIBool("AutoRefinery", "UseUnRefinedBypass_3", IntUseUnRefinedBypass_3, "Option");
    UseCryptBypass = bool(IntUseCryptBypass);
    UseRefinedBypass = bool(IntUseRefinedBypass);
    UseUnRefinedBypass = bool(IntUseUnRefinedBypass);
    UseRefinedBypass_1 = bool(IntUseRefinedBypass_1);
    UseRefinedBypass_2 = bool(IntUseRefinedBypass_2);
    UseRefinedBypass_3 = bool(IntUseRefinedBypass_3);
    UseUnRefinedBypass_1 = bool(IntUseUnRefinedBypass_1);
    UseUnRefinedBypass_2 = bool(IntUseUnRefinedBypass_2);
    UseUnRefinedBypass_3 = bool(IntUseUnRefinedBypass_3);
    return;
}

function InitHandle()
{
    Me = GetHandle("InterfaceAI_BypassEdit");
    RefOption = GetHandle("InterfaceAI_BypassEdit.BypassEditRefWnd");
    UnRefOption = GetHandle("InterfaceAI_BypassEdit.BypassEditUnRefWnd");
    checkIsCrypt = CheckBoxHandle(GetHandle("InterfaceAI_BypassEdit.checkIsCryptBypass"));
    checkUseRefBypass = CheckBoxHandle(GetHandle("InterfaceAI_BypassEdit.checkUseRefBypass"));
    checkUseUnRefBypass = CheckBoxHandle(GetHandle("InterfaceAI_BypassEdit.checkUseUnRefBypass"));
    checkUseRefBypass_1 = CheckBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditRefWnd.checkUseBypassRef_1"));
    checkUseRefBypass_2 = CheckBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditRefWnd.checkUseBypassRef_2"));
    checkUseRefBypass_3 = CheckBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditRefWnd.checkUseBypassRef_3"));
    checkUseUnRefBypass_1 = CheckBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditUnRefWnd.checkUseBypassUnRef_1"));
    checkUseUnRefBypass_2 = CheckBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditUnRefWnd.checkUseBypassUnRef_2"));
    checkUseUnRefBypass_3 = CheckBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditUnRefWnd.checkUseBypassUnRef_3"));
    editBypassRef_1 = EditBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditRefWnd.EditRefBypass_1"));
    editBypassRef_2 = EditBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditRefWnd.EditRefBypass_2"));
    editBypassRef_3 = EditBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditRefWnd.EditRefBypass_3"));
    editBypassUnRef_1 = EditBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditUnRefWnd.EditUnRefBypass_1"));
    editBypassUnRef_2 = EditBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditUnRefWnd.EditUnRefBypass_2"));
    editBypassUnRef_3 = EditBoxHandle(GetHandle("InterfaceAI_BypassEdit.BypassEditUnRefWnd.EditUnRefBypass_3"));
    script = EnchantAIWnd(GetScript("EnchantAIWnd"));
    return;
}

function OnShow()
{
    checkIsCrypt.SetCheck(UseCryptBypass);
    checkUseRefBypass.SetCheck(UseRefinedBypass);
    checkUseUnRefBypass.SetCheck(UseUnRefinedBypass);
    checkUseRefBypass_1.SetCheck(UseRefinedBypass_1);
    checkUseRefBypass_2.SetCheck(UseRefinedBypass_2);
    checkUseRefBypass_3.SetCheck(UseRefinedBypass_3);
    checkUseUnRefBypass_1.SetCheck(UseUnRefinedBypass_1);
    checkUseUnRefBypass_2.SetCheck(UseUnRefinedBypass_2);
    checkUseUnRefBypass_2.SetCheck(UseUnRefinedBypass_3);
    editBypassRef_1.SetString(RefBypass_1);
    editBypassRef_2.SetString(RefBypass_2);
    editBypassRef_3.SetString(RefBypass_3);
    editBypassUnRef_1.SetString(UnRefBypass_1);
    editBypassUnRef_2.SetString(UnRefBypass_2);
    editBypassUnRef_2.SetString(UnRefBypass_3);
    // End:0x150
    if(UseRefinedBypass)
    {
        RefOption.EnableWindow();        
    }
    else
    {
        RefOption.DisableWindow();
    }
    // End:0x17A
    if(UseUnRefinedBypass)
    {
        UnRefOption.EnableWindow();        
    }
    else
    {
        UnRefOption.DisableWindow();
    }
    InitLocalization();
    return;
}

function OnHide()
{
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x30
        case "btnBypassEditClose":
            Me.HideWindow();
            // End:0x5B
            break;
        // End:0x58
        case "btnBypassOK":
            BypassApplyParam();
            Me.HideWindow();
            // End:0x5B
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function BypassApplyParam()
{
    script.NPC_Simul_SetParam(true, UseCryptBypass, UseRefinedBypass, UseRefinedBypass_1, UseRefinedBypass_2, UseRefinedBypass_3, UseUnRefinedBypass, UseUnRefinedBypass_1, UseUnRefinedBypass_2, UseUnRefinedBypass_3, RefBypass_1, RefBypass_2, RefBypass_3, UnRefBypass_1, UnRefBypass_2, UnRefBypass_3);
    return;
}

function OnClickCheckBox(string strID)
{
    switch(strID)
    {
        // End:0x71
        case "checkIsCryptBypass":
            // End:0x66
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_BypassEdit.checkIsCryptBypass"))
            {
                UseCryptBypass = true;                
            }
            else
            {
                UseCryptBypass = false;
            }
            // End:0x484
            break;
        // End:0xF7
        case "checkUseRefBypass":
            // End:0xDD
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_BypassEdit.checkUseRefBypass"))
            {
                UseRefinedBypass = true;
                RefOption.EnableWindow();                
            }
            else
            {
                UseRefinedBypass = false;
                RefOption.DisableWindow();
            }
            // End:0x484
            break;
        // End:0x181
        case "checkUseUnRefBypass":
            // End:0x167
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_BypassEdit.checkUseUnRefBypass"))
            {
                UseUnRefinedBypass = true;
                UnRefOption.EnableWindow();                
            }
            else
            {
                UseUnRefinedBypass = false;
                UnRefOption.DisableWindow();
            }
            // End:0x484
            break;
        // End:0x1FE
        case "checkUseBypassRef_1":
            // End:0x1F3
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_BypassEdit.BypassEditRefWnd.checkUseBypassRef_1"))
            {
                UseRefinedBypass_1 = true;                
            }
            else
            {
                UseRefinedBypass_1 = false;
            }
            // End:0x484
            break;
        // End:0x27B
        case "checkUseBypassRef_2":
            // End:0x270
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_BypassEdit.BypassEditRefWnd.checkUseBypassRef_2"))
            {
                UseRefinedBypass_2 = true;                
            }
            else
            {
                UseRefinedBypass_2 = false;
            }
            // End:0x484
            break;
        // End:0x2F8
        case "checkUseBypassRef_3":
            // End:0x2ED
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_BypassEdit.BypassEditRefWnd.checkUseBypassRef_3"))
            {
                UseRefinedBypass_3 = true;                
            }
            else
            {
                UseRefinedBypass_3 = false;
            }
            // End:0x484
            break;
        // End:0x37B
        case "checkUseBypassUnRef_1":
            // End:0x370
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_BypassEdit.BypassEditUnRefWnd.checkUseBypassUnRef_1"))
            {
                UseUnRefinedBypass_1 = true;                
            }
            else
            {
                UseUnRefinedBypass_1 = false;
            }
            // End:0x484
            break;
        // End:0x3FE
        case "checkUseBypassUnRef_2":
            // End:0x3F3
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_BypassEdit.BypassEditUnRefWnd.checkUseBypassUnRef_2"))
            {
                UseUnRefinedBypass_2 = true;                
            }
            else
            {
                UseUnRefinedBypass_2 = false;
            }
            // End:0x484
            break;
        // End:0x481
        case "checkUseBypassUnRef_3":
            // End:0x476
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("InterfaceAI_BypassEdit.BypassEditUnRefWnd.checkUseBypassUnRef_3"))
            {
                UseUnRefinedBypass_3 = true;                
            }
            else
            {
                UseUnRefinedBypass_3 = false;
            }
            // End:0x484
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnChangeEditBox(string strID)
{
    switch(strID)
    {
        // End:0x33
        case "EditRefBypass_1":
            RefBypass_1 = editBypassRef_1.GetString();
            // End:0x118
            break;
        // End:0x5F
        case "EditRefBypass_2":
            RefBypass_2 = editBypassRef_2.GetString();
            // End:0x118
            break;
        // End:0x8B
        case "EditRefBypass_3":
            RefBypass_3 = editBypassRef_3.GetString();
            // End:0x118
            break;
        // End:0xB9
        case "EditUnRefBypass_1":
            UnRefBypass_1 = editBypassUnRef_1.GetString();
            // End:0x118
            break;
        // End:0xE7
        case "EditUnRefBypass_2":
            UnRefBypass_2 = editBypassUnRef_2.GetString();
            // End:0x118
            break;
        // End:0x115
        case "EditUnRefBypass_3":
            UnRefBypass_3 = editBypassUnRef_3.GetString();
            // End:0x118
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function InitLocalization()
{
    local string TextUseRefBypass, TextUseUnRefBypass;

    TextUseRefBypass = "Use Refinery bypass?";
    TextUseUnRefBypass = "Use UnRefinery bypass?";
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("InterfaceAI_BypassEdit.txtUseRefBypass", TextUseRefBypass);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("InterfaceAI_BypassEdit.txtUseUnRefBypass", TextUseUnRefBypass);
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
