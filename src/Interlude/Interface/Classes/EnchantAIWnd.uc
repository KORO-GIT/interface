class EnchantAIWnd extends UICommonAPI;

const TIMER_ENCHANT_ID = 10300;
const TIMER_ENCHANT_FUN_ID = 10301;
const TIMER_REFINERY_NPC_UNREF_ID = 10450;
const TIMER_REFINERY_NPC_REF_ID = 10451;
const TIMER_REFINERY_UNREF_ID = 10452;
const TIMER_REFINERY_WEAPON_ID = 10453;
const TIMER_REFINERY_LIFESTONE_ID = 10454;
const TIMER_REFINERY_GEMSTONE_ID = 10455;
const TIMER_REFINERY_FINAL_ID = 10456;
const TIMER_REFINERY_REF_BYPASS_1_ID = 10457;
const TIMER_REFINERY_REF_BYPASS_2_ID = 10458;
const TIMER_REFINERY_REF_BYPASS_3_ID = 10459;
const TIMER_REFINERY_UNREF_BYPASS_1_ID = 10460;
const TIMER_REFINERY_UNREF_BYPASS_2_ID = 10461;
const TIMER_REFINERY_UNREF_BYPASS_3_ID = 10462;
const TIMER_SKILL_ID = 10500;
const MULTY_LS_SlIDER = 250;

var WindowHandle m_hHelpWnd;
var WindowHandle Me;
var bool IsMinimized;
var ButtonHandle b_GetNPCInfo;
var ButtonHandle b_SelectEdit;
var ButtonHandle b_CustomEdit;
var ButtonHandle b_BypassEdit;
var CheckBoxHandle checkScrollSave;
var CheckBoxHandle checkScrollDestroy;
var CheckBoxHandle checkScrollStack;
var ItemWindowHandle m_DragboxItem1;
var ItemWindowHandle m_DragboxItem11;
var ItemWindowHandle m_DragBoxItem2;
var ItemWindowHandle m_DragboxItem3;
var ItemWindowHandle m_DragBoxItem4;
var ItemWindowHandle m_DragBoxItem5;
var ItemWindowHandle m_InventoryList;
var array<string> InventorySlot;
var ItemInfo ScrollItemInfo;
var ItemInfo BlessScrollItemInfo;
var ItemInfo EquipItemInfo;
var ItemInfo WeaponItemInfo;
var ItemInfo LifeStoneItemInfo;
var ItemInfo GemStoneItemInfo;
var ItemInfo SelectedSkillInfo;
var int EquipItemServerID;
var int BlessScrollServerID;
var int ScrollServerID;
var int GemstoneCount;
var bool EnableEnchantProcess;
var bool EnableRefineryProcess;
var bool EnableSkillProcess;
var bool EnchantItem_UseOldScroll;
var bool EnchantItem_UseDestrItem;
var bool EnchantItem_IsStack;
var bool EnchantItem_UpdateBless;
var int EnchantItem_ResetTo;
var int EnchantItem_Power;
var int EnchantItem_Record;
var int EnchantItem_EnchantTo;
var int EnchantItem_EnchantSaveTo;
var int EnchantItem_CurrentEnchantLevel;
var int ComboEnchantSelect;
var int EnchantSkillLimit;
var TextBoxHandle m_InstructionText;
var TextBoxHandle m_InstructionText2;
var TextBoxHandle m_InstructionText3;
var bool SearchAll;
var bool SearchPassive;
var bool SearchActive;
var bool SearchChance;
var bool SearchStat;
var bool SearchSelect;
var bool SearchCustom;
var int SearchQuality;
var int TIMER_ENCHANT_DELAY;
var int TIMER_ENCHANT2_DELAY;
var int TIMER_REFINERY_NPCTALK_DELAY;
var int TIMER_REFINERY_UNREF_DELAY;
var int TIMER_REFINERY_WEAPON_DELAY;
var int TIMER_REFINERY_LIFESTONE_DELAY;
var int TIMER_REFINERY_GEMSTONE_DELAY;
var int TIMER_REFINERY_FINAL_DELAY;
var bool EnchantInUse;
var int TIMER_ENCHANTSKILL_DELAY;
var string EnchantInstruction_SelectScroll;
var string EnchantInstruction_SelectItem;
var string EnchantInstruction_CheckOption;
var string EnchantInstruction_Process;
var string EnchantInstruction_Result;
var string EnchantInstruction_Stop;
var string EnchantInstruction_Error_Destroy;
var string EnchantInstruction_Error_ScrollEnd;
var string DelayScroll;
var string DelayEnchant;
var string DelayScrollTooltip;
var string DelayEnchantTooltip;
var string Second;
var string Quantity;
var string NpcInfoDefault;
var string NpcInfoName;
var string NpcInfoID;
var string DelayNPC;
var string DelayUN;
var string DelayWP;
var string DelayLS;
var string DelayGS;
var string DelayConfirm;
var string DelayNPCTooltip;
var string DelayUNTooltip;
var string DelayWPTooltip;
var string DelayLSTooltip;
var string DelayGSTooltip;
var string DelayConfirmTooltip;
var string RefineryInstruction_SelectWeapon;
var string RefineryInstruction_SelectLS;
var string RefineryInstruction_CheckOption;
var string RefineryInstruction_Process;
var string RefineryInstruction_Stop;
var string RefineryInstruction_Result;
var string RefineryInstruction_Error_NPC;
var string RefineryInstruction_Error_LS;
var string RefineryInstruction_Error_GS;
var string RefineryInstruction_Error_Adena;
var string RefineryInstruction_Error_FULL;
var string RefineryBypass;
var string UnRefineryBypass;
var string SkillDelay;
var string SkillDelayTooltip;
var string SkillInstruction_Result;
var string SkillInstruction_CheckOption;
var string SkillInstruction_Process;
var string SkillInstruction_SelectSkill;
var string SkillInstruction_Error_NoEnchant;
var string SkillInstruction_Error_NoBook;
var string SkillInstruction_Error_EnchantLimit;
var UserInfo NpcInfo;
var bool UseNpcSimulation;
var string RefBypass_1;
var string RefBypass_2;
var string RefBypass_3;
var string UnRefBypass_1;
var string UnRefBypass_2;
var string UnRefBypass_3;
var string CryptRefBypass_1;
var string CryptRefBypass_2;
var string CryptRefBypass_3;
var string CryptUnRefBypass_1;
var string CryptUnRefBypass_2;
var string CryptUnRefBypass_3;
var bool UseRefinedBypass_1;
var bool UseRefinedBypass_2;
var bool UseRefinedBypass_3;
var bool UseUnRefinedBypass_1;
var bool UseUnRefinedBypass_2;
var bool UseUnRefinedBypass_3;
var bool UseRefinedBypass;
var bool UseUnRefinedBypass;
var bool UseCryptBypass;

function OnLoad()
{
    RegisterEvents();
    RegisterXmls();
    CheckFirst();
    Innit();
    Reset();
    return;
}

function RegisterXmls()
{
    m_hHelpWnd = GetHandle("EnchantAIHelpWnd");
    Me = GetHandle("EnchantAIWnd");
    m_DragboxItem1 = ItemWindowHandle(GetHandle("EnchantAIWnd.ItemDragBoxe1Wnd.ItemDragBox1"));
    m_DragboxItem11 = ItemWindowHandle(GetHandle("EnchantAIWnd.ItemDragBox11Wnd.ItemDragBox11"));
    m_DragBoxItem2 = ItemWindowHandle(GetHandle("EnchantAIWnd.ItemDragBoxe2Wnd.ItemDragBox2"));
    m_DragboxItem3 = ItemWindowHandle(GetHandle("EnchantAIWnd.ItemDragBox3Wnd.ItemDragBox3"));
    m_DragBoxItem4 = ItemWindowHandle(GetHandle("EnchantAIWnd.ItemDragBox4Wnd.ItemDragBox4"));
    m_DragBoxItem5 = ItemWindowHandle(GetHandle("EnchantAIWnd.ItemDragBox5Wnd.ItemDragBox5"));
    m_InventoryList = ItemWindowHandle(GetHandle("InventoryWnd.InventoryItem"));
    checkScrollSave = CheckBoxHandle(GetHandle("InventoryWnd.checkSaveEnchant"));
    checkScrollDestroy = CheckBoxHandle(GetHandle("InventoryWnd.checkUseDestroyItem"));
    checkScrollStack = CheckBoxHandle(GetHandle("InventoryWnd.checkIsStuck"));
    b_GetNPCInfo = ButtonHandle(GetHandle("EnchantAIWnd.btnGetNPCInfo"));
    b_SelectEdit = ButtonHandle(GetHandle("EnchantAIWnd.btnSelectEdit"));
    b_CustomEdit = ButtonHandle(GetHandle("EnchantAIWnd.btnCustomEdit"));
    b_BypassEdit = ButtonHandle(GetHandle("EnchantAIWnd.btnBypassEdit"));
    m_InstructionText = TextBoxHandle(GetHandle("EnchantAIWnd.txtInstruction"));
    m_InstructionText2 = TextBoxHandle(GetHandle("EnchantAIWnd.txtInstruction2"));
    m_InstructionText3 = TextBoxHandle(GetHandle("EnchantAIWnd.txtInstruction3"));
    return;
}

function RegisterEvents()
{
    RegisterEvent(2770);
    RegisterEvent(2780);
    RegisterEvent(2790);
    RegisterEvent(2800);
    RegisterEvent(2040);
    RegisterEvent(2890);
    RegisterEvent(580);
    RegisterEvent(980);
    RegisterEvent(990);
    RegisterEvent(2820);
    RegisterEvent(2830);
    return;
}

function OnHide()
{
    // End:0x0C
    if(IsMinimized)
    {        
    }
    else
    {
        Reset();
    }
    return;
}

function OnShow()
{
    // End:0x14
    if(IsMinimized)
    {
        IsMinimized = false;        
    }
    else
    {
        Reset();
        IsMinimized = false;
    }
    SetFocus();
    return;
}

function OnMinimize()
{
    IsMinimized = true;
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x28
        case 580:
            // End:0x25
            if(!EnchantInUse)
            {
                HandleSystemMessage(a_Param);
            }
            // End:0xA5
            break;
        // End:0x3E
        case 2780:
            EV_GameStoneCheck(a_Param);
            // End:0xA5
            break;
        // End:0x4F
        case 980:
            TargetUpdate();
            // End:0xA5
            break;
        // End:0x60
        case 990:
            ClearNpcInfo();
            // End:0xA5
            break;
        // End:0x76
        case 2800:
            RefineryResult(a_Param);
            // End:0xA5
            break;
        // End:0x8C
        case 2820:
            RefineryCancelResult(a_Param);
            // End:0xA5
            break;
        // End:0xA2
        case 2830:
            OnUnRefineDoneResult(a_Param);
            // End:0xA5
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function TargetUpdate()
{
    local int m_nowTargetID;

    m_nowTargetID = Class'NWindow.UIDATA_TARGET'.static.GetTargetID();
    // End:0x2F
    if(NpcInfo.nID != m_nowTargetID)
    {
        ClearNpcInfo();
    }
    return;
}

function Reset()
{
    m_DragboxItem1.Clear();
    m_DragboxItem11.Clear();
    m_DragBoxItem2.Clear();
    m_DragboxItem1.EnableWindow();
    m_DragBoxItem2.DisableWindow();
    m_DragboxItem3.EnableWindow();
    m_DragBoxItem4.DisableWindow();
    m_InstructionText.SetText(EnchantInstruction_SelectScroll);
    m_InstructionText2.SetText(RefineryInstruction_SelectWeapon);
    m_InstructionText3.SetText(SkillInstruction_SelectSkill);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.valRecord", "");
    Class'NWindow.UIAPI_EDITBOX'.static.SetString("EnchantAIWnd.editCount", "0");
    Class'NWindow.UIAPI_EDITBOX'.static.SetString("EnchantAIWnd.editEnchantLvl", "0");
    ClearNpcInfo();
    ComboEnchantSelect = 0;
    UpdateEnchantSkillParam();
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("EnchantAIWnd.ItemEnchantTab.txtEquipItem", "ItemDragBoxe2Wnd", "TopCenter", "TopCenter", 0, 40);
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("EnchantAIWnd.ItemEnchantTab.txtBlessScroll", "ItemDragBoxe1Wnd", "TopCenter", "TopCenter", 0, 40);
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("EnchantAIWnd.SkillEnchantTab.txtSkillSlot", "ItemDragBox5Wnd", "TopCenter", "TopCenter", 0, 40);
    EnchantInUse = true;
    return;
}

function Innit()
{
    local int UseNpcSimulRef, CurrentTick, IntUseCryptBypass, IntUseRefinedBypass, IntUseRefinedBypass_1, IntUseRefinedBypass_2,
	    IntUseRefinedBypass_3, IntUseUnRefinedBypass, IntUseUnRefinedBypass_1, IntUseUnRefinedBypass_2, IntUseUnRefinedBypass_3;

    GetINIBool("AutoRefinery", "UseCryptBypass", IntUseCryptBypass, "Option");
    GetINIString("AutoRefinery", "RefinedBypass_1", RefBypass_1, "Option");
    GetINIString("AutoRefinery", "RefinedBypass_2", RefBypass_2, "Option");
    GetINIString("AutoRefinery", "RefinedBypass_3", RefBypass_3, "Option");
    GetINIString("AutoRefinery", "UnRefinedBypass_1", UnRefBypass_1, "Option");
    GetINIString("AutoRefinery", "UnRefinedBypass_2", UnRefBypass_2, "Option");
    GetINIString("AutoRefinery", "UnRefinedBypass_3", UnRefBypass_3, "Option");
    GetINIBool("AutoRefinery", "UseRefinedBypass", IntUseRefinedBypass, "Option");
    GetINIBool("AutoRefinery", "UseUnRefinedBypass", IntUseUnRefinedBypass, "Option");
    GetINIBool("AutoRefinery", "UseRefinedBypass_1", IntUseRefinedBypass_1, "Option");
    GetINIBool("AutoRefinery", "UseRefinedBypass_2", IntUseRefinedBypass_2, "Option");
    GetINIBool("AutoRefinery", "UseRefinedBypass_3", IntUseRefinedBypass_3, "Option");
    GetINIBool("AutoRefinery", "UseUnRefinedBypass_1", IntUseUnRefinedBypass_1, "Option");
    GetINIBool("AutoRefinery", "UseUnRefinedBypass_2", IntUseUnRefinedBypass_2, "Option");
    GetINIBool("AutoRefinery", "UseUnRefinedBypass_3", IntUseUnRefinedBypass_3, "Option");
    NPC_Simul_SetParam(false, bool(IntUseCryptBypass), bool(IntUseRefinedBypass), bool(IntUseRefinedBypass_1), bool(IntUseRefinedBypass_2), bool(IntUseRefinedBypass_3), bool(IntUseUnRefinedBypass), bool(IntUseUnRefinedBypass_1), bool(IntUseUnRefinedBypass_2), bool(IntUseUnRefinedBypass_3), RefBypass_1, RefBypass_2, RefBypass_3, UnRefBypass_1, UnRefBypass_2, UnRefBypass_3);
    EnchantItem_EnchantSaveTo = 3;
    EnchantItem_Power = 1;
    EnchantItem_ResetTo = 0;
    EnchantItem_UseOldScroll = false;
    EnchantItem_UseDestrItem = false;
    EnchantItem_IsStack = true;
    EnchantItem_UpdateBless = true;
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkSaveEnchant", EnchantItem_UseOldScroll);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkUseDestroyItem", EnchantItem_UseDestrItem);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkIsStuck", EnchantItem_IsStack);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkBlessUpdate", EnchantItem_UpdateBless);
    Class'NWindow.UIAPI_EDITBOX'.static.SetString("EnchantAIWnd.ScrollEnchantLvlEdit", string(EnchantItem_EnchantSaveTo));
    InvetorySlotName();
    InitLocalization();
    GetINIInt("AutoEnchant", "Delay_ScrollSelect", CurrentTick, "Option");
    SetDelay("Delay_ScrollSelect", CurrentTick, 250, TIMER_ENCHANT_DELAY);
    Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("EnchantAIWnd.EnchantDelay1SliderCtrl", CurrentTick);
    GetINIInt("AutoEnchant", "Delay_EnchantItem", CurrentTick, "Option");
    SetDelay("Delay_EnchantItem", CurrentTick, 250, TIMER_ENCHANT2_DELAY);
    Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("EnchantAIWnd.EnchantDelay2SliderCtrl", CurrentTick);
    GetINIInt("AutoRefinery", "Delay_NPCTalk", CurrentTick, "Option");
    SetDelay("Delay_NPCTalk", CurrentTick, 250, TIMER_REFINERY_NPCTALK_DELAY);
    Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("EnchantAIWnd.RefineryDelay1SliderCtrl", CurrentTick);
    GetINIInt("AutoRefinery", "Delay_WP", CurrentTick, "Option");
    SetDelay("Delay_WP", CurrentTick, 250, TIMER_REFINERY_WEAPON_DELAY);
    Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("EnchantAIWnd.RefineryDelay2SliderCtrl", CurrentTick);
    GetINIInt("AutoRefinery", "Delay_LS", CurrentTick, "Option");
    SetDelay("Delay_LS", CurrentTick, 250, TIMER_REFINERY_LIFESTONE_DELAY);
    Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("EnchantAIWnd.RefineryDelay3SliderCtrl", CurrentTick);
    GetINIInt("AutoRefinery", "Delay_GS", CurrentTick, "Option");
    SetDelay("Delay_GS", CurrentTick, 250, TIMER_REFINERY_GEMSTONE_DELAY);
    Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("EnchantAIWnd.RefineryDelay4SliderCtrl", CurrentTick);
    GetINIInt("AutoRefinery", "Delay_UN", CurrentTick, "Option");
    SetDelay("Delay_UN", CurrentTick, 250, TIMER_REFINERY_UNREF_DELAY);
    Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("EnchantAIWnd.RefineryDelay5SliderCtrl", CurrentTick);
    GetINIInt("AutoRefinery", "Delay_Final", CurrentTick, "Option");
    SetDelay("Delay_Final", CurrentTick, 250, TIMER_REFINERY_FINAL_DELAY);
    Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("EnchantAIWnd.RefineryDelay6SliderCtrl", CurrentTick);
    GetINIInt("AutoEnchantSkill", "Delay_SkillEnchant", CurrentTick, "Option");
    SetDelay("Delay_SkillEnchant", CurrentTick, 250, TIMER_ENCHANTSKILL_DELAY);
    Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("EnchantAIWnd.SkillEnchantDelay1SliderCtrl", CurrentTick);
    GetINIBool("AutoRefinery", "UseNPCSimulation", UseNpcSimulRef, "Option");
    UseNpcSimulation = bool(UseNpcSimulRef);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkUseSimulRef", UseNpcSimulation);
    GetINIString("AutoRefinery", "NPCSimulationBypass_Ref", RefineryBypass, "Option");
    GetINIString("AutoRefinery", "NPCSimulationBypass_UnRef", UnRefineryBypass, "Option");
    ClearNpcInfo();
    SearchQuality = 0;
    ComboBox_Quality();
    ComboBoxParam();
    return;
}

function InitLocalization()
{
    local string WindowName, RecommendPlace, MustPlace, EnchantTo, RecordEnchant, Scroll,
	    ScrollBless, item, ScrollSave, ScrollSaveTxt, ScrollSaveTooltip,
	    ScrollUseOtherEqipTooltip, ScrollUseOtherEqipTxt, ScrollIsStuckTooltip, ScrollIsStuckTxt, ScrollEcnhantBlessUpdate,
	    TypeAll, TypePassive, TypeActive, TypeChance, TypeStat,
	    TypeSelect, TypeCustom, Quality, UseNpcSimulation, EditSelectList,
	    EditCustomList, EditBypass, GetNpcInfoTooltim, Skill, SkillRecommend,
	    SkillType, SkillEnchantTo;

    WindowName = "Interface AI: Automatic enhancement";
    RecommendPlace = "Place only unequipped items!";
    MustPlace = "Please place only unequipped items!";
    EnchantTo = "Enchant to:";
    RecordEnchant = "Record:";
    DelayScroll = "Delay(scroll)";
    DelayEnchant = "Delay(item)";
    Second = "sec";
    Quantity = "qty.";
    Scroll = "Scroll";
    ScrollBless = "Bless\\nScroll";
    item = "Item";
    ScrollSave = "Save Enchant:";
    ScrollSaveTxt = "Use ordinary scrolls?";
    ScrollSaveTooltip = "Use ordinary scrolls to the save level enchant?";
    ScrollUseOtherEqipTooltip = "Use other item (ID) if enchant fail?";
    ScrollUseOtherEqipTxt = "Use other item if fail?";
    ScrollIsStuckTooltip = "Scroll is stackable? (More than 1 in one slot)";
    ScrollIsStuckTxt = "Scroll is stackable?";
    ScrollEcnhantBlessUpdate = "Stopped on enchant process?";
    DelayScrollTooltip = "Delay to emulate pressing of scroll.";
    DelayEnchantTooltip = "Delay to emulate selection of item.";
    EnchantInstruction_SelectScroll = "Select the scroll to be enchanted.";
    EnchantInstruction_SelectItem = "Select the item to be enchanted.";
    EnchantInstruction_CheckOption = "Write how much enchant levels you want?";
    EnchantInstruction_Process = "Enchant in process...";
    EnchantInstruction_Result = "Congratulations!\\nYou get";
    EnchantInstruction_Stop = "Enchant stopped.";
    EnchantInstruction_Error_Destroy = "Oops, the item was broken ...";
    EnchantInstruction_Error_ScrollEnd = "The scrolls of enchantment was ended!";
    TypeAll = "Type: All";
    TypePassive = "Type: Passive";
    TypeActive = "Type: Active";
    TypeChance = "Type: Chance";
    TypeStat = "Type: Stat";
    TypeSelect = "Select:";
    TypeCustom = "Type: Custom";
    Quality = "Quality:";
    UseNpcSimulation = "Use the dialog with NPC";
    NpcInfoDefault = "Undefined";
    NpcInfoName = "Name";
    NpcInfoID = "ID";
    DelayNPC = "Delay(NPC)";
    DelayUN = "Delay(Cancel)";
    DelayWP = "Delay(Weapon)";
    DelayLS = "Delay(LS)";
    DelayGS = "Delay(GemStone)";
    DelayConfirm = "Delay(Confirm)";
    DelayNPCTooltip = "Delay to simulate dialog with npc.";
    DelayUNTooltip = "Delay to cancel refinery.\\nDefault 2 seconds.";
    DelayWPTooltip = "Delay to insert Weapon.";
    DelayLSTooltip = "Delay to insert LifeStone.";
    DelayGSTooltip = "Delay to insert GemStone.";
    DelayConfirmTooltip = "Delay to confirm refinery.\\nDefault 1.9 seconds.";
    GetNpcInfoTooltim = "Get NPC Info.";
    EditSelectList = "Edit select list";
    EditCustomList = "Edit custom list";
    EditBypass = "Bypass Editor";
    RefineryInstruction_SelectWeapon = "Place Weapon to refined.";
    RefineryInstruction_SelectLS = "Place LifeStone.";
    RefineryInstruction_CheckOption = "Please, check the options.";
    RefineryInstruction_Process = "Refine in process...";
    RefineryInstruction_Stop = "Refinery stopped.";
    RefineryInstruction_Result = "Congratulations!\\nYou get";
    RefineryInstruction_Error_NPC = "Please, target NPC-shop!";
    RefineryInstruction_Error_LS = "You used all LifeStones!";
    RefineryInstruction_Error_GS = "You used all GemStones!";
    RefineryInstruction_Error_Adena = "You do not have enough adena.";
    RefineryInstruction_Error_FULL = "Unknown error!\\nPlease check the components and options!";
    Skill = "Skill";
    SkillRecommend = ("You need talk with \\n" @ "Enchant's Skills Master") @ " at least once!";
    SkillType = "Type of enchant:";
    SkillEnchantTo = "Enchant to:";
    SkillDelay = "Delay";
    SkillDelayTooltip = "Delay to enchant skill.";
    SkillInstruction_SelectSkill = "Place the skill you want to be enchanted.";
    SkillInstruction_CheckOption = "Please, select type of enchant\\nand how muc enchant level's you want.";
    SkillInstruction_Process = "Skill enchant in process...";
    SkillInstruction_Result = "Congratulations!\\nYou get";
    SkillInstruction_Error_NoEnchant = "You can't enchant this skill.";
    SkillInstruction_Error_NoBook = "You have ended the book!";
    SkillInstruction_Error_EnchantLimit = "You have to write the enchant limit!";
    Me.SetWindowTitle(WindowName);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtWarns", RecommendPlace);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtEnchantTo", EnchantTo);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtRecord", RecordEnchant);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtScroll", Scroll);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtBlessScroll", ScrollBless);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtEquipItem", item);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtEnchantScroll", ScrollSave);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtUseOrdinalScroll", ScrollSaveTxt);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtUseDestroyItem", ScrollUseOtherEqipTxt);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtIsStuck", ScrollIsStuckTxt);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtBlessUpdate", ScrollEcnhantBlessUpdate);
    checkScrollSave.SetTooltipCustomType(SetTooltip(ScrollSaveTooltip));
    checkScrollDestroy.SetTooltipCustomType(SetTooltip(ScrollUseOtherEqipTooltip));
    checkScrollStack.SetTooltipCustomType(SetTooltip(ScrollIsStuckTooltip));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtWarn", MustPlace);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtTypeAll", TypeAll);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtTypePassive", TypePassive);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtTypeActive", TypeActive);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtTypeChance", TypeChance);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtTypeStat", TypeStat);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtTypeSelect", TypeSelect);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtTypeCustom", TypeCustom);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtQuality", Quality);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtUseSimulRef", UseNpcSimulation);
    b_GetNPCInfo.SetTooltipCustomType(SetTooltip(GetNpcInfoTooltim));
    b_SelectEdit.SetTooltipCustomType(SetTooltip(EditSelectList));
    b_CustomEdit.SetTooltipCustomType(SetTooltip(EditCustomList));
    b_BypassEdit.SetTooltipCustomType(SetTooltip(EditBypass));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.SkillEnchantTab.txtRecomeds", SkillRecommend);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.SkillEnchantTab.txtSkillSlot", Skill);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.SkillEnchantTab.txtEnchantType", SkillType);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.SkillEnchantTab.txtEnchantLevel", SkillEnchantTo);
    return;
}

function InvetorySlotName()
{
    InventorySlot[0] = "InventoryItem";
    InventorySlot[1] = "EquipItem_LHand";
    InventorySlot[2] = "EquipItem_RHand";
    InventorySlot[3] = "EquipItem_Head";
    InventorySlot[4] = "EquipItem_Chest";
    InventorySlot[5] = "EquipItem_Legs";
    InventorySlot[6] = "EquipItem_Gloves";
    InventorySlot[7] = "EquipItem_Feet";
    InventorySlot[8] = "EquipItem_Neck";
    InventorySlot[9] = "EquipItem_REar";
    InventorySlot[10] = "EquipItem_LEar";
    InventorySlot[11] = "EquipItem_RFinger";
    InventorySlot[12] = "EquipItem_LFinger";
    return;
}

function OnClickCheckBox(string strID)
{
    switch(strID)
    {
        // End:0x63
        case "checkSaveEnchant":
            // End:0x58
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkSaveEnchant"))
            {
                EnchantItem_UseOldScroll = true;                
            }
            else
            {
                EnchantItem_UseOldScroll = false;
            }
            // End:0xFDC
            break;
        // End:0xC5
        case "checkUseDestroyItem":
            // End:0xBA
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkUseDestroyItem"))
            {
                EnchantItem_UseDestrItem = true;                
            }
            else
            {
                EnchantItem_UseDestrItem = false;
            }
            // End:0xFDC
            break;
        // End:0x119
        case "checkIsStuck":
            // End:0x10E
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkIsStuck"))
            {
                EnchantItem_IsStack = true;                
            }
            else
            {
                EnchantItem_IsStack = false;
            }
            // End:0xFDC
            break;
        // End:0x175
        case "checkBlessUpdate":
            // End:0x16A
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkBlessUpdate"))
            {
                EnchantItem_UpdateBless = true;                
            }
            else
            {
                EnchantItem_UpdateBless = false;
            }
            // End:0xFDC
            break;
        // End:0x205
        case "checkUseSimulRef":
            // End:0x1C6
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkUseSimulRef"))
            {
                UseNpcSimulation = true;                
            }
            else
            {
                UseNpcSimulation = false;
            }
            SetINIBool("AutoRefinery", "UseNPCSimulation", UseNpcSimulation, "Option");
            // End:0xFDC
            break;
        // End:0x6DD
        case "checkTypeAll":
            // End:0x490
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypeAll"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypePassive");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeActive");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeChance");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeStat");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeSelect");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeCustom");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.comboTypeAll");
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypePassive", true);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeActive", true);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeChance", true);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeStat", true);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeSelect", true);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeCustom", true);                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypePassive");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeActive");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeChance");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeStat");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeSelect");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeCustom");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.comboTypeAll");
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypePassive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeActive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeChance", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeStat", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeSelect", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeCustom", false);
            }
            // End:0xFDC
            break;
        // End:0xB5B
        case "checkTypeSelect":
            // End:0x93E
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypeSelect"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypePassive");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeActive");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeChance");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeStat");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeCustom");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.comboTypeAll");
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeAll", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypePassive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeActive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeChance", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeStat", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeCustom", false);                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypePassive");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeActive");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeChance");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeStat");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeCustom");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.comboTypeAll");
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeAll", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypePassive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeActive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeChance", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeStat", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeCustom", false);
            }
            // End:0xFDC
            break;
        // End:0xFD9
        case "checkTypeCustom":
            // End:0xDBC
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypeCustom"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypePassive");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeActive");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeChance");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeStat");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.checkTypeSelect");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.comboTypeAll");
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeAll", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypePassive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeActive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeChance", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeStat", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeSelect", false);                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypePassive");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeActive");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeChance");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeStat");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.checkTypeSelect");
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.comboTypeAll");
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeAll", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypePassive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeActive", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeChance", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeStat", false);
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("EnchantAIWnd.checkTypeSelect", false);
            }
            // End:0xFDC
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function ShowBypassEdit()
{
    // End:0x61
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("InterfaceAI_EditAugmentListWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_EditAugmentListWnd");
    }
    // End:0xB5
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("InterfaceAI_BypassEdit"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_BypassEdit");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("InterfaceAI_BypassEdit");
    }
    return;
}

function ShowListEdit(int Type)
{
    // End:0x51
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("InterfaceAI_BypassEdit"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_BypassEdit");
    }
    // End:0x13E
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("InterfaceAI_EditAugmentListWnd"))
    {
        // End:0xFA
        if(Class'NWindow.UIAPI_TABCTRL'.static.GetTopIndex("InterfaceAI_EditAugmentListWnd.TabListCtrl") == Type)
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_EditAugmentListWnd");            
        }
        else
        {
            Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("InterfaceAI_EditAugmentListWnd.TabListCtrl", Type, true);
        }        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("InterfaceAI_EditAugmentListWnd");
        Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("InterfaceAI_EditAugmentListWnd.TabListCtrl", Type, true);
    }
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x21
        case "btnEnchantOK":
            OnClickEnchantStart();
            // End:0x141
            break;
        // End:0x3E
        case "btnEnchantPause":
            OnClickEnchantStop();
            // End:0x141
            break;
        // End:0x59
        case "btnRefineryOK":
            OnClickStartRefinery();
            // End:0x141
            break;
        // End:0x78
        case "btnRefineryCancel":
            OnClickStopRefinery();
            // End:0x141
            break;
        // End:0x93
        case "btnGetNPCInfo":
            GetNpcInfo();
            // End:0x141
            break;
        // End:0xAB
        case "btnSkillOK":
            OnClickEnchantSkillStart();
            // End:0x141
            break;
        // End:0xC7
        case "btnSkillCancel":
            OnClickEnchantSkillCancel();
            // End:0x141
            break;
        // End:0xE3
        case "btnSelectEdit":
            ShowListEdit(0);
            // End:0x141
            break;
        // End:0xFF
        case "btnCustomEdit":
            ShowListEdit(1);
            // End:0x141
            break;
        // End:0x11A
        case "btnBypassEdit":
            ShowBypassEdit();
            // End:0x141
            break;
        // End:0x13E
        case "BtnClose":
            HideWindow("EnchantAIWnd");
            // End:0x141
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnClickEnchantSkillStart()
{
    m_InstructionText3.SetAnchor("ItemEnchantTab", "BottomCenter", "BottomCenter", 0, -45);
    // End:0x5D
    if(EnchantSkillLimit != 0)
    {
        EnchantSkill();
        EnableSkillProcess = true;        
    }
    else
    {
        m_InstructionText.SetText(SkillInstruction_Error_EnchantLimit);
    }
    return;
}

function OnClickEnchantSkillCancel()
{
    StopEnchantSkill();
    return;
}

function GetNpcInfo()
{
    GetTargetInfo(NpcInfo);
    // End:0x8D
    if(NpcInfo.nID != 0)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtNPCInfo", (((((NpcInfoName $ ": ") $ NpcInfo.Name) $ " ") $ NpcInfoID) $ ": ") $ string(NpcInfo.nID));        
    }
    else
    {
        m_InstructionText2.SetText(RefineryInstruction_Error_NPC);
    }
    return;
}

function ClearNpcInfo()
{
    NpcInfo.nID = 0;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtNPCInfo", (((((NpcInfoName $ ": ") $ NpcInfoDefault) $ " ") $ NpcInfoID) $ ": ") $ NpcInfoDefault);
    return;
}

function SetDelay(string Type, int CurrentTick, int TickAdd, out int Time)
{
    local string Seconds;
    local int CurrentTick_temp;

    Time = CurrentTick * TickAdd;
    Seconds = string(float(Time) / float(1000));
    switch(Type)
    {
        // End:0x12C
        case "Delay_ScrollSelect":
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtDelay1", (((DelayScroll $ " ") $ Seconds) $ " ") $ Second);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("EnchantAIWnd.ItemEnchantTab.EnchantDelay1SliderCtrl", (DelayScrollTooltip @ Seconds) @ Second);
            SetINIInt("AutoEnchant", Type, CurrentTick, "Option");
            Time = Time + TIMER_ENCHANT2_DELAY;
            // End:0x8CA
            break;
        // End:0x261
        case "Delay_EnchantItem":
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.ItemEnchantTab.txtDelay2", (((DelayEnchant $ " ") $ Seconds) $ " ") $ Second);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("EnchantAIWnd.ItemEnchantTab.EnchantDelay2SliderCtrl", (DelayEnchantTooltip @ Seconds) @ Second);
            SetINIInt("AutoEnchant", Type, CurrentTick, "Option");
            GetINIInt("AutoEnchant", "Delay_ScrollSelect", CurrentTick_temp, "Option");
            TIMER_ENCHANT_DELAY = (CurrentTick_temp * TickAdd) + Time;
            // End:0x8CA
            break;
        // End:0x35B
        case "Delay_SkillEnchant":
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.SkillEnchantTab.txtSkillDelay1", (((SkillDelay $ " ") $ Seconds) $ " ") $ Second);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("EnchantAIWnd.SkillEnchantTab.SkillEnchantDelay1SliderCtrl", (SkillDelayTooltip @ Seconds) @ Second);
            SetINIInt("AutoEnchantSkill", Type, CurrentTick, "Option");
            // End:0x8CA
            break;
        // End:0x441
        case "Delay_UN":
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtRefDelay5", (((DelayUN $ " ") $ Seconds) $ " ") $ Second);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("EnchantAIWnd.AugmentationTab.RefineryDelay5SliderCtrl", (DelayUNTooltip @ Seconds) @ Second);
            SetINIInt("AutoRefinery", Type, CurrentTick, "Option");
            // End:0x8CA
            break;
        // End:0x52C
        case "Delay_NPCTalk":
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtRefDelay1", (((DelayNPC $ " ") $ Seconds) $ " ") $ Second);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("EnchantAIWnd.AugmentationTab.RefineryDelay1SliderCtrl", (DelayNPCTooltip @ Seconds) @ Second);
            SetINIInt("AutoRefinery", Type, CurrentTick, "Option");
            // End:0x8CA
            break;
        // End:0x612
        case "Delay_WP":
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtRefDelay2", (((DelayWP $ " ") $ Seconds) $ " ") $ Second);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("EnchantAIWnd.AugmentationTab.RefineryDelay2SliderCtrl", (DelayWPTooltip @ Seconds) @ Second);
            SetINIInt("AutoRefinery", Type, CurrentTick, "Option");
            // End:0x8CA
            break;
        // End:0x6F8
        case "Delay_LS":
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtRefDelay3", (((DelayLS $ " ") $ Seconds) $ " ") $ Second);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("EnchantAIWnd.AugmentationTab.RefineryDelay3SliderCtrl", (DelayLSTooltip @ Seconds) @ Second);
            SetINIInt("AutoRefinery", Type, CurrentTick, "Option");
            // End:0x8CA
            break;
        // End:0x7DE
        case "Delay_GS":
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtRefDelay4", (((DelayGS $ " ") $ Seconds) $ " ") $ Second);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("EnchantAIWnd.AugmentationTab.RefineryDelay4SliderCtrl", (DelayGSTooltip @ Seconds) @ Second);
            SetINIInt("AutoRefinery", Type, CurrentTick, "Option");
            // End:0x8CA
            break;
        // End:0x8C7
        case "Delay_Final":
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.AugmentationTab.txtRefDelay6", (((DelayConfirm $ " ") $ Seconds) $ " ") $ Second);
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipText("EnchantAIWnd.AugmentationTab.RefineryDelay6SliderCtrl", (DelayConfirmTooltip @ Seconds) @ Second);
            SetINIInt("AutoRefinery", Type, CurrentTick, "Option");
            // End:0x8CA
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnComboBoxItemSelected(string a_ControlID, int a_SelectedIndex)
{
    // End:0x25
    if(a_ControlID == "comboSkillType")
    {
        ComboEnchantSelect = a_SelectedIndex;
    }
    return;
}

function OnChangeEditBox(string strID)
{
    switch(strID)
    {
        // End:0x51
        case "editEnchantLvl":
            EnchantItem_EnchantTo = int(Class'NWindow.UIAPI_EDITBOX'.static.GetString("EnchantAIWnd.editEnchantLvl"));
            // End:0xF8
            break;
        // End:0xA7
        case "ScrollEnchantLvlEdit":
            EnchantItem_EnchantSaveTo = int(Class'NWindow.UIAPI_EDITBOX'.static.GetString("EnchantAIWnd.ScrollEnchantLvlEdit"));
            // End:0xF8
            break;
        // End:0xF5
        case "editSkillEnchant":
            EnchantSkillLimit = int(Class'NWindow.UIAPI_EDITBOX'.static.GetString("EnchantAIWnd.editSkillEnchant"));
            // End:0xF8
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnModifyCurrentTickSliderCtrl(string strID, int iCurrentTick)
{
    switch(strID)
    {
        // End:0x4C
        case "EnchantDelay1SliderCtrl":
            SetDelay("Delay_ScrollSelect", iCurrentTick, 250, TIMER_ENCHANT_DELAY);
            // End:0x24D
            break;
        // End:0x90
        case "EnchantDelay2SliderCtrl":
            SetDelay("Delay_EnchantItem", iCurrentTick, 250, TIMER_ENCHANT2_DELAY);
            // End:0x24D
            break;
        // End:0xDA
        case "SkillEnchantDelay1SliderCtrl":
            SetDelay("Delay_SkillEnchant", iCurrentTick, 250, TIMER_ENCHANTSKILL_DELAY);
            // End:0x24D
            break;
        // End:0x11B
        case "RefineryDelay1SliderCtrl":
            SetDelay("Delay_NPCTalk", iCurrentTick, 250, TIMER_REFINERY_NPCTALK_DELAY);
            // End:0x24D
            break;
        // End:0x157
        case "RefineryDelay2SliderCtrl":
            SetDelay("Delay_WP", iCurrentTick, 250, TIMER_REFINERY_WEAPON_DELAY);
            // End:0x24D
            break;
        // End:0x193
        case "RefineryDelay3SliderCtrl":
            SetDelay("Delay_LS", iCurrentTick, 250, TIMER_REFINERY_LIFESTONE_DELAY);
            // End:0x24D
            break;
        // End:0x1CF
        case "RefineryDelay4SliderCtrl":
            SetDelay("Delay_GS", iCurrentTick, 250, TIMER_REFINERY_GEMSTONE_DELAY);
            // End:0x24D
            break;
        // End:0x20B
        case "RefineryDelay5SliderCtrl":
            SetDelay("Delay_UN", iCurrentTick, 250, TIMER_REFINERY_UNREF_DELAY);
            // End:0x24D
            break;
        // End:0x24A
        case "RefineryDelay6SliderCtrl":
            SetDelay("Delay_Final", iCurrentTick, 250, TIMER_REFINERY_FINAL_DELAY);
            // End:0x24D
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnDropItem(string a_WindowID, ItemInfo a_ItemInfo, int X, int Y)
{
    switch(a_WindowID)
    {
        // End:0x26
        case "ItemDragBox1":
            DragInsertBlessSrollItem(a_ItemInfo);
            // End:0xC5
            break;
        // End:0x46
        case "ItemDragBox11":
            DragInsertSrollItem(a_ItemInfo);
            // End:0xC5
            break;
        // End:0x65
        case "ItemDragBox2":
            DragInserEquiptItem(a_ItemInfo);
            // End:0xC5
            break;
        // End:0x84
        case "ItemDragBox3":
            DropWeapon(a_ItemInfo);
            // End:0xC5
            break;
        // End:0xA3
        case "ItemDragBox4":
            DropLifeStone(a_ItemInfo);
            // End:0xC5
            break;
        // End:0xC2
        case "ItemDragBox5":
            InsertDragSkill(a_ItemInfo);
            // End:0xC5
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function AlarmWindow()
{
    // End:0x18
    if(IsMinimized)
    {
        Me.NotifyAlarm();
    }
    return;
}

function EnchantItemStop()
{
    EnchantInUse = true;
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10300);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10301);
    EnableEnchantProcess = false;
    return;
}

function EnchantItemStopSucsesfull()
{
    EnchantInUse = true;
    AlarmWindow();
    EnchantItemStop();
    PlaySound("Interface.complete_enchant");
    m_InstructionText.SetText((((EnchantInstruction_Result $ " ") $ EquipItemInfo.Name) $ " +") $ string(EnchantItem_CurrentEnchantLevel));
    return;
}

function OnClickEnchantStop()
{
    m_InstructionText.SetText(EnchantInstruction_Stop);
    EnchantItemStop();
    return;
}

function OnClickEnchantStart()
{
    EnchantInUse = false;
    m_InstructionText.SetAnchor("ItemEnchantTab", "BottomCenter", "BottomCenter", 0, -38);
    // End:0xD5
    if(EquipItemInfo.ClassID != 0)
    {
        // End:0xBE
        if((ScrollItemInfo.ClassID != 0) || BlessScrollItemInfo.ClassID != 0)
        {
            // End:0xA7
            if(EnchantItem_EnchantTo > 0)
            {
                // End:0x9E
                if(EnchantItem_CurrentEnchantLevel >= EnchantItem_EnchantTo)
                {
                    EnchantItemStopSucsesfull();                    
                }
                else
                {
                    EnchantSelectScrollFunction();
                }                
            }
            else
            {
                m_InstructionText.SetText(EnchantInstruction_CheckOption);
            }            
        }
        else
        {
            m_InstructionText.SetText(EnchantInstruction_SelectScroll);
        }        
    }
    else
    {
        m_InstructionText.SetText(EnchantInstruction_SelectItem);
    }
    return;
}

function int GetScrollCount(out ItemInfo ScrollInform)
{
    local int Index;
    local ItemInfo ScrInfo;

    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("InventoryWnd.InventoryItem", ScrollInform.ClassID);
    // End:0x8C
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.InventoryItem", Index, ScrInfo))
    {
        ScrollInform = ScrInfo;
        return ScrInfo.ItemNum;        
    }
    else
    {
        return 0;
    }
    return 0;
}

function EnchantClearSlot(int Type)
{
    switch(Type)
    {
        // End:0x41
        case 0:
            m_DragboxItem11.Clear();
            ScrollItemInfo.ItemNum = 0;
            ScrollItemInfo.ServerID = 0;
            ScrollItemInfo.ClassID = 0;
            // End:0xB9
            break;
        // End:0x7B
        case 1:
            m_DragboxItem1.Clear();
            BlessScrollItemInfo.ItemNum = 0;
            BlessScrollItemInfo.ServerID = 0;
            BlessScrollItemInfo.ClassID = 0;
            // End:0xB9
            break;
        // End:0xB6
        case 2:
            m_DragBoxItem2.Clear();
            EquipItemInfo.ItemNum = 0;
            EquipItemInfo.ServerID = 0;
            EquipItemInfo.ClassID = 0;
            // End:0xB9
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function EnchantSelectScrollFunction()
{
    // End:0x100
    if((EnchantItem_CurrentEnchantLevel < EnchantItem_EnchantSaveTo) && EnchantItem_UseOldScroll)
    {
        // End:0x92
        if(EnchantItem_IsStack)
        {
            // End:0x6E
            if((GetScrollCount(ScrollItemInfo)) > 0)
            {
                RequestUseItem(ScrollItemInfo.ServerID);
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10301, TIMER_ENCHANT2_DELAY);                
            }
            else
            {
                m_InstructionText.SetText(EnchantInstruction_Error_ScrollEnd);
                EnchantItemStop();
                EnchantClearSlot(0);
            }            
        }
        else
        {
            // End:0xDC
            if(ScrollItemInfo.ItemNum > 0)
            {
                RequestUseItem(ScrollItemInfo.ServerID);
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10301, TIMER_ENCHANT2_DELAY);                
            }
            else
            {
                m_InstructionText.SetText(EnchantInstruction_Error_ScrollEnd);
                EnchantItemStop();
                EnchantClearSlot(0);
            }
        }        
    }
    else
    {
        // End:0x178
        if(EnchantItem_IsStack)
        {
            // End:0x154
            if((GetScrollCount(BlessScrollItemInfo)) > 0)
            {
                RequestUseItem(BlessScrollItemInfo.ServerID);
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10301, TIMER_ENCHANT2_DELAY);                
            }
            else
            {
                m_InstructionText.SetText(EnchantInstruction_Error_ScrollEnd);
                EnchantItemStop();
                EnchantClearSlot(1);
            }            
        }
        else
        {
            // End:0x1C2
            if(BlessScrollItemInfo.ItemNum > 0)
            {
                RequestUseItem(BlessScrollItemInfo.ServerID);
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10301, TIMER_ENCHANT2_DELAY);                
            }
            else
            {
                m_InstructionText.SetText(EnchantInstruction_Error_ScrollEnd);
                EnchantItemStop();
                EnchantClearSlot(1);
            }
        }
    }
    return;
}

function EnchantFinishFunction()
{
    Class'NWindow.EnchantAPI'.static.RequestEnchantItem(EquipItemInfo.ServerID);
    m_InstructionText.SetText(EnchantInstruction_Process);
    return;
}

function HandleSystemMessage(string a_Param)
{
    local int idx, Id;

    ParseInt(a_Param, "Index", idx);
    switch(idx)
    {
        // End:0x41
        case 62:
            EnchantItem_CurrentEnchantLevel = 1;
            HandleEnchantResult("Result=65535");
            // End:0x154
            break;
        // End:0x87
        case 63:
            ParseInt(a_Param, "Param1", Id);
            EnchantItem_CurrentEnchantLevel = (Id + 1);
            HandleEnchantResult("Result=65535");
            // End:0x154
            break;
        // End:0x8C
        case 64:
        // End:0xAB
        case 65:
            EnchantItem_CurrentEnchantLevel = 0;
            HandleEnchantResult("Result=1");
            // End:0x154
            break;
        // End:0xB3
        case 614:
        // End:0xBB
        case 1517:
        // End:0xDD
        case 1983:
            EnchantItem_CurrentEnchantLevel = 0;
            HandleEnchantResult("Result=1");
            // End:0x154
            break;
        // End:0xF8
        case 355:
            HandleEnchantResult("Result=0");
            // End:0x154
            break;
        // End:0x136
        case 369:
            ParseInt(a_Param, "Param1", Id);
            EnchantItem_CurrentEnchantLevel = Id;
            HandleEnchantResult("Result=1");
            // End:0x154
            break;
        // End:0x151
        case 424:
            HandleEnchantResult("Result=2");
            // End:0x154
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleEnchantResult(string param)
{
    local int IntResult;

    ParseInt(param, "Result", IntResult);
    switch(IntResult)
    {
        // End:0x91
        case 0:
            // End:0x44
            if(EnchantItem_Record < EnchantItem_CurrentEnchantLevel)
            {
                EnchantItem_Record = EnchantItem_CurrentEnchantLevel;
                UpdateEnchantItemParam(false);
            }
            // End:0x5C
            if(EnchantItem_CurrentEnchantLevel >= EnchantItem_EnchantTo)
            {
                EnchantItemStopSucsesfull();                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10300, TIMER_ENCHANT_DELAY);
            }
            UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);
            // End:0x2D4
            break;
        // End:0x17B
        case 1:
            // End:0x108
            if(EnchantItem_UseDestrItem)
            {
                // End:0xE3
                if(UpdateDestroyedItem())
                {
                    InserEquiptItem(EquipItemInfo);
                    UpdateEnchantItemParam(true);
                    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10300, TIMER_ENCHANT_DELAY);                    
                }
                else
                {
                    EnchantClearSlot(2);
                    EnchantItemStop();
                    m_InstructionText.SetText(EnchantInstruction_Error_Destroy);
                }                
            }
            else
            {
                // End:0x156
                if(EnchantItem_UpdateBless)
                {
                    EquipItemInfo.Enchanted = EnchantItem_CurrentEnchantLevel;
                    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10300, TIMER_ENCHANT_DELAY);
                    UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);                    
                }
                else
                {
                    EnchantClearSlot(2);
                    EnchantItemStop();
                    m_InstructionText.SetText(EnchantInstruction_Error_Destroy);
                }
            }
            // End:0x2D4
            break;
        // End:0x201
        case 65535:
            EquipItemInfo.Enchanted = EnchantItem_CurrentEnchantLevel;
            // End:0x1B4
            if(EnchantItem_Record < EnchantItem_CurrentEnchantLevel)
            {
                EnchantItem_Record = EnchantItem_CurrentEnchantLevel;
                UpdateEnchantItemParam(false);
            }
            // End:0x1CC
            if(EnchantItem_CurrentEnchantLevel >= EnchantItem_EnchantTo)
            {
                EnchantItemStopSucsesfull();                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10300, TIMER_ENCHANT_DELAY);
            }
            UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);
            // End:0x2D4
            break;
        // End:0x27C
        case 2:
            // End:0x25F
            if(EnchantItem_UpdateBless)
            {
                EnchantItem_CurrentEnchantLevel = EnchantItem_ResetTo;
                EquipItemInfo.Enchanted = EnchantItem_CurrentEnchantLevel;
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10300, TIMER_ENCHANT_DELAY);
                UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);                
            }
            else
            {
                EnchantItemStop();
                m_InstructionText.SetText(EnchantInstruction_Stop);
            }
            // End:0x2D4
            break;
        // End:0x2D1
        case 3:
            EnchantItem_CurrentEnchantLevel = EnchantItem_ResetTo;
            EquipItemInfo.Enchanted = EnchantItem_CurrentEnchantLevel;
            Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10300, TIMER_ENCHANT_DELAY);
            UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);
            // End:0x2D4
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function bool UpdateDestroyedItem()
{
    local int Index;
    local ItemInfo ScrInfo;

    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("InventoryWnd.InventoryItem", EquipItemInfo.ClassID);
    // End:0x83
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.InventoryItem", Index, ScrInfo))
    {
        EquipItemInfo = ScrInfo;
        return true;        
    }
    else
    {
        return false;
    }
    return false;
}

function UpdateEnchantItemParam(bool NewItem)
{
    // End:0x44
    if(NewItem)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.valRecord", "+" $ string(EquipItemInfo.Enchanted));        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.valRecord", "+" $ string(EnchantItem_Record));
    }
    return;
}

function DragInsertSrollItem(ItemInfo a_ItemInfo)
{
    EnchantClearSlot(0);
    EnchantClearSlot(2);
    ScrollItemInfo = a_ItemInfo;
    m_DragBoxItem2.EnableWindow();
    m_DragboxItem11.AddItem(a_ItemInfo);
    m_InstructionText.SetText(EnchantInstruction_SelectItem);
    return;
}

function DragInsertBlessSrollItem(ItemInfo a_ItemInfo)
{
    EnchantClearSlot(1);
    EnchantClearSlot(2);
    BlessScrollItemInfo = a_ItemInfo;
    BlessScrollServerID = a_ItemInfo.ServerID;
    m_DragboxItem1.AddItem(a_ItemInfo);
    m_DragBoxItem2.EnableWindow();
    m_InstructionText.SetText(EnchantInstruction_SelectItem);
    GetScrollCount(BlessScrollItemInfo);
    return;
}

function DragInserEquiptItem(ItemInfo a_ItemInfo)
{
    // End:0x48
    if(m_DragBoxItem2.IsEnableWindow())
    {
        InserEquiptItem(a_ItemInfo);
        UpdateEnchantItemParam(true);
        EnchantItem_Record = a_ItemInfo.Enchanted;
        m_InstructionText.SetText(EnchantInstruction_CheckOption);
    }
    return;
}

function InserEquiptItem(ItemInfo a_ItemInfo)
{
    m_DragBoxItem2.Clear();
    EquipItemInfo = a_ItemInfo;
    EquipItemServerID = a_ItemInfo.ServerID;
    EnchantItem_CurrentEnchantLevel = a_ItemInfo.Enchanted;
    m_DragBoxItem2.AddItem(a_ItemInfo);
    return;
}

function UpdateEquiptItem(int Enchant)
{
    EquipItemInfo.Enchanted = Enchant;
    m_DragBoxItem2.Clear();
    m_DragBoxItem2.AddItem(EquipItemInfo);
    return;
}

function InsertDragSkill(ItemInfo a_ItemInfo)
{
    local string EnchantString;

    EnchantString = Class'NWindow.UIDATA_SKILL'.static.GetEnchantName(a_ItemInfo.ClassID, 101);
    // End:0x5A
    if(EnchantString != "")
    {
        SelectedSkillInfo = a_ItemInfo;
        DragSkill(SelectedSkillInfo);
        m_InstructionText3.SetText(SkillInstruction_CheckOption);        
    }
    else
    {
        m_InstructionText3.SetText(SkillInstruction_Error_NoEnchant);
    }
    return;
}

function DragSkill(ItemInfo a_ItemInfo)
{
    m_DragBoxItem5.Clear();
    m_DragBoxItem5.AddItem(a_ItemInfo);
    UpdateCombobox(a_ItemInfo);
    return;
}

function UpdateSkill(out ItemInfo Info)
{
    local int Index;
    local ItemInfo Skill;

    RequestSkillList();
    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("MagicSkillWnd.ASkill.SkillItem", SelectedSkillInfo.ClassID);
    // End:0x8C
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("MagicSkillWnd.ASkill.SkillItem", Index, Skill))
    {
        Info = Skill;
    }
    return;
}

function UpdateEnchantSkillParam()
{
    local UserInfo MyInfo;

    // End:0xBB
    if(GetPlayerInfo(MyInfo))
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.SkillEnchantTab.txtExp", ((Int64ToString(MyInfo.nCurExp) $ " (") $ string(GetExpRate(MyInfo.nCurExp, MyInfo.nLevel))) $ "%)");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.SkillEnchantTab.txtSP", string(MyInfo.nSP));
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EnchantAIWnd.SkillEnchantTab.txtBookCount", string(UpdateGiantBookCount()) @ Quantity);
    return;
}

function int UpdateGiantBookCount()
{
    local int Count, Index, InvetoryItems, i;
    local ItemInfo BookInfo, InventoryItem;

    Count = 0;
    InvetoryItems = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("InventoryWnd.InventoryItem");
    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("InventoryWnd.InventoryItem", 6622);
    // End:0x156
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.InventoryItem", Index, BookInfo))
    {
        // End:0x12C
        if(BookInfo.ItemNum == 1)
        {
            i = 0;

            while(i <= InvetoryItems)
            {
                // End:0x11F
                if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.InventoryItem", InvetoryItems, InventoryItem))
                {
                    // End:0x11F
                    if(InventoryItem.ClassID == 6622)
                    {
                        Count++;
                    }
                }
                ++i;
            }            
        }
        else
        {
            // End:0x146
            if(BookInfo.ItemNum == 0)
            {
                Count = 0;                
            }
            else
            {
                Count = BookInfo.ItemNum;
            }
        }
    }
    return Count;
}

function EnchantSkill()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10500, TIMER_ENCHANTSKILL_DELAY);
    UpdateSkill(SelectedSkillInfo);
    // End:0xF9
    if((SelectedSkillInfo.Level == (EnchantSkillLimit + 100)) || SelectedSkillInfo.Level == (EnchantSkillLimit + 140))
    {
        StopEnchantSkill();
        AlarmWindow();
        m_InstructionText3.SetText(((SkillInstruction_Result @ Class'NWindow.UIDATA_SKILL'.static.GetName(SelectedSkillInfo.ClassID, SelectedSkillInfo.Level)) $ " ") $ Class'NWindow.UIDATA_SKILL'.static.GetEnchantName(SelectedSkillInfo.ClassID, SelectedSkillInfo.Level));
        PlaySound("Interface.complete_refinery");        
    }
    else
    {
        // End:0x140
        if((SelectedSkillInfo.Level < 100) && ComboEnchantSelect == 0)
        {
            RequestExEnchantSkill(SelectedSkillInfo.ClassID, 101);
            m_InstructionText3.SetText(SkillInstruction_Process);            
        }
        else
        {
            // End:0x187
            if((SelectedSkillInfo.Level < 100) && ComboEnchantSelect == 1)
            {
                RequestExEnchantSkill(SelectedSkillInfo.ClassID, 141);
                m_InstructionText3.SetText(SkillInstruction_Process);                
            }
            else
            {
                RequestExEnchantSkill(SelectedSkillInfo.ClassID, SelectedSkillInfo.Level + 1);
                m_InstructionText3.SetText(SkillInstruction_Process);
            }
        }
    }
    UpdateSkill(SelectedSkillInfo);
    DragSkill(SelectedSkillInfo);
    UpdateEnchantSkillParam();
    return;
}

function StopEnchantSkill()
{
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10500);
    EnableSkillProcess = false;
    return;
}

function UpdateCombobox(ItemInfo Skill)
{
    local string Enchant1Full, Enchant2Full;
    local array<string> Enchant1Name, Enchant2Name;
    local int tempInt, tempInt2;

    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("EnchantAIWnd.comboSkillType");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("EnchantAIWnd.comboSkillType");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("EnchantAIWnd.comboSkillType", ComboEnchantSelect);
    Enchant1Name.Length = 0;
    Enchant2Name.Length = 0;
    Enchant1Full = Class'NWindow.UIDATA_SKILL'.static.GetEnchantName(Skill.ClassID, 101);
    Enchant2Full = Class'NWindow.UIDATA_SKILL'.static.GetEnchantName(Skill.ClassID, 141);
    tempInt = Split(Enchant1Full, " ", Enchant1Name);
    tempInt2 = Split(Enchant2Full, " ", Enchant2Name);
    // End:0x14E
    if(Enchant1Name[1] != "")
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.AddString("EnchantAIWnd.comboSkillType", Enchant1Name[1]);
    }
    // End:0x18F
    if(Enchant2Name[1] != "")
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.AddString("EnchantAIWnd.comboSkillType", Enchant2Name[1]);
    }
    // End:0x210
    if((SelectedSkillInfo.Level > 100) && SelectedSkillInfo.Level < 131)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("EnchantAIWnd.comboSkillType", ComboEnchantSelect);
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.comboSkillType");
    }
    // End:0x27E
    if(SelectedSkillInfo.Level > 131)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("EnchantAIWnd.comboSkillType", ComboEnchantSelect);
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("EnchantAIWnd.comboSkillType");
    }
    return;
}

function SetSearchParam()
{
    SearchAll = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypeAll");
    SearchPassive = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypePassive");
    SearchActive = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypeActive");
    SearchChance = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypeChance");
    SearchStat = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypeStat");
    SearchSelect = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypeSelect");
    SearchCustom = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("EnchantAIWnd.checkTypeCustom");
    return;
}

function OnTimer(int TimerID)
{
    switch(TimerID)
    {
        // End:0x3A
        case 10300:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10300);
            EnchantSelectScrollFunction();
            // End:0x34C
            break;
        // End:0x6D
        case 10301:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10301);
            EnchantFinishFunction();
            // End:0x34C
            break;
        // End:0xA0
        case 10500:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10500);
            EnchantSkill();
            // End:0x34C
            break;
        // End:0xDD
        case 10450:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10450);
            RefineNpcTalk("UnRefine");
            // End:0x34C
            break;
        // End:0x118
        case 10451:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10451);
            RefineNpcTalk("Refine");
            // End:0x34C
            break;
        // End:0x14B
        case 10452:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10452);
            UnRefineFunction();
            // End:0x34C
            break;
        // End:0x17E
        case 10453:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10453);
            WeaponRefineFunction();
            // End:0x34C
            break;
        // End:0x1B1
        case 10454:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10454);
            LifeStoneRefineFunction();
            // End:0x34C
            break;
        // End:0x1E4
        case 10455:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10455);
            GameStoneRefineFunction();
            // End:0x34C
            break;
        // End:0x217
        case 10456:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10456);
            ConfirmRefineFunction();
            // End:0x34C
            break;
        // End:0x24A
        case 10457:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10457);
            RefineNpcTalk_SendRefBypass_1();
            // End:0x34C
            break;
        // End:0x27D
        case 10458:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10458);
            RefineNpcTalk_SendRefBypass_2();
            // End:0x34C
            break;
        // End:0x2B0
        case 10459:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10459);
            RefineNpcTalk_SendRefBypass_3();
            // End:0x34C
            break;
        // End:0x2E3
        case 10460:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10460);
            RefineNpcTalk_SendUnRefBypass_1();
            // End:0x34C
            break;
        // End:0x316
        case 10461:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10461);
            RefineNpcTalk_SendUnRefBypass_2();
            // End:0x34C
            break;
        // End:0x349
        case 10462:
            Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10462);
            RefineNpcTalk_SendUnRefBypass_3();
            // End:0x34C
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnClickStartRefinery()
{
    // End:0xBB
    if(WeaponItemInfo.ClassID != 0)
    {
        // End:0xA4
        if(LifeStoneItemInfo.ClassID != 0)
        {
            SetSearchParam();
            // End:0x93
            if(WeaponItemInfo.RefineryOp2 != 0)
            {
                // End:0x69
                if(UseNpcSimulation)
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10450, TIMER_REFINERY_NPCTALK_DELAY);                    
                }
                else
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10452, TIMER_REFINERY_UNREF_DELAY);
                }                
            }
            else
            {
                StartRefinery();
            }
            EnableRefineryProcess = true;            
        }
        else
        {
            m_InstructionText2.SetText(RefineryInstruction_SelectLS);
        }        
    }
    else
    {
        m_InstructionText2.SetText(RefineryInstruction_SelectWeapon);
    }
    m_InstructionText2.SetAnchor("ItemEnchantTab", "BottomCenter", "BottomCenter", 0, -45);
    return;
}

function int UpdateLifeStoneCount()
{
    local int Count, Index, InvetoryItems, i;
    local ItemInfo LSInfo, InventoryItem;

    Count = 0;
    InvetoryItems = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("InventoryWnd.InventoryItem");
    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("InventoryWnd.InventoryItem", LifeStoneItemInfo.ClassID);
    // End:0x172
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.InventoryItem", Index, LSInfo))
    {
        LifeStoneItemInfo = LSInfo;
        // End:0x148
        if(LSInfo.ItemNum == 1)
        {
            i = 0;

            while(i <= InvetoryItems)
            {
                // End:0x13B
                if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.InventoryItem", i, InventoryItem))
                {
                    // End:0x13B
                    if(InventoryItem.ClassID == LifeStoneItemInfo.ClassID)
                    {
                        Count = Count + 1;
                    }
                }
                ++i;
            }            
        }
        else
        {
            // End:0x162
            if(LSInfo.ItemNum == 0)
            {
                Count = 0;                
            }
            else
            {
                Count = LSInfo.ItemNum;
            }
        }
    }
    return Count;
}

function StartRefinery()
{
    // End:0x7D
    if((UpdateLifeStoneCount()) != 0)
    {
        // End:0x3F
        if(UseNpcSimulation)
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10451, TIMER_REFINERY_NPCTALK_DELAY);            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10453, TIMER_REFINERY_WEAPON_DELAY);
        }
        m_InstructionText2.SetText(RefineryInstruction_Process);        
    }
    else
    {
        StopRefinery();
        m_InstructionText2.SetText(RefineryInstruction_Error_LS);
        m_DragBoxItem4.Clear();
    }
    return;
}

function RefineNpcTalk(string Type)
{
    local UserInfo MyInfo;

    GetPlayerInfo(MyInfo);
    switch(Type)
    {
        // End:0x85
        case "Refine":
            // End:0x5B
            if(UseRefinedBypass && UseRefinedBypass_1)
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10457, TIMER_REFINERY_NPCTALK_DELAY);                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10453, TIMER_REFINERY_WEAPON_DELAY);
            }
            // End:0xFD
            break;
        // End:0xFA
        case "UnRefine":
            // End:0xD0
            if(UseUnRefinedBypass && UseUnRefinedBypass_1)
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10460, TIMER_REFINERY_NPCTALK_DELAY);                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10452, TIMER_REFINERY_UNREF_DELAY);
            }
            // End:0xFD
            break;
        // End:0xFFFF
        default:
            break;
    }
    RequestAction(NpcInfo.nID, MyInfo.Loc);
    return;
}

function RefineNpcTalk_SendRefBypass_1()
{
    // End:0x17
    if(UseCryptBypass)
    {
        RequestBypassToServer(CryptRefBypass_1);        
    }
    else
    {
        RequestBypassToServer(RefBypass_1);
    }
    // End:0x55
    if(UseRefinedBypass_2)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10458, TIMER_REFINERY_NPCTALK_DELAY);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10453, TIMER_REFINERY_WEAPON_DELAY);
    }
    return;
}

function RefineNpcTalk_SendRefBypass_2()
{
    // End:0x17
    if(UseCryptBypass)
    {
        RequestBypassToServer(CryptRefBypass_2);        
    }
    else
    {
        RequestBypassToServer(RefBypass_2);
    }
    // End:0x55
    if(UseRefinedBypass_3)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10459, TIMER_REFINERY_NPCTALK_DELAY);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10453, TIMER_REFINERY_WEAPON_DELAY);
    }
    return;
}

function RefineNpcTalk_SendRefBypass_3()
{
    // End:0x17
    if(UseCryptBypass)
    {
        RequestBypassToServer(CryptRefBypass_3);        
    }
    else
    {
        RequestBypassToServer(RefBypass_3);
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10453, TIMER_REFINERY_WEAPON_DELAY);
    return;
}

function RefineNpcTalk_SendUnRefBypass_1()
{
    // End:0x17
    if(UseCryptBypass)
    {
        RequestBypassToServer(CryptUnRefBypass_1);        
    }
    else
    {
        RequestBypassToServer(UnRefBypass_1);
    }
    // End:0x55
    if(UseUnRefinedBypass_2)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10461, TIMER_REFINERY_NPCTALK_DELAY);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10452, TIMER_REFINERY_UNREF_DELAY);
    }
    return;
}

function RefineNpcTalk_SendUnRefBypass_2()
{
    // End:0x17
    if(UseCryptBypass)
    {
        RequestBypassToServer(CryptUnRefBypass_2);        
    }
    else
    {
        RequestBypassToServer(UnRefBypass_2);
    }
    // End:0x55
    if(UseUnRefinedBypass_3)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10462, TIMER_REFINERY_NPCTALK_DELAY);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10452, TIMER_REFINERY_UNREF_DELAY);
    }
    return;
}

function RefineNpcTalk_SendUnRefBypass_3()
{
    // End:0x17
    if(UseCryptBypass)
    {
        RequestBypassToServer(CryptUnRefBypass_3);        
    }
    else
    {
        RequestBypassToServer(UnRefBypass_3);
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10452, TIMER_REFINERY_UNREF_DELAY);
    return;
}

function UnRefineFunction()
{
    Class'NWindow.RefineryAPI'.static.RequestRefineCancel(WeaponItemInfo.ServerID);
    StartRefinery();
    return;
}

function WeaponRefineFunction()
{
    Class'NWindow.RefineryAPI'.static.ConfirmTargetItem(WeaponItemInfo.ServerID);
    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10454, TIMER_REFINERY_LIFESTONE_DELAY);
    return;
}

function LifeStoneRefineFunction()
{
    Class'NWindow.RefineryAPI'.static.ConfirmRefinerItem(WeaponItemInfo.ServerID, LifeStoneItemInfo.ServerID);
    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10455, TIMER_REFINERY_GEMSTONE_DELAY);
    return;
}

function GameStoneRefineFunction()
{
    Class'NWindow.RefineryAPI'.static.ConfirmGemStone(WeaponItemInfo.ServerID, LifeStoneItemInfo.ServerID, GemStoneItemInfo.ServerID, GemstoneCount);
    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10456, TIMER_REFINERY_FINAL_DELAY);
    return;
}

function ConfirmRefineFunction()
{
    Class'NWindow.RefineryAPI'.static.RequestRefine(WeaponItemInfo.ServerID, LifeStoneItemInfo.ServerID, GemStoneItemInfo.ServerID, GemstoneCount);
    return;
}

function RefineryCancelResult(string a_Param)
{
    local INT64 Diff, CurAdena, m_Adena;

    ParseInt64(a_Param, "Adena", m_Adena);
    CurAdena.nLeft = 0;
    CurAdena.nRight = GetAdena();
    Diff = Int64SubtractBfromA(CurAdena, m_Adena);
    // End:0x86
    if((Diff.nLeft < 0) || Diff.nRight < 0)
    {
        StopRefinery();
        m_InstructionText2.SetText(RefineryInstruction_Error_Adena);
    }
    return;
}

function RefineryResult(string a_Param)
{
    local int Option1, Option2, RefineResult;

    ParseInt(a_Param, "Option1", Option1);
    ParseInt(a_Param, "Option2", Option2);
    ParseInt(a_Param, "Result", RefineResult);
    // End:0x139
    if(EnableRefineryProcess)
    {
        switch(RefineResult)
        {
            // End:0x7B
            case 0:
                StopRefinery();
                m_InstructionText2.SetText(RefineryInstruction_Error_FULL);
                // End:0x139
                break;
            // End:0x136
            case 1:
                WeaponItemInfo.RefineryOp1 = Option1;
                WeaponItemInfo.RefineryOp2 = Option2;
                // End:0xBE
                if((IsRefineryTarget(WeaponItemInfo.RefineryOp2)) == true)
                {
                    RefineryFindTaget();                    
                }
                else
                {
                    WeaponItemInfo.RefineryOp2 = Option2;
                    InserWeaponItem(WeaponItemInfo);
                    // End:0x10C
                    if(UseNpcSimulation)
                    {
                        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10450, TIMER_REFINERY_NPCTALK_DELAY);                        
                    }
                    else
                    {
                        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("EnchantAIWnd", 10452, TIMER_REFINERY_UNREF_DELAY);
                    }
                }
                // End:0x139
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        return;
    }
}

function RefineryFindTaget()
{
    InserWeaponItem(WeaponItemInfo);
    AlarmWindow();
    StopRefinery();
    PlaySound("Interface.complete_refinery");
    m_InstructionText2.SetText(((((RefineryInstruction_Result @ (GetRefineryTypeName(WeaponItemInfo.RefineryOp2))) $ ": ") $ (GetRefinerySkillName(WeaponItemInfo.RefineryOp2))) $ " Level: ") $ (GetRefinerySkillLvl(WeaponItemInfo.RefineryOp2)));
    return;
}

function OnClickStopRefinery()
{
    StopRefinery();
    m_InstructionText2.SetText(RefineryInstruction_Stop);
    return;
}

function StopRefinery()
{
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10450);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10451);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10452);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10453);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10454);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10455);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("EnchantAIWnd", 10456);
    EnableRefineryProcess = false;
    return;
}

function bool IsRefineryItem(ItemInfo a_ItemInfo)
{
    local bool IsRefinery;

    IsRefinery = false;
    // End:0x32
    if((a_ItemInfo.RefineryOp1 != 0) || a_ItemInfo.RefineryOp2 != 0)
    {
        IsRefinery = true;
    }
    return IsRefinery;
}

function DropWeapon(ItemInfo a_ItemInfo)
{
    m_DragboxItem3.Clear();
    m_DragBoxItem4.Clear();
    InserWeaponItem(a_ItemInfo);
    m_DragBoxItem4.EnableWindow();
    m_InstructionText2.SetText(RefineryInstruction_SelectLS);
    return;
}

function DropLifeStone(ItemInfo a_ItemInfo)
{
    // End:0x40
    if(m_DragBoxItem4.IsEnableWindow())
    {
        m_DragBoxItem4.Clear();
        InserLifeStoneItem(a_ItemInfo);
        m_InstructionText2.SetText(RefineryInstruction_CheckOption);
    }
    return;
}

function InserWeaponItem(ItemInfo a_ItemInfo)
{
    m_DragboxItem3.Clear();
    WeaponItemInfo = a_ItemInfo;
    m_DragboxItem3.AddItem(a_ItemInfo);
    return;
}

function InserLifeStoneItem(ItemInfo a_ItemInfo)
{
    m_DragBoxItem4.Clear();
    LifeStoneItemInfo = a_ItemInfo;
    m_DragBoxItem4.AddItem(a_ItemInfo);
    return;
}

function OnUnRefineDoneResult(string a_Param)
{
    local int UnRefineResult;

    ParseInt(a_Param, "Result", UnRefineResult);
    switch(UnRefineResult)
    {
        // End:0x6C
        case 1:
            WeaponItemInfo.RefineryOp1 = 0;
            WeaponItemInfo.RefineryOp2 = 0;
            // End:0x69
            if(!m_DragboxItem3.SetItem(0, WeaponItemInfo))
            {
                m_DragboxItem3.AddItem(WeaponItemInfo);
            }
            // End:0x76
            break;
        // End:0x73
        case 0:
            // End:0x76
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function EV_GameStoneCheck(string a_Param)
{
    local int Result, RequiredGemstoneAmount, RequiredGemstoneClassID, GamestoneIndex;

    ParseInt(a_Param, "Result", Result);
    ParseInt(a_Param, "GemStoneCount", RequiredGemstoneAmount);
    ParseInt(a_Param, "GemStoneClassID", RequiredGemstoneClassID);
    GemstoneCount = RequiredGemstoneAmount;
    // End:0x10A
    if(Result == 1)
    {
        GamestoneIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("InventoryWnd.InventoryItem", RequiredGemstoneClassID);
        // End:0x10A
        if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.InventoryItem", GamestoneIndex, GemStoneItemInfo))
        {
            // End:0x10A
            if(GemStoneItemInfo.ItemNum < GemstoneCount)
            {
                StopRefinery();
                m_InstructionText2.SetText(RefineryInstruction_Error_GS);
            }
        }
    }
    return;
}

function NPC_Simul_SetParam(bool IsUpdate, bool ParamCrypt, bool ParamRef, bool ParamRef1, bool ParamRef2, bool ParamRef3, bool ParamUnRef, bool ParamUnRef1, bool ParamUnRef2, bool ParamUnRef3, string RefBypass1, string RefBypass2, string RefBypass3, string UnRefBypass1, string UnRefBypass2, string UnRefBypass3)
{
    UseCryptBypass = ParamCrypt;
    UseRefinedBypass = ParamRef;
    UseRefinedBypass_1 = ParamRef1;
    UseRefinedBypass_2 = ParamRef2;
    UseRefinedBypass_3 = ParamRef3;
    // End:0x55
    if(UseRefinedBypass_1)
    {
        RefBypass_1 = RefBypass1;
    }
    // End:0x69
    if(UseRefinedBypass_2)
    {
        RefBypass_2 = RefBypass2;
    }
    // End:0x7D
    if(UseRefinedBypass_3)
    {
        RefBypass_3 = RefBypass3;
    }
    UseUnRefinedBypass = ParamUnRef;
    UseUnRefinedBypass_1 = ParamUnRef1;
    UseUnRefinedBypass_2 = ParamUnRef2;
    UseUnRefinedBypass_3 = ParamUnRef3;
    // End:0xC5
    if(UseUnRefinedBypass_1)
    {
        UnRefBypass_1 = UnRefBypass1;
    }
    // End:0xD9
    if(UseUnRefinedBypass_2)
    {
        UnRefBypass_2 = UnRefBypass2;
    }
    // End:0xED
    if(UseUnRefinedBypass_3)
    {
        UnRefBypass_3 = UnRefBypass3;
    }
    // End:0x15C
    if(UseCryptBypass)
    {
        CryptRefBypass_1 = GetSuperRace(RefBypass1);
        CryptRefBypass_2 = GetSuperRace(RefBypass2);
        CryptRefBypass_3 = GetSuperRace(RefBypass3);
        CryptUnRefBypass_1 = GetSuperRace(UnRefBypass1);
        CryptUnRefBypass_2 = GetSuperRace(UnRefBypass2);
        CryptUnRefBypass_3 = GetSuperRace(UnRefBypass3);
    }
    // End:0x47D
    if(IsUpdate)
    {
        SetINIBool("AutoRefinery", "UseCryptBypass", UseCryptBypass, "Option");
        SetINIString("AutoRefinery", "RefinedBypass_1", RefBypass_1, "Option");
        SetINIString("AutoRefinery", "RefinedBypass_2", RefBypass_2, "Option");
        SetINIString("AutoRefinery", "RefinedBypass_3", RefBypass_3, "Option");
        SetINIString("AutoRefinery", "UnRefinedBypass_1", UnRefBypass_1, "Option");
        SetINIString("AutoRefinery", "UnRefinedBypass_2", UnRefBypass_2, "Option");
        SetINIString("AutoRefinery", "UnRefinedBypass_3", UnRefBypass_3, "Option");
        SetINIBool("AutoRefinery", "UseRefinedBypass", UseRefinedBypass, "Option");
        SetINIBool("AutoRefinery", "UseUnRefinedBypass", UseUnRefinedBypass, "Option");
        SetINIBool("AutoRefinery", "UseRefinedBypass_1", UseRefinedBypass_1, "Option");
        SetINIBool("AutoRefinery", "UseRefinedBypass_2", UseRefinedBypass_2, "Option");
        SetINIBool("AutoRefinery", "UseRefinedBypass_3", UseRefinedBypass_3, "Option");
        SetINIBool("AutoRefinery", "UseUnRefinedBypass_1", UseUnRefinedBypass_1, "Option");
        SetINIBool("AutoRefinery", "UseUnRefinedBypass_2", UseUnRefinedBypass_2, "Option");
        SetINIBool("AutoRefinery", "UseUnRefinedBypass_3", UseUnRefinedBypass_3, "Option");
    }
    return;
}

function NPC_Simul_SetBoolParam(int Type, bool param)
{
    switch(Type)
    {
        // End:0x1B
        case 0:
            UseRefinedBypass = param;
            // End:0x9B
            break;
        // End:0x2F
        case 1:
            UseUnRefinedBypass = param;
            // End:0x9B
            break;
        // End:0x44
        case 2:
            UseRefinedBypass_1 = param;
            // End:0x9B
            break;
        // End:0x59
        case 3:
            UseRefinedBypass_2 = param;
            // End:0x9B
            break;
        // End:0x6E
        case 4:
            UseRefinedBypass_3 = param;
            // End:0x9B
            break;
        // End:0x83
        case 5:
            UseUnRefinedBypass_1 = param;
            // End:0x9B
            break;
        // End:0x98
        case 6:
            UseUnRefinedBypass_2 = param;
            // End:0x9B
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function NPC_Simul_SetStringParam(int Type, string param)
{
    switch(Type)
    {
        // End:0x19
        case 0:
            RefBypass_1 = param;
            // End:0x67
            break;
        // End:0x2B
        case 1:
            RefBypass_2 = param;
            // End:0x67
            break;
        // End:0x3E
        case 2:
            RefBypass_3 = param;
            // End:0x67
            break;
        // End:0x51
        case 3:
            UnRefBypass_1 = param;
            // End:0x67
            break;
        // End:0x64
        case 4:
            UnRefBypass_2 = param;
            // End:0x67
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function bool IsRefineryTarget(int Id)
{
    local array<string> arrSplit, arrSplit2;
    local bool SearchResult, IsRefinery;
    local int RefineryQuality, RefineryType, i, tempquality;

    SearchResult = false;
    IsRefinery = false;
    RefineryQuality = 0;
    RefineryType = 0;
    arrSplit.Length = 0;
    arrSplit2.Length = 0;
    GetRefineryParam(Id, arrSplit);
    GetRefineryCustomList(arrSplit2);
    tempquality = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("EnchantAIWnd.comboQuality");
    IsRefinery = bool(arrSplit[0]);
    RefineryQuality = int(arrSplit[1]);
    RefineryType = int(arrSplit[2]);
    // End:0xBD
    if(tempquality == 0)
    {
        SearchQuality = 0;        
    }
    else
    {
        // End:0xD0
        if(tempquality == 1)
        {
            SearchQuality = 4;
        }
    }
    // End:0x30E
    if(IsRefinery)
    {
        // End:0x11C
        if(((SearchAll == true) && SearchQuality == 0) || (SearchAll == true) && SearchQuality == RefineryQuality)
        {
            SearchResult = true;            
        }
        else
        {
            // End:0x17B
            if((((SearchPassive == true) && RefineryType == 2) && SearchQuality == 0) || ((SearchPassive == true) && RefineryType == 2) && SearchQuality == RefineryQuality)
            {
                SearchResult = true;                
            }
            else
            {
                // End:0x1D8
                if((((SearchActive == true) && RefineryType == 1) && SearchQuality == 0) || ((SearchPassive == true) && RefineryType == 1) && SearchQuality == RefineryQuality)
                {
                    SearchResult = true;                    
                }
                else
                {
                    // End:0x237
                    if((((SearchChance == true) && RefineryType == 3) && SearchQuality == 0) || ((SearchPassive == true) && RefineryType == 3) && SearchQuality == RefineryQuality)
                    {
                        SearchResult = true;                        
                    }
                    else
                    {
                        // End:0x296
                        if((((SearchStat == true) && RefineryType == 4) && SearchQuality == 0) || ((SearchPassive == true) && RefineryType == 4) && SearchQuality == RefineryQuality)
                        {
                            SearchResult = true;                            
                        }
                        else
                        {
                            // End:0x2BF
                            if((SearchSelect == true) && Id == (GetComboboxSelect()))
                            {
                                SearchResult = true;                                
                            }
                            else
                            {
                                // End:0x30E
                                if(SearchCustom == true)
                                {
                                    i = 0;

                                    while(i < arrSplit2.Length)
                                    {
                                        // End:0x304
                                        if(Id == int(arrSplit2[i]))
                                        {
                                            SearchResult = true;
                                            break;
                                        }
                                        ++i;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    return SearchResult;
}

function int GetComboboxSelect()
{
    local array<string> arrSplit;
    local int ComboNum, Result;

    GetRefinerySelectList(arrSplit);
    ComboNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("EnchantAIWnd.comboTypeAll");
    Result = int(arrSplit[ComboNum]);
    return Result;
}

function string GetRefinerySkillName(int Id)
{
    local array<string> arrSplit;

    GetRefineryParam(Id, arrSplit);
    return arrSplit[3];
}

function string GetRefineryTypeName(int Id)
{
    local array<string> arrSplit;
    local int TypeID;
    local string Names;

    GetRefineryParam(Id, arrSplit);
    TypeID = int(arrSplit[2]);
    switch(TypeID)
    {
        // End:0x3C
        case 1:
            Names = "Active";
            // End:0x80
            break;
        // End:0x53
        case 2:
            Names = "Passive";
            // End:0x80
            break;
        // End:0x69
        case 3:
            Names = "Chance";
            // End:0x80
            break;
        // End:0x7D
        case 4:
            Names = "Stat";
            // End:0x80
            break;
        // End:0xFFFF
        default:
            break;
    }
    return Names;
}

function string GetRefinerySkillLvl(int Id)
{
    local array<string> arrSplit;

    GetRefineryParam(Id, arrSplit);
    return arrSplit[4];
}

function GetRefineryParam(int Id, out array<string> arrSplit)
{
    local string Value;
    local int SplitCount;

    RefineryParam(Id, Value);
    SplitCount = Split(Value, ",", arrSplit);
    return;
}

function GetRefinerySelectList(out array<string> arrSplit)
{
    local string Value;
    local int SplitCount;

    Value = "";
    GetINIString("AutoRefinery", "SelectList", Value, "Option");
    SplitCount = Split(Value, ",", arrSplit);
    return;
}

function GetRefineryCustomList(out array<string> arrSplit)
{
    local string Value;
    local int SplitCount;

    GetINIString("AutoRefinery", "CustomList", Value, "Option");
    SplitCount = Split(Value, ",", arrSplit);
    return;
}

function ComboBox_Quality()
{
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("EnchantAIWnd.comboQuality");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("EnchantAIWnd.comboQuality", "All");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("EnchantAIWnd.comboQuality", "Top");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("EnchantAIWnd.comboQuality", 0);
    return;
}

function ComboBoxParam()
{
    local array<string> arrSplit;
    local int i;

    arrSplit.Length = 0;
    GetRefinerySelectList(arrSplit);
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("EnchantAIWnd.comboTypeAll");
    // End:0x111
    if(arrSplit[0] != "")
    {
        i = 0;

        while(i < arrSplit.Length)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("EnchantAIWnd.comboTypeAll", (((((GetRefineryTypeName(int(arrSplit[i]))) $ ": ") $ (GetRefinerySkillName(int(arrSplit[i])))) $ " ") $ (GetRefinerySkillLvl(int(arrSplit[i])))) $ " lvl");
            ++i;
        }
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("EnchantAIWnd.comboTypeAll", 0);
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

function SetFirstOption()
{
    SetINIBool("AutoUsePotion", "EnableAutoUsePotion", true, "Option");
    SetINIBool("AutoUsePotion", "UsePotionInPeaceZone", true, "Option");
    SetINIBool("AutoUsePotion", "UseSaveItem", true, "Option");
    SetINIInt("AutoUsePotion", "CP_DifferenceToUse", 200, "Option");
    SetINIInt("AutoUsePotion", "HP_DifferenceToUse", 400, "Option");
    SetINIInt("AutoUsePotion", "MP_DifferenceToUse", 500, "Option");
    SetINIInt("AutoUsePotion", "CPPotion_ID", 0, "Option");
    SetINIInt("AutoUsePotion", "HPPotion_ID", 0, "Option");
    SetINIInt("AutoUsePotion", "MPPotion_ID", 0, "Option");
    SetINIInt("AutoUsePotion", "CP_Reuse", 3, "Option");
    SetINIInt("AutoUsePotion", "HP_Reuse", 14, "Option");
    SetINIInt("AutoUsePotion", "MP_Reuse", 9, "Option");
    SetINIInt("AutoEnchant", "Delay_ScrollSelect", 0, "Option");
    SetINIInt("AutoEnchant", "Delay_EnchantItem", 1, "Option");
    SetINIInt("AutoRefinery", "Delay_NPCTalk", 3, "Option");
    SetINIInt("AutoRefinery", "Delay_WP", 1, "Option");
    SetINIInt("AutoRefinery", "Delay_LS", 1, "Option");
    SetINIInt("AutoRefinery", "Delay_GS", 1, "Option");
    SetINIInt("AutoRefinery", "Delay_UN", 1, "Option");
    SetINIInt("AutoRefinery", "Delay_Final", 1, "Option");
    SetINIBool("AutoRefinery", "UseNPCSimulation", false, "Option");
    SetINIString("AutoRefinery", "NPCSimulationBypass_Ref", "npc_$s1_Augment 1", "Option");
    SetINIString("AutoRefinery", "NPCSimulationBypass_UnRef", "npc_$s1_Augment 2", "Option");
    SetINIString("AutoRefinery", "SelectList", "16184,16186,16192,16233,16235,16236,16237,16294,16336,16211,16285,16196,16281,16206,16283,16201,16282,16208,16284,16287,14691", "Option");
    SetINIString("AutoRefinery", "CustomList", "16200,16201,16202,16203,16204,16205,16206,16207,16208,16209,16210,16211,16212,16213,16214,16215,16216,16217,16218", "Option");
    SetINIInt("AutoEnchantSkill", "Delay_SkillEnchant", 3, "Option");
    return;
}

function CheckFirst()
{
    local bool IsFirst;
    local int IsFirstInt;

    GetINIBool("L2mod", "IsFirst", IsFirstInt, "Option");
    IsFirst = bool(IsFirstInt);
    // End:0x70
    if(IsFirst == false)
    {
        SetFirstOption();
        SetINIBool("L2mod", "IsFirst", true, "Option");
        RefreshINI("Option");
    }
    return;
}

function SetFocus()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("EnchantAIWnd.SkillEnchantTab");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("EnchantAIWnd.TabEnchant");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("EnchantAIWnd.ItemEnchantTab");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("EnchantAIWnd.AugmentationTab");
    return;
}
