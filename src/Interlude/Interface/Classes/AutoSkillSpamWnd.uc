class AutoSkillSpamWnd extends UICommonAPI;

const TIMERID_SPAM_SKILL = 9999;

var bool useSpam_1;
var bool useSpam_2;
var bool useSpam_3;
var bool useSpam_4;
var bool useSpam_5;
var WindowHandle m_hOptWnd;
var WindowHandle AutoSkillSpamWnd;
var ItemWindowHandle SkillBox_Spam_1;
var ItemWindowHandle SkillBox_Spam_2;
var ItemWindowHandle SkillBox_Spam_3;
var ItemWindowHandle SkillBox_Spam_4;
var ItemWindowHandle SkillBox_Spam_5;
var ItemInfo SkillBox_Spam_Spam_Item_1;
var ItemInfo SkillBox_Spam_Spam_Item_2;
var ItemInfo SkillBox_Spam_Spam_Item_3;
var ItemInfo SkillBox_Spam_Spam_Item_4;
var ItemInfo SkillBox_Spam_Spam_Item_5;
var TextureHandle Toggle_Skill_Spam_1;
var TextureHandle Toggle_Skill_Spam_2;
var TextureHandle Toggle_Skill_Spam_3;
var TextureHandle Toggle_Skill_Spam_4;
var TextureHandle Toggle_Skill_Spam_5;

function OnLoad()
{
    RegisterEvent(150);
    RegisterEvent(160);
    useSpam_1 = false;
    useSpam_2 = false;
    useSpam_3 = false;
    useSpam_4 = false;
    useSpam_5 = false;
    AutoSkillSpamWnd = GetHandle("AutoSkillSpamWnd");
    SkillBox_Spam_1 = ItemWindowHandle(GetHandle("AutoSkillSpamWnd.SkillBox_Spam_1"));
    SkillBox_Spam_2 = ItemWindowHandle(GetHandle("AutoSkillSpamWnd.SkillBox_Spam_2"));
    SkillBox_Spam_3 = ItemWindowHandle(GetHandle("AutoSkillSpamWnd.SkillBox_Spam_3"));
    SkillBox_Spam_4 = ItemWindowHandle(GetHandle("AutoSkillSpamWnd.SkillBox_Spam_4"));
    SkillBox_Spam_5 = ItemWindowHandle(GetHandle("AutoSkillSpamWnd.SkillBox_Spam_5"));
    Toggle_Skill_Spam_1 = TextureHandle(GetHandle("AutoSkillSpamWnd.Toggle_Skill_Spam_1"));
    Toggle_Skill_Spam_2 = TextureHandle(GetHandle("AutoSkillSpamWnd.Toggle_Skill_Spam_2"));
    Toggle_Skill_Spam_3 = TextureHandle(GetHandle("AutoSkillSpamWnd.Toggle_Skill_Spam_3"));
    Toggle_Skill_Spam_4 = TextureHandle(GetHandle("AutoSkillSpamWnd.Toggle_Skill_Spam_4"));
    Toggle_Skill_Spam_5 = TextureHandle(GetHandle("AutoSkillSpamWnd.Toggle_Skill_Spam_5"));
    Toggle_Skill_Spam_1.HideWindow();
    Toggle_Skill_Spam_2.HideWindow();
    Toggle_Skill_Spam_3.HideWindow();
    Toggle_Skill_Spam_4.HideWindow();
    Toggle_Skill_Spam_5.HideWindow();
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    // End:0x12
    if(a_EventID == 150)
    {
        HandleGamingStateEnter();
    }
    // End:0x24
    if(a_EventID == 160)
    {
        saveINI();
    }
    return;
}

function HandleGamingStateEnter()
{
    Reset();
    AutoSkillSpamWnd.SetTimer(10210, 2000);
    AutoSkillSpamWnd.SetTimer(9999, 300);
    return;
}

function Reset()
{
    AutoSkillSpamWnd.KillTimer(10210);
    AutoSkillSpamWnd.KillTimer(9999);
    useSpam_1 = false;
    useSpam_2 = false;
    useSpam_3 = false;
    useSpam_4 = false;
    useSpam_5 = false;
    SkillBox_Spam_1.Clear();
    SkillBox_Spam_2.Clear();
    SkillBox_Spam_3.Clear();
    SkillBox_Spam_4.Clear();
    SkillBox_Spam_5.Clear();
    SkillBox_Spam_Spam_Item_1.ClassID = 0;
    SkillBox_Spam_Spam_Item_2.ClassID = 0;
    SkillBox_Spam_Spam_Item_3.ClassID = 0;
    SkillBox_Spam_Spam_Item_4.ClassID = 0;
    SkillBox_Spam_Spam_Item_5.ClassID = 0;
    Toggle_Skill_Spam_1.HideWindow();
    Toggle_Skill_Spam_2.HideWindow();
    Toggle_Skill_Spam_3.HideWindow();
    Toggle_Skill_Spam_4.HideWindow();
    Toggle_Skill_Spam_5.HideWindow();
    return;
}

function InsertSkillsOnStart()
{
    local int outValue;
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    GetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_1", outValue, "Option");
    // End:0x70
    if((outValue == 2) || outValue == 4)
    {
        GetActionInfoFunc(outValue, SkillBox_Spam_Spam_Item_1);        
    }
    else
    {
        GetSkillInfoFunc(outValue, SkillBox_Spam_Spam_Item_1);
    }
    // End:0xA4
    if(SkillBox_Spam_Spam_Item_1.ClassID > 0)
    {
        SkillBox_Spam_1.AddItem(SkillBox_Spam_Spam_Item_1);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_2", outValue, "Option");
    // End:0x109
    if((outValue == 2) || outValue == 4)
    {
        GetActionInfoFunc(outValue, SkillBox_Spam_Spam_Item_2);        
    }
    else
    {
        GetSkillInfoFunc(outValue, SkillBox_Spam_Spam_Item_2);
    }
    // End:0x13D
    if(SkillBox_Spam_Spam_Item_2.ClassID > 0)
    {
        SkillBox_Spam_2.AddItem(SkillBox_Spam_Spam_Item_2);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_3", outValue, "Option");
    // End:0x1A2
    if((outValue == 2) || outValue == 4)
    {
        GetActionInfoFunc(outValue, SkillBox_Spam_Spam_Item_3);        
    }
    else
    {
        GetSkillInfoFunc(outValue, SkillBox_Spam_Spam_Item_3);
    }
    // End:0x1D6
    if(SkillBox_Spam_Spam_Item_3.ClassID > 0)
    {
        SkillBox_Spam_3.AddItem(SkillBox_Spam_Spam_Item_3);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_4", outValue, "Option");
    // End:0x23B
    if((outValue == 2) || outValue == 4)
    {
        GetActionInfoFunc(outValue, SkillBox_Spam_Spam_Item_4);        
    }
    else
    {
        GetSkillInfoFunc(outValue, SkillBox_Spam_Spam_Item_4);
    }
    // End:0x26F
    if(SkillBox_Spam_Spam_Item_4.ClassID > 0)
    {
        SkillBox_Spam_4.AddItem(SkillBox_Spam_Spam_Item_4);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_5", outValue, "Option");
    // End:0x2D4
    if((outValue == 2) || outValue == 4)
    {
        GetActionInfoFunc(outValue, SkillBox_Spam_Spam_Item_5);        
    }
    else
    {
        GetSkillInfoFunc(outValue, SkillBox_Spam_Spam_Item_5);
    }
    // End:0x308
    if(SkillBox_Spam_Spam_Item_5.ClassID > 0)
    {
        SkillBox_Spam_5.AddItem(SkillBox_Spam_Spam_Item_5);
    }
    return;
}

function OnTimer(int a_TimerID)
{
    // End:0x15
    if(a_TimerID == 9999)
    {
        SpamSkills();
    }
    // End:0x3E
    if(a_TimerID == 10210)
    {
        AutoSkillSpamWnd.KillTimer(10210);
        InsertSkillsOnStart();
    }
    return;
}

function SpamSkills()
{
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    // End:0x1AB
    if(UserInfo.nCurHP > 0)
    {
        // End:0x6B
        if(useSpam_1)
        {
            // End:0x5B
            if((SkillBox_Spam_Spam_Item_1.ClassID == 4) || SkillBox_Spam_Spam_Item_1.ClassID == 2)
            {
                DoAction(SkillBox_Spam_Spam_Item_1.ClassID);                
            }
            else
            {
                UseSkill(SkillBox_Spam_Spam_Item_1.ClassID);
            }
        }
        // End:0xBB
        if(useSpam_2)
        {
            // End:0xAB
            if((SkillBox_Spam_Spam_Item_2.ClassID == 4) || SkillBox_Spam_Spam_Item_2.ClassID == 2)
            {
                DoAction(SkillBox_Spam_Spam_Item_2.ClassID);                
            }
            else
            {
                UseSkill(SkillBox_Spam_Spam_Item_2.ClassID);
            }
        }
        // End:0x10B
        if(useSpam_3)
        {
            // End:0xFB
            if((SkillBox_Spam_Spam_Item_3.ClassID == 4) || SkillBox_Spam_Spam_Item_3.ClassID == 2)
            {
                DoAction(SkillBox_Spam_Spam_Item_3.ClassID);                
            }
            else
            {
                UseSkill(SkillBox_Spam_Spam_Item_3.ClassID);
            }
        }
        // End:0x15B
        if(useSpam_4)
        {
            // End:0x14B
            if((SkillBox_Spam_Spam_Item_4.ClassID == 4) || SkillBox_Spam_Spam_Item_4.ClassID == 2)
            {
                DoAction(SkillBox_Spam_Spam_Item_4.ClassID);                
            }
            else
            {
                UseSkill(SkillBox_Spam_Spam_Item_4.ClassID);
            }
        }
        // End:0x1AB
        if(useSpam_5)
        {
            // End:0x19B
            if((SkillBox_Spam_Spam_Item_5.ClassID == 4) || SkillBox_Spam_Spam_Item_5.ClassID == 2)
            {
                DoAction(SkillBox_Spam_Spam_Item_5.ClassID);                
            }
            else
            {
                UseSkill(SkillBox_Spam_Spam_Item_5.ClassID);
            }
        }
    }
    return;
}

function OnDropItem(string a_WindowID, ItemInfo a_ItemInfo, int X, int Y)
{
    // End:0x4C
    if(a_WindowID == "SkillBox_Spam_1")
    {
        SkillBox_Spam_1.Clear();
        SkillBox_Spam_Spam_Item_1 = a_ItemInfo;
        SkillBox_Spam_1.AddItem(a_ItemInfo);        
    }
    else
    {
        // End:0x98
        if(a_WindowID == "SkillBox_Spam_2")
        {
            SkillBox_Spam_2.Clear();
            SkillBox_Spam_Spam_Item_2 = a_ItemInfo;
            SkillBox_Spam_2.AddItem(a_ItemInfo);            
        }
        else
        {
            // End:0xE4
            if(a_WindowID == "SkillBox_Spam_3")
            {
                SkillBox_Spam_3.Clear();
                SkillBox_Spam_Spam_Item_3 = a_ItemInfo;
                SkillBox_Spam_3.AddItem(a_ItemInfo);                
            }
            else
            {
                // End:0x130
                if(a_WindowID == "SkillBox_Spam_4")
                {
                    SkillBox_Spam_4.Clear();
                    SkillBox_Spam_Spam_Item_4 = a_ItemInfo;
                    SkillBox_Spam_4.AddItem(a_ItemInfo);                    
                }
                else
                {
                    // End:0x179
                    if(a_WindowID == "SkillBox_Spam_5")
                    {
                        SkillBox_Spam_5.Clear();
                        SkillBox_Spam_Spam_Item_5 = a_ItemInfo;
                        SkillBox_Spam_5.AddItem(a_ItemInfo);
                    }
                }
            }
        }
    }
    saveINI();
    return;
}

function OnClickItem(string strID, int Index)
{
    // End:0x53
    if((strID == "SkillBox_Spam_1") && Index > -1)
    {
        // End:0x45
        if(!useSpam_1)
        {
            EnableSkill(SkillBox_Spam_1);            
        }
        else
        {
            DisableSkill(SkillBox_Spam_1);
        }        
    }
    else
    {
        // End:0xA6
        if((strID == "SkillBox_Spam_2") && Index > -1)
        {
            // End:0x98
            if(!useSpam_2)
            {
                EnableSkill(SkillBox_Spam_2);                
            }
            else
            {
                DisableSkill(SkillBox_Spam_2);
            }            
        }
        else
        {
            // End:0xF9
            if((strID == "SkillBox_Spam_3") && Index > -1)
            {
                // End:0xEB
                if(!useSpam_3)
                {
                    EnableSkill(SkillBox_Spam_3);                    
                }
                else
                {
                    DisableSkill(SkillBox_Spam_3);
                }                
            }
            else
            {
                // End:0x14C
                if((strID == "SkillBox_Spam_4") && Index > -1)
                {
                    // End:0x13E
                    if(!useSpam_4)
                    {
                        EnableSkill(SkillBox_Spam_4);                        
                    }
                    else
                    {
                        DisableSkill(SkillBox_Spam_4);
                    }                    
                }
                else
                {
                    // End:0x19C
                    if((strID == "SkillBox_Spam_5") && Index > -1)
                    {
                        // End:0x191
                        if(!useSpam_5)
                        {
                            EnableSkill(SkillBox_Spam_5);                            
                        }
                        else
                        {
                            DisableSkill(SkillBox_Spam_5);
                        }
                    }
                }
            }
        }
    }
    return;
}

function DisableSkill(ItemWindowHandle ItemWnd)
{
    switch(ItemWnd)
    {
        // End:0x29
        case SkillBox_Spam_1:
            Toggle_Skill_Spam_1.HideWindow();
            useSpam_1 = false;
            // End:0xB4
            break;
        // End:0x4B
        case SkillBox_Spam_2:
            Toggle_Skill_Spam_2.HideWindow();
            useSpam_2 = false;
            // End:0xB4
            break;
        // End:0x6D
        case SkillBox_Spam_3:
            Toggle_Skill_Spam_3.HideWindow();
            useSpam_3 = false;
            // End:0xB4
            break;
        // End:0x8F
        case SkillBox_Spam_4:
            Toggle_Skill_Spam_4.HideWindow();
            useSpam_4 = false;
            // End:0xB4
            break;
        // End:0xB1
        case SkillBox_Spam_5:
            Toggle_Skill_Spam_5.HideWindow();
            useSpam_5 = false;
            // End:0xB4
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function EnableSkill(ItemWindowHandle ItemWnd)
{
    switch(ItemWnd)
    {
        // End:0x29
        case SkillBox_Spam_1:
            Toggle_Skill_Spam_1.ShowWindow();
            useSpam_1 = true;
            // End:0xB4
            break;
        // End:0x4B
        case SkillBox_Spam_2:
            Toggle_Skill_Spam_2.ShowWindow();
            useSpam_2 = true;
            // End:0xB4
            break;
        // End:0x6D
        case SkillBox_Spam_3:
            Toggle_Skill_Spam_3.ShowWindow();
            useSpam_3 = true;
            // End:0xB4
            break;
        // End:0x8F
        case SkillBox_Spam_4:
            Toggle_Skill_Spam_4.ShowWindow();
            useSpam_4 = true;
            // End:0xB4
            break;
        // End:0xB1
        case SkillBox_Spam_5:
            Toggle_Skill_Spam_5.ShowWindow();
            useSpam_5 = true;
            // End:0xB4
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnRClickItem(string strID, int Index)
{
    // End:0x44
    if(strID == "SkillBox_Spam_1")
    {
        DisableSkill(SkillBox_Spam_1);
        SkillBox_Spam_1.Clear();
        SkillBox_Spam_Spam_Item_1.ClassID = 0;        
    }
    else
    {
        // End:0x88
        if(strID == "SkillBox_Spam_2")
        {
            DisableSkill(SkillBox_Spam_2);
            SkillBox_Spam_2.Clear();
            SkillBox_Spam_Spam_Item_2.ClassID = 0;            
        }
        else
        {
            // End:0xCC
            if(strID == "SkillBox_Spam_3")
            {
                DisableSkill(SkillBox_Spam_3);
                SkillBox_Spam_3.Clear();
                SkillBox_Spam_Spam_Item_3.ClassID = 0;                
            }
            else
            {
                // End:0x110
                if(strID == "SkillBox_Spam_4")
                {
                    DisableSkill(SkillBox_Spam_4);
                    SkillBox_Spam_4.Clear();
                    SkillBox_Spam_Spam_Item_4.ClassID = 0;                    
                }
                else
                {
                    // End:0x151
                    if(strID == "SkillBox_Spam_5")
                    {
                        DisableSkill(SkillBox_Spam_5);
                        SkillBox_Spam_5.Clear();
                        SkillBox_Spam_Spam_Item_5.ClassID = 0;
                    }
                }
            }
        }
    }
    saveINI();
    return;
}

function GetSkillInfoFunc(int Id, out ItemInfo Info)
{
    local int Index;
    local ItemInfo Skill;

    RequestSkillList();
    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("MagicSkillWnd.ASkill.SkillItem", Id);
    // End:0x87
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("MagicSkillWnd.ASkill.SkillItem", Index, Skill))
    {
        Info = Skill;
    }
    return;
}

function GetActionInfoFunc(int Id, out ItemInfo Info)
{
    local int Index;
    local ItemInfo Skill;

    Class'NWindow.ActionAPI'.static.RequestActionList();
    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("ActionWnd.ActionBasicItem", Id);
    // End:0x86
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("ActionWnd.ActionBasicItem", Index, Skill))
    {
        Info = Skill;
    }
    return;
}

function saveINI()
{
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    SetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_1", SkillBox_Spam_Spam_Item_1.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_2", SkillBox_Spam_Spam_Item_2.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_3", SkillBox_Spam_Spam_Item_3.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_4", SkillBox_Spam_Spam_Item_4.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Spam_Spam_Item_5", SkillBox_Spam_Spam_Item_5.ClassID, "Option");
    return;
}
