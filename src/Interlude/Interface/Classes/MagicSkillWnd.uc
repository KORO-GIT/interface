class MagicSkillWnd extends UICommonAPI;

const Skill_MAX_COUNT = 24;

var bool m_bShow;
var string m_WindowName;

function OnLoad()
{
    RegisterEvent(1280);
    RegisterEvent(1290);
    RegisterEvent(1900);
    m_bShow = false;
    return;
}

function OnShow()
{
    RequestSkillList();
    m_bShow = true;
    return;
}

function OnHide()
{
    m_bShow = false;
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x18
    if(Event_ID == 1280)
    {
        HandleSkillListStart();        
    }
    else
    {
        // End:0x35
        if(Event_ID == 1290)
        {
            HandleSkillList(param);            
        }
        else
        {
            // End:0x4A
            if(Event_ID == 1900)
            {
                HandleLanguageChanged();
            }
        }
    }
    return;
}

function OnClickItem(string strID, int Index)
{
    local ItemInfo infItem;

    // End:0x6C
    if((strID == "SkillItem") && Index > -1)
    {
        // End:0x6C
        if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".ASkill.SkillItem", Index, infItem))
        {
            UseSkill(infItem.ClassID);
        }
    }
    return;
}

function HandleLanguageChanged()
{
    RequestSkillList();
    return;
}

function HandleSkillListStart()
{
    Clear();
    return;
}

function Clear()
{
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear(m_WindowName $ ".ASkill.SkillItem");
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear(m_WindowName $ ".PSkill.PItemWnd");
    return;
}

function HandleSkillList(string param)
{
    local string WndName;
    local int tmp;
    local UIEventManager.ESkillCategory Type;
    local int SkillID, SkillLevel, Lock;
    local string strIconName, strSkillName, strDescription, strEnchantName, strCommand;

    local ItemInfo infItem;

    ParseInt(param, "Type", tmp);
    ParseInt(param, "ClassID", SkillID);
    ParseInt(param, "Level", SkillLevel);
    ParseInt(param, "Lock", Lock);
    ParseString(param, "Name", strSkillName);
    ParseString(param, "IconName", strIconName);
    ParseString(param, "Description", strDescription);
    ParseString(param, "EnchantName", strEnchantName);
    ParseString(param, "Command", strCommand);
    infItem.ClassID = SkillID;
    infItem.Level = SkillLevel;
    infItem.Name = strSkillName;
    infItem.AdditionalName = strEnchantName;
    infItem.IconName = strIconName;
    infItem.Description = strDescription;
    infItem.ItemSubType = 2;
    infItem.MacroCommand = strCommand;
    // End:0x179
    if(Lock > 0)
    {
        infItem.bIsLock = true;        
    }
    else
    {
        infItem.bIsLock = false;
    }
    Type = ESkillCategory(tmp);
    // End:0x1BD
    if(Type == SKILL_Passive)
    {
        WndName = "PSkill.PItemWnd";        
    }
    else
    {
        WndName = "ASkill.SkillItem";
    }
    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem((m_WindowName $ ".") $ WndName, infItem);
    return;
}

defaultproperties
{
    m_WindowName="MagicSkillWnd"
}
