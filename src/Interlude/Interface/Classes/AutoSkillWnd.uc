class AutoSkillWnd extends UICommonAPI;

const TIMERID_AutoBuffs = 9999;

var string BuffsParams;
var bool useBuff_1;
var bool useBuff_2;
var bool useBuff_3;
var bool useBuff_4;
var bool useBuff_5;
var bool useBuff_6;
var bool useBuff_7;
var bool useBuff_8;
var WindowHandle m_hOptWnd;
var WindowHandle AutoSkillWnd;
var ItemWindowHandle SkillBox_1;
var ItemWindowHandle SkillBox_2;
var ItemWindowHandle SkillBox_3;
var ItemWindowHandle SkillBox_4;
var ItemWindowHandle SkillBox_5;
var ItemWindowHandle SkillBox_6;
var ItemWindowHandle SkillBox_7;
var ItemWindowHandle SkillBox_8;
var ItemInfo SkillBox_Item_1;
var ItemInfo SkillBox_Item_2;
var ItemInfo SkillBox_Item_3;
var ItemInfo SkillBox_Item_4;
var ItemInfo SkillBox_Item_5;
var ItemInfo SkillBox_Item_6;
var ItemInfo SkillBox_Item_7;
var ItemInfo SkillBox_Item_8;
var TextureHandle Toggle_Skill_1;
var TextureHandle Toggle_Skill_2;
var TextureHandle Toggle_Skill_3;
var TextureHandle Toggle_Skill_4;
var TextureHandle Toggle_Skill_5;
var TextureHandle Toggle_Skill_6;
var TextureHandle Toggle_Skill_7;
var TextureHandle Toggle_Skill_8;

function OnLoad()
{
    RegisterEvent(150);
    RegisterEvent(160);
    RegisterEvent(950);
    useBuff_1 = false;
    useBuff_2 = false;
    useBuff_3 = false;
    useBuff_4 = false;
    useBuff_5 = false;
    useBuff_6 = false;
    useBuff_7 = false;
    useBuff_8 = false;
    AutoSkillWnd = GetHandle("AutoSkillWnd");
    SkillBox_1 = ItemWindowHandle(GetHandle("AutoSkillWnd.SkillBox_1"));
    SkillBox_2 = ItemWindowHandle(GetHandle("AutoSkillWnd.SkillBox_2"));
    SkillBox_3 = ItemWindowHandle(GetHandle("AutoSkillWnd.SkillBox_3"));
    SkillBox_4 = ItemWindowHandle(GetHandle("AutoSkillWnd.SkillBox_4"));
    SkillBox_5 = ItemWindowHandle(GetHandle("AutoSkillWnd.SkillBox_5"));
    SkillBox_6 = ItemWindowHandle(GetHandle("AutoSkillWnd.SkillBox_6"));
    SkillBox_7 = ItemWindowHandle(GetHandle("AutoSkillWnd.SkillBox_7"));
    SkillBox_8 = ItemWindowHandle(GetHandle("AutoSkillWnd.SkillBox_8"));
    Toggle_Skill_1 = TextureHandle(GetHandle("AutoSkillWnd.Toggle_Skill_1"));
    Toggle_Skill_2 = TextureHandle(GetHandle("AutoSkillWnd.Toggle_Skill_2"));
    Toggle_Skill_3 = TextureHandle(GetHandle("AutoSkillWnd.Toggle_Skill_3"));
    Toggle_Skill_4 = TextureHandle(GetHandle("AutoSkillWnd.Toggle_Skill_4"));
    Toggle_Skill_5 = TextureHandle(GetHandle("AutoSkillWnd.Toggle_Skill_5"));
    Toggle_Skill_6 = TextureHandle(GetHandle("AutoSkillWnd.Toggle_Skill_6"));
    Toggle_Skill_7 = TextureHandle(GetHandle("AutoSkillWnd.Toggle_Skill_7"));
    Toggle_Skill_8 = TextureHandle(GetHandle("AutoSkillWnd.Toggle_Skill_8"));
    Toggle_Skill_1.HideWindow();
    Toggle_Skill_2.HideWindow();
    Toggle_Skill_3.HideWindow();
    Toggle_Skill_4.HideWindow();
    Toggle_Skill_5.HideWindow();
    Toggle_Skill_6.HideWindow();
    Toggle_Skill_7.HideWindow();
    Toggle_Skill_8.HideWindow();
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
    // End:0x3E
    if(a_EventID == 950)
    {
        BuffsParams = a_Param;
    }
    return;
}

function OnDefaultPosition()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillWnd", "Menu", "TopRight", "TopRight", -230, -25);
    return;
}

function HandleGamingStateEnter()
{
    Reset();
    AutoSkillWnd.SetTimer(10210, 2000);
    AutoSkillWnd.SetTimer(9999, 300);
    return;
}

function Reset()
{
    AutoSkillWnd.KillTimer(10210);
    AutoSkillWnd.KillTimer(9999);
    useBuff_1 = false;
    useBuff_2 = false;
    useBuff_3 = false;
    useBuff_4 = false;
    useBuff_5 = false;
    useBuff_6 = false;
    useBuff_7 = false;
    useBuff_8 = false;
    SkillBox_1.Clear();
    SkillBox_2.Clear();
    SkillBox_3.Clear();
    SkillBox_4.Clear();
    SkillBox_5.Clear();
    SkillBox_6.Clear();
    SkillBox_7.Clear();
    SkillBox_8.Clear();
    SkillBox_Item_1.ClassID = 0;
    SkillBox_Item_2.ClassID = 0;
    SkillBox_Item_3.ClassID = 0;
    SkillBox_Item_4.ClassID = 0;
    SkillBox_Item_5.ClassID = 0;
    SkillBox_Item_6.ClassID = 0;
    SkillBox_Item_7.ClassID = 0;
    SkillBox_Item_8.ClassID = 0;
    Toggle_Skill_1.HideWindow();
    Toggle_Skill_2.HideWindow();
    Toggle_Skill_3.HideWindow();
    Toggle_Skill_4.HideWindow();
    Toggle_Skill_5.HideWindow();
    Toggle_Skill_6.HideWindow();
    Toggle_Skill_7.HideWindow();
    Toggle_Skill_8.HideWindow();
    return;
}

function InsertSkillsOnStart()
{
    local int outValue;
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    GetINIInt(UserInfo.Name, "SkillBox_Item_1", outValue, "Option");
    GetItemInfo(outValue, SkillBox_Item_1);
    // End:0x6D
    if(SkillBox_Item_1.ClassID > 0)
    {
        SkillBox_1.AddItem(SkillBox_Item_1);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Item_2", outValue, "Option");
    GetItemInfo(outValue, SkillBox_Item_2);
    // End:0xCF
    if(SkillBox_Item_2.ClassID > 0)
    {
        SkillBox_2.AddItem(SkillBox_Item_2);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Item_3", outValue, "Option");
    GetItemInfo(outValue, SkillBox_Item_3);
    // End:0x131
    if(SkillBox_Item_3.ClassID > 0)
    {
        SkillBox_3.AddItem(SkillBox_Item_3);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Item_4", outValue, "Option");
    GetItemInfo(outValue, SkillBox_Item_4);
    // End:0x193
    if(SkillBox_Item_4.ClassID > 0)
    {
        SkillBox_4.AddItem(SkillBox_Item_4);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Item_5", outValue, "Option");
    GetItemInfo(outValue, SkillBox_Item_5);
    // End:0x1F5
    if(SkillBox_Item_5.ClassID > 0)
    {
        SkillBox_5.AddItem(SkillBox_Item_5);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Item_6", outValue, "Option");
    GetItemInfo(outValue, SkillBox_Item_6);
    // End:0x257
    if(SkillBox_Item_6.ClassID > 0)
    {
        SkillBox_6.AddItem(SkillBox_Item_6);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Item_7", outValue, "Option");
    GetItemInfo(outValue, SkillBox_Item_7);
    // End:0x2B9
    if(SkillBox_Item_7.ClassID > 0)
    {
        SkillBox_7.AddItem(SkillBox_Item_7);
    }
    GetINIInt(UserInfo.Name, "SkillBox_Item_8", outValue, "Option");
    GetItemInfo(outValue, SkillBox_Item_8);
    // End:0x31B
    if(SkillBox_Item_8.ClassID > 0)
    {
        SkillBox_8.AddItem(SkillBox_Item_8);
    }
    return;
}

function OnTimer(int a_TimerID)
{
    // End:0x15
    if(a_TimerID == 9999)
    {
        CheckBuffs();
    }
    // End:0x3E
    if(a_TimerID == 10210)
    {
        AutoSkillWnd.KillTimer(10210);
        InsertSkillsOnStart();
    }
    return;
}

function CheckBuffs()
{
    local int i, Max;
    local StatusIconInfo Info;
    local UserInfo UserInfo;
    local bool have_1, have_2, have_3, have_4, have_5, have_6,
	    have_7, have_8;

    // End:0x5A3
    if(((((((useBuff_1 || useBuff_2) || useBuff_3) || useBuff_4) || useBuff_5) || useBuff_6) || useBuff_7) || useBuff_8)
    {
        have_1 = false;
        have_2 = false;
        have_3 = false;
        have_4 = false;
        have_5 = false;
        have_6 = false;
        have_7 = false;
        have_8 = false;
        ParseInt(BuffsParams, "Max", Max);
        i = 0;
        J0xB2:

        // End:0x2E3 [Loop If]
        if(i < Max)
        {
            ParseInt(BuffsParams, "SkillID_" $ string(i), Info.ClassID);
            // End:0x127
            if(((Info.ClassID == SkillBox_Item_1.ClassID) && SkillBox_Item_1.ClassID > 0) && useBuff_1)
            {
                have_1 = true;
            }
            // End:0x165
            if(((Info.ClassID == SkillBox_Item_2.ClassID) && SkillBox_Item_2.ClassID > 0) && useBuff_2)
            {
                have_2 = true;
            }
            // End:0x1A3
            if(((Info.ClassID == SkillBox_Item_3.ClassID) && SkillBox_Item_3.ClassID > 0) && useBuff_3)
            {
                have_3 = true;
            }
            // End:0x1E1
            if(((Info.ClassID == SkillBox_Item_4.ClassID) && SkillBox_Item_4.ClassID > 0) && useBuff_4)
            {
                have_4 = true;
            }
            // End:0x21F
            if(((Info.ClassID == SkillBox_Item_5.ClassID) && SkillBox_Item_5.ClassID > 0) && useBuff_5)
            {
                have_5 = true;
            }
            // End:0x25D
            if(((Info.ClassID == SkillBox_Item_6.ClassID) && SkillBox_Item_6.ClassID > 0) && useBuff_6)
            {
                have_6 = true;
            }
            // End:0x29B
            if(((Info.ClassID == SkillBox_Item_7.ClassID) && SkillBox_Item_7.ClassID > 0) && useBuff_7)
            {
                have_7 = true;
            }
            // End:0x2D9
            if(((Info.ClassID == SkillBox_Item_8.ClassID) && SkillBox_Item_8.ClassID > 0) && useBuff_8)
            {
                have_8 = true;
            }
            i++;
            // [Loop Continue]
            goto J0xB2;
        }
        GetPlayerInfo(UserInfo);
        // End:0x5A3
        if(UserInfo.nCurHP > 0)
        {
            // End:0x353
            if(!have_1 && useBuff_1)
            {
                // End:0x33A
                if(IsTriggerSkill(SkillBox_Item_1.ClassID))
                {
                    UseSkill(SkillBox_Item_1.ClassID);                    
                }
                else
                {
                    RequestSelfTarget();
                    UseSkill(SkillBox_Item_1.ClassID);
                }                
            }
            else
            {
                // End:0x3A8
                if(!have_2 && useBuff_2)
                {
                    // End:0x38F
                    if(IsTriggerSkill(SkillBox_Item_2.ClassID))
                    {
                        UseSkill(SkillBox_Item_2.ClassID);                        
                    }
                    else
                    {
                        RequestSelfTarget();
                        UseSkill(SkillBox_Item_2.ClassID);
                    }                    
                }
                else
                {
                    // End:0x3FD
                    if(!have_3 && useBuff_3)
                    {
                        // End:0x3E4
                        if(IsTriggerSkill(SkillBox_Item_3.ClassID))
                        {
                            UseSkill(SkillBox_Item_3.ClassID);                            
                        }
                        else
                        {
                            RequestSelfTarget();
                            UseSkill(SkillBox_Item_3.ClassID);
                        }                        
                    }
                    else
                    {
                        // End:0x452
                        if(!have_4 && useBuff_4)
                        {
                            // End:0x439
                            if(IsTriggerSkill(SkillBox_Item_4.ClassID))
                            {
                                UseSkill(SkillBox_Item_4.ClassID);                                
                            }
                            else
                            {
                                RequestSelfTarget();
                                UseSkill(SkillBox_Item_4.ClassID);
                            }                            
                        }
                        else
                        {
                            // End:0x4A7
                            if(!have_5 && useBuff_5)
                            {
                                // End:0x48E
                                if(IsTriggerSkill(SkillBox_Item_5.ClassID))
                                {
                                    UseSkill(SkillBox_Item_5.ClassID);                                    
                                }
                                else
                                {
                                    RequestSelfTarget();
                                    UseSkill(SkillBox_Item_5.ClassID);
                                }                                
                            }
                            else
                            {
                                // End:0x4FC
                                if(!have_6 && useBuff_6)
                                {
                                    // End:0x4E3
                                    if(IsTriggerSkill(SkillBox_Item_6.ClassID))
                                    {
                                        UseSkill(SkillBox_Item_6.ClassID);                                        
                                    }
                                    else
                                    {
                                        RequestSelfTarget();
                                        UseSkill(SkillBox_Item_6.ClassID);
                                    }                                    
                                }
                                else
                                {
                                    // End:0x551
                                    if(!have_7 && useBuff_7)
                                    {
                                        // End:0x538
                                        if(IsTriggerSkill(SkillBox_Item_7.ClassID))
                                        {
                                            UseSkill(SkillBox_Item_7.ClassID);                                            
                                        }
                                        else
                                        {
                                            RequestSelfTarget();
                                            UseSkill(SkillBox_Item_7.ClassID);
                                        }                                        
                                    }
                                    else
                                    {
                                        // End:0x5A3
                                        if(!have_8 && useBuff_8)
                                        {
                                            // End:0x58D
                                            if(IsTriggerSkill(SkillBox_Item_8.ClassID))
                                            {
                                                UseSkill(SkillBox_Item_8.ClassID);                                                
                                            }
                                            else
                                            {
                                                RequestSelfTarget();
                                                UseSkill(SkillBox_Item_8.ClassID);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function OnDropItem(string a_WindowID, ItemInfo a_ItemInfo, int X, int Y)
{
    // End:0x47
    if(a_WindowID == "SkillBox_1")
    {
        SkillBox_1.Clear();
        SkillBox_Item_1 = a_ItemInfo;
        SkillBox_1.AddItem(a_ItemInfo);        
    }
    else
    {
        // End:0x8E
        if(a_WindowID == "SkillBox_2")
        {
            SkillBox_2.Clear();
            SkillBox_Item_2 = a_ItemInfo;
            SkillBox_2.AddItem(a_ItemInfo);            
        }
        else
        {
            // End:0xD5
            if(a_WindowID == "SkillBox_3")
            {
                SkillBox_3.Clear();
                SkillBox_Item_3 = a_ItemInfo;
                SkillBox_3.AddItem(a_ItemInfo);                
            }
            else
            {
                // End:0x11C
                if(a_WindowID == "SkillBox_4")
                {
                    SkillBox_4.Clear();
                    SkillBox_Item_4 = a_ItemInfo;
                    SkillBox_4.AddItem(a_ItemInfo);                    
                }
                else
                {
                    // End:0x163
                    if(a_WindowID == "SkillBox_5")
                    {
                        SkillBox_5.Clear();
                        SkillBox_Item_5 = a_ItemInfo;
                        SkillBox_5.AddItem(a_ItemInfo);                        
                    }
                    else
                    {
                        // End:0x1AA
                        if(a_WindowID == "SkillBox_6")
                        {
                            SkillBox_6.Clear();
                            SkillBox_Item_6 = a_ItemInfo;
                            SkillBox_6.AddItem(a_ItemInfo);                            
                        }
                        else
                        {
                            // End:0x1F1
                            if(a_WindowID == "SkillBox_7")
                            {
                                SkillBox_7.Clear();
                                SkillBox_Item_7 = a_ItemInfo;
                                SkillBox_7.AddItem(a_ItemInfo);                                
                            }
                            else
                            {
                                // End:0x235
                                if(a_WindowID == "SkillBox_8")
                                {
                                    SkillBox_8.Clear();
                                    SkillBox_Item_8 = a_ItemInfo;
                                    SkillBox_8.AddItem(a_ItemInfo);
                                }
                            }
                        }
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
    // End:0x4E
    if((strID == "SkillBox_1") && Index > -1)
    {
        // End:0x40
        if(!useBuff_1)
        {
            EnableSkill(SkillBox_1);            
        }
        else
        {
            DisableSkill(SkillBox_1);
        }        
    }
    else
    {
        // End:0x9C
        if((strID == "SkillBox_2") && Index > -1)
        {
            // End:0x8E
            if(!useBuff_2)
            {
                EnableSkill(SkillBox_2);                
            }
            else
            {
                DisableSkill(SkillBox_2);
            }            
        }
        else
        {
            // End:0xEA
            if((strID == "SkillBox_3") && Index > -1)
            {
                // End:0xDC
                if(!useBuff_3)
                {
                    EnableSkill(SkillBox_3);                    
                }
                else
                {
                    DisableSkill(SkillBox_3);
                }                
            }
            else
            {
                // End:0x138
                if((strID == "SkillBox_4") && Index > -1)
                {
                    // End:0x12A
                    if(!useBuff_4)
                    {
                        EnableSkill(SkillBox_4);                        
                    }
                    else
                    {
                        DisableSkill(SkillBox_4);
                    }                    
                }
                else
                {
                    // End:0x186
                    if((strID == "SkillBox_5") && Index > -1)
                    {
                        // End:0x178
                        if(!useBuff_5)
                        {
                            EnableSkill(SkillBox_5);                            
                        }
                        else
                        {
                            DisableSkill(SkillBox_5);
                        }                        
                    }
                    else
                    {
                        // End:0x1D4
                        if((strID == "SkillBox_6") && Index > -1)
                        {
                            // End:0x1C6
                            if(!useBuff_6)
                            {
                                EnableSkill(SkillBox_6);                                
                            }
                            else
                            {
                                DisableSkill(SkillBox_6);
                            }                            
                        }
                        else
                        {
                            // End:0x222
                            if((strID == "SkillBox_7") && Index > -1)
                            {
                                // End:0x214
                                if(!useBuff_7)
                                {
                                    EnableSkill(SkillBox_7);                                    
                                }
                                else
                                {
                                    DisableSkill(SkillBox_7);
                                }                                
                            }
                            else
                            {
                                // End:0x26D
                                if((strID == "SkillBox_8") && Index > -1)
                                {
                                    // End:0x262
                                    if(!useBuff_8)
                                    {
                                        EnableSkill(SkillBox_8);                                        
                                    }
                                    else
                                    {
                                        DisableSkill(SkillBox_8);
                                    }
                                }
                            }
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
        case SkillBox_1:
            Toggle_Skill_1.HideWindow();
            useBuff_1 = false;
            // End:0x11A
            break;
        // End:0x4B
        case SkillBox_2:
            Toggle_Skill_2.HideWindow();
            useBuff_2 = false;
            // End:0x11A
            break;
        // End:0x6D
        case SkillBox_3:
            Toggle_Skill_3.HideWindow();
            useBuff_3 = false;
            // End:0x11A
            break;
        // End:0x8F
        case SkillBox_4:
            Toggle_Skill_4.HideWindow();
            useBuff_4 = false;
            // End:0x11A
            break;
        // End:0xB1
        case SkillBox_5:
            Toggle_Skill_5.HideWindow();
            useBuff_5 = false;
            // End:0x11A
            break;
        // End:0xD3
        case SkillBox_6:
            Toggle_Skill_6.HideWindow();
            useBuff_6 = false;
            // End:0x11A
            break;
        // End:0xF5
        case SkillBox_7:
            Toggle_Skill_7.HideWindow();
            useBuff_7 = false;
            // End:0x11A
            break;
        // End:0x117
        case SkillBox_8:
            Toggle_Skill_8.HideWindow();
            useBuff_8 = false;
            // End:0x11A
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
        case SkillBox_1:
            Toggle_Skill_1.ShowWindow();
            useBuff_1 = true;
            // End:0x11A
            break;
        // End:0x4B
        case SkillBox_2:
            Toggle_Skill_2.ShowWindow();
            useBuff_2 = true;
            // End:0x11A
            break;
        // End:0x6D
        case SkillBox_3:
            Toggle_Skill_3.ShowWindow();
            useBuff_3 = true;
            // End:0x11A
            break;
        // End:0x8F
        case SkillBox_4:
            Toggle_Skill_4.ShowWindow();
            useBuff_4 = true;
            // End:0x11A
            break;
        // End:0xB1
        case SkillBox_5:
            Toggle_Skill_5.ShowWindow();
            useBuff_5 = true;
            // End:0x11A
            break;
        // End:0xD3
        case SkillBox_6:
            Toggle_Skill_6.ShowWindow();
            useBuff_6 = true;
            // End:0x11A
            break;
        // End:0xF5
        case SkillBox_7:
            Toggle_Skill_7.ShowWindow();
            useBuff_7 = true;
            // End:0x11A
            break;
        // End:0x117
        case SkillBox_8:
            Toggle_Skill_8.ShowWindow();
            useBuff_8 = true;
            // End:0x11A
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnRClickItem(string strID, int Index)
{
    // End:0x3F
    if(strID == "SkillBox_1")
    {
        DisableSkill(SkillBox_1);
        SkillBox_1.Clear();
        SkillBox_Item_1.ClassID = 0;        
    }
    else
    {
        // End:0x7E
        if(strID == "SkillBox_2")
        {
            DisableSkill(SkillBox_2);
            SkillBox_2.Clear();
            SkillBox_Item_2.ClassID = 0;            
        }
        else
        {
            // End:0xBD
            if(strID == "SkillBox_3")
            {
                DisableSkill(SkillBox_3);
                SkillBox_3.Clear();
                SkillBox_Item_3.ClassID = 0;                
            }
            else
            {
                // End:0xFC
                if(strID == "SkillBox_4")
                {
                    DisableSkill(SkillBox_4);
                    SkillBox_4.Clear();
                    SkillBox_Item_4.ClassID = 0;                    
                }
                else
                {
                    // End:0x13B
                    if(strID == "SkillBox_5")
                    {
                        DisableSkill(SkillBox_5);
                        SkillBox_5.Clear();
                        SkillBox_Item_5.ClassID = 0;                        
                    }
                    else
                    {
                        // End:0x17A
                        if(strID == "SkillBox_6")
                        {
                            DisableSkill(SkillBox_6);
                            SkillBox_6.Clear();
                            SkillBox_Item_6.ClassID = 0;                            
                        }
                        else
                        {
                            // End:0x1B9
                            if(strID == "SkillBox_7")
                            {
                                DisableSkill(SkillBox_7);
                                SkillBox_7.Clear();
                                SkillBox_Item_7.ClassID = 0;                                
                            }
                            else
                            {
                                // End:0x1F5
                                if(strID == "SkillBox_8")
                                {
                                    DisableSkill(SkillBox_8);
                                    SkillBox_8.Clear();
                                    SkillBox_Item_8.ClassID = 0;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    saveINI();
    return;
}

function GetItemInfo(int Id, out ItemInfo Info)
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

function saveINI()
{
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    SetINIInt(UserInfo.Name, "SkillBox_Item_1", SkillBox_Item_1.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Item_2", SkillBox_Item_2.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Item_3", SkillBox_Item_3.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Item_4", SkillBox_Item_4.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Item_5", SkillBox_Item_5.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Item_6", SkillBox_Item_6.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Item_7", SkillBox_Item_7.ClassID, "Option");
    SetINIInt(UserInfo.Name, "SkillBox_Item_8", SkillBox_Item_8.ClassID, "Option");
    return;
}

function bool IsTriggerSkill(int SkillID)
{
    switch(SkillID)
    {
        // End:0x11
        case 60:
            return true;
            // End:0x593
            break;
        // End:0x1B
        case 99:
            return true;
            // End:0x593
            break;
        // End:0x25
        case 196:
            return true;
            // End:0x593
            break;
        // End:0x2F
        case 197:
            return true;
            // End:0x593
            break;
        // End:0x39
        case 221:
            return true;
            // End:0x593
            break;
        // End:0x43
        case 222:
            return true;
            // End:0x593
            break;
        // End:0x4D
        case 226:
            return true;
            // End:0x593
            break;
        // End:0x5A
        case 256:
            return true;
            // End:0x593
            break;
        // End:0x67
        case 288:
            return true;
            // End:0x593
            break;
        // End:0x74
        case 296:
            return true;
            // End:0x593
            break;
        // End:0x81
        case 312:
            return true;
            // End:0x593
            break;
        // End:0x8E
        case 318:
            return true;
            // End:0x593
            break;
        // End:0x9B
        case 322:
            return true;
            // End:0x593
            break;
        // End:0xA8
        case 334:
            return true;
            // End:0x593
            break;
        // End:0xB5
        case 335:
            return true;
            // End:0x593
            break;
        // End:0xC2
        case 336:
            return true;
            // End:0x593
            break;
        // End:0xCF
        case 337:
            return true;
            // End:0x593
            break;
        // End:0xDC
        case 338:
            return true;
            // End:0x593
            break;
        // End:0xE9
        case 339:
            return true;
            // End:0x593
            break;
        // End:0xF6
        case 340:
            return true;
            // End:0x593
            break;
        // End:0x103
        case 414:
            return true;
            // End:0x593
            break;
        // End:0x110
        case 422:
            return true;
            // End:0x593
            break;
        // End:0x11D
        case 424:
            return true;
            // End:0x593
            break;
        // End:0x12A
        case 1001:
            return true;
            // End:0x593
            break;
        // End:0x137
        case 1262:
            return true;
            // End:0x593
            break;
        // End:0x144
        case 1283:
            return true;
            // End:0x593
            break;
        // End:0x151
        case 4517:
            return true;
            // End:0x593
            break;
        // End:0x15E
        case 4518:
            return true;
            // End:0x593
            break;
        // End:0x16B
        case 4519:
            return true;
            // End:0x593
            break;
        // End:0x178
        case 4520:
            return true;
            // End:0x593
            break;
        // End:0x185
        case 4525:
            return true;
            // End:0x593
            break;
        // End:0x192
        case 4532:
            return true;
            // End:0x593
            break;
        // End:0x19F
        case 4545:
            return true;
            // End:0x593
            break;
        // End:0x1AC
        case 5087:
            return true;
            // End:0x593
            break;
        // End:0x1B9
        case 344:
            return true;
            // End:0x593
            break;
        // End:0x1C6
        case 263:
            return true;
            // End:0x593
            break;
        // End:0x1D3
        case 409:
            return true;
            // End:0x593
            break;
        // End:0x1DD
        case 30:
            return true;
            // End:0x593
            break;
        // End:0x1E7
        case 16:
            return true;
            // End:0x593
            break;
        // End:0x1F4
        case 321:
            return true;
            // End:0x593
            break;
        // End:0x201
        case 1235:
            return true;
            // End:0x593
            break;
        // End:0x20E
        case 1265:
            return true;
            // End:0x593
            break;
        // End:0x21B
        case 1341:
            return true;
            // End:0x593
            break;
        // End:0x228
        case 1342:
            return true;
            // End:0x593
            break;
        // End:0x235
        case 1417:
            return true;
            // End:0x593
            break;
        // End:0x242
        case 1231:
            return true;
            // End:0x593
            break;
        // End:0x24F
        case 1267:
            return true;
            // End:0x593
            break;
        // End:0x25C
        case 1239:
            return true;
            // End:0x593
            break;
        // End:0x269
        case 1340:
            return true;
            // End:0x593
            break;
        // End:0x276
        case 1339:
            return true;
            // End:0x593
            break;
        // End:0x280
        case 101:
            return true;
            // End:0x593
            break;
        // End:0x28A
        case 111:
            return true;
            // End:0x593
            break;
        // End:0x294
        case 110:
            return true;
            // End:0x593
            break;
        // End:0x2A1
        case 445:
            return true;
            // End:0x593
            break;
        // End:0x2AE
        case 357:
            return true;
            // End:0x593
            break;
        // End:0x2BB
        case 356:
            return true;
            // End:0x593
            break;
        // End:0x2C8
        case 410:
            return true;
            // End:0x593
            break;
        // End:0x2D5
        case 1230:
            return true;
            // End:0x593
            break;
        // End:0x2E2
        case 1169:
            return true;
            // End:0x593
            break;
        // End:0x2EF
        case 1263:
            return true;
            // End:0x593
            break;
        // End:0x2FC
        case 1218:
            return true;
            // End:0x593
            break;
        // End:0x309
        case 1148:
            return true;
            // End:0x593
            break;
        // End:0x316
        case 1343:
            return true;
            // End:0x593
            break;
        // End:0x323
        case 1234:
            return true;
            // End:0x593
            break;
        // End:0x330
        case 1159:
            return true;
            // End:0x593
            break;
        // End:0x33D
        case 358:
            return true;
            // End:0x593
            break;
        // End:0x34A
        case 355:
            return true;
            // End:0x593
            break;
        // End:0x354
        case 11:
            return true;
            // End:0x593
            break;
        // End:0x35E
        case 12:
            return true;
            // End:0x593
            break;
        // End:0x36B
        case 1409:
            return true;
            // End:0x593
            break;
        // End:0x378
        case 1335:
            return true;
            // End:0x593
            break;
        // End:0x385
        case 1311:
            return true;
            // End:0x593
            break;
        // End:0x392
        case 1401:
            return true;
            // End:0x593
            break;
        // End:0x39C
        case 78:
            return true;
            // End:0x593
            break;
        // End:0x3A9
        case 297:
            return true;
            // End:0x593
            break;
        // End:0x3B3
        case 94:
            return true;
            // End:0x593
            break;
        // End:0x3BD
        case 176:
            return true;
            // End:0x593
            break;
        // End:0x3CA
        case 420:
            return true;
            // End:0x593
            break;
        // End:0x3D4
        case 139:
            return true;
            // End:0x593
            break;
        // End:0x3E1
        case 440:
            return true;
            // End:0x593
            break;
        // End:0x3EB
        case 121:
            return true;
            // End:0x593
            break;
        // End:0x3F8
        case 413:
            return true;
            // End:0x593
            break;
        // End:0x405
        case 424:
            return true;
            // End:0x593
            break;
        // End:0x412
        case 340:
            return true;
            // End:0x593
            break;
        // End:0x41F
        case 339:
            return true;
            // End:0x593
            break;
        // End:0x42C
        case 287:
            return true;
            // End:0x593
            break;
        // End:0x436
        case 19:
            return true;
            // End:0x593
            break;
        // End:0x443
        case 313:
            return true;
            // End:0x593
            break;
        // End:0x44D
        case 131:
            return true;
            // End:0x593
            break;
        // End:0x45A
        case 1324:
            return true;
            // End:0x593
            break;
        // End:0x467
        case 1085:
            return true;
            // End:0x593
            break;
        // End:0x474
        case 1059:
            return true;
            // End:0x593
            break;
        // End:0x481
        case 1004:
            return true;
            // End:0x593
            break;
        // End:0x48E
        case 1365:
            return true;
            // End:0x593
            break;
        // End:0x49B
        case 1086:
            return true;
            // End:0x593
            break;
        // End:0x4A8
        case 1204:
            return true;
            // End:0x593
            break;
        // End:0x4B5
        case 1282:
            return true;
            // End:0x593
            break;
        // End:0x4C2
        case 341:
            return true;
            // End:0x593
            break;
        // End:0x4CF
        case 406:
            return true;
            // End:0x593
            break;
        // End:0x4D9
        case 112:
            return true;
            // End:0x593
            break;
        // End:0x4E3
        case 82:
            return true;
            // End:0x593
            break;
        // End:0x4ED
        case 86:
            return true;
            // End:0x593
            break;
        // End:0x4F7
        case 196:
            return true;
            // End:0x593
            break;
        // End:0x501
        case 197:
            return true;
            // End:0x593
            break;
        // End:0x50E
        case 318:
            return true;
            // End:0x593
            break;
        // End:0x518
        case 18:
            return true;
            // End:0x593
            break;
        // End:0x522
        case 28:
            return true;
            // End:0x593
            break;
        // End:0x52F
        case 322:
            return true;
            // End:0x593
            break;
        // End:0x53C
        case 288:
            return true;
            // End:0x593
            break;
        // End:0x546
        case 92:
            return true;
            // End:0x593
            break;
        // End:0x553
        case 352:
            return true;
            // End:0x593
            break;
        // End:0x55D
        case 121:
            return true;
            // End:0x593
            break;
        // End:0x56A
        case 286:
            return true;
            // End:0x593
            break;
        // End:0x574
        case 181:
            return true;
            // End:0x593
            break;
        // End:0x581
        case 337:
            return true;
            // End:0x593
            break;
        // End:0x58B
        case 4:
            return true;
            // End:0x593
            break;
        // End:0xFFFF
        default:
            return false;
            break;
    }    
    return false;
}
