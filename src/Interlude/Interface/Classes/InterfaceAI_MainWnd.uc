class InterfaceAI_MainWnd extends UICommonAPI;

const TIMER_ID = 9800;
const TIMER_ID2 = 9801;
const TIMER_DELAY = 100;
const TIMER_DELAY2 = 100;

var WindowHandle Me;
var ButtonHandle btn_Enchant;
var ButtonHandle btn_LifeStone;
var ButtonHandle btn_Skill;
var ButtonHandle btnOptions;
var bool showeffect;

function OnLoad()
{
    RegisterEvents();
    InitHandle();
    LoadData();
    return;
}

function RegisterEvents()
{
    RegisterEvent(19000);
    return;
}

function LoadData()
{
    btn_Enchant.SetTooltipCustomType(SetTooltip("Automatic Enchant Items"));
    btn_LifeStone.SetTooltipCustomType(SetTooltip("Automatic Augmentation"));
    btn_Skill.SetTooltipCustomType(SetTooltip("Automatic Enchant Skills"));
    btnOptions.SetTooltipCustomType(SetTooltip("Options"));
    return;
}

function InitHandle()
{
    Me = GetHandle("InterfaceAI_MainWnd");
    btn_Enchant = ButtonHandle(GetHandle("InterfaceAI_MainWnd.btnMenuScroll"));
    btn_LifeStone = ButtonHandle(GetHandle("InterfaceAI_MainWnd.btnMenuLS"));
    btn_Skill = ButtonHandle(GetHandle("InterfaceAI_MainWnd.btnMenuSkill"));
    btnOptions = ButtonHandle(GetHandle("InterfaceAI_MainWnd.btnOptions"));
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x23
        case "btnMenuScroll":
            ShowAutomatic(0);
            // End:0x5A
            break;
        // End:0x3B
        case "btnMenuLS":
            ShowAutomatic(1);
            // End:0x5A
            break;
        // End:0x57
        case "btnMenuSkill":
            ShowAutomatic(2);
            // End:0x5A
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function ShowAutomatic(int Type)
{
    // End:0xA3
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("EnchantAIWnd"))
    {
        // End:0x72
        if(Class'NWindow.UIAPI_TABCTRL'.static.GetTopIndex("EnchantAIWnd.TabEnchant") == Type)
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("EnchantAIWnd");            
        }
        else
        {
            Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("EnchantAIWnd.TabEnchant", Type, true);
        }        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("EnchantAIWnd");
        Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("EnchantAIWnd.TabEnchant", Type, true);
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
