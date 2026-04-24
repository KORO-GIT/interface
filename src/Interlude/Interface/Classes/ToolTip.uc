class ToolTip extends UICommonAPI;

const TOOLTIP_MINIMUM_WIDTH = 144;
const TOOLTIP_SETITEM_MAX = 3;

var CustomTooltip m_Tooltip;
var DrawItemInfo m_Info;
var bool m_bAdminItemIDMode;

function OnLoad()
{
    RegisterEvent(2920);
    RegisterEvent(2280);
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x1D
        case 2920:
            HandleRequestTooltipInfo(param);
            // End:0x20
            break;
        case 2280:
            m_bAdminItemIDMode = true;
            // End:0x20
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleRequestTooltipInfo(string param)
{
    local string TooltipType;
    local int SourceType;
    local UIEventManager.ETooltipSourceType eSourceType;

    ClearTooltip();
    // End:0x2A
    if(!ParseString(param, "TooltipType", TooltipType))
    {
        return;
    }
    // End:0x4D
    if(!ParseInt(param, "SourceType", SourceType))
    {
        return;
    }
    eSourceType = ETooltipSourceType(SourceType);
    if(TooltipType == "Text")
    {
        ReturnTooltip_NTT_TEXT(param, eSourceType, false);
    }
    else if(TooltipType == "Description")
    {
        ReturnTooltip_NTT_TEXT(param, eSourceType, true);
    }
    else if(TooltipType == "Action")
    {
        ReturnTooltip_NTT_ACTION(param, eSourceType);
    }
    else if(TooltipType == "Skill")
    {
        ReturnTooltip_NTT_SKILL(param, eSourceType);
    }
    else if(TooltipType == "NormalItem")
    {
        ReturnTooltip_NTT_NORMALITEM(param, eSourceType);
    }
    else if(TooltipType == "Shortcut")
    {
        ReturnTooltip_NTT_SHORTCUT(param, eSourceType);
    }
    else if(TooltipType == "AbnormalStatus")
    {
        ReturnTooltip_NTT_ABNORMALSTATUS(param, eSourceType);
    }
    else if(TooltipType == "RecipeManufacture")
    {
        ReturnTooltip_NTT_RECIPE_MANUFACTURE(param, eSourceType);
    }
    else if(TooltipType == "Recipe")
    {
        ReturnTooltip_NTT_RECIPE(param, eSourceType, false);
    }
    else if(TooltipType == "RecipePrice")
    {
        ReturnTooltip_NTT_RECIPE(param, eSourceType, true);
    }
    else if((((((TooltipType == "Inventory") || TooltipType == "InventoryPrice1") || TooltipType == "InventoryPrice2") || TooltipType == "InventoryPrice1HideEnchant") || TooltipType == "InventoryPrice1HideEnchantStackable") || TooltipType == "InventoryPrice2PrivateShop")
    {
        ReturnTooltip_NTT_ITEM(param, TooltipType, eSourceType);
    }
    else if(TooltipType == "PartyMatch")
    {
        ReturnTooltip_NTT_PARTYMATCH(param, eSourceType);
    }
    else if(TooltipType == "QuestInfo")
    {
        ReturnTooltip_NTT_QUESTINFO(param, eSourceType);
    }
    else if(TooltipType == "QuestList")
    {
        ReturnTooltip_NTT_QUESTLIST(param, eSourceType);
    }
    else if(TooltipType == "RaidList")
    {
        ReturnTooltip_NTT_RAIDLIST(param, eSourceType);
    }
    else if(TooltipType == "ClanInfo")
    {
        ReturnTooltip_NTT_CLANINFO(param, eSourceType);
    }
    else if((((((TooltipType == "ManorSeedInfo") || TooltipType == "ManorCropInfo") || TooltipType == "ManorSeedSetting") || TooltipType == "ManorCropSetting") || TooltipType == "ManorDefaultInfo") || TooltipType == "ManorCropSell")
    {
        ReturnTooltip_NTT_MANOR(param, TooltipType, eSourceType);
    }
    return;
}

function bool IsEnchantableItem(UIEventManager.EItemParamType Type)
{
    return (((Type == ITEMP_WEAPON) || Type == ITEMP_ARMOR) || Type == ITEMP_ACCESSARY) || Type == ITEMP_SHIELD;
}

function ClearTooltip()
{
    m_Tooltip.SimpleLineCount = 0;
    m_Tooltip.MinimumWidth = 0;
    m_Tooltip.DrawList.Remove(0, m_Tooltip.DrawList.Length);
    return;
}

function StartItem()
{
    local DrawItemInfo infoClear;

    m_Info = infoClear;
    return;
}

function EndItem()
{
    m_Tooltip.DrawList.Length = m_Tooltip.DrawList.Length + 1;
    m_Tooltip.DrawList[m_Tooltip.DrawList.Length - 1] = m_Info;
    return;
}

function ReturnTooltip_NTT_TEXT(string param, UIEventManager.ETooltipSourceType eSourceType, bool bDesc)
{
    local string strText;
    local int Id;

    // End:0x156
    if(int(eSourceType) == 0)
    {
        // End:0xFB
        if(ParseString(param, "Text", strText))
        {
            // End:0xF8
            if(Len(strText) > 0)
            {
                // End:0xC2
                if(bDesc)
                {
                    m_Tooltip.MinimumWidth = 144;
                    StartItem();
                    m_Info.eType = DIT_TEXT;
                    m_Info.t_color.R = 178;
                    m_Info.t_color.G = 190;
                    m_Info.t_color.B = 207;
                    m_Info.t_color.A = byte(255);
                    m_Info.t_strText = strText;
                    EndItem();                    
                }
                else
                {
                    StartItem();
                    m_Info.eType = DIT_TEXT;
                    m_Info.t_bDrawOneLine = true;
                    m_Info.t_strText = strText;
                    EndItem();
                }
            }            
        }
        else
        {
            // End:0x153
            if(ParseInt(param, "ID", Id))
            {
                // End:0x153
                if(Id > 0)
                {
                    StartItem();
                    m_Info.eType = DIT_TEXT;
                    m_Info.t_bDrawOneLine = true;
                    m_Info.t_ID = Id;
                    EndItem();
                }
            }
        }        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_ITEM(string param, string TooltipType, UIEventManager.ETooltipSourceType eSourceType)
{
    local ItemInfo item;
    local byte EItemType;
    local UIEventManager.EEtcItemType EEtcItemType;
    local bool bLargeWidth;
    local string SlotString, strTmp;
    local int nTmp, idx;
    local string ItemName;
    local int Quality, ColorR, ColorG, ColorB;
    local string strDesc1, strDesc2, strDesc3;
    local array<int> arrID;
    local int SetID, ClassID;
    local string strAdena, strAdenaComma;
    local Color AdenaColor;
    local bool bAddedSetHeader;

    // End:0x16BB
    if(int(eSourceType) == 1)
    {
        ParamToItemInfo(param, item);
        EItemType = byte(item.ItemType);
        EEtcItemType = EEtcItemType(item.ItemSubType);
        ItemName = Class'NWindow.UIDATA_ITEM'.static.GetRefineryItemName(item.Name, item.RefineryOp1, item.RefineryOp2);
        AddTooltipItemIcon(item);
        // End:0xD9
        if((TooltipType != "InventoryPrice1HideEnchant") && TooltipType != "InventoryPrice1HideEnchantStackable")
        {
            AddTooltipItemEnchant(item);
        }
        AddTooltipItemName(ItemName, item);
        AddTooltipItemGrade(item);
        // End:0x12E
        if(TooltipType != "InventoryPrice1HideEnchantStackable")
        {
            AddTooltipItemCount(item);
        }
        // End:0x1B3
        if(item.ClassID == 57)
        {
            m_Tooltip.SimpleLineCount = 2;
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.bLineBreak = true;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_strText = ("(" $ ConvertNumToText(string(item.ItemNum))) $ ")";
            EndItem();
        }
        // End:0x365
        if(((TooltipType == "InventoryPrice1") || TooltipType == "InventoryPrice1HideEnchant") || TooltipType == "InventoryPrice1HideEnchantStackable")
        {
            strAdena = string(item.Price);
            strAdenaComma = MakeCostString(strAdena);
            AdenaColor = GetNumericColor(strAdenaComma);
            AddTooltipItemOption(322, strAdenaComma $ " ", true, true, false);
            SetTooltipItemColor(int(AdenaColor.R), int(AdenaColor.G), int(AdenaColor.B), 0);
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color = AdenaColor;
            m_Info.t_ID = 469;
            EndItem();
            m_Tooltip.SimpleLineCount = 2;
            // End:0x365
            if(item.Price > 0)
            {
                m_Tooltip.SimpleLineCount = 3;
                AddTooltipItemOption(0, ("(" $ ConvertNumToText(strAdena)) $ ")", false, true, false);
                SetTooltipItemColor(int(AdenaColor.R), int(AdenaColor.G), int(AdenaColor.B), 0);
            }
        }
        // End:0x608
        if((TooltipType == "InventoryPrice2") || TooltipType == "InventoryPrice2PrivateShop")
        {
            strAdena = string(item.Price);
            strAdenaComma = MakeCostString(strAdena);
            AdenaColor = GetNumericColor(strAdenaComma);
            AddTooltipItemOption2(322, 468, true, true, false);
            SetTooltipItemColor(int(AdenaColor.R), int(AdenaColor.G), int(AdenaColor.B), 0);
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color = AdenaColor;
            m_Info.t_strText = (" " $ strAdenaComma) $ " ";
            EndItem();
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color = AdenaColor;
            m_Info.t_ID = 469;
            EndItem();
            m_Tooltip.SimpleLineCount = 2;
            // End:0x608
            if(item.Price > 0)
            {
                m_Tooltip.SimpleLineCount = 3;
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.nOffSetY = 6;
                m_Info.bLineBreak = true;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_color = AdenaColor;
                m_Info.t_strText = "(";
                EndItem();
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.nOffSetY = 6;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_color = AdenaColor;
                m_Info.t_ID = 468;
                EndItem();
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.nOffSetY = 6;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_color = AdenaColor;
                m_Info.t_strText = (" " $ ConvertNumToText(strAdena)) $ ")";
                EndItem();
            }
        }
        // End:0x66D
        if(TooltipType == "InventoryPrice2PrivateShop")
        {
            // End:0x66D
            if(IsStackableItem(item.ConsumeType) && item.Reserved > 0)
            {
                AddTooltipItemOption(808, string(item.Reserved), true, true, false);
            }
        }
        SlotString = GetSlotTypeString(item.ItemType, item.SlotBitType, item.ArmorType);
        switch(EItemType)
        {
            // End:0xAFB
            case 0:
                bLargeWidth = true;
                strTmp = GetWeaponTypeString(item.WeaponType);
                // End:0x6EB
                if(Len(strTmp) > 0)
                {
                    AddTooltipItemOptionETC(0, (strTmp $ " / ") $ SlotString, false, true, false, true);
                }
                AddTooltipItemBar(4);
                AddTooltipAugmentSummary(item);
                AddTooltipItemStatWithEnchant(94, GetPhysicalDamage(item.WeaponType, item.SlotBitType, item.CrystalType, item.Enchanted, item.PhysicalDamage), item.PhysicalDamage, item.Enchanted, false);
                AddTooltipItemStatWithEnchant(98, GetMagicalDamage(item.WeaponType, item.SlotBitType, item.CrystalType, item.Enchanted, item.MagicalDamage), item.MagicalDamage, item.Enchanted, false);
                AddTooltipItemBlank(2);
                AddTooltipItemBar(4);
                AddTooltipItemOption(111, GetAttackSpeedString(item.AttackSpeed), true, true, false);
                // End:0x7E5
                if(item.SoulshotCount > 0)
                {
                    AddTooltipItemOption(404, "X " $ string(item.SoulshotCount), true, true, false);
                }
                // End:0x815
                if(item.SpiritshotCount > 0)
                {
                    AddTooltipItemOption(496, "X " $ string(item.SpiritshotCount), true, true, false);
                }
                AddTooltipItemOption(52, string(item.Weight), true, true, false);
                // End:0x856
                if(item.MpConsume != 0)
                {
                    AddTooltipItemOption(320, string(item.MpConsume), true, true, false);
                }
                // End:0xAF8
                if((item.RefineryOp1 != 0) || item.RefineryOp2 != 0)
                {
                    AddTooltipItemBlank(10);
                    AddTooltipItemBG("LifeBG", "Augment", "");
                    // End:0x8E6
                    if(item.RefineryOp2 != 0)
                    {
                        Quality = Class'NWindow.UIDATA_REFINERYOPTION'.static.GetQuality(item.RefineryOp2);
                        GetRefineryColor(Quality, ColorR, ColorG, ColorB);
                    }
                    // End:0x9CF
                    if(item.RefineryOp1 != 0)
                    {
                        strDesc1 = "";
                        strDesc2 = "";
                        strDesc3 = "";
                        // End:0x9CF
                        if(Class'NWindow.UIDATA_REFINERYOPTION'.static.GetOptionDescription(item.RefineryOp1, strDesc1, strDesc2, strDesc3))
                        {
                            // End:0x96B
                            if(Len(strDesc1) > 0)
                            {
                                AddTooltipItemOption(0, strDesc1, false, true, false);
                                SetTooltipItemColor(ColorR, ColorG, ColorB, 0);
                            }
                            // End:0x99D
                            if(Len(strDesc2) > 0)
                            {
                                AddTooltipItemOption(0, strDesc2, false, true, false);
                                SetTooltipItemColor(ColorR, ColorG, ColorB, 0);
                            }
                            // End:0x9CF
                            if(Len(strDesc3) > 0)
                            {
                                AddTooltipItemOption(0, strDesc3, false, true, false);
                                SetTooltipItemColor(ColorR, ColorG, ColorB, 0);
                            }
                        }
                    }
                    // End:0xAB8
                    if(item.RefineryOp2 != 0)
                    {
                        strDesc1 = "";
                        strDesc2 = "";
                        strDesc3 = "";
                        // End:0xAB8
                        if(Class'NWindow.UIDATA_REFINERYOPTION'.static.GetOptionDescription(item.RefineryOp2, strDesc1, strDesc2, strDesc3))
                        {
                            // End:0xA54
                            if(Len(strDesc1) > 0)
                            {
                                AddTooltipItemOption(0, strDesc1, false, true, false);
                                SetTooltipItemColor(ColorR, ColorG, ColorB, 0);
                            }
                            // End:0xA86
                            if(Len(strDesc2) > 0)
                            {
                                AddTooltipItemOption(0, strDesc2, false, true, false);
                                SetTooltipItemColor(ColorR, ColorG, ColorB, 0);
                            }
                            // End:0xAB8
                            if(Len(strDesc3) > 0)
                            {
                                AddTooltipItemOption(0, strDesc3, false, true, false);
                                SetTooltipItemColor(ColorR, ColorG, ColorB, 0);
                            }
                        }
                    }
                    AddTooltipItemOption(1491, "", true, false, false);
                    SetTooltipItemColor(ColorR, ColorG, ColorB, 0);
                    // End:0xAF8
                    if(Len(item.Description) > 0)
                    {
                        AddTooltipItemBlank(10);
                    }
                }
                if(Len(item.Description) > 0)
                {
                    bLargeWidth = true;
                    if(Left(item.Description, 5) == "<Soul")
                    {
                        AddTooltipItemBG("SaBG", "Special Ability: ", item.AdditionalName);
                        AddTooltipPlainText(Mid(item.Description, 29), 110, 140, 160, 0, true, false);
                    }
                    else
                    {
                        AddTooltipItemBG("", "Description ", item.AdditionalName);
                        AddTooltipPlainText(item.Description, 110, 140, 160, 0, true, false);
                    }
                }
                // End:0xEBE
                break;
            // End:0xCA6
            case 1:
                bLargeWidth = true;
                // End:0xBAB
                if((item.SlotBitType == 256) || item.SlotBitType == 128)
                {
                    if(Len(SlotString) > 0)
                    {
                        AddTooltipItemOptionETC(0, SlotString, false, true, false, true);
                    }
                    AddTooltipItemBar(4);
                    AddTooltipItemStatWithEnchant(95, GetShieldDefense(item.CrystalType, item.Enchanted, item.ShieldDefense), item.ShieldDefense, item.Enchanted, false);
                    AddTooltipItemBar(4);
                    AddTooltipItemOption(317, string(item.ShieldDefenseRate), true, true, false);
                    AddTooltipItemOption(97, string(item.AvoidModify), true, true, false);
                    AddTooltipItemOption(52, string(item.Weight), true, true, false);                    
                }
                else
                {
                    // End:0xC3F
                    if(IsMagicalArmor(item.ClassID))
                    {
                        // End:0xBDA
                        if(Len(SlotString) > 0)
                        {
                            AddTooltipItemOptionETC(0, SlotString, false, true, false, true);
                        }
                        AddTooltipItemBar(4);
                        AddTooltipItemOptionBonus("MP", string(item.MpBonus), true, true, false);
                        AddTooltipItemStatWithEnchant(95, GetPhysicalDefense(item.CrystalType, item.Enchanted, item.PhysicalDefense), item.PhysicalDefense, item.Enchanted, false);
                        AddTooltipItemBar(4);
                        AddTooltipItemOption(52, string(item.Weight), true, true, false);                        
                    }
                    else
                    {
                        // End:0xC5B
                        if(Len(SlotString) > 0)
                        {
                            AddTooltipItemOptionETC(0, SlotString, false, true, false, true);
                        }
                        AddTooltipItemBar(4);
                        AddTooltipItemStatWithEnchant(95, GetPhysicalDefense(item.CrystalType, item.Enchanted, item.PhysicalDefense), item.PhysicalDefense, item.Enchanted, false);
                        AddTooltipItemBar(4);
                        AddTooltipItemOption(52, string(item.Weight), true, true, false);
                    }
                }
                // End:0xEBE
                break;
            // End:0xD1A
            case 2:
                bLargeWidth = true;
                // End:0xCCF
                if(Len(SlotString) > 0)
                {
                    AddTooltipItemOptionETC(0, SlotString, false, true, false, true);
                }
                AddTooltipItemBar(4);
                AddTooltipItemStatWithEnchant(99, GetMagicalDefense(item.CrystalType, item.Enchanted, item.MagicalDefense), item.MagicalDefense, item.Enchanted, false);
                AddTooltipItemBar(4);
                AddTooltipItemOption(52, string(item.Weight), true, true, false);
                // End:0xEBE
                break;
            // End:0xD46
            case 3:
                bLargeWidth = true;
                // End:0xD43
                if(Len(SlotString) > 0)
                {
                    AddTooltipItemOptionETC(0, SlotString, false, true, false, true);
                }
                // End:0xEBE
                break;
            // End:0xEBB
            case 5:
                bLargeWidth = true;
                // End:0xDB9
                if(EEtcItemType == ITEME_PET_COLLAR)
                {
                    // End:0xD81
                    if(item.Damaged == 0)
                    {
                        nTmp = 971;                        
                    }
                    else
                    {
                        nTmp = 970;
                    }
                    AddTooltipItemOption2(969, nTmp, true, true, false);
                    AddTooltipItemOption(88, string(item.Enchanted), true, true, false);                    
                }
                else
                {
                    // End:0xDE6
                    if(EEtcItemType == ITEME_TICKET_OF_LORD)
                    {
                        AddTooltipItemOption(972, string(item.Enchanted), true, true, false);                        
                    }
                    else
                    {
                        // End:0xE3B
                        if(EEtcItemType == ITEME_LOTTO)
                        {
                            AddTooltipItemOption(670, string(item.Blessed), true, true, false);
                            AddTooltipItemOption(671, GetLottoString(item.Enchanted, item.Damaged), true, true, false);                            
                        }
                        else
                        {
                            // End:0xEA1
                            if(EEtcItemType == ITEME_RACE_TICKET)
                            {
                                AddTooltipItemOption(670, string(item.Enchanted), true, true, false);
                                AddTooltipItemOption(671, GetRaceTicketString(item.Blessed), true, true, false);
                                AddTooltipItemOption(744, string(item.Damaged * 100), true, true, false);
                            }
                        }
                    }
                }
                AddTooltipItemOption(52, string(item.Weight), true, true, false);
                // End:0xEBE
                break;
            // End:0xFFFF
            default:
                break;
        }
        // End:0x10CC
        if((item.CurrentDurability >= 0) && item.Durability > 0)
        {
            bLargeWidth = true;
            AddTooltipItemBlank(10);
            AddTooltipItemBG("ClockBG", "Time Remaining", "");
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetX = 3;
            m_Info.bLineBreak = true;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 163;
            m_Info.t_color.G = 163;
            m_Info.t_color.B = 163;
            m_Info.t_color.A = byte(255);
            m_Info.t_ID = 1493;
            EndItem();
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.t_bDrawOneLine = true;
            // End:0x1023
            if((item.CurrentDurability + 1) <= 5)
            {
                m_Info.t_color.R = byte(255);
                m_Info.t_color.G = 0;
                m_Info.t_color.B = 0;                
            }
            else
            {
                m_Info.t_color.R = 176;
                m_Info.t_color.G = 155;
                m_Info.t_color.B = 121;
            }
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = ((" " $ string(item.CurrentDurability)) $ "/") $ string(item.Durability);
            EndItem();
            AddTooltipItemOption(1491, "", true, false, false);
            // End:0x10CC
            if(Len(item.Description) > 0)
            {
                AddTooltipItemBlank(10);
            }
        }
        // End:0x1178
        if((Len(item.Description) > 0) && EItemType != 0)
        {
            bLargeWidth = true;
            AddTooltipItemBar(4);
            AddTooltipPlainText(item.Description, 178, 190, 207, 4, true, false);
        }
        // End:0x16B8
        if(item.ClassID > 0)
        {
            idx = 0;

            while(idx < 3)
            {
                Class'NWindow.UIDATA_ITEM'.static.GetSetItemIDList(item.ClassID, idx, arrID);
                if((arrID.Length > 0) && !bAddedSetHeader)
                {
                    AddTooltipItemBlank(10);
                    AddTooltipItemBG("setBG", "Armor Set", "");
                    bAddedSetHeader = true;
                }
                SetID = 0;

                while(SetID < arrID.Length)
                {
                    bLargeWidth = true;
                    ClassID = arrID[SetID];
                    // End:0x137A
                    if(item.ClassID != ClassID)
                    {
                        strTmp = Class'NWindow.UIDATA_ITEM'.static.GetItemName(ClassID);
                        // End:0x137A
                        if(Len(strTmp) > 0)
                        {
                            StartItem();
                            m_Info.eType = DIT_TEXTURE;
                            m_Info.nOffSetX = 3;
                            m_Info.nOffSetY = 5;
                            m_Info.bLineBreak = true;
                            m_Info.t_bDrawOneLine = true;
                            m_Info.u_nTextureWidth = 16;
                            m_Info.u_nTextureHeight = 16;
                            m_Info.u_nTextureUWidth = 32;
                            m_Info.u_nTextureUHeight = 32;
                            m_Info.u_strTexture = Class'NWindow.UIDATA_ITEM'.static.GetItemTextureName(ClassID);
                            EndItem();
                            StartItem();
                            m_Info.eType = DIT_TEXT;
                            m_Info.nOffSetX = 3;
                            m_Info.nOffSetY = 6;
                            m_Info.t_bDrawOneLine = true;
                            m_Info.t_color.R = 100;
                            m_Info.t_color.G = 100;
                            m_Info.t_color.B = 65;
                            m_Info.t_color.A = byte(255);
                            m_Info.t_strText = strTmp;
                            ParamAdd(m_Info.Condition, "Type", "Equip");
                            ParamAdd(m_Info.Condition, "ServerID", string(item.ServerID));
                            ParamAdd(m_Info.Condition, "EquipID", string(ClassID));
                            ParamAdd(m_Info.Condition, "NormalColor", "100,100,65");
                            ParamAdd(m_Info.Condition, "EnableColor", "255,250,160");
                            EndItem();
                        }
                    }
                    SetID++;
                }
                strTmp = Class'NWindow.UIDATA_ITEM'.static.GetSetItemEffectDescription(item.ClassID, idx);
                // End:0x152B
                if(Len(strTmp) > 0)
                {
                    if(!bAddedSetHeader)
                    {
                        AddTooltipItemBlank(10);
                        AddTooltipItemBG("setBG", "Armor Set", "");
                        bAddedSetHeader = true;
                    }
                    bLargeWidth = true;
                    StartItem();
                    m_Info.eType = DIT_TEXT;
                    m_Info.nOffSetX = 3;
                    m_Info.nOffSetY = 6;
                    m_Info.bLineBreak = true;
                    m_Info.t_color.R = 100;
                    m_Info.t_color.G = 70;
                    m_Info.t_color.B = 0;
                    m_Info.t_color.A = byte(255);
                    m_Info.t_strText = strTmp;
                    ParamAdd(m_Info.Condition, "Type", "SetEffect");
                    ParamAdd(m_Info.Condition, "ServerID", string(item.ServerID));
                    ParamAdd(m_Info.Condition, "ClassID", string(item.ClassID));
                    ParamAdd(m_Info.Condition, "EffectID", string(idx));
                    ParamAdd(m_Info.Condition, "NormalColor", "100,70,0");
                    ParamAdd(m_Info.Condition, "EnableColor", "255,180,0");
                    EndItem();
                    AddTooltipItemBar(4);
                }
                idx++;
            }
            strTmp = Class'NWindow.UIDATA_ITEM'.static.GetSetItemEnchantEffectDescription(item.ClassID);
            // End:0x16B8
            if(Len(strTmp) > 0)
            {
                bLargeWidth = true;
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.nOffSetY = 6;
                m_Info.bLineBreak = true;
                m_Info.t_color.R = 74;
                m_Info.t_color.G = 92;
                m_Info.t_color.B = 104;
                m_Info.t_color.A = byte(255);
                m_Info.t_strText = strTmp;
                ParamAdd(m_Info.Condition, "Type", "EnchantEffect");
                ParamAdd(m_Info.Condition, "ServerID", string(item.ServerID));
                ParamAdd(m_Info.Condition, "ClassID", string(item.ClassID));
                ParamAdd(m_Info.Condition, "NormalColor", "74,92,104");
                ParamAdd(m_Info.Condition, "EnableColor", "111,146,169");
                EndItem();
            }
        }
        if((TooltipType == "Inventory") && ShouldShowAdminItemIDs())
        {
            bLargeWidth = true;
            AddTooltipItemBlank(6);
            AddTooltipAdminItemIDs(item);
        }        
    }
    else
    {
        return;
    }
    // End:0x16D3
    if(bLargeWidth)
    {
        m_Tooltip.MinimumWidth = 144;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function bool ShouldShowAdminItemIDs()
{
    local UserInfo Info;
    local int Value;

    // EV_ShowGMWnd is only expected for GM/admin sessions.
    if(m_bAdminItemIDMode)
    {
        return true;
    }
    if(GetOptionBool("Game", "ShowAdminItemIDs"))
    {
        return true;
    }
    if(GetPlayerInfo(Info))
    {
        if(GetINIInt(Info.Name, "ShowAdminItemIDs", Value, "Option"))
        {
            return Value != 0;
        }
    }
    return false;
}

function AddTooltipAdminItemIDs(ItemInfo item)
{
    AddTooltipAdminItemIDLine("ID", string(item.ClassID));
    // ServerID is the runtime object id; it may be empty for static/preview items.
    if(item.ServerID > 0)
    {
        AddTooltipAdminItemIDLine("ServerID", string(item.ServerID));
    }
    return;
}

function AddTooltipAdminItemIDLine(string Label, string Value)
{
    StartItem();
    m_Info.eType = DIT_TEXT;
    m_Info.nOffSetY = 6;
    m_Info.bLineBreak = true;
    m_Info.t_bDrawOneLine = true;
    m_Info.t_color.R = 163;
    m_Info.t_color.G = 163;
    m_Info.t_color.B = 163;
    m_Info.t_color.A = byte(255);
    m_Info.t_strText = Label;
    EndItem();

    StartItem();
    m_Info.eType = DIT_TEXT;
    m_Info.nOffSetY = 6;
    m_Info.t_bDrawOneLine = true;
    m_Info.t_color.R = 163;
    m_Info.t_color.G = 163;
    m_Info.t_color.B = 163;
    m_Info.t_color.A = byte(255);
    m_Info.t_strText = " : ";
    EndItem();

    StartItem();
    m_Info.eType = DIT_TEXT;
    m_Info.nOffSetY = 6;
    m_Info.t_bDrawOneLine = true;
    m_Info.t_color.R = 176;
    m_Info.t_color.G = 155;
    m_Info.t_color.B = 121;
    m_Info.t_color.A = byte(255);
    m_Info.t_strText = Value;
    EndItem();
    return;
}

function AddTooltipAugmentSummary(ItemInfo item)
{
    AddTooltipAugmentSummaryLine(item.RefineryOp2);
    AddTooltipAugmentSummaryLine(item.RefineryOp1);
    return;
}

function AddTooltipAugmentSummaryLine(int RefineryOp)
{
    local string RefParam;
    local array<string> Parts;

    if((RefineryOp <= 14561) || (RefineryOp >= 16380))
    {
        return;
    }
    RefineryParam(RefineryOp, RefParam);
    Parts.Length = 0;
    Split(RefParam, ",", Parts);
    if((Parts.Length >= 5) && (Parts[1] == "3") && (Parts[2] == "1"))
    {
        AddTooltipPlainText(("Active Skill: " $ Parts[3]) $ (" " $ Parts[4]) $ " Lv.", 255, 102, 255, 6, true, true);
    }
    return;
}

function AddTooltipItemSectionTitle(int TitleID)
{
    local string Title;

    Title = GetSystemString(TitleID);
    if((Left(Title, 1) == "<") && (Right(Title, 1) == ">"))
    {
        Title = Mid(Title, 1, Len(Title) - 2);
    }
    AddTooltipPlainText(Title, 178, 190, 207, 6, true, true);
    return;
}

function AddTooltipPlainText(string Text, int R, int G, int B, int OffsetY, bool bLineBreak, bool bOneLine)
{
    StartItem();
    m_Info.eType = DIT_TEXT;
    m_Info.nOffSetY = OffsetY;
    m_Info.bLineBreak = bLineBreak;
    m_Info.t_bDrawOneLine = bOneLine;
    m_Info.t_color.R = byte(R);
    m_Info.t_color.G = byte(G);
    m_Info.t_color.B = byte(B);
    m_Info.t_color.A = byte(255);
    m_Info.t_strText = Text;
    EndItem();
    return;
}

function AddTooltipItemStatWithEnchant(int TitleID, int TotalValue, int BaseValue, int EnchantValue, bool IamFirst)
{
    AddTooltipItemOptionFirst(TitleID, string(TotalValue), true, true, IamFirst);
    if((EnchantValue > 0) && (BaseValue > 0))
    {
        AddTooltipItemOptionNoLine(0, " (" $ string(BaseValue), true, true, false);
        AddTooltipItemOptionNoLineYellow(0, " +" $ string(TotalValue - BaseValue), true, true, false);
        AddTooltipItemOptionNoLine(0, ")", true, true, false);
    }
    AddTooltipItemBlank(2);
    return;
}

function ReturnTooltip_NTT_ACTION(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local ItemInfo item;

    // End:0x149
    if(int(eSourceType) == 1)
    {
        ParseString(param, "Name", item.Name);
        ParseString(param, "Description", item.Description);
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_strText = item.Name;
        EndItem();
        // End:0x146
        if(Len(item.Description) > 0)
        {
            m_Tooltip.MinimumWidth = 144;
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.t_bDrawOneLine = false;
            m_Info.bLineBreak = true;
            m_Info.t_color.R = 178;
            m_Info.t_color.G = 190;
            m_Info.t_color.B = 207;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = item.Description;
            EndItem();
        }        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_SKILL(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local ItemInfo item;
    local UIEventManager.EItemParamType EItemParamType;
    local UIEventManager.EShortCutItemType eShortCutType;
    local int nTmp, SkillLevel;

    // End:0x569
    if(int(eSourceType) == 1)
    {
        ParseString(param, "Name", item.Name);
        ParseString(param, "AdditionalName", item.AdditionalName);
        ParseString(param, "Description", item.Description);
        ParseInt(param, "ClassID", item.ClassID);
        ParseInt(param, "Level", item.Level);
        eShortCutType = EShortCutItemType(item.ItemSubType);
        EItemParamType = EItemParamType(item.ItemType);
        SkillLevel = item.Level;
        m_Tooltip.MinimumWidth = 144;
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_strText = item.Name;
        EndItem();
        // End:0x1F7
        if(Len(item.AdditionalName) > 0)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetX = 5;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = byte(255);
            m_Info.t_color.G = 217;
            m_Info.t_color.B = 105;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = item.AdditionalName;
            EndItem();
            SkillLevel = Class'NWindow.UIDATA_SKILL'.static.GetEnchantSkillLevel(item.ClassID, item.Level);
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_strText = " ";
        EndItem();
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 163;
        m_Info.t_color.G = 163;
        m_Info.t_color.B = 163;
        m_Info.t_color.A = byte(255);
        m_Info.t_ID = 88;
        EndItem();
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 176;
        m_Info.t_color.G = 155;
        m_Info.t_color.B = 121;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = " " $ string(SkillLevel);
        EndItem();
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.nOffSetY = 6;
        m_Info.bLineBreak = true;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 176;
        m_Info.t_color.G = 155;
        m_Info.t_color.B = 121;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Class'NWindow.UIDATA_SKILL'.static.GetOperateType(item.ClassID, item.Level);
        EndItem();
        nTmp = Class'NWindow.UIDATA_SKILL'.static.GetHpConsume(item.ClassID, item.Level);
        // End:0x430
        if(nTmp > 0)
        {
            AddTooltipItemOption(1195, string(nTmp), true, true, false);
        }
        nTmp = Class'NWindow.UIDATA_SKILL'.static.GetMpConsume(item.ClassID, item.Level);
        // End:0x479
        if(nTmp > 0)
        {
            AddTooltipItemOption(320, string(nTmp), true, true, false);
        }
        nTmp = Class'NWindow.UIDATA_SKILL'.static.GetCastRange(item.ClassID, item.Level);
        // End:0x4C2
        if(nTmp >= 0)
        {
            AddTooltipItemOption(321, string(nTmp), true, true, false);
        }
        // End:0x566
        if(Len(item.Description) > 0)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.bLineBreak = true;
            m_Info.t_color.R = 178;
            m_Info.t_color.G = 190;
            m_Info.t_color.B = 207;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = item.Description;
            EndItem();
        }        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_ABNORMALSTATUS(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local ItemInfo item;
    local UIEventManager.EItemParamType EItemParamType;
    local UIEventManager.EShortCutItemType eShortCutType;

    // End:0x601
    if(int(eSourceType) == 1)
    {
        ParseString(param, "Name", item.Name);
        ParseString(param, "AdditionalName", item.AdditionalName);
        ParseString(param, "Description", item.Description);
        ParseInt(param, "ClassID", item.ClassID);
        ParseInt(param, "Level", item.Level);
        ParseInt(param, "Reserved", item.Reserved);
        eShortCutType = EShortCutItemType(item.ItemSubType);
        EItemParamType = EItemParamType(item.ItemType);
        m_Tooltip.MinimumWidth = 144;
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_strText = item.Name;
        EndItem();
        // End:0x20B
        if(Len(item.AdditionalName) > 0)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetX = 5;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = byte(255);
            m_Info.t_color.G = 217;
            m_Info.t_color.B = 105;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = item.AdditionalName;
            EndItem();
            item.Level = Class'NWindow.UIDATA_SKILL'.static.GetEnchantSkillLevel(item.ClassID, item.Level);
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_strText = " ";
        EndItem();
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 163;
        m_Info.t_color.G = 163;
        m_Info.t_color.B = 163;
        m_Info.t_color.A = byte(255);
        m_Info.t_ID = 88;
        EndItem();
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 176;
        m_Info.t_color.G = 155;
        m_Info.t_color.B = 121;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = " " $ string(item.Level);
        EndItem();
        // End:0x55A
        if(!IsDebuff(item.ClassID, item.Level) && item.Reserved >= 0)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.bLineBreak = true;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 163;
            m_Info.t_color.G = 163;
            m_Info.t_color.B = 163;
            m_Info.t_color.A = byte(255);
            m_Info.t_ID = 1199;
            EndItem();
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 163;
            m_Info.t_color.G = 163;
            m_Info.t_color.B = 163;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = " : ";
            EndItem();
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 176;
            m_Info.t_color.G = 155;
            m_Info.t_color.B = 121;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = MakeBuffTimeStr(item.Reserved);
            ParamAdd(m_Info.Condition, "Type", "RemainTime");
            EndItem();
        }
        // End:0x5FE
        if(Len(item.Description) > 0)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.bLineBreak = true;
            m_Info.t_color.R = 178;
            m_Info.t_color.G = 190;
            m_Info.t_color.B = 207;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = item.Description;
            EndItem();
        }        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_NORMALITEM(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local ItemInfo item;

    // End:0x168
    if(int(eSourceType) == 1)
    {
        ParseString(param, "Name", item.Name);
        ParseString(param, "Description", item.Description);
        ParseString(param, "AdditionalName", item.AdditionalName);
        ParseInt(param, "CrystalType", item.CrystalType);
        AddTooltipItemName(item.Name, item);
        AddTooltipItemGrade(item);
        // End:0x165
        if(Len(item.Description) > 0)
        {
            m_Tooltip.MinimumWidth = 144;
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.bLineBreak = true;
            m_Info.t_color.R = 178;
            m_Info.t_color.G = 190;
            m_Info.t_color.B = 207;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = item.Description;
            EndItem();
        }        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_RECIPE(string param, UIEventManager.ETooltipSourceType eSourceType, bool bShowPrice)
{
    local ItemInfo item;
    local string strAdena, strAdenaComma;
    local Color AdenaColor;

    // End:0x2D5
    if(int(eSourceType) == 1)
    {
        ParseString(param, "Name", item.Name);
        ParseString(param, "Description", item.Description);
        ParseString(param, "AdditionalName", item.AdditionalName);
        ParseInt(param, "CrystalType", item.CrystalType);
        ParseInt(param, "Weight", item.Weight);
        ParseInt(param, "Price", item.Price);
        AddTooltipItemName(item.Name, item);
        AddTooltipItemGrade(item);
        // End:0x20A
        if(bShowPrice)
        {
            strAdena = string(item.Price);
            strAdenaComma = MakeCostString(strAdena);
            AdenaColor = GetNumericColor(strAdenaComma);
            AddTooltipItemOption(641, strAdenaComma $ " ", true, true, false);
            SetTooltipItemColor(int(AdenaColor.R), int(AdenaColor.G), int(AdenaColor.B), 0);
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color = AdenaColor;
            m_Info.t_ID = 469;
            EndItem();
            AddTooltipItemOption(0, ("(" $ ConvertNumToText(strAdena)) $ ")", false, true, false);
            SetTooltipItemColor(int(AdenaColor.R), int(AdenaColor.G), int(AdenaColor.B), 0);
        }
        AddTooltipItemOption(52, string(item.Weight), true, true, false);
        // End:0x2D2
        if(Len(item.Description) > 0)
        {
            m_Tooltip.MinimumWidth = 144;
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.bLineBreak = true;
            m_Info.t_color.R = 178;
            m_Info.t_color.G = 190;
            m_Info.t_color.B = 207;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = item.Description;
            EndItem();
        }        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_SHORTCUT(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local ItemInfo item;
    local UIEventManager.EItemParamType EItemParamType;
    local UIEventManager.EShortCutItemType eShortCutType;
    local string ItemName;

    // End:0x5B3
    if(int(eSourceType) == 1)
    {
        ParseString(param, "Name", item.Name);
        ParseString(param, "AdditionalName", item.AdditionalName);
        ParseInt(param, "ClassID", item.ClassID);
        ParseInt(param, "Level", item.Level);
        ParseInt(param, "Reserved", item.Reserved);
        ParseInt(param, "Enchanted", item.Enchanted);
        ParseInt(param, "ItemType", item.ItemType);
        ParseInt(param, "ItemSubType", item.ItemSubType);
        ParseInt(param, "CrystalType", item.CrystalType);
        ParseInt(param, "ConsumeType", item.ConsumeType);
        ParseInt(param, "RefineryOp1", item.RefineryOp1);
        ParseInt(param, "RefineryOp2", item.RefineryOp2);
        ParseInt(param, "ItemNum", item.ItemNum);
        ParseInt(param, "MpConsume", item.MpConsume);
        eShortCutType = EShortCutItemType(item.ItemSubType);
        EItemParamType = EItemParamType(item.ItemType);
        ItemName = Class'NWindow.UIDATA_ITEM'.static.GetRefineryItemName(item.Name, item.RefineryOp1, item.RefineryOp2);
        switch(eShortCutType)
        {
            // End:0x267
            case SCIT_ITEM:
                AddTooltipItemEnchant(item);
                AddTooltipItemName(ItemName, item);
                AddTooltipItemGrade(item);
                AddTooltipItemCount(item);
                // End:0x5B0
                break;
            // End:0x565
            case SCIT_SKILL:
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_strText = ItemName;
                EndItem();
                // End:0x376
                if(Len(item.AdditionalName) > 0)
                {
                    StartItem();
                    m_Info.eType = DIT_TEXT;
                    m_Info.nOffSetX = 5;
                    m_Info.t_bDrawOneLine = true;
                    m_Info.t_color.R = byte(255);
                    m_Info.t_color.G = 217;
                    m_Info.t_color.B = 105;
                    m_Info.t_color.A = byte(255);
                    m_Info.t_strText = item.AdditionalName;
                    EndItem();
                    item.Level = Class'NWindow.UIDATA_SKILL'.static.GetEnchantSkillLevel(item.ClassID, item.Level);
                }
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_strText = " ";
                EndItem();
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_color.R = 163;
                m_Info.t_color.G = 163;
                m_Info.t_color.B = 163;
                m_Info.t_color.A = byte(255);
                m_Info.t_ID = 88;
                EndItem();
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_color.R = 176;
                m_Info.t_color.G = 155;
                m_Info.t_color.B = 121;
                m_Info.t_color.A = byte(255);
                m_Info.t_strText = " " $ string(item.Level);
                EndItem();
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_strText = " (";
                EndItem();
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_ID = 91;
                EndItem();
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_strText = (":" $ string(item.MpConsume)) $ ")";
                EndItem();
                // End:0x5B0
                break;
            // End:0x56A
            case SCIT_ACTION:
            // End:0x56F
            case SCIT_MACRO:
            // End:0x5AD
            case SCIT_RECIPE:
                StartItem();
                m_Info.eType = DIT_TEXT;
                m_Info.t_bDrawOneLine = true;
                m_Info.t_strText = ItemName;
                EndItem();
                // End:0x5B0
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
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_RECIPE_MANUFACTURE(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local ItemInfo item;

    // End:0x1D9
    if(int(eSourceType) == 1)
    {
        ParseString(param, "Name", item.Name);
        ParseString(param, "Description", item.Description);
        ParseString(param, "AdditionalName", item.AdditionalName);
        ParseInt(param, "Reserved", item.Reserved);
        ParseInt(param, "CrystalType", item.CrystalType);
        ParseInt(param, "ItemNum", item.ItemNum);
        m_Tooltip.MinimumWidth = 144;
        AddTooltipItemName(item.Name, item);
        AddTooltipItemGrade(item);
        AddTooltipItemOption(736, string(item.Reserved), true, true, false);
        AddTooltipItemOption(737, string(item.ItemNum), true, true, false);
        // End:0x1D6
        if(Len(item.Description) > 0)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = 6;
            m_Info.bLineBreak = true;
            m_Info.t_color.R = 178;
            m_Info.t_color.G = 190;
            m_Info.t_color.B = 207;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = item.Description;
            EndItem();
        }        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_CLANINFO(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local LVDataRecord Record;

    // End:0x4B
    if(int(eSourceType) == 2)
    {
        ParamToRecord(param, Record);
        AddTooltipItemOption(391, GetClassType(int(Record.LVDataList[2].szData)), true, true, true);        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_PARTYMATCH(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local LVDataRecord Record;

    // End:0x4A
    if(int(eSourceType) == 2)
    {
        ParamToRecord(param, Record);
        AddTooltipItemOption(391, GetClassType(int(Record.LVDataList[1].szData)), true, true, true);        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_QUESTLIST(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local LVDataRecord Record;
    local int nTmp;

    // End:0x9A
    if(int(eSourceType) == 2)
    {
        ParamToRecord(param, Record);
        AddTooltipItemOption(1200, Record.LVDataList[0].szData, true, true, true);
        switch(Record.LVDataList[3].nReserved1)
        {
            // End:0x57
            case 0:
            // End:0x6A
            case 2:
                nTmp = 861;
                // End:0x84
                break;
            // End:0x6E
            case 1:
            // End:0x81
            case 3:
                nTmp = 862;
                // End:0x84
                break;
            // End:0xFFFF
            default:
                break;
        }
        AddTooltipItemOption2(1202, nTmp, true, true, false);        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_RAIDLIST(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local LVDataRecord Record;

    // End:0xC9
    if(int(eSourceType) == 2)
    {
        ParamToRecord(param, Record);
        // End:0x34
        if(Len(Record.szReserved) < 1)
        {
            return;
        }
        m_Tooltip.MinimumWidth = 144;
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = false;
        m_Info.t_color.R = 178;
        m_Info.t_color.G = 190;
        m_Info.t_color.B = 207;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Record.szReserved;
        EndItem();        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_QUESTINFO(string param, UIEventManager.ETooltipSourceType eSourceType)
{
    local LVDataRecord Record;
    local int nTmp, Width1, Width2, Height;

    // End:0x224
    if(int(eSourceType) == 2)
    {
        ParamToRecord(param, Record);
        AddTooltipItemOption(1200, Record.LVDataList[0].szData, true, true, true);
        AddTooltipItemOption(1201, Record.LVDataList[1].szData, true, true, false);
        GetTextSize((GetSystemString(1200) $ " : ") $ Record.LVDataList[0].szData, Width1, Height);
        GetTextSize((GetSystemString(1201) $ " : ") $ Record.LVDataList[1].szData, Width2, Height);
        // End:0xE2
        if(Width2 > Width1)
        {
            Width1 = Width2;
        }
        // End:0xF6
        if(144 > Width1)
        {
            Width1 = 144;
        }
        m_Tooltip.MinimumWidth = Width1 + 30;
        AddTooltipItemOption(922, Record.LVDataList[2].szData, true, true, false);
        switch(Record.LVDataList[3].nReserved1)
        {
            // End:0x142
            case 0:
            // End:0x155
            case 2:
                nTmp = 861;
                // End:0x16F
                break;
            // End:0x159
            case 1:
            // End:0x16C
            case 3:
                nTmp = 862;
                // End:0x16F
                break;
            // End:0xFFFF
            default:
                break;
        }
        AddTooltipItemOption2(1202, nTmp, true, true, false);
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.nOffSetY = 6;
        m_Info.t_bDrawOneLine = false;
        m_Info.bLineBreak = true;
        m_Info.t_color.R = 178;
        m_Info.t_color.G = 190;
        m_Info.t_color.B = 207;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Record.szReserved;
        EndItem();        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function ReturnTooltip_NTT_MANOR(string param, string TooltipType, UIEventManager.ETooltipSourceType eSourceType)
{
    local LVDataRecord Record;
    local int idx1, idx2, idx3;

    // End:0x1E4
    if(int(eSourceType) == 2)
    {
        ParamToRecord(param, Record);
        // End:0x54
        if(TooltipType == "ManorSeedInfo")
        {
            idx1 = 4;
            idx2 = 5;
            idx3 = 6;            
        }
        else
        {
            // End:0x88
            if(TooltipType == "ManorCropInfo")
            {
                idx1 = 5;
                idx2 = 6;
                idx3 = 7;                
            }
            else
            {
                // End:0xBF
                if(TooltipType == "ManorSeedSetting")
                {
                    idx1 = 7;
                    idx2 = 8;
                    idx3 = 9;                    
                }
                else
                {
                    // End:0xF6
                    if(TooltipType == "ManorCropSetting")
                    {
                        idx1 = 9;
                        idx2 = 10;
                        idx3 = 11;                        
                    }
                    else
                    {
                        // End:0x12C
                        if(TooltipType == "ManorDefaultInfo")
                        {
                            idx1 = 1;
                            idx2 = 4;
                            idx3 = 5;                            
                        }
                        else
                        {
                            // End:0x15D
                            if(TooltipType == "ManorCropSell")
                            {
                                idx1 = 7;
                                idx2 = 8;
                                idx3 = 9;
                            }
                        }
                    }
                }
            }
        }
        AddTooltipItemOption(0, Record.LVDataList[0].szData, false, true, true);
        AddTooltipItemOption(537, Record.LVDataList[idx1].szData, true, true, false);
        AddTooltipItemOption(1134, Record.LVDataList[idx2].szData, true, true, false);
        AddTooltipItemOption(1135, Record.LVDataList[idx3].szData, true, true, false);        
    }
    else
    {
        return;
    }
    ReturnTooltipInfo(m_Tooltip);
    return;
}

function AddTooltipItemOption(int TitleID, string Content, bool bTitle, bool bContent, bool IamFirst)
{
    // End:0xAE
    if(bTitle)
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        // End:0x34
        if(!IamFirst)
        {
            m_Info.nOffSetY = 6;
        }
        m_Info.bLineBreak = true;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 163;
        m_Info.t_color.G = 163;
        m_Info.t_color.B = 163;
        m_Info.t_color.A = byte(255);
        m_Info.t_ID = TitleID;
        EndItem();
    }
    // End:0x208
    if(bContent)
    {
        // End:0x158
        if(bTitle)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            // End:0xEB
            if(!IamFirst)
            {
                m_Info.nOffSetY = 6;
            }
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 163;
            m_Info.t_color.G = 163;
            m_Info.t_color.B = 163;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = " : ";
            EndItem();
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        // End:0x183
        if(!IamFirst)
        {
            m_Info.nOffSetY = 6;
        }
        // End:0x19B
        if(!bTitle)
        {
            m_Info.bLineBreak = true;
        }
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 176;
        m_Info.t_color.G = 155;
        m_Info.t_color.B = 121;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Content;
        EndItem();
    }
    return;
}

function AddTooltipItemOption2(int TitleID, int ContentID, bool bTitle, bool bContent, bool IamFirst)
{
    // End:0xAE
    if(bTitle)
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        // End:0x34
        if(!IamFirst)
        {
            m_Info.nOffSetY = 6;
        }
        m_Info.bLineBreak = true;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 163;
        m_Info.t_color.G = 163;
        m_Info.t_color.B = 163;
        m_Info.t_color.A = byte(255);
        m_Info.t_ID = TitleID;
        EndItem();
    }
    // End:0x208
    if(bContent)
    {
        // End:0x158
        if(bTitle)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            // End:0xEB
            if(!IamFirst)
            {
                m_Info.nOffSetY = 6;
            }
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 163;
            m_Info.t_color.G = 163;
            m_Info.t_color.B = 163;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = " : ";
            EndItem();
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        // End:0x183
        if(!IamFirst)
        {
            m_Info.nOffSetY = 6;
        }
        // End:0x19B
        if(!bTitle)
        {
            m_Info.bLineBreak = true;
        }
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 176;
        m_Info.t_color.G = 155;
        m_Info.t_color.B = 121;
        m_Info.t_color.A = byte(255);
        m_Info.t_ID = ContentID;
        EndItem();
    }
    return;
}

function AddTooltipItemOptionETC(int TitleID, string Content, bool bTitle, bool bContent, bool IamFirst, bool isCard)
{
    if(bTitle)
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.nOffSetX = 36;
        m_Info.nOffSetY = -14;
        m_Info.bLineBreak = true;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 163;
        m_Info.t_color.G = 163;
        m_Info.t_color.B = 163;
        m_Info.t_color.A = byte(255);
        m_Info.t_ID = TitleID;
        EndItem();
    }
    if(bContent)
    {
        if(bTitle)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = -14;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 163;
            m_Info.t_color.G = 163;
            m_Info.t_color.B = 163;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = " : ";
            EndItem();
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        if(!IamFirst)
        {
            m_Info.nOffSetY = -14;
        }
        if(!bTitle)
        {
            m_Info.bLineBreak = true;
        }
        if(isCard)
        {
            m_Info.nOffSetX = 36;
        }
        m_Tooltip.SimpleLineCount = 2;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 176;
        m_Info.t_color.G = 155;
        m_Info.t_color.B = 121;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Content;
        EndItem();
    }
    return;
}

function AddTooltipItemOptionETC2(string TitleID, string Content, bool bTitle, bool bContent, bool IamFirst)
{
    if(bTitle)
    {
        StartItem();
        m_Tooltip.SimpleLineCount = 2;
        m_Info.eType = DIT_TEXT;
        m_Info.nOffSetX = 36;
        m_Info.nOffSetY = -14;
        m_Info.bLineBreak = true;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 163;
        m_Info.t_color.G = 163;
        m_Info.t_color.B = 163;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = TitleID;
        EndItem();
    }
    if(bContent)
    {
        if(bTitle)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.nOffSetY = -14;
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 163;
            m_Info.t_color.G = 163;
            m_Info.t_color.B = 163;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = " : ";
            EndItem();
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        if(!IamFirst)
        {
            m_Info.nOffSetY = -14;
        }
        if(!bTitle)
        {
            m_Info.bLineBreak = true;
        }
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 176;
        m_Info.t_color.G = 155;
        m_Info.t_color.B = 121;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Content;
        EndItem();
    }
    return;
}

function AddTooltipItemOptionFirst(int TitleID, string Content, bool bTitle, bool bContent, bool IamFirst)
{
    if(bTitle)
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        if(!IamFirst)
        {
            m_Info.nOffSetY = 3;
        }
        m_Info.bLineBreak = true;
        m_Info.t_bDrawOneLine = true;
        m_Info.nOffSetX = 3;
        m_Info.t_color.R = byte(255);
        m_Info.t_color.G = byte(255);
        m_Info.t_color.B = byte(255);
        m_Info.t_color.A = byte(255);
        m_Info.t_ID = TitleID;
        EndItem();
    }
    if((Content != "0") && bContent)
    {
        if(bTitle)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            if(!IamFirst)
            {
                m_Info.nOffSetY = 3;
            }
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 163;
            m_Info.t_color.G = 163;
            m_Info.t_color.B = 163;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = " : ";
            EndItem();
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        if(!IamFirst)
        {
            m_Info.nOffSetY = 3;
        }
        if(!bTitle)
        {
            m_Info.bLineBreak = true;
        }
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 222;
        m_Info.t_color.G = 202;
        m_Info.t_color.B = 105;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Content;
        EndItem();
    }
    return;
}

function AddTooltipItemOptionNoLine(int TitleID, string Content, bool bTitle, bool bContent, bool Yellow)
{
    if((Content != "0") && bContent)
    {
        if(bTitle)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.t_strText = "";
            EndItem();
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.nOffSetY = 3;
        m_Info.t_color.R = 176;
        m_Info.t_color.G = 155;
        m_Info.t_color.B = 121;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Content;
        EndItem();
    }
    return;
}

function AddTooltipItemOptionNoLineYellow(int TitleID, string Content, bool bTitle, bool bContent, bool Yellow)
{
    if((Content != "0") && bContent)
    {
        if(bTitle)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            m_Info.t_strText = "";
            EndItem();
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.nOffSetY = 3;
        m_Info.t_color.R = 225;
        m_Info.t_color.G = 152;
        m_Info.t_color.B = 14;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Content;
        EndItem();
    }
    return;
}

function AddTooltipItemBG(string Icon, string Name, string name2)
{
    StartItem();
    m_Info.eType = DIT_TEXTURE;
    m_Info.bLineBreak = true;
    m_Info.t_bDrawOneLine = true;
    m_Info.u_nTextureWidth = 300;
    m_Info.u_nTextureHeight = 24;
    m_Info.u_strTexture = "Interface.Tooltip.TooltipSectionBG";
    EndItem();
    StartItem();
    m_Info.eType = DIT_TEXT;
    m_Info.nOffSetY = -20;
    m_Info.nOffSetX = 3;
    m_Info.bLineBreak = true;
    m_Info.t_color.R = byte(255);
    m_Info.t_color.G = byte(255);
    m_Info.t_color.B = byte(255);
    m_Info.t_color.A = byte(255);
    m_Info.t_strText = Name;
    EndItem();
    if(Len(name2) > 0)
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.nOffSetY = -20;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = byte(255);
        m_Info.t_color.G = 217;
        m_Info.t_color.B = 105;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = name2;
        EndItem();
    }
    return;
}

function AddTooltipItemOptionBonus(string TitleID, string Content, bool bTitle, bool bContent, bool IamFirst)
{
    if(bTitle)
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        if(!IamFirst)
        {
            m_Info.nOffSetY = 4;
        }
        m_Info.nOffSetX = 3;
        m_Info.bLineBreak = true;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 200;
        m_Info.t_color.G = 200;
        m_Info.t_color.B = 200;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = TitleID;
        EndItem();
    }
    if((Content != "0") && bContent)
    {
        if(bTitle)
        {
            StartItem();
            m_Info.eType = DIT_TEXT;
            if(!IamFirst)
            {
                m_Info.nOffSetY = 4;
            }
            m_Info.t_bDrawOneLine = true;
            m_Info.t_color.R = 163;
            m_Info.t_color.G = 163;
            m_Info.t_color.B = 163;
            m_Info.t_color.A = byte(255);
            m_Info.t_strText = " : ";
            EndItem();
        }
        StartItem();
        m_Info.eType = DIT_TEXT;
        if(!IamFirst)
        {
            m_Info.nOffSetY = 4;
        }
        if(!bTitle)
        {
            m_Info.bLineBreak = true;
        }
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 4;
        m_Info.t_color.G = 140;
        m_Info.t_color.B = 220;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = Content;
        EndItem();
    }
    return;
}

function AddTooltipItemBar(int Y)
{
    StartItem();
    m_Info.eType = DIT_TEXTURE;
    m_Info.nOffSetY = Y;
    m_Info.bLineBreak = true;
    m_Info.t_bDrawOneLine = true;
    m_Info.u_nTextureWidth = 300;
    m_Info.u_nTextureHeight = 1;
    m_Info.u_strTexture = "Interface.Tooltip.TooltipLine";
    EndItem();
    return;
}

function SetTooltipItemColor(int R, int G, int B, int offset)
{
    local int idx;

    idx = (m_Tooltip.DrawList.Length - 1) - offset;
    m_Tooltip.DrawList[idx].t_color.R = byte(R);
    m_Tooltip.DrawList[idx].t_color.G = byte(G);
    m_Tooltip.DrawList[idx].t_color.B = byte(B);
    m_Tooltip.DrawList[idx].t_color.A = byte(255);
    return;
}

function AddTooltipItemBlank(int Height)
{
    StartItem();
    m_Info.eType = DIT_BLANK;
    m_Info.b_nHeight = Height;
    EndItem();
    return;
}

function AddTooltipItemIcon(ItemInfo item)
{
    local string TextureName;

    TextureName = Class'NWindow.UIDATA_ITEM'.static.GetItemTextureName(item.ClassID);
    if(Len(TextureName) < 1)
    {
        TextureName = item.IconName;
    }
    StartItem();
    m_Info.eType = DIT_TEXTURE;
    m_Info.t_bDrawOneLine = true;
    m_Info.u_nTextureWidth = 32;
    m_Info.u_nTextureHeight = 32;
    m_Info.u_strTexture = TextureName;
    EndItem();
    return;
}

function AddTooltipItemEnchant(ItemInfo item)
{
    local UIEventManager.EItemParamType EItemParamType;

    EItemParamType = EItemParamType(item.ItemType);
    // End:0xC3
    if((item.Enchanted > 0) && IsEnchantableItem(EItemParamType))
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 176;
        m_Info.t_color.G = 155;
        m_Info.t_color.B = 121;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = ("+" $ string(item.Enchanted)) $ " ";
        EndItem();
    }
    return;
}

function AddTooltipItemName(string Name, ItemInfo item)
{
    // End:0xD4
    if(Len(item.AdditionalName) > 0)
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = 0;
        m_Info.t_color.G = 97;
        m_Info.t_color.B = 218;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = " " $ Name;
        EndItem();
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = byte(255);
        m_Info.t_color.G = 217;
        m_Info.t_color.B = 105;
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = " " $ item.AdditionalName;
        EndItem();
    }
    else
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_color.R = byte(255);
        m_Info.t_color.G = byte(255);
        m_Info.t_color.B = byte(255);
        m_Info.t_color.A = byte(255);
        m_Info.t_strText = " " $ Name;
        EndItem();
    }
    return;
}

function AddTooltipItemGrade(ItemInfo item)
{
    local string strTmp;

    strTmp = GetItemGradeString(item.CrystalType);
    // End:0x97
    if(Len(strTmp) > 0)
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_strText = " ";
        EndItem();
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_strText = ("`" $ strTmp) $ "`";
        EndItem();
    }
    return;
}

function AddTooltipItemCount(ItemInfo item)
{
    // End:0x61
    if(IsStackableItem(item.ConsumeType))
    {
        StartItem();
        m_Info.eType = DIT_TEXT;
        m_Info.t_bDrawOneLine = true;
        m_Info.t_strText = (" (" $ MakeCostString(string(item.ItemNum))) $ ")";
        EndItem();
    }
    return;
}

function GetRefineryColor(int Quality, out int R, out int G, out int B)
{
    switch(Quality)
    {
        // End:0x26
        case 1:
            R = 187;
            G = 181;
            B = 138;
            // End:0xA4
            break;
        // End:0x46
        case 2:
            R = 132;
            G = 174;
            B = 216;
            // End:0xA4
            break;
        // End:0x66
        case 3:
            R = 193;
            G = 112;
            B = 202;
            // End:0xA4
            break;
        // End:0x86
        case 4:
            R = 225;
            G = 109;
            B = 109;
            // End:0xA4
            break;
        // End:0xFFFF
        default:
            R = 187;
            G = 181;
            B = 138;
            // End:0xA4
            break;
            break;
    }
    return;
}
