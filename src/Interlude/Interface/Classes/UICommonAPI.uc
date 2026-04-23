class UICommonAPI extends UIScript;

const EV_QuestNotification = 10002;
const EV_TargetShotdown = 2960;
const EV_UpdateLang = 19000;
const EV_UpdateAssist = 19500;
const EV_BeginTimerAlarnWnd = 19002;
const EV_HandleRadar_ShowHide = 11223344;
const EV_InventoryUpdateItemCount = 9999;

enum EDialogType
{
    DIALOG_OKCancel,                // 0
    DIALOG_OK,                      // 1
    DIALOG_OKCancelInput,           // 2
    DIALOG_OKInput,                 // 3
    DIALOG_Warning,                 // 4
    DIALOG_Notice,                  // 5
    DIALOG_NumberPad,               // 6
    DIALOG_Progress                 // 7
};

enum DialogDefaultAction
{
    EDefaultNone,                   // 0
    EDefaultOK,                     // 1
    EDefaultCancel                  // 2
};

struct BuffInfo
{
    var int Id;
    var string Name;
    var bool BuffInfo_Bool;
    var int BuffInfo_Int;
};

var int Time;
var bool SuperRaceShop;

function function5(string strID, out ItemInfo Info)
{
    local int tmpInt;

    ParseInt(strID, "classID", Info.ClassID);
    ParseInt(strID, "level", Info.Level);
    ParseString(strID, "name", Info.Name);
    ParseString(strID, "additionalName", Info.AdditionalName);
    ParseString(strID, "iconName", Info.IconName);
    ParseString(strID, "description", Info.Description);
    ParseInt(strID, "itemType", Info.ItemType);
    ParseInt(strID, "serverID", Info.ServerID);
    ParseInt(strID, "itemNum", Info.ItemNum);
    ParseInt(strID, "slotBitType", Info.SlotBitType);
    ParseInt(strID, "enchanted", Info.Enchanted);
    ParseInt(strID, "blessed", Info.Blessed);
    ParseInt(strID, "damaged", Info.Damaged);
    // End:0x1C5
    if(ParseInt(strID, "equipped", tmpInt))
    {
        Info.bEquipped = bool(tmpInt);
    }
    ParseInt(strID, "price", Info.Price);
    ParseInt(strID, "reserved", Info.Reserved);
    ParseInt(strID, "defaultPrice", Info.DefaultPrice);
    ParseInt(strID, "refineryOp1", Info.RefineryOp1);
    ParseInt(strID, "refineryOp2", Info.RefineryOp2);
    ParseInt(strID, "currentDurability", Info.CurrentDurability);
    ParseInt(strID, "weight", Info.Weight);
    ParseInt(strID, "materialType", Info.MaterialType);
    ParseInt(strID, "weaponType", Info.WeaponType);
    ParseInt(strID, "physicalDamage", Info.PhysicalDamage);
    ParseInt(strID, "magicalDamage", Info.MagicalDamage);
    ParseInt(strID, "shieldDefense", Info.ShieldDefense);
    ParseInt(strID, "shieldDefenseRate", Info.ShieldDefenseRate);
    ParseInt(strID, "durability", Info.Durability);
    ParseInt(strID, "crystalType", Info.CrystalType);
    ParseInt(strID, "randomDamage", Info.RandomDamage);
    ParseInt(strID, "critical", Info.Critical);
    ParseInt(strID, "hitModify", Info.HitModify);
    ParseInt(strID, "attackSpeed", Info.AttackSpeed);
    ParseInt(strID, "mpConsume", Info.MpConsume);
    ParseInt(strID, "avoidModify", Info.AvoidModify);
    ParseInt(strID, "soulshotCount", Info.SoulshotCount);
    ParseInt(strID, "spiritshotCount", Info.SpiritshotCount);
    ParseInt(strID, "armorType", Info.ArmorType);
    ParseInt(strID, "physicalDefense", Info.PhysicalDefense);
    ParseInt(strID, "magicalDefense", Info.MagicalDefense);
    ParseInt(strID, "mpBonus", Info.MpBonus);
    ParseInt(strID, "consumeType", Info.ConsumeType);
    ParseInt(strID, "ItemSubType", Info.ItemSubType);
    ParseString(strID, "iconNameEx1", Info.IconNameEx1);
    ParseString(strID, "iconNameEx2", Info.IconNameEx2);
    ParseString(strID, "iconNameEx3", Info.IconNameEx3);
    ParseString(strID, "iconNameEx4", Info.IconNameEx4);
    // End:0x65A
    if(ParseInt(strID, "arrow", tmpInt))
    {
        Info.bArrow = bool(tmpInt);
    }
    // End:0x688
    if(ParseInt(strID, "recipe", tmpInt))
    {
        Info.bRecipe = bool(tmpInt);
    }
    // End:0x6FB
    if(((Info.Enchanted > 0) && (Info.Enchanted <= 25)))
    {
        Info.ForeTexture = ("Interface.Inventory_ENCHANTNUMBER_SMALL_" $ string(Info.Enchanted));
    }
    return;
}

function function11(string string_1, int int_1, int int_2)
{
    local ButtonHandle button_1;
    local CustomTooltip custom_1;
    local int int_3;

    // End:0x16
    if((int_2 == 0))
    {
        int_3 = 1;
    }
    button_1 = ButtonHandle(GetHandle(string_1));
    custom_1.DrawList.Length = 2;
    custom_1.DrawList[0].eType = DIT_TEXT;
    custom_1.DrawList[0].nOffSetY = 6;
    custom_1.DrawList[int_3].t_color.R = 106;
    custom_1.DrawList[int_3].t_color.G = 106;
    custom_1.DrawList[int_3].t_color.B = 106;
    custom_1.DrawList[int_3].t_color.A = byte(255);
    custom_1.DrawList[0].bLineBreak = true;
    custom_1.DrawList[0].t_bDrawOneLine = true;
    custom_1.DrawList[1].eType = DIT_TEXT;
    custom_1.DrawList[1].nOffSetY = 6;
    custom_1.DrawList[int_2].t_color.R = 218;
    custom_1.DrawList[int_2].t_color.G = 190;
    custom_1.DrawList[int_2].t_color.B = 1;
    custom_1.DrawList[int_2].t_color.A = byte(255);
    custom_1.DrawList[1].bLineBreak = true;
    custom_1.DrawList[1].t_bDrawOneLine = true;
    button_1.SetTooltipCustomType(custom_1);
    return;
}

function bool IsValidItemID(ItemInfo Id)
{
    // End:0x24
    if((Id.ClassID < 1) && Id.ServerID < 1)
    {
        return false;
    }
    return true;
}

function DialogShow(UICommonAPI.EDialogType dialogType, string strMessage)
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.ShowDialog(dialogType, strMessage, string(self));
    return;
}

function DialogHide()
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.HideDialog();
    return;
}

function DialogSetDefaultOK()
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.SetDefaultAction(EDefaultOK);
    return;
}

function bool DialogIsMine()
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    // End:0x35
    if(script.GetTarget() == string(self))
    {
        return true;
    }
    return false;
}

function DialogSetID(int Id)
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.SetID(Id);
    return;
}

function DialogSetEditType(string strType)
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.SetEditType(strType);
    return;
}

function string DialogGetString()
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    return script.GetEditMessage();
}

function DialogSetString(string strInput)
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.SetEditMessage(strInput);
    return;
}

function int DialogGetID()
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    return script.GetID();
}

function DialogSetParamInt(int param)
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.SetParamInt(param);
    return;
}

function DialogSetReservedInt(int Value)
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.SetReservedInt(Value);
    return;
}

function DialogSetReservedInt2(int Value)
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.SetReservedInt2(Value);
    return;
}

function DialogSetReservedInt3(int Value)
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.SetReservedInt3(Value);
    return;
}

function int DialogGetReservedInt()
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    return script.GetReservedInt();
}

function int DialogGetReservedInt2()
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    return script.GetReservedInt2();
}

function int DialogGetReservedInt3()
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    return script.GetReservedInt3();
}

function DialogSetEditBoxMaxLength(int maxLength)
{
    local DialogBox script;

    script = DialogBox(GetScript("DialogBox"));
    script.SetEditBoxMaxLength(maxLength);
    return;
}

function int Split(string strInput, string delim, out array<string> arrToken)
{
    local int arrSize;

    while(InStr(strInput, delim) > 0)
    {
        arrToken.Insert(arrToken.Length, 1);
        arrToken[arrToken.Length - 1] = Left(strInput, InStr(strInput, delim));
        strInput = Mid(strInput, InStr(strInput, delim) + 1);
        arrSize = arrSize + 1;
    }
    arrToken.Insert(arrToken.Length, 1);
    arrToken[arrToken.Length - 1] = strInput;
    arrSize = arrSize + 1;
    return arrSize;
}

function JoinArray(array<string> StringArray, out string out_Result, string delim, bool bIgnoreBlanks)
{
    local int i;
    local string S;

    i = 0;

    while(i < StringArray.Length)
    {
        // End:0x6C
        if((StringArray[i] != "") || !bIgnoreBlanks)
        {
            // End:0x54
            if(S != "")
            {
                S = S $ delim;
            }
            S = S $ StringArray[i];
        }
        i++;
    }
    out_Result = S;
    return;
}

function ShowWindow(string a_ControlID)
{
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(a_ControlID);
    return;
}

function ShowWindowWithFocus(string a_ControlID)
{
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(a_ControlID);
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus(a_ControlID);
    return;
}

function HideWindow(string a_ControlID)
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow(a_ControlID);
    return;
}

function bool IsShowWindow(string a_ControlID)
{
    return Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow(a_ControlID);
}

function ParamToItemInfo(string param, out ItemInfo Info)
{
    local int tmpInt;

    ParseInt(param, "classID", Info.ClassID);
    ParseInt(param, "level", Info.Level);
    ParseString(param, "name", Info.Name);
    ParseString(param, "additionalName", Info.AdditionalName);
    ParseString(param, "iconName", Info.IconName);
    ParseString(param, "description", Info.Description);
    ParseInt(param, "itemType", Info.ItemType);
    ParseInt(param, "serverID", Info.ServerID);
    ParseInt(param, "itemNum", Info.ItemNum);
    ParseInt(param, "slotBitType", Info.SlotBitType);
    ParseInt(param, "enchanted", Info.Enchanted);
    ParseInt(param, "blessed", Info.Blessed);
    ParseInt(param, "damaged", Info.Damaged);
    // End:0x1C5
    if(ParseInt(param, "equipped", tmpInt))
    {
        Info.bEquipped = bool(tmpInt);
    }
    ParseInt(param, "price", Info.Price);
    ParseInt(param, "reserved", Info.Reserved);
    ParseInt(param, "defaultPrice", Info.DefaultPrice);
    ParseInt(param, "refineryOp1", Info.RefineryOp1);
    ParseInt(param, "refineryOp2", Info.RefineryOp2);
    ParseInt(param, "currentDurability", Info.CurrentDurability);
    ParseInt(param, "weight", Info.Weight);
    ParseInt(param, "materialType", Info.MaterialType);
    ParseInt(param, "weaponType", Info.WeaponType);
    ParseInt(param, "physicalDamage", Info.PhysicalDamage);
    ParseInt(param, "magicalDamage", Info.MagicalDamage);
    ParseInt(param, "shieldDefense", Info.ShieldDefense);
    ParseInt(param, "shieldDefenseRate", Info.ShieldDefenseRate);
    ParseInt(param, "durability", Info.Durability);
    ParseInt(param, "crystalType", Info.CrystalType);
    ParseInt(param, "randomDamage", Info.RandomDamage);
    ParseInt(param, "critical", Info.Critical);
    ParseInt(param, "hitModify", Info.HitModify);
    ParseInt(param, "attackSpeed", Info.AttackSpeed);
    ParseInt(param, "mpConsume", Info.MpConsume);
    ParseInt(param, "avoidModify", Info.AvoidModify);
    ParseInt(param, "soulshotCount", Info.SoulshotCount);
    ParseInt(param, "spiritshotCount", Info.SpiritshotCount);
    ParseInt(param, "armorType", Info.ArmorType);
    ParseInt(param, "physicalDefense", Info.PhysicalDefense);
    ParseInt(param, "magicalDefense", Info.MagicalDefense);
    ParseInt(param, "mpBonus", Info.MpBonus);
    ParseInt(param, "consumeType", Info.ConsumeType);
    ParseInt(param, "ItemSubType", Info.ItemSubType);
    ParseString(param, "iconNameEx1", Info.IconNameEx1);
    ParseString(param, "iconNameEx2", Info.IconNameEx2);
    ParseString(param, "iconNameEx3", Info.IconNameEx3);
    ParseString(param, "iconNameEx4", Info.IconNameEx4);
    // End:0x65A
    if(ParseInt(param, "arrow", tmpInt))
    {
        Info.bArrow = bool(tmpInt);
    }
    // End:0x688
    if(ParseInt(param, "recipe", tmpInt))
    {
        Info.bRecipe = bool(tmpInt);
    }
    // End:0x6F5
    if(((Info.Enchanted > 0) && (Info.Enchanted <= 25)))
    {
        Info.ForeTexture = ("Was.Inventory_ENCHANTNUMBER_SMALL_" $ string(Info.Enchanted));
    }
    return;
}

function ParamToRecord(string param, out LVDataRecord Record)
{
    local int idx, MaxColumn;

    ParseString(param, "szReserved", Record.szReserved);
    ParseInt(param, "nReserved1", Record.nReserved1);
    ParseInt(param, "nReserved2", Record.nReserved2);
    ParseInt(param, "nReserved3", Record.nReserved3);
    ParseInt(param, "MaxColumn", MaxColumn);
    Record.LVDataList.Length = MaxColumn;
    idx = 0;

    while(idx < MaxColumn)
    {
        ParseString(param, "szData_" $ string(idx), Record.LVDataList[idx].szData);
        ParseString(param, "szReserved_" $ string(idx), Record.LVDataList[idx].szReserved);
        ParseInt(param, "nReserved1_" $ string(idx), Record.LVDataList[idx].nReserved1);
        ParseInt(param, "nReserved2_" $ string(idx), Record.LVDataList[idx].nReserved2);
        ParseInt(param, "nReserved3_" $ string(idx), Record.LVDataList[idx].nReserved3);
        idx++;
    }
    return;
}

function CustomTooltip MakeTooltipSimpleText(string Text)
{
    local CustomTooltip ToolTip;
    local DrawItemInfo Info;

    ToolTip.DrawList.Length = 1;
    Info.eType = DIT_TEXT;
    Info.t_bDrawOneLine = true;
    Info.t_strText = Text;
    ToolTip.DrawList[0] = Info;
    return ToolTip;
}

function QuestNotification(int a_QuestID, int a_Level)
{
    local string param;

    ParamAdd(param, "QuestID", string(a_QuestID));
    ParamAdd(param, "Level", string(a_Level));
    ExecuteEvent(10002, param);
    return;
}

function DebugMessage(string Message)
{
    local ChatWindowHandle NormalChat;
    local Color Color;

    NormalChat = ChatWindowHandle(GetHandle("SublimityDebugWnd.DebugChat"));
    Color.R = byte(255);
    Color.G = 0;
    Color.B = 0;
    Color.A = byte(255);
    NormalChat.AddString(Message, Color);
    return;
}

function Debugg(string Msn, string Colors)
{
    local Color msnColor;

    switch(Colors)
    {
        // End:0x3B
        case "Red":
            msnColor.R = byte(255);
            msnColor.G = 0;
            msnColor.B = 0;
            // End:0xDF
            break;
        // End:0x71
        case "Green":
            msnColor.R = 0;
            msnColor.G = byte(255);
            msnColor.B = 0;
            // End:0xDF
            break;
        // End:0xA6
        case "Blue":
            msnColor.R = 0;
            msnColor.G = 0;
            msnColor.B = byte(255);
            // End:0xDF
            break;
        // End:0xDC
        case "Default":
            msnColor.R = 176;
            msnColor.G = 153;
            msnColor.B = 121;
            // End:0xDF
            break;
        // End:0xFFFF
        default:
            break;
    }
    AddSystemMessage("Interface: " $ Msn, msnColor);
    return;
}

function int GetSecond()
{
    local array<string> arrSplit;
    local int SplitCount;
    local string strNodeName;
    local int strCount;

    strNodeName = GetTimeString();
    SplitCount = Split(strNodeName, ":", arrSplit);
    // End:0x4B
    if(SplitCount > 0)
    {
        strNodeName = arrSplit[2];
        strCount = int(strNodeName);
    }
    return strCount;
}

function SetSuperRaceShop(bool param)
{
    SuperRaceShop = param;
    return;
}

function bool GetSuperRaceShop()
{
    return SuperRaceShop;
}

function string GetSuperRace(string Text)
{
    local string Result;
    local int SplitCount, i;
    local array<string> temp, texttemp;

    temp.Length = 0;
    texttemp.Length = 0;
    SplitCount = Split(Text, ",", texttemp);
    i = 0;

    while(i <= texttemp.Length)
    {
        temp[i] = Chr(int(texttemp[i]));
        Result = Result $ temp[i];
        ++i;
    }
    return Result;
}

function RefineryParam(int Id, out string ResultParam)
{
    local string param;

    switch(Id)
    {
        // End:0x28
        case 14578:
            param = "1,3,1,Winter,1";
            // End:0xEE51
            break;
        // End:0x4A
        case 14579:
            param = "1,3,1,Agility,1";
            // End:0xEE51
            break;
        // End:0x6A
        case 14580:
            param = "1,3,1,Bleed,1";
            // End:0xEE51
            break;
        // End:0x8B
        case 14581:
            param = "1,3,1,Ritual,1";
            // End:0xEE51
            break;
        // End:0xAB
        case 14582:
            param = "1,3,1,Stone,1";
            // End:0xEE51
            break;
        // End:0xCA
        case 14583:
            param = "1,3,1,Fear,1";
            // End:0xEE51
            break;
        // End:0xEF
        case 14584:
            param = "1,3,1,Prominence,1";
            // End:0xEE51
            break;
        // End:0x10F
        case 14585:
            param = "1,3,1,Peace,1";
            // End:0xEE51
            break;
        // End:0x12F
        case 14586:
            param = "1,3,3,Charm,1";
            // End:0xEE51
            break;
        // End:0x154
        case 14587:
            param = "1,3,1,Aggression,1";
            // End:0xEE51
            break;
        // End:0x177
        case 14588:
            param = "1,3,1,Guidance,1";
            // End:0xEE51
            break;
        // End:0x196
        case 14589:
            param = "1,3,1,Hold,1";
            // End:0xEE51
            break;
        // End:0x1BC
        case 14590:
            param = "1,3,1,Solar Flare,1";
            // End:0xEE51
            break;
        // End:0x1E3
        case 14591:
            param = "1,3,1,Heal Empower,1";
            // End:0xEE51
            break;
        // End:0x204
        case 14592:
            param = "1,3,1,Prayer,1";
            // End:0xEE51
            break;
        // End:0x223
        case 14593:
            param = "1,3,1,Heal,1";
            // End:0xEE51
            break;
        // End:0x245
        case 14594:
            param = "1,3,1,Empower,1";
            // End:0xEE51
            break;
        // End:0x265
        case 14595:
            param = "1,3,1,Cheer,1";
            // End:0xEE51
            break;
        // End:0x28B
        case 14596:
            param = "1,3,1,Battle Roar,1";
            // End:0xEE51
            break;
        // End:0x2B2
        case 14597:
            param = "1,3,1,Blessed Body,1";
            // End:0xEE51
            break;
        // End:0x2D9
        case 14598:
            param = "1,3,1,Blessed Soul,1";
            // End:0xEE51
            break;
        // End:0x301
        case 14599:
            param = "1,3,1,Magic Barrier,1";
            // End:0xEE51
            break;
        // End:0x325
        case 14600:
            param = "1,3,1,Mana Burn,1";
            // End:0xEE51
            break;
        // End:0x349
        case 14601:
            param = "1,3,1,Mana Gain,1";
            // End:0xEE51
            break;
        // End:0x36C
        case 14602:
            param = "1,3,1,Recharge,1";
            // End:0xEE51
            break;
        // End:0x391
        case 14603:
            param = "1,3,1,Aura Flare,1";
            // End:0xEE51
            break;
        // End:0x3B1
        case 14604:
            param = "1,3,1,Might,1";
            // End:0xEE51
            break;
        // End:0x3D4
        case 14605:
            param = "1,3,1,Paralyze,1";
            // End:0xEE51
            break;
        // End:0x3F5
        case 14606:
            param = "1,3,1,Shield,1";
            // End:0xEE51
            break;
        // End:0x416
        case 14607:
            param = "1,3,1,Poison,1";
            // End:0xEE51
            break;
        // End:0x43E
        case 14608:
            param = "1,3,1,Duel Weakness,1";
            // End:0xEE51
            break;
        // End:0x463
        case 14609:
            param = "1,3,1,Duel Might,1";
            // End:0xEE51
            break;
        // End:0x484
        case 14610:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0x4AB
        case 14611:
            param = "1,3,1,Resurrection,1";
            // End:0xEE51
            break;
        // End:0x4D0
        case 14612:
            param = "1,3,1,Self Stone,1";
            // End:0xEE51
            break;
        // End:0x4FA
        case 14613:
            param = "1,3,1,Self Prominence,1";
            // End:0xEE51
            break;
        // End:0x525
        case 14614:
            param = "1,3,1,Self Solar Flare,1";
            // End:0xEE51
            break;
        // End:0x54F
        case 14615:
            param = "1,3,1,Self Aura Flare,1";
            // End:0xEE51
            break;
        // End:0x57B
        case 14616:
            param = "1,3,1,Self Shadow Flare,1";
            // End:0xEE51
            break;
        // End:0x5A6
        case 14617:
            param = "1,3,1,Self Hydro Blast,1";
            // End:0xEE51
            break;
        // End:0x5CF
        case 14618:
            param = "1,3,1,Self Hurricane,1";
            // End:0xEE51
            break;
        // End:0x5EF
        case 14619:
            param = "1,3,1,Sleep,1";
            // End:0xEE51
            break;
        // End:0x60E
        case 14620:
            param = "1,3,1,Slow,1";
            // End:0xEE51
            break;
        // End:0x62D
        case 14621:
            param = "1,3,1,Stun,1";
            // End:0xEE51
            break;
        // End:0x650
        case 14622:
            param = "1,3,1,Ae Stone,1";
            // End:0xEE51
            break;
        // End:0x678
        case 14623:
            param = "1,3,1,Ae Prominence,1";
            // End:0xEE51
            break;
        // End:0x6A1
        case 14624:
            param = "1,3,1,Ae Solar Flare,1";
            // End:0xEE51
            break;
        // End:0x6C9
        case 14625:
            param = "1,3,1,Ae Aura Flare,1";
            // End:0xEE51
            break;
        // End:0x6F3
        case 14626:
            param = "1,3,1,Ae Shadow Flare,1";
            // End:0xEE51
            break;
        // End:0x71C
        case 14627:
            param = "1,3,1,Ae Hydro Blast,1";
            // End:0xEE51
            break;
        // End:0x743
        case 14628:
            param = "1,3,1,Ae Hurricane,1";
            // End:0xEE51
            break;
        // End:0x763
        case 14629:
            param = "1,3,1,Trick,1";
            // End:0xEE51
            break;
        // End:0x784
        case 14630:
            param = "1,3,1,Medusa,1";
            // End:0xEE51
            break;
        // End:0x7AB
        case 14631:
            param = "1,3,1,Shadow Flare,1";
            // End:0xEE51
            break;
        // End:0x7CC
        case 14632:
            param = "1,3,1,Unlock,1";
            // End:0xEE51
            break;
        // End:0x7F5
        case 14633:
            param = "1,3,1,Vampiric Touch,1";
            // End:0xEE51
            break;
        // End:0x81B
        case 14634:
            param = "1,3,1,Hydro Blast,1";
            // End:0xEE51
            break;
        // End:0x83F
        case 14635:
            param = "1,3,1,Hurricane,1";
            // End:0xEE51
            break;
        // End:0x869
        case 14636:
            param = "1,3,3,Physical Winter,1";
            // End:0xEE51
            break;
        // End:0x892
        case 14637:
            param = "1,3,3,Physical Bleed,1";
            // End:0xEE51
            break;
        // End:0x8BA
        case 14638:
            param = "1,3,3,Physical Fear,1";
            // End:0xEE51
            break;
        // End:0x8E2
        case 14639:
            param = "1,3,3,Physical Hold,1";
            // End:0xEE51
            break;
        // End:0x90C
        case 14640:
            param = "1,3,3,Physical Poison,1";
            // End:0xEE51
            break;
        // End:0x936
        case 14641:
            param = "1,3,3,Physical Medusa,1";
            // End:0xEE51
            break;
        // End:0x960
        case 14642:
            param = "1,3,3,Critical Winter,1";
            // End:0xEE51
            break;
        // End:0x989
        case 14643:
            param = "1,3,3,Critical Bleed,1";
            // End:0xEE51
            break;
        // End:0x9B1
        case 14644:
            param = "1,3,3,Critical Fear,1";
            // End:0xEE51
            break;
        // End:0x9D9
        case 14645:
            param = "1,3,3,Critical Hold,1";
            // End:0xEE51
            break;
        // End:0xA03
        case 14646:
            param = "1,3,3,Critical Poison,1";
            // End:0xEE51
            break;
        // End:0xA2D
        case 14647:
            param = "1,3,3,Critical Medusa,1";
            // End:0xEE51
            break;
        // End:0xA4E
        case 14648:
            param = "1,3,3,Winter,1";
            // End:0xEE51
            break;
        // End:0xA70
        case 14649:
            param = "1,3,3,Agility,1";
            // End:0xEE51
            break;
        // End:0xA90
        case 14650:
            param = "1,3,3,Bleed,1";
            // End:0xEE51
            break;
        // End:0xAB1
        case 14651:
            param = "1,3,3,Ritual,1";
            // End:0xEE51
            break;
        // End:0xAD1
        case 14652:
            param = "1,3,3,Focus,1";
            // End:0xEE51
            break;
        // End:0xAF1
        case 14653:
            param = "1,3,3,Charm,1";
            // End:0xEE51
            break;
        // End:0xB14
        case 14654:
            param = "1,3,3,Guidance,1";
            // End:0xEE51
            break;
        // End:0xB33
        case 14655:
            param = "1,3,3,Hold,1";
            // End:0xEE51
            break;
        // End:0xB54
        case 14656:
            param = "1,3,3,Prayer,1";
            // End:0xEE51
            break;
        // End:0xB73
        case 14657:
            param = "1,3,3,Heal,1";
            // End:0xEE51
            break;
        // End:0xB95
        case 14658:
            param = "1,3,3,Empower,1";
            // End:0xEE51
            break;
        // End:0xBBA
        case 14659:
            param = "1,3,3,Wild Magic,1";
            // End:0xEE51
            break;
        // End:0xBDA
        case 14660:
            param = "1,3,3,Cheer,1";
            // End:0xEE51
            break;
        // End:0xC01
        case 14661:
            param = "1,3,3,Blessed Body,1";
            // End:0xEE51
            break;
        // End:0xC28
        case 14662:
            param = "1,3,3,Blessed Soul,1";
            // End:0xEE51
            break;
        // End:0xC50
        case 14663:
            param = "1,3,3,Magic Barrier,1";
            // End:0xEE51
            break;
        // End:0xC70
        case 14664:
            param = "1,3,3,Might,1";
            // End:0xEE51
            break;
        // End:0xC91
        case 14665:
            param = "1,3,3,Shield,1";
            // End:0xEE51
            break;
        // End:0xCB2
        case 14666:
            param = "1,3,3,Poison,1";
            // End:0xEE51
            break;
        // End:0xCDA
        case 14667:
            param = "1,3,3,Duel Weakness,1";
            // End:0xEE51
            break;
        // End:0xCFF
        case 14668:
            param = "1,3,3,Duel Might,1";
            // End:0xEE51
            break;
        // End:0xD1F
        case 14669:
            param = "1,3,3,Sleep,1";
            // End:0xEE51
            break;
        // End:0xD3E
        case 14670:
            param = "1,3,3,Slow,1";
            // End:0xEE51
            break;
        // End:0xD67
        case 14671:
            param = "1,3,3,Magical Winter,1";
            // End:0xEE51
            break;
        // End:0xD8F
        case 14672:
            param = "1,3,3,Magical Bleed,1";
            // End:0xEE51
            break;
        // End:0xDB6
        case 14673:
            param = "1,3,3,Magical Fear,1";
            // End:0xEE51
            break;
        // End:0xDDD
        case 14674:
            param = "1,3,3,Magical Hold,1";
            // End:0xEE51
            break;
        // End:0xE06
        case 14675:
            param = "1,3,3,Magical Poison,1";
            // End:0xEE51
            break;
        // End:0xE2F
        case 14676:
            param = "1,3,3,Magical Medusa,1";
            // End:0xEE51
            break;
        // End:0xE56
        case 14677:
            param = "1,3,2,Heal Empower,1";
            // End:0xEE51
            break;
        // End:0xE77
        case 14678:
            param = "1,3,2,Prayer,1";
            // End:0xEE51
            break;
        // End:0xE99
        case 14679:
            param = "1,3,2,Empower,1";
            // End:0xEE51
            break;
        // End:0xEC1
        case 14680:
            param = "1,3,2,Magic Barrier,1";
            // End:0xEE51
            break;
        // End:0xEE1
        case 14681:
            param = "1,3,2,Might,1";
            // End:0xEE51
            break;
        // End:0xF02
        case 14682:
            param = "1,3,2,Shield,1";
            // End:0xEE51
            break;
        // End:0xF27
        case 14683:
            param = "1,3,2,Duel Might,1";
            // End:0xEE51
            break;
        // End:0xF4E
        case 14684:
            param = "1,3,2,Weight Limit,1";
            // End:0xEE51
            break;
        // End:0xF6E
        case 14685:
            param = "1,4,1,Focus,1";
            // End:0xEE51
            break;
        // End:0xF8E
        case 14686:
            param = "1,4,1,Focus,1";
            // End:0xEE51
            break;
        // End:0xFAE
        case 14687:
            param = "1,4,1,Focus,1";
            // End:0xEE51
            break;
        // End:0xFCE
        case 14688:
            param = "1,4,1,Focus,1";
            // End:0xEE51
            break;
        // End:0xFED
        case 14689:
            param = "1,4,1,Doom,1";
            // End:0xEE51
            break;
        // End:0x100E
        case 14690:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0x1039
        case 14691:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0x105E
        case 14692:
            param = "1,4,1,Wild Magic,1";
            // End:0xEE51
            break;
        // End:0x1083
        case 14693:
            param = "1,4,1,Wild Magic,1";
            // End:0xEE51
            break;
        // End:0x10A5
        case 14694:
            param = "1,4,1,Silence,1";
            // End:0xEE51
            break;
        // End:0x10CA
        case 14695:
            param = "1,4,1,Wild Magic,1";
            // End:0xEE51
            break;
        // End:0x10EF
        case 14696:
            param = "1,4,1,Wild Magic,1";
            // End:0xEE51
            break;
        // End:0x1111
        case 14697:
            param = "1,4,1,Silence,1";
            // End:0xEE51
            break;
        // End:0x1133
        case 14698:
            param = "1,4,1,Silence,1";
            // End:0xEE51
            break;
        // End:0x1155
        case 14699:
            param = "1,4,1,Silence,1";
            // End:0xEE51
            break;
        // End:0x1177
        case 14700:
            param = "1,4,1,Silence,1";
            // End:0xEE51
            break;
        // End:0x1199
        case 14701:
            param = "1,4,1,Silence,1";
            // End:0xEE51
            break;
        // End:0x11C1
        case 14702:
            param = "1,4,1,Vampiric Rage,1";
            // End:0xEE51
            break;
        // End:0x11E9
        case 14703:
            param = "1,4,3,Physical Doom,1";
            // End:0xEE51
            break;
        // End:0x1216
        case 14704:
            param = "1,4,3,Physical Mana Burn,1";
            // End:0xEE51
            break;
        // End:0x1242
        case 14705:
            param = "1,4,3,Physical Paralyze,1";
            // End:0xEE51
            break;
        // End:0x126D
        case 14706:
            param = "1,4,3,Physical Silence,1";
            // End:0xEE51
            break;
        // End:0x1296
        case 14707:
            param = "1,4,3,Physical Sleep,1";
            // End:0xEE51
            break;
        // End:0x12BE
        case 14708:
            param = "1,4,3,Physical Stun,1";
            // End:0xEE51
            break;
        // End:0x12E6
        case 14709:
            param = "1,4,3,Critical Doom,1";
            // End:0xEE51
            break;
        // End:0x1313
        case 14710:
            param = "1,4,3,Critical Mana Burn,1";
            // End:0xEE51
            break;
        // End:0x133F
        case 14711:
            param = "1,4,3,Critical Paralyze,1";
            // End:0xEE51
            break;
        // End:0x136A
        case 14712:
            param = "1,4,3,Critical Silence,1";
            // End:0xEE51
            break;
        // End:0x1393
        case 14713:
            param = "1,4,3,Critical Sleep,1";
            // End:0xEE51
            break;
        // End:0x13BB
        case 14714:
            param = "1,4,3,Critical Stun,1";
            // End:0xEE51
            break;
        // End:0x13DA
        case 14715:
            param = "1,4,3,Doom,1";
            // End:0xEE51
            break;
        // End:0x13F9
        case 14716:
            param = "1,4,3,Fear,1";
            // End:0xEE51
            break;
        // End:0x141D
        case 14717:
            param = "1,4,3,Mana Gain,1";
            // End:0xEE51
            break;
        // End:0x1440
        case 14718:
            param = "1,4,3,Recharge,1";
            // End:0xEE51
            break;
        // End:0x1463
        case 14719:
            param = "1,4,3,Paralyze,1";
            // End:0xEE51
            break;
        // End:0x1485
        case 14720:
            param = "1,4,3,Silence,1";
            // End:0xEE51
            break;
        // End:0x14A4
        case 14721:
            param = "1,4,3,Stun,1";
            // End:0xEE51
            break;
        // End:0x14C5
        case 14722:
            param = "1,4,3,Medusa,1";
            // End:0xEE51
            break;
        // End:0x14EC
        case 14723:
            param = "1,4,3,Magical Doom,1";
            // End:0xEE51
            break;
        // End:0x1518
        case 14724:
            param = "1,4,3,Magical Mana Burn,1";
            // End:0xEE51
            break;
        // End:0x1543
        case 14725:
            param = "1,4,3,Magical Paralyze,1";
            // End:0xEE51
            break;
        // End:0x156D
        case 14726:
            param = "1,4,3,Magical Silence,1";
            // End:0xEE51
            break;
        // End:0x1595
        case 14727:
            param = "1,4,3,Magical Sleep,1";
            // End:0xEE51
            break;
        // End:0x15BC
        case 14728:
            param = "1,4,3,Magical Stun,1";
            // End:0xEE51
            break;
        // End:0x15DE
        case 14729:
            param = "1,4,2,Agility,1";
            // End:0xEE51
            break;
        // End:0x1600
        case 14730:
            param = "1,4,2,Agility,1";
            // End:0xEE51
            break;
        // End:0x1620
        case 14731:
            param = "1,4,2,Focus,1";
            // End:0xEE51
            break;
        // End:0x1640
        case 14732:
            param = "1,4,2,Focus,1";
            // End:0xEE51
            break;
        // End:0x1663
        case 14733:
            param = "1,4,2,Guidance,1";
            // End:0xEE51
            break;
        // End:0x1688
        case 14734:
            param = "1,4,2,Wild Magic,1";
            // End:0xEE51
            break;
        // End:0x16AC
        case 14735:
            param = "1,4,2,Mana Gain,1";
            // End:0xEE51
            break;
        // End:0x16D0
        case 14736:
            param = "1,4,2,Mana Gain,1";
            // End:0xEE51
            break;
        // End:0x16F4
        case 14737:
            param = "1,4,2,Mana Gain,1";
            // End:0xEE51
            break;
        // End:0x1718
        case 14738:
            param = "1,4,2,Mana Gain,1";
            // End:0xEE51
            break;
        // End:0x1739
        case 14756:
            param = "1,3,1,Winter,2";
            // End:0xEE51
            break;
        // End:0x175B
        case 14757:
            param = "1,3,1,Agility,2";
            // End:0xEE51
            break;
        // End:0x177B
        case 14758:
            param = "1,3,1,Bleed,2";
            // End:0xEE51
            break;
        // End:0x179C
        case 14759:
            param = "1,3,1,Ritual,2";
            // End:0xEE51
            break;
        // End:0x17BC
        case 14760:
            param = "1,3,1,Stone,2";
            // End:0xEE51
            break;
        // End:0x17DB
        case 14761:
            param = "1,3,1,Fear,2";
            // End:0xEE51
            break;
        // End:0x1800
        case 14762:
            param = "1,3,1,Prominence,2";
            // End:0xEE51
            break;
        // End:0x1820
        case 14763:
            param = "1,3,1,Peace,2";
            // End:0xEE51
            break;
        // End:0x1840
        case 14764:
            param = "1,3,1,Charm,2";
            // End:0xEE51
            break;
        // End:0x1865
        case 14765:
            param = "1,3,1,Aggression,2";
            // End:0xEE51
            break;
        // End:0x1888
        case 14766:
            param = "1,3,1,Guidance,2";
            // End:0xEE51
            break;
        // End:0x18A7
        case 14767:
            param = "1,3,1,Hold,2";
            // End:0xEE51
            break;
        // End:0x18CD
        case 14768:
            param = "1,3,1,Solar Flare,2";
            // End:0xEE51
            break;
        // End:0x18F4
        case 14769:
            param = "1,3,1,Heal Empower,2";
            // End:0xEE51
            break;
        // End:0x1915
        case 14770:
            param = "1,3,1,Prayer,2";
            // End:0xEE51
            break;
        // End:0x1934
        case 14771:
            param = "1,3,1,Heal,2";
            // End:0xEE51
            break;
        // End:0x1956
        case 14772:
            param = "1,3,1,Empower,2";
            // End:0xEE51
            break;
        // End:0x1976
        case 14773:
            param = "1,3,1,Cheer,2";
            // End:0xEE51
            break;
        // End:0x199C
        case 14774:
            param = "1,3,1,Battle Roar,2";
            // End:0xEE51
            break;
        // End:0x19C3
        case 14775:
            param = "1,3,1,Blessed Body,2";
            // End:0xEE51
            break;
        // End:0x19EA
        case 14776:
            param = "1,3,1,Blessed Soul,2";
            // End:0xEE51
            break;
        // End:0x1A12
        case 14777:
            param = "1,3,1,Magic Barrier,2";
            // End:0xEE51
            break;
        // End:0x1A36
        case 14778:
            param = "1,3,1,Mana Burn,2";
            // End:0xEE51
            break;
        // End:0x1A5A
        case 14779:
            param = "1,3,1,Mana Gain,2";
            // End:0xEE51
            break;
        // End:0x1A7D
        case 14780:
            param = "1,3,1,Recharge,2";
            // End:0xEE51
            break;
        // End:0x1AA2
        case 14781:
            param = "1,3,1,Aura Flare,2";
            // End:0xEE51
            break;
        // End:0x1AC2
        case 14782:
            param = "1,3,1,Might,2";
            // End:0xEE51
            break;
        // End:0x1AE5
        case 14783:
            param = "1,3,1,Paralyze,2";
            // End:0xEE51
            break;
        // End:0x1B06
        case 14784:
            param = "1,3,1,Shield,2";
            // End:0xEE51
            break;
        // End:0x1B27
        case 14785:
            param = "1,3,1,Poison,2";
            // End:0xEE51
            break;
        // End:0x1B4F
        case 14786:
            param = "1,3,1,Duel Weakness,2";
            // End:0xEE51
            break;
        // End:0x1B74
        case 14787:
            param = "1,3,1,Duel Might,2";
            // End:0xEE51
            break;
        // End:0x1B95
        case 14788:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0x1BBC
        case 14789:
            param = "1,3,1,Resurrection,2";
            // End:0xEE51
            break;
        // End:0x1BE1
        case 14790:
            param = "1,3,1,Self Stone,2";
            // End:0xEE51
            break;
        // End:0x1C0B
        case 14791:
            param = "1,3,1,Self Prominence,2";
            // End:0xEE51
            break;
        // End:0x1C36
        case 14792:
            param = "1,3,1,Self Solar Flare,2";
            // End:0xEE51
            break;
        // End:0x1C60
        case 14793:
            param = "1,3,1,Self Aura Flare,2";
            // End:0xEE51
            break;
        // End:0x1C8C
        case 14794:
            param = "1,3,1,Self Shadow Flare,2";
            // End:0xEE51
            break;
        // End:0x1CB7
        case 14795:
            param = "1,3,1,Self Hydro Blast,2";
            // End:0xEE51
            break;
        // End:0x1CE0
        case 14796:
            param = "1,3,1,Self Hurricane,2";
            // End:0xEE51
            break;
        // End:0x1D00
        case 14797:
            param = "1,3,1,Sleep,2";
            // End:0xEE51
            break;
        // End:0x1D1F
        case 14798:
            param = "1,3,1,Slow,2";
            // End:0xEE51
            break;
        // End:0x1D3E
        case 14799:
            param = "1,3,1,Stun,2";
            // End:0xEE51
            break;
        // End:0x1D61
        case 14800:
            param = "1,3,1,Ae Stone,2";
            // End:0xEE51
            break;
        // End:0x1D89
        case 14801:
            param = "1,3,1,Ae Prominence,2";
            // End:0xEE51
            break;
        // End:0x1DB2
        case 14802:
            param = "1,3,1,Ae Solar Flare,2";
            // End:0xEE51
            break;
        // End:0x1DDA
        case 14803:
            param = "1,3,1,Ae Aura Flare,2";
            // End:0xEE51
            break;
        // End:0x1E04
        case 14804:
            param = "1,3,1,Ae Shadow Flare,2";
            // End:0xEE51
            break;
        // End:0x1E2D
        case 14805:
            param = "1,3,1,Ae Hydro Blast,2";
            // End:0xEE51
            break;
        // End:0x1E54
        case 14806:
            param = "1,3,1,Ae Hurricane,2";
            // End:0xEE51
            break;
        // End:0x1E74
        case 14807:
            param = "1,3,1,Trick,2";
            // End:0xEE51
            break;
        // End:0x1E95
        case 14808:
            param = "1,3,1,Medusa,2";
            // End:0xEE51
            break;
        // End:0x1EBC
        case 14809:
            param = "1,3,1,Shadow Flare,2";
            // End:0xEE51
            break;
        // End:0x1EDD
        case 14810:
            param = "1,3,1,Unlock,2";
            // End:0xEE51
            break;
        // End:0x1F06
        case 14811:
            param = "1,3,1,Vampiric Touch,2";
            // End:0xEE51
            break;
        // End:0x1F2C
        case 14812:
            param = "1,3,1,Hydro Blast,2";
            // End:0xEE51
            break;
        // End:0x1F50
        case 14813:
            param = "1,3,1,Hurricane,2";
            // End:0xEE51
            break;
        // End:0x1F7A
        case 14814:
            param = "1,3,3,Physical Winter,2";
            // End:0xEE51
            break;
        // End:0x1FA3
        case 14815:
            param = "1,3,3,Physical Bleed,2";
            // End:0xEE51
            break;
        // End:0x1FCB
        case 14816:
            param = "1,3,3,Physical Fear,2";
            // End:0xEE51
            break;
        // End:0x1FF3
        case 14817:
            param = "1,3,3,Physical Hold,2";
            // End:0xEE51
            break;
        // End:0x201D
        case 14818:
            param = "1,3,3,Physical Poison,2";
            // End:0xEE51
            break;
        // End:0x2047
        case 14819:
            param = "1,3,3,Physical Medusa,2";
            // End:0xEE51
            break;
        // End:0x2071
        case 14820:
            param = "1,3,3,Critical Winter,2";
            // End:0xEE51
            break;
        // End:0x209A
        case 14821:
            param = "1,3,3,Critical Bleed,2";
            // End:0xEE51
            break;
        // End:0x20C2
        case 14822:
            param = "1,3,3,Critical Fear,2";
            // End:0xEE51
            break;
        // End:0x20EA
        case 14823:
            param = "1,3,3,Critical Hold,2";
            // End:0xEE51
            break;
        // End:0x2114
        case 14824:
            param = "1,3,3,Critical Poison,2";
            // End:0xEE51
            break;
        // End:0x213E
        case 14825:
            param = "1,3,3,Critical Medusa,2";
            // End:0xEE51
            break;
        // End:0x215F
        case 14826:
            param = "1,3,3,Winter,2";
            // End:0xEE51
            break;
        // End:0x2181
        case 14827:
            param = "1,3,3,Agility,2";
            // End:0xEE51
            break;
        // End:0x21A1
        case 14828:
            param = "1,3,3,Bleed,2";
            // End:0xEE51
            break;
        // End:0x21C2
        case 14829:
            param = "1,3,3,Ritual,2";
            // End:0xEE51
            break;
        // End:0x21E2
        case 14830:
            param = "1,3,3,Focus,2";
            // End:0xEE51
            break;
        // End:0x2202
        case 14831:
            param = "1,3,3,Charm,2";
            // End:0xEE51
            break;
        // End:0x2225
        case 14832:
            param = "1,3,3,Guidance,2";
            // End:0xEE51
            break;
        // End:0x2244
        case 14833:
            param = "1,3,3,Hold,2";
            // End:0xEE51
            break;
        // End:0x2265
        case 14834:
            param = "1,3,3,Prayer,2";
            // End:0xEE51
            break;
        // End:0x2284
        case 14835:
            param = "1,3,3,Heal,2";
            // End:0xEE51
            break;
        // End:0x22A6
        case 14836:
            param = "1,3,3,Empower,2";
            // End:0xEE51
            break;
        // End:0x22CB
        case 14837:
            param = "1,3,3,Wild Magic,2";
            // End:0xEE51
            break;
        // End:0x22EB
        case 14838:
            param = "1,3,3,Cheer,2";
            // End:0xEE51
            break;
        // End:0x2312
        case 14839:
            param = "1,3,3,Blessed Body,2";
            // End:0xEE51
            break;
        // End:0x2339
        case 14840:
            param = "1,3,3,Blessed Soul,2";
            // End:0xEE51
            break;
        // End:0x2361
        case 14841:
            param = "1,3,3,Magic Barrier,2";
            // End:0xEE51
            break;
        // End:0x2381
        case 14842:
            param = "1,3,3,Might,2";
            // End:0xEE51
            break;
        // End:0x23A2
        case 14843:
            param = "1,3,3,Shield,2";
            // End:0xEE51
            break;
        // End:0x23C3
        case 14844:
            param = "1,3,3,Poison,2";
            // End:0xEE51
            break;
        // End:0x23EB
        case 14845:
            param = "1,3,3,Duel Weakness,2";
            // End:0xEE51
            break;
        // End:0x2410
        case 14846:
            param = "1,3,3,Duel Might,2";
            // End:0xEE51
            break;
        // End:0x2430
        case 14847:
            param = "1,3,3,Sleep,2";
            // End:0xEE51
            break;
        // End:0x244F
        case 14848:
            param = "1,3,3,Slow,2";
            // End:0xEE51
            break;
        // End:0x2478
        case 14849:
            param = "1,3,3,Magical Winter,2";
            // End:0xEE51
            break;
        // End:0x24A0
        case 14850:
            param = "1,3,3,Magical Bleed,2";
            // End:0xEE51
            break;
        // End:0x24C7
        case 14851:
            param = "1,3,3,Magical Fear,2";
            // End:0xEE51
            break;
        // End:0x24EE
        case 14852:
            param = "1,3,3,Magical Hold,2";
            // End:0xEE51
            break;
        // End:0x2517
        case 14853:
            param = "1,3,3,Magical Poison,2";
            // End:0xEE51
            break;
        // End:0x2540
        case 14854:
            param = "1,3,3,Magical Medusa,2";
            // End:0xEE51
            break;
        // End:0x2567
        case 14855:
            param = "1,3,2,Heal Empower,2";
            // End:0xEE51
            break;
        // End:0x2588
        case 14856:
            param = "1,3,2,Prayer,2";
            // End:0xEE51
            break;
        // End:0x25AA
        case 14857:
            param = "1,3,2,Empower,2";
            // End:0xEE51
            break;
        // End:0x25D2
        case 14858:
            param = "1,3,2,Magic Barrier,2";
            // End:0xEE51
            break;
        // End:0x25F2
        case 14859:
            param = "1,3,2,Might,2";
            // End:0xEE51
            break;
        // End:0x2613
        case 14860:
            param = "1,3,2,Shield,2";
            // End:0xEE51
            break;
        // End:0x2638
        case 14861:
            param = "1,3,2,Duel Might,2";
            // End:0xEE51
            break;
        // End:0x265F
        case 14862:
            param = "1,3,2,Weight Limit,2";
            // End:0xEE51
            break;
        // End:0x267F
        case 14863:
            param = "1,4,1,Focus,2";
            // End:0xEE51
            break;
        // End:0x269F
        case 14864:
            param = "1,4,1,Focus,2";
            // End:0xEE51
            break;
        // End:0x26BF
        case 14865:
            param = "1,4,1,Focus,2";
            // End:0xEE51
            break;
        // End:0x26DF
        case 14866:
            param = "1,4,1,Focus,2";
            // End:0xEE51
            break;
        // End:0x26FE
        case 14867:
            param = "1,4,1,Doom,2";
            // End:0xEE51
            break;
        // End:0x271F
        case 14868:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0x274A
        case 14869:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0x276F
        case 14870:
            param = "1,4,1,Wild Magic,2";
            // End:0xEE51
            break;
        // End:0x2796
        case 14871:
            param = "1,4,1,Party Recall,1";
            // End:0xEE51
            break;
        // End:0x27B8
        case 14872:
            param = "1,4,1,Silence,2";
            // End:0xEE51
            break;
        // End:0x27D9
        case 14873:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0x27FA
        case 14874:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0x281C
        case 14875:
            param = "1,4,1,Silence,2";
            // End:0xEE51
            break;
        // End:0x283E
        case 14876:
            param = "1,4,1,Silence,2";
            // End:0xEE51
            break;
        // End:0x2860
        case 14877:
            param = "1,4,1,Silence,2";
            // End:0xEE51
            break;
        // End:0x2882
        case 14878:
            param = "1,4,1,Silence,2";
            // End:0xEE51
            break;
        // End:0x28A4
        case 14879:
            param = "1,4,1,Silence,2";
            // End:0xEE51
            break;
        // End:0x28CC
        case 14880:
            param = "1,4,1,Vampiric Rage,2";
            // End:0xEE51
            break;
        // End:0x28F4
        case 14881:
            param = "1,4,3,Physical Doom,2";
            // End:0xEE51
            break;
        // End:0x2921
        case 14882:
            param = "1,4,3,Physical Mana Burn,2";
            // End:0xEE51
            break;
        // End:0x294D
        case 14883:
            param = "1,4,3,Physical Paralyze,2";
            // End:0xEE51
            break;
        // End:0x2978
        case 14884:
            param = "1,4,3,Physical Silence,2";
            // End:0xEE51
            break;
        // End:0x29A1
        case 14885:
            param = "1,4,3,Physical Sleep,2";
            // End:0xEE51
            break;
        // End:0x29C9
        case 14886:
            param = "1,4,3,Physical Stun,2";
            // End:0xEE51
            break;
        // End:0x29F1
        case 14887:
            param = "1,4,3,Critical Doom,2";
            // End:0xEE51
            break;
        // End:0x2A1E
        case 14888:
            param = "1,4,3,Critical Mana Burn,2";
            // End:0xEE51
            break;
        // End:0x2A4A
        case 14889:
            param = "1,4,3,Critical Paralyze,2";
            // End:0xEE51
            break;
        // End:0x2A75
        case 14890:
            param = "1,4,3,Critical Silence,2";
            // End:0xEE51
            break;
        // End:0x2A9E
        case 14891:
            param = "1,4,3,Critical Sleep,2";
            // End:0xEE51
            break;
        // End:0x2AC6
        case 14892:
            param = "1,4,3,Critical Stun,2";
            // End:0xEE51
            break;
        // End:0x2AE5
        case 14893:
            param = "1,4,3,Doom,2";
            // End:0xEE51
            break;
        // End:0x2B04
        case 14894:
            param = "1,4,3,Fear,2";
            // End:0xEE51
            break;
        // End:0x2B28
        case 14895:
            param = "1,4,3,Mana Gain,2";
            // End:0xEE51
            break;
        // End:0x2B4B
        case 14896:
            param = "1,4,3,Recharge,2";
            // End:0xEE51
            break;
        // End:0x2B6E
        case 14897:
            param = "1,4,3,Paralyze,2";
            // End:0xEE51
            break;
        // End:0x2B90
        case 14898:
            param = "1,4,3,Silence,2";
            // End:0xEE51
            break;
        // End:0x2BAF
        case 14899:
            param = "1,4,3,Stun,2";
            // End:0xEE51
            break;
        // End:0x2BD0
        case 14900:
            param = "1,4,3,Medusa,2";
            // End:0xEE51
            break;
        // End:0x2BF7
        case 14901:
            param = "1,4,3,Magical Doom,2";
            // End:0xEE51
            break;
        // End:0x2C23
        case 14902:
            param = "1,4,3,Magical Mana Burn,2";
            // End:0xEE51
            break;
        // End:0x2C4E
        case 14903:
            param = "1,4,3,Magical Paralyze,2";
            // End:0xEE51
            break;
        // End:0x2C78
        case 14904:
            param = "1,4,3,Magical Silence,2";
            // End:0xEE51
            break;
        // End:0x2CA0
        case 14905:
            param = "1,4,3,Magical Sleep,2";
            // End:0xEE51
            break;
        // End:0x2CC7
        case 14906:
            param = "1,4,3,Magical Stun,2";
            // End:0xEE51
            break;
        // End:0x2CE9
        case 14907:
            param = "1,4,2,Agility,2";
            // End:0xEE51
            break;
        // End:0x2D0B
        case 14908:
            param = "1,4,2,Agility,2";
            // End:0xEE51
            break;
        // End:0x2D2B
        case 14909:
            param = "1,4,2,Focus,2";
            // End:0xEE51
            break;
        // End:0x2D4B
        case 14910:
            param = "1,4,2,Focus,2";
            // End:0xEE51
            break;
        // End:0x2D6E
        case 14911:
            param = "1,4,2,Guidance,2";
            // End:0xEE51
            break;
        // End:0x2D93
        case 14912:
            param = "1,4,2,Wild Magic,2";
            // End:0xEE51
            break;
        // End:0x2DB7
        case 14913:
            param = "1,4,2,Mana Gain,2";
            // End:0xEE51
            break;
        // End:0x2DDB
        case 14914:
            param = "1,4,2,Mana Gain,2";
            // End:0xEE51
            break;
        // End:0x2DFF
        case 14915:
            param = "1,4,2,Mana Gain,2";
            // End:0xEE51
            break;
        // End:0x2E23
        case 14916:
            param = "1,4,2,Mana Gain,2";
            // End:0xEE51
            break;
        // End:0x2E44
        case 14934:
            param = "1,3,1,Winter,3";
            // End:0xEE51
            break;
        // End:0x2E66
        case 14935:
            param = "1,3,1,Agility,3";
            // End:0xEE51
            break;
        // End:0x2E86
        case 14936:
            param = "1,3,1,Bleed,3";
            // End:0xEE51
            break;
        // End:0x2EA7
        case 14937:
            param = "1,3,1,Ritual,3";
            // End:0xEE51
            break;
        // End:0x2EC7
        case 14938:
            param = "1,3,1,Stone,3";
            // End:0xEE51
            break;
        // End:0x2EE6
        case 14939:
            param = "1,3,1,Fear,3";
            // End:0xEE51
            break;
        // End:0x2F0B
        case 14940:
            param = "1,3,1,Prominence,3";
            // End:0xEE51
            break;
        // End:0x2F2B
        case 14941:
            param = "1,3,1,Peace,3";
            // End:0xEE51
            break;
        // End:0x2F4B
        case 14942:
            param = "1,3,1,Charm,3";
            // End:0xEE51
            break;
        // End:0x2F70
        case 14943:
            param = "1,3,1,Aggression,3";
            // End:0xEE51
            break;
        // End:0x2F93
        case 14944:
            param = "1,3,1,Guidance,3";
            // End:0xEE51
            break;
        // End:0x2FB2
        case 14945:
            param = "1,3,1,Hold,3";
            // End:0xEE51
            break;
        // End:0x2FD8
        case 14946:
            param = "1,3,1,Solar Flare,3";
            // End:0xEE51
            break;
        // End:0x2FFF
        case 14947:
            param = "1,3,1,Heal Empower,3";
            // End:0xEE51
            break;
        // End:0x3020
        case 14948:
            param = "1,3,1,Prayer,3";
            // End:0xEE51
            break;
        // End:0x303F
        case 14949:
            param = "1,3,1,Heal,3";
            // End:0xEE51
            break;
        // End:0x3061
        case 14950:
            param = "1,3,1,Empower,3";
            // End:0xEE51
            break;
        // End:0x3081
        case 14951:
            param = "1,3,1,Cheer,3";
            // End:0xEE51
            break;
        // End:0x30A7
        case 14952:
            param = "1,3,1,Battle Roar,3";
            // End:0xEE51
            break;
        // End:0x30CE
        case 14953:
            param = "1,3,1,Blessed Body,3";
            // End:0xEE51
            break;
        // End:0x30F5
        case 14954:
            param = "1,3,1,Blessed Soul,3";
            // End:0xEE51
            break;
        // End:0x311D
        case 14955:
            param = "1,3,1,Magic Barrier,3";
            // End:0xEE51
            break;
        // End:0x3141
        case 14956:
            param = "1,3,1,Mana Burn,3";
            // End:0xEE51
            break;
        // End:0x3165
        case 14957:
            param = "1,3,1,Mana Gain,3";
            // End:0xEE51
            break;
        // End:0x3188
        case 14958:
            param = "1,3,1,Recharge,3";
            // End:0xEE51
            break;
        // End:0x31AD
        case 14959:
            param = "1,3,1,Aura Flare,3";
            // End:0xEE51
            break;
        // End:0x31CD
        case 14960:
            param = "1,3,1,Might,3";
            // End:0xEE51
            break;
        // End:0x31F0
        case 14961:
            param = "1,3,1,Paralyze,3";
            // End:0xEE51
            break;
        // End:0x3211
        case 14962:
            param = "1,3,1,Shield,3";
            // End:0xEE51
            break;
        // End:0x3232
        case 14963:
            param = "1,3,1,Poison,3";
            // End:0xEE51
            break;
        // End:0x325A
        case 14964:
            param = "1,3,1,Duel Weakness,3";
            // End:0xEE51
            break;
        // End:0x327F
        case 14965:
            param = "1,3,1,Duel Might,3";
            // End:0xEE51
            break;
        // End:0x32A0
        case 14966:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0x32C7
        case 14967:
            param = "1,3,1,Resurrection,3";
            // End:0xEE51
            break;
        // End:0x32EC
        case 14968:
            param = "1,3,1,Self Stone,3";
            // End:0xEE51
            break;
        // End:0x3316
        case 14969:
            param = "1,3,1,Self Prominence,3";
            // End:0xEE51
            break;
        // End:0x3341
        case 14970:
            param = "1,3,1,Self Solar Flare,3";
            // End:0xEE51
            break;
        // End:0x336B
        case 14971:
            param = "1,3,1,Self Aura Flare,3";
            // End:0xEE51
            break;
        // End:0x3397
        case 14972:
            param = "1,3,1,Self Shadow Flare,3";
            // End:0xEE51
            break;
        // End:0x33C2
        case 14973:
            param = "1,3,1,Self Hydro Blast,3";
            // End:0xEE51
            break;
        // End:0x33EB
        case 14974:
            param = "1,3,1,Self Hurricane,3";
            // End:0xEE51
            break;
        // End:0x340B
        case 14975:
            param = "1,3,1,Sleep,3";
            // End:0xEE51
            break;
        // End:0x342A
        case 14976:
            param = "1,3,1,Slow,3";
            // End:0xEE51
            break;
        // End:0x3449
        case 14977:
            param = "1,3,1,Stun,3";
            // End:0xEE51
            break;
        // End:0x346C
        case 14978:
            param = "1,3,1,Ae Stone,3";
            // End:0xEE51
            break;
        // End:0x3494
        case 14979:
            param = "1,3,1,Ae Prominence,3";
            // End:0xEE51
            break;
        // End:0x34BD
        case 14980:
            param = "1,3,1,Ae Solar Flare,3";
            // End:0xEE51
            break;
        // End:0x34E5
        case 14981:
            param = "1,3,1,Ae Aura Flare,3";
            // End:0xEE51
            break;
        // End:0x350F
        case 14982:
            param = "1,3,1,Ae Shadow Flare,3";
            // End:0xEE51
            break;
        // End:0x3538
        case 14983:
            param = "1,3,1,Ae Hydro Blast,3";
            // End:0xEE51
            break;
        // End:0x355F
        case 14984:
            param = "1,3,1,Ae Hurricane,3";
            // End:0xEE51
            break;
        // End:0x357F
        case 14985:
            param = "1,3,1,Trick,3";
            // End:0xEE51
            break;
        // End:0x35A0
        case 14986:
            param = "1,3,1,Medusa,3";
            // End:0xEE51
            break;
        // End:0x35C7
        case 14987:
            param = "1,3,1,Shadow Flare,3";
            // End:0xEE51
            break;
        // End:0x35E8
        case 14988:
            param = "1,3,1,Unlock,3";
            // End:0xEE51
            break;
        // End:0x3611
        case 14989:
            param = "1,3,1,Vampiric Touch,3";
            // End:0xEE51
            break;
        // End:0x3637
        case 14990:
            param = "1,3,1,Hydro Blast,3";
            // End:0xEE51
            break;
        // End:0x365B
        case 14991:
            param = "1,3,1,Hurricane,3";
            // End:0xEE51
            break;
        // End:0x3685
        case 14992:
            param = "1,3,3,Physical Winter,3";
            // End:0xEE51
            break;
        // End:0x36AE
        case 14993:
            param = "1,3,3,Physical Bleed,3";
            // End:0xEE51
            break;
        // End:0x36D6
        case 14994:
            param = "1,3,3,Physical Fear,3";
            // End:0xEE51
            break;
        // End:0x36FE
        case 14995:
            param = "1,3,3,Physical Hold,3";
            // End:0xEE51
            break;
        // End:0x3728
        case 14996:
            param = "1,3,3,Physical Poison,3";
            // End:0xEE51
            break;
        // End:0x3752
        case 14997:
            param = "1,3,3,Physical Medusa,3";
            // End:0xEE51
            break;
        // End:0x377C
        case 14998:
            param = "1,3,3,Critical Winter,3";
            // End:0xEE51
            break;
        // End:0x37A5
        case 14999:
            param = "1,3,3,Critical Bleed,3";
            // End:0xEE51
            break;
        // End:0x37CD
        case 15000:
            param = "1,3,3,Critical Fear,3";
            // End:0xEE51
            break;
        // End:0x37F5
        case 15001:
            param = "1,3,3,Critical Hold,3";
            // End:0xEE51
            break;
        // End:0x381F
        case 15002:
            param = "1,3,3,Critical Poison,3";
            // End:0xEE51
            break;
        // End:0x3849
        case 15003:
            param = "1,3,3,Critical Medusa,3";
            // End:0xEE51
            break;
        // End:0x386A
        case 15004:
            param = "1,3,3,Winter,3";
            // End:0xEE51
            break;
        // End:0x388C
        case 15005:
            param = "1,3,3,Agility,3";
            // End:0xEE51
            break;
        // End:0x38AC
        case 15006:
            param = "1,3,3,Bleed,3";
            // End:0xEE51
            break;
        // End:0x38CD
        case 15007:
            param = "1,3,3,Ritual,3";
            // End:0xEE51
            break;
        // End:0x38ED
        case 15008:
            param = "1,3,3,Focus,3";
            // End:0xEE51
            break;
        // End:0x390D
        case 15009:
            param = "1,3,3,Charm,3";
            // End:0xEE51
            break;
        // End:0x3930
        case 15010:
            param = "1,3,3,Guidance,3";
            // End:0xEE51
            break;
        // End:0x394F
        case 15011:
            param = "1,3,3,Hold,3";
            // End:0xEE51
            break;
        // End:0x3970
        case 15012:
            param = "1,3,3,Prayer,3";
            // End:0xEE51
            break;
        // End:0x398F
        case 15013:
            param = "1,3,3,Heal,3";
            // End:0xEE51
            break;
        // End:0x39B1
        case 15014:
            param = "1,3,3,Empower,3";
            // End:0xEE51
            break;
        // End:0x39D6
        case 15015:
            param = "1,3,3,Wild Magic,3";
            // End:0xEE51
            break;
        // End:0x39F6
        case 15016:
            param = "1,3,3,Cheer,3";
            // End:0xEE51
            break;
        // End:0x3A1D
        case 15017:
            param = "1,3,3,Blessed Body,3";
            // End:0xEE51
            break;
        // End:0x3A44
        case 15018:
            param = "1,3,3,Blessed Soul,3";
            // End:0xEE51
            break;
        // End:0x3A6C
        case 15019:
            param = "1,3,3,Magic Barrier,3";
            // End:0xEE51
            break;
        // End:0x3A8C
        case 15020:
            param = "1,3,3,Might,3";
            // End:0xEE51
            break;
        // End:0x3AAD
        case 15021:
            param = "1,3,3,Shield,3";
            // End:0xEE51
            break;
        // End:0x3ACE
        case 15022:
            param = "1,3,3,Poison,3";
            // End:0xEE51
            break;
        // End:0x3AF6
        case 15023:
            param = "1,3,3,Duel Weakness,3";
            // End:0xEE51
            break;
        // End:0x3B1B
        case 15024:
            param = "1,3,3,Duel Might,3";
            // End:0xEE51
            break;
        // End:0x3B3B
        case 15025:
            param = "1,3,3,Sleep,3";
            // End:0xEE51
            break;
        // End:0x3B5A
        case 15026:
            param = "1,3,3,Slow,3";
            // End:0xEE51
            break;
        // End:0x3B83
        case 15027:
            param = "1,3,3,Magical Winter,3";
            // End:0xEE51
            break;
        // End:0x3BAB
        case 15028:
            param = "1,3,3,Magical Bleed,3";
            // End:0xEE51
            break;
        // End:0x3BD2
        case 15029:
            param = "1,3,3,Magical Fear,3";
            // End:0xEE51
            break;
        // End:0x3BF9
        case 15030:
            param = "1,3,3,Magical Hold,3";
            // End:0xEE51
            break;
        // End:0x3C22
        case 15031:
            param = "1,3,3,Magical Poison,3";
            // End:0xEE51
            break;
        // End:0x3C4B
        case 15032:
            param = "1,3,3,Magical Medusa,3";
            // End:0xEE51
            break;
        // End:0x3C72
        case 15033:
            param = "1,3,2,Heal Empower,3";
            // End:0xEE51
            break;
        // End:0x3C93
        case 15034:
            param = "1,3,2,Prayer,3";
            // End:0xEE51
            break;
        // End:0x3CB5
        case 15035:
            param = "1,3,2,Empower,3";
            // End:0xEE51
            break;
        // End:0x3CDD
        case 15036:
            param = "1,3,2,Magic Barrier,3";
            // End:0xEE51
            break;
        // End:0x3CFD
        case 15037:
            param = "1,3,2,Might,3";
            // End:0xEE51
            break;
        // End:0x3D1E
        case 15038:
            param = "1,3,2,Shield,3";
            // End:0xEE51
            break;
        // End:0x3D43
        case 15039:
            param = "1,3,2,Duel Might,3";
            // End:0xEE51
            break;
        // End:0x3D6A
        case 15040:
            param = "1,3,2,Weight Limit,3";
            // End:0xEE51
            break;
        // End:0x3D8A
        case 15041:
            param = "1,4,1,Focus,3";
            // End:0xEE51
            break;
        // End:0x3DAA
        case 15042:
            param = "1,4,1,Focus,3";
            // End:0xEE51
            break;
        // End:0x3DCA
        case 15043:
            param = "1,4,1,Focus,3";
            // End:0xEE51
            break;
        // End:0x3DEA
        case 15044:
            param = "1,4,1,Focus,3";
            // End:0xEE51
            break;
        // End:0x3E09
        case 15045:
            param = "1,4,1,Doom,3";
            // End:0xEE51
            break;
        // End:0x3E2A
        case 15046:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0x3E55
        case 15047:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0x3E7A
        case 15048:
            param = "1,4,1,Wild Magic,3";
            // End:0xEE51
            break;
        // End:0x3EA1
        case 15049:
            param = "1,4,1,Party Recall,1";
            // End:0xEE51
            break;
        // End:0x3EC3
        case 15050:
            param = "1,4,1,Silence,3";
            // End:0xEE51
            break;
        // End:0x3EEA
        case 15051:
            param = "1,4,1,Party Recall,1";
            // End:0xEE51
            break;
        // End:0x3F11
        case 15052:
            param = "1,4,1,Party Recall,1";
            // End:0xEE51
            break;
        // End:0x3F38
        case 15053:
            param = "1,4,1,Party Recall,1";
            // End:0xEE51
            break;
        // End:0x3F5A
        case 15054:
            param = "1,4,1,Silence,3";
            // End:0xEE51
            break;
        // End:0x3F7C
        case 15055:
            param = "1,4,1,Silence,3";
            // End:0xEE51
            break;
        // End:0x3F9E
        case 15056:
            param = "1,4,1,Silence,3";
            // End:0xEE51
            break;
        // End:0x3FC0
        case 15057:
            param = "1,4,1,Silence,3";
            // End:0xEE51
            break;
        // End:0x3FE8
        case 15058:
            param = "1,4,1,Vampiric Rage,3";
            // End:0xEE51
            break;
        // End:0x4010
        case 15059:
            param = "1,4,3,Physical Doom,3";
            // End:0xEE51
            break;
        // End:0x403D
        case 15060:
            param = "1,4,3,Physical Mana Burn,3";
            // End:0xEE51
            break;
        // End:0x4069
        case 15061:
            param = "1,4,3,Physical Paralyze,3";
            // End:0xEE51
            break;
        // End:0x4094
        case 15062:
            param = "1,4,3,Physical Silence,3";
            // End:0xEE51
            break;
        // End:0x40BD
        case 15063:
            param = "1,4,3,Physical Sleep,3";
            // End:0xEE51
            break;
        // End:0x40E5
        case 15064:
            param = "1,4,3,Physical Stun,3";
            // End:0xEE51
            break;
        // End:0x410D
        case 15065:
            param = "1,4,3,Critical Doom,3";
            // End:0xEE51
            break;
        // End:0x413A
        case 15066:
            param = "1,4,3,Critical Mana Burn,3";
            // End:0xEE51
            break;
        // End:0x4166
        case 15067:
            param = "1,4,3,Critical Paralyze,3";
            // End:0xEE51
            break;
        // End:0x4191
        case 15068:
            param = "1,4,3,Critical Silence,3";
            // End:0xEE51
            break;
        // End:0x41BA
        case 15069:
            param = "1,4,3,Critical Sleep,3";
            // End:0xEE51
            break;
        // End:0x41E2
        case 15070:
            param = "1,4,3,Critical Stun,3";
            // End:0xEE51
            break;
        // End:0x4201
        case 15071:
            param = "1,4,3,Doom,3";
            // End:0xEE51
            break;
        // End:0x4220
        case 15072:
            param = "1,4,3,Fear,3";
            // End:0xEE51
            break;
        // End:0x4244
        case 15073:
            param = "1,4,3,Mana Gain,3";
            // End:0xEE51
            break;
        // End:0x4267
        case 15074:
            param = "1,4,3,Recharge,3";
            // End:0xEE51
            break;
        // End:0x428A
        case 15075:
            param = "1,4,3,Paralyze,3";
            // End:0xEE51
            break;
        // End:0x42AC
        case 15076:
            param = "1,4,3,Silence,3";
            // End:0xEE51
            break;
        // End:0x42CB
        case 15077:
            param = "1,4,3,Stun,3";
            // End:0xEE51
            break;
        // End:0x42EC
        case 15078:
            param = "1,4,3,Medusa,3";
            // End:0xEE51
            break;
        // End:0x4313
        case 15079:
            param = "1,4,3,Magical Doom,3";
            // End:0xEE51
            break;
        // End:0x433F
        case 15080:
            param = "1,4,3,Magical Mana Burn,3";
            // End:0xEE51
            break;
        // End:0x436A
        case 15081:
            param = "1,4,3,Magical Paralyze,3";
            // End:0xEE51
            break;
        // End:0x4394
        case 15082:
            param = "1,4,3,Magical Silence,3";
            // End:0xEE51
            break;
        // End:0x43BC
        case 15083:
            param = "1,4,3,Magical Sleep,3";
            // End:0xEE51
            break;
        // End:0x43E3
        case 15084:
            param = "1,4,3,Magical Stun,3";
            // End:0xEE51
            break;
        // End:0x4405
        case 15085:
            param = "1,4,2,Agility,3";
            // End:0xEE51
            break;
        // End:0x4427
        case 15086:
            param = "1,4,2,Agility,3";
            // End:0xEE51
            break;
        // End:0x4447
        case 15087:
            param = "1,4,2,Focus,3";
            // End:0xEE51
            break;
        // End:0x4467
        case 15088:
            param = "1,4,2,Focus,3";
            // End:0xEE51
            break;
        // End:0x448A
        case 15089:
            param = "1,4,2,Guidance,3";
            // End:0xEE51
            break;
        // End:0x44AF
        case 15090:
            param = "1,4,2,Wild Magic,3";
            // End:0xEE51
            break;
        // End:0x44D3
        case 15091:
            param = "1,4,2,Mana Gain,3";
            // End:0xEE51
            break;
        // End:0x44F7
        case 15092:
            param = "1,4,2,Mana Gain,3";
            // End:0xEE51
            break;
        // End:0x451B
        case 15093:
            param = "1,4,2,Mana Gain,3";
            // End:0xEE51
            break;
        // End:0x453F
        case 15094:
            param = "1,4,2,Mana Gain,3";
            // End:0xEE51
            break;
        // End:0x4560
        case 15112:
            param = "1,3,1,Winter,4";
            // End:0xEE51
            break;
        // End:0x4582
        case 15113:
            param = "1,3,1,Agility,4";
            // End:0xEE51
            break;
        // End:0x45A2
        case 15114:
            param = "1,3,1,Bleed,4";
            // End:0xEE51
            break;
        // End:0x45C3
        case 15115:
            param = "1,3,1,Ritual,4";
            // End:0xEE51
            break;
        // End:0x45E3
        case 15116:
            param = "1,3,1,Stone,4";
            // End:0xEE51
            break;
        // End:0x4602
        case 15117:
            param = "1,3,1,Fear,4";
            // End:0xEE51
            break;
        // End:0x4627
        case 15118:
            param = "1,3,1,Prominence,4";
            // End:0xEE51
            break;
        // End:0x4647
        case 15119:
            param = "1,3,1,Peace,4";
            // End:0xEE51
            break;
        // End:0x4667
        case 15120:
            param = "1,3,1,Charm,4";
            // End:0xEE51
            break;
        // End:0x468C
        case 15121:
            param = "1,3,1,Aggression,4";
            // End:0xEE51
            break;
        // End:0x46AF
        case 15122:
            param = "1,3,1,Guidance,4";
            // End:0xEE51
            break;
        // End:0x46CE
        case 15123:
            param = "1,3,1,Hold,4";
            // End:0xEE51
            break;
        // End:0x46F4
        case 15124:
            param = "1,3,1,Solar Flare,4";
            // End:0xEE51
            break;
        // End:0x471B
        case 15125:
            param = "1,3,1,Heal Empower,4";
            // End:0xEE51
            break;
        // End:0x473C
        case 15126:
            param = "1,3,1,Prayer,4";
            // End:0xEE51
            break;
        // End:0x475B
        case 15127:
            param = "1,3,1,Heal,4";
            // End:0xEE51
            break;
        // End:0x477D
        case 15128:
            param = "1,3,1,Empower,4";
            // End:0xEE51
            break;
        // End:0x479D
        case 15129:
            param = "1,3,1,Cheer,4";
            // End:0xEE51
            break;
        // End:0x47C3
        case 15130:
            param = "1,3,1,Battle Roar,4";
            // End:0xEE51
            break;
        // End:0x47EA
        case 15131:
            param = "1,3,1,Blessed Body,4";
            // End:0xEE51
            break;
        // End:0x4811
        case 15132:
            param = "1,3,1,Blessed Soul,4";
            // End:0xEE51
            break;
        // End:0x4839
        case 15133:
            param = "1,3,1,Magic Barrier,4";
            // End:0xEE51
            break;
        // End:0x485D
        case 15134:
            param = "1,3,1,Mana Burn,4";
            // End:0xEE51
            break;
        // End:0x4881
        case 15135:
            param = "1,3,1,Mana Gain,4";
            // End:0xEE51
            break;
        // End:0x48A4
        case 15136:
            param = "1,3,1,Recharge,4";
            // End:0xEE51
            break;
        // End:0x48C9
        case 15137:
            param = "1,3,1,Aura Flare,4";
            // End:0xEE51
            break;
        // End:0x48E9
        case 15138:
            param = "1,3,1,Might,4";
            // End:0xEE51
            break;
        // End:0x490C
        case 15139:
            param = "1,3,1,Paralyze,4";
            // End:0xEE51
            break;
        // End:0x492D
        case 15140:
            param = "1,3,1,Shield,4";
            // End:0xEE51
            break;
        // End:0x494E
        case 15141:
            param = "1,3,1,Poison,4";
            // End:0xEE51
            break;
        // End:0x4976
        case 15142:
            param = "1,3,1,Duel Weakness,4";
            // End:0xEE51
            break;
        // End:0x499B
        case 15143:
            param = "1,3,1,Duel Might,4";
            // End:0xEE51
            break;
        // End:0x49BC
        case 15144:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0x49E3
        case 15145:
            param = "1,3,1,Resurrection,4";
            // End:0xEE51
            break;
        // End:0x4A08
        case 15146:
            param = "1,3,1,Self Stone,4";
            // End:0xEE51
            break;
        // End:0x4A32
        case 15147:
            param = "1,3,1,Self Prominence,4";
            // End:0xEE51
            break;
        // End:0x4A5D
        case 15148:
            param = "1,3,1,Self Solar Flare,4";
            // End:0xEE51
            break;
        // End:0x4A87
        case 15149:
            param = "1,3,1,Self Aura Flare,4";
            // End:0xEE51
            break;
        // End:0x4AB3
        case 15150:
            param = "1,3,1,Self Shadow Flare,4";
            // End:0xEE51
            break;
        // End:0x4ADE
        case 15151:
            param = "1,3,1,Self Hydro Blast,4";
            // End:0xEE51
            break;
        // End:0x4B07
        case 15152:
            param = "1,3,1,Self Hurricane,4";
            // End:0xEE51
            break;
        // End:0x4B27
        case 15153:
            param = "1,3,1,Sleep,4";
            // End:0xEE51
            break;
        // End:0x4B46
        case 15154:
            param = "1,3,1,Slow,4";
            // End:0xEE51
            break;
        // End:0x4B65
        case 15155:
            param = "1,3,1,Stun,4";
            // End:0xEE51
            break;
        // End:0x4B88
        case 15156:
            param = "1,3,1,Ae Stone,4";
            // End:0xEE51
            break;
        // End:0x4BB0
        case 15157:
            param = "1,3,1,Ae Prominence,4";
            // End:0xEE51
            break;
        // End:0x4BD9
        case 15158:
            param = "1,3,1,Ae Solar Flare,4";
            // End:0xEE51
            break;
        // End:0x4C01
        case 15159:
            param = "1,3,1,Ae Aura Flare,4";
            // End:0xEE51
            break;
        // End:0x4C2B
        case 15160:
            param = "1,3,1,Ae Shadow Flare,4";
            // End:0xEE51
            break;
        // End:0x4C54
        case 15161:
            param = "1,3,1,Ae Hydro Blast,4";
            // End:0xEE51
            break;
        // End:0x4C7B
        case 15162:
            param = "1,3,1,Ae Hurricane,4";
            // End:0xEE51
            break;
        // End:0x4C9B
        case 15163:
            param = "1,3,1,Trick,4";
            // End:0xEE51
            break;
        // End:0x4CBC
        case 15164:
            param = "1,3,1,Medusa,4";
            // End:0xEE51
            break;
        // End:0x4CE3
        case 15165:
            param = "1,3,1,Shadow Flare,4";
            // End:0xEE51
            break;
        // End:0x4D04
        case 15166:
            param = "1,3,1,Unlock,4";
            // End:0xEE51
            break;
        // End:0x4D2D
        case 15167:
            param = "1,3,1,Vampiric Touch,4";
            // End:0xEE51
            break;
        // End:0x4D53
        case 15168:
            param = "1,3,1,Hydro Blast,4";
            // End:0xEE51
            break;
        // End:0x4D77
        case 15169:
            param = "1,3,1,Hurricane,4";
            // End:0xEE51
            break;
        // End:0x4DA1
        case 15170:
            param = "1,3,3,Physical Winter,4";
            // End:0xEE51
            break;
        // End:0x4DCA
        case 15171:
            param = "1,3,3,Physical Bleed,4";
            // End:0xEE51
            break;
        // End:0x4DF2
        case 15172:
            param = "1,3,3,Physical Fear,4";
            // End:0xEE51
            break;
        // End:0x4E1A
        case 15173:
            param = "1,3,3,Physical Hold,4";
            // End:0xEE51
            break;
        // End:0x4E44
        case 15174:
            param = "1,3,3,Physical Poison,4";
            // End:0xEE51
            break;
        // End:0x4E6E
        case 15175:
            param = "1,3,3,Physical Medusa,4";
            // End:0xEE51
            break;
        // End:0x4E98
        case 15176:
            param = "1,3,3,Critical Winter,4";
            // End:0xEE51
            break;
        // End:0x4EC1
        case 15177:
            param = "1,3,3,Critical Bleed,4";
            // End:0xEE51
            break;
        // End:0x4EE9
        case 15178:
            param = "1,3,3,Critical Fear,4";
            // End:0xEE51
            break;
        // End:0x4F11
        case 15179:
            param = "1,3,3,Critical Hold,4";
            // End:0xEE51
            break;
        // End:0x4F3B
        case 15180:
            param = "1,3,3,Critical Poison,4";
            // End:0xEE51
            break;
        // End:0x4F65
        case 15181:
            param = "1,3,3,Critical Medusa,4";
            // End:0xEE51
            break;
        // End:0x4F86
        case 15182:
            param = "1,3,3,Winter,4";
            // End:0xEE51
            break;
        // End:0x4FA8
        case 15183:
            param = "1,3,3,Agility,4";
            // End:0xEE51
            break;
        // End:0x4FC8
        case 15184:
            param = "1,3,3,Bleed,4";
            // End:0xEE51
            break;
        // End:0x4FE9
        case 15185:
            param = "1,3,3,Ritual,4";
            // End:0xEE51
            break;
        // End:0x5009
        case 15186:
            param = "1,3,3,Focus,4";
            // End:0xEE51
            break;
        // End:0x5029
        case 15187:
            param = "1,3,3,Charm,4";
            // End:0xEE51
            break;
        // End:0x504C
        case 15188:
            param = "1,3,3,Guidance,4";
            // End:0xEE51
            break;
        // End:0x506B
        case 15189:
            param = "1,3,3,Hold,4";
            // End:0xEE51
            break;
        // End:0x508C
        case 15190:
            param = "1,3,3,Prayer,4";
            // End:0xEE51
            break;
        // End:0x50AB
        case 15191:
            param = "1,3,3,Heal,4";
            // End:0xEE51
            break;
        // End:0x50CD
        case 15192:
            param = "1,3,3,Empower,4";
            // End:0xEE51
            break;
        // End:0x50F2
        case 15193:
            param = "1,3,3,Wild Magic,4";
            // End:0xEE51
            break;
        // End:0x5112
        case 15194:
            param = "1,3,3,Cheer,4";
            // End:0xEE51
            break;
        // End:0x5139
        case 15195:
            param = "1,3,3,Blessed Body,4";
            // End:0xEE51
            break;
        // End:0x5160
        case 15196:
            param = "1,3,3,Blessed Soul,4";
            // End:0xEE51
            break;
        // End:0x5188
        case 15197:
            param = "1,3,3,Magic Barrier,4";
            // End:0xEE51
            break;
        // End:0x51A8
        case 15198:
            param = "1,3,3,Might,4";
            // End:0xEE51
            break;
        // End:0x51C9
        case 15199:
            param = "1,3,3,Shield,4";
            // End:0xEE51
            break;
        // End:0x51EA
        case 15200:
            param = "1,3,3,Poison,4";
            // End:0xEE51
            break;
        // End:0x5212
        case 15201:
            param = "1,3,3,Duel Weakness,4";
            // End:0xEE51
            break;
        // End:0x5237
        case 15202:
            param = "1,3,3,Duel Might,4";
            // End:0xEE51
            break;
        // End:0x5257
        case 15203:
            param = "1,3,3,Sleep,4";
            // End:0xEE51
            break;
        // End:0x5276
        case 15204:
            param = "1,3,3,Slow,4";
            // End:0xEE51
            break;
        // End:0x529F
        case 15205:
            param = "1,3,3,Magical Winter,4";
            // End:0xEE51
            break;
        // End:0x52C7
        case 15206:
            param = "1,3,3,Magical Bleed,4";
            // End:0xEE51
            break;
        // End:0x52EE
        case 15207:
            param = "1,3,3,Magical Fear,4";
            // End:0xEE51
            break;
        // End:0x5315
        case 15208:
            param = "1,3,3,Magical Hold,4";
            // End:0xEE51
            break;
        // End:0x533E
        case 15209:
            param = "1,3,3,Magical Poison,4";
            // End:0xEE51
            break;
        // End:0x5367
        case 15210:
            param = "1,3,3,Magical Medusa,4";
            // End:0xEE51
            break;
        // End:0x538E
        case 15211:
            param = "1,3,2,Heal Empower,4";
            // End:0xEE51
            break;
        // End:0x53AF
        case 15212:
            param = "1,3,2,Prayer,4";
            // End:0xEE51
            break;
        // End:0x53D1
        case 15213:
            param = "1,3,2,Empower,4";
            // End:0xEE51
            break;
        // End:0x53F9
        case 15214:
            param = "1,3,2,Magic Barrier,4";
            // End:0xEE51
            break;
        // End:0x5419
        case 15215:
            param = "1,3,2,Might,4";
            // End:0xEE51
            break;
        // End:0x543A
        case 15216:
            param = "1,3,2,Shield,4";
            // End:0xEE51
            break;
        // End:0x545F
        case 15217:
            param = "1,3,2,Duel Might,4";
            // End:0xEE51
            break;
        // End:0x5486
        case 15218:
            param = "1,3,2,Weight Limit,4";
            // End:0xEE51
            break;
        // End:0x54A8
        case 15219:
            param = "1,4,1,Refresh,1";
            // End:0xEE51
            break;
        // End:0x54CA
        case 15220:
            param = "1,4,1,Clarity,1";
            // End:0xEE51
            break;
        // End:0x54EA
        case 15221:
            param = "1,4,1,Focus,4";
            // End:0xEE51
            break;
        // End:0x5513
        case 15222:
            param = "1,4,1,Reflect Damage,1";
            // End:0xEE51
            break;
        // End:0x5532
        case 15223:
            param = "1,4,1,Doom,4";
            // End:0xEE51
            break;
        // End:0x5553
        case 15224:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0x557E
        case 15225:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0x55A3
        case 15226:
            param = "1,4,1,Wild Magic,4";
            // End:0xEE51
            break;
        // End:0x55CA
        case 15227:
            param = "1,4,1,Party Recall,1";
            // End:0xEE51
            break;
        // End:0x55EC
        case 15228:
            param = "1,4,1,Silence,4";
            // End:0xEE51
            break;
        // End:0x5614
        case 15229:
            param = "1,4,1,Skill Refresh,1";
            // End:0xEE51
            break;
        // End:0x563C
        case 15230:
            param = "1,4,1,Skill Clarity,1";
            // End:0xEE51
            break;
        // End:0x5664
        case 15231:
            param = "1,4,1,Music Refresh,1";
            // End:0xEE51
            break;
        // End:0x568C
        case 15232:
            param = "1,4,1,Music Clarity,1";
            // End:0xEE51
            break;
        // End:0x56B4
        case 15233:
            param = "1,4,1,Spell Refresh,1";
            // End:0xEE51
            break;
        // End:0x56DC
        case 15234:
            param = "1,4,1,Spell Clarity,1";
            // End:0xEE51
            break;
        // End:0x5704
        case 15235:
            param = "1,4,1,Spell Clarity,1";
            // End:0xEE51
            break;
        // End:0x572C
        case 15236:
            param = "1,4,1,Vampiric Rage,4";
            // End:0xEE51
            break;
        // End:0x5754
        case 15237:
            param = "1,4,3,Physical Doom,4";
            // End:0xEE51
            break;
        // End:0x5781
        case 15238:
            param = "1,4,3,Physical Mana Burn,4";
            // End:0xEE51
            break;
        // End:0x57AD
        case 15239:
            param = "1,4,3,Physical Paralyze,4";
            // End:0xEE51
            break;
        // End:0x57D8
        case 15240:
            param = "1,4,3,Physical Silence,4";
            // End:0xEE51
            break;
        // End:0x5801
        case 15241:
            param = "1,4,3,Physical Sleep,4";
            // End:0xEE51
            break;
        // End:0x5829
        case 15242:
            param = "1,4,3,Physical Stun,4";
            // End:0xEE51
            break;
        // End:0x5851
        case 15243:
            param = "1,4,3,Critical Doom,4";
            // End:0xEE51
            break;
        // End:0x587E
        case 15244:
            param = "1,4,3,Critical Mana Burn,4";
            // End:0xEE51
            break;
        // End:0x58AA
        case 15245:
            param = "1,4,3,Critical Paralyze,4";
            // End:0xEE51
            break;
        // End:0x58D5
        case 15246:
            param = "1,4,3,Critical Silence,4";
            // End:0xEE51
            break;
        // End:0x58FE
        case 15247:
            param = "1,4,3,Critical Sleep,4";
            // End:0xEE51
            break;
        // End:0x5926
        case 15248:
            param = "1,4,3,Critical Stun,4";
            // End:0xEE51
            break;
        // End:0x5945
        case 15249:
            param = "1,4,3,Doom,4";
            // End:0xEE51
            break;
        // End:0x5964
        case 15250:
            param = "1,4,3,Fear,4";
            // End:0xEE51
            break;
        // End:0x5988
        case 15251:
            param = "1,4,3,Mana Gain,4";
            // End:0xEE51
            break;
        // End:0x59AB
        case 15252:
            param = "1,4,3,Recharge,4";
            // End:0xEE51
            break;
        // End:0x59CE
        case 15253:
            param = "1,4,3,Paralyze,4";
            // End:0xEE51
            break;
        // End:0x59F0
        case 15254:
            param = "1,4,3,Silence,4";
            // End:0xEE51
            break;
        // End:0x5A0F
        case 15255:
            param = "1,4,3,Stun,4";
            // End:0xEE51
            break;
        // End:0x5A30
        case 15256:
            param = "1,4,3,Medusa,4";
            // End:0xEE51
            break;
        // End:0x5A57
        case 15257:
            param = "1,4,3,Magical Doom,4";
            // End:0xEE51
            break;
        // End:0x5A83
        case 15258:
            param = "1,4,3,Magical Mana Burn,4";
            // End:0xEE51
            break;
        // End:0x5AAE
        case 15259:
            param = "1,4,3,Magical Paralyze,4";
            // End:0xEE51
            break;
        // End:0x5AD8
        case 15260:
            param = "1,4,3,Magical Silence,4";
            // End:0xEE51
            break;
        // End:0x5B00
        case 15261:
            param = "1,4,3,Magical Sleep,4";
            // End:0xEE51
            break;
        // End:0x5B27
        case 15262:
            param = "1,4,3,Magical Stun,4";
            // End:0xEE51
            break;
        // End:0x5B49
        case 15263:
            param = "1,4,2,Clarity,1";
            // End:0xEE51
            break;
        // End:0x5B6B
        case 15264:
            param = "1,4,2,Agility,4";
            // End:0xEE51
            break;
        // End:0x5B8B
        case 15265:
            param = "1,4,2,Focus,4";
            // End:0xEE51
            break;
        // End:0x5BB4
        case 15266:
            param = "1,4,2,Reflect Damage,1";
            // End:0xEE51
            break;
        // End:0x5BD7
        case 15267:
            param = "1,4,2,Guidance,4";
            // End:0xEE51
            break;
        // End:0x5BFC
        case 15268:
            param = "1,4,2,Wild Magic,4";
            // End:0xEE51
            break;
        // End:0x5C20
        case 15269:
            param = "1,4,2,Mana Gain,4";
            // End:0xEE51
            break;
        // End:0x5C48
        case 15270:
            param = "1,4,2,Skill Clarity,1";
            // End:0xEE51
            break;
        // End:0x5C70
        case 15271:
            param = "1,4,2,Music Clarity,1";
            // End:0xEE51
            break;
        // End:0x5C98
        case 15272:
            param = "1,4,2,Spell Clarity,1";
            // End:0xEE51
            break;
        // End:0x5CB9
        case 15290:
            param = "1,3,1,Winter,5";
            // End:0xEE51
            break;
        // End:0x5CDB
        case 15291:
            param = "1,3,1,Agility,5";
            // End:0xEE51
            break;
        // End:0x5CFB
        case 15292:
            param = "1,3,1,Bleed,5";
            // End:0xEE51
            break;
        // End:0x5D1C
        case 15293:
            param = "1,3,1,Ritual,5";
            // End:0xEE51
            break;
        // End:0x5D3C
        case 15294:
            param = "1,3,1,Stone,5";
            // End:0xEE51
            break;
        // End:0x5D5B
        case 15295:
            param = "1,3,1,Fear,5";
            // End:0xEE51
            break;
        // End:0x5D80
        case 15296:
            param = "1,3,1,Prominence,5";
            // End:0xEE51
            break;
        // End:0x5DA0
        case 15297:
            param = "1,3,1,Peace,5";
            // End:0xEE51
            break;
        // End:0x5DC0
        case 15298:
            param = "1,3,1,Charm,5";
            // End:0xEE51
            break;
        // End:0x5DE5
        case 15299:
            param = "1,3,1,Aggression,5";
            // End:0xEE51
            break;
        // End:0x5E08
        case 15300:
            param = "1,3,1,Guidance,5";
            // End:0xEE51
            break;
        // End:0x5E27
        case 15301:
            param = "1,3,1,Hold,5";
            // End:0xEE51
            break;
        // End:0x5E4D
        case 15302:
            param = "1,3,1,Solar Flare,5";
            // End:0xEE51
            break;
        // End:0x5E74
        case 15303:
            param = "1,3,1,Heal Empower,5";
            // End:0xEE51
            break;
        // End:0x5E95
        case 15304:
            param = "1,3,1,Prayer,5";
            // End:0xEE51
            break;
        // End:0x5EB4
        case 15305:
            param = "1,3,1,Heal,5";
            // End:0xEE51
            break;
        // End:0x5ED6
        case 15306:
            param = "1,3,1,Empower,5";
            // End:0xEE51
            break;
        // End:0x5EF6
        case 15307:
            param = "1,3,1,Cheer,5";
            // End:0xEE51
            break;
        // End:0x5F1C
        case 15308:
            param = "1,3,1,Battle Roar,5";
            // End:0xEE51
            break;
        // End:0x5F43
        case 15309:
            param = "1,3,1,Blessed Body,5";
            // End:0xEE51
            break;
        // End:0x5F6A
        case 15310:
            param = "1,3,1,Blessed Soul,5";
            // End:0xEE51
            break;
        // End:0x5F92
        case 15311:
            param = "1,3,1,Magic Barrier,5";
            // End:0xEE51
            break;
        // End:0x5FB6
        case 15312:
            param = "1,3,1,Mana Burn,5";
            // End:0xEE51
            break;
        // End:0x5FDA
        case 15313:
            param = "1,3,1,Mana Gain,5";
            // End:0xEE51
            break;
        // End:0x5FFD
        case 15314:
            param = "1,3,1,Recharge,5";
            // End:0xEE51
            break;
        // End:0x6022
        case 15315:
            param = "1,3,1,Aura Flare,5";
            // End:0xEE51
            break;
        // End:0x6042
        case 15316:
            param = "1,3,1,Might,5";
            // End:0xEE51
            break;
        // End:0x6065
        case 15317:
            param = "1,3,1,Paralyze,5";
            // End:0xEE51
            break;
        // End:0x6086
        case 15318:
            param = "1,3,1,Shield,5";
            // End:0xEE51
            break;
        // End:0x60A7
        case 15319:
            param = "1,3,1,Poison,5";
            // End:0xEE51
            break;
        // End:0x60CF
        case 15320:
            param = "1,3,1,Duel Weakness,5";
            // End:0xEE51
            break;
        // End:0x60F4
        case 15321:
            param = "1,3,1,Duel Might,5";
            // End:0xEE51
            break;
        // End:0x6115
        case 15322:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0x613C
        case 15323:
            param = "1,3,1,Resurrection,5";
            // End:0xEE51
            break;
        // End:0x6161
        case 15324:
            param = "1,3,1,Self Stone,5";
            // End:0xEE51
            break;
        // End:0x618B
        case 15325:
            param = "1,3,1,Self Prominence,5";
            // End:0xEE51
            break;
        // End:0x61B6
        case 15326:
            param = "1,3,1,Self Solar Flare,5";
            // End:0xEE51
            break;
        // End:0x61E0
        case 15327:
            param = "1,3,1,Self Aura Flare,5";
            // End:0xEE51
            break;
        // End:0x620C
        case 15328:
            param = "1,3,1,Self Shadow Flare,5";
            // End:0xEE51
            break;
        // End:0x6237
        case 15329:
            param = "1,3,1,Self Hydro Blast,5";
            // End:0xEE51
            break;
        // End:0x6260
        case 15330:
            param = "1,3,1,Self Hurricane,5";
            // End:0xEE51
            break;
        // End:0x6280
        case 15331:
            param = "1,3,1,Sleep,5";
            // End:0xEE51
            break;
        // End:0x629F
        case 15332:
            param = "1,3,1,Slow,5";
            // End:0xEE51
            break;
        // End:0x62BE
        case 15333:
            param = "1,3,1,Stun,5";
            // End:0xEE51
            break;
        // End:0x62E1
        case 15334:
            param = "1,3,1,Ae Stone,5";
            // End:0xEE51
            break;
        // End:0x6309
        case 15335:
            param = "1,3,1,Ae Prominence,5";
            // End:0xEE51
            break;
        // End:0x6332
        case 15336:
            param = "1,3,1,Ae Solar Flare,5";
            // End:0xEE51
            break;
        // End:0x635A
        case 15337:
            param = "1,3,1,Ae Aura Flare,5";
            // End:0xEE51
            break;
        // End:0x6384
        case 15338:
            param = "1,3,1,Ae Shadow Flare,5";
            // End:0xEE51
            break;
        // End:0x63AD
        case 15339:
            param = "1,3,1,Ae Hydro Blast,5";
            // End:0xEE51
            break;
        // End:0x63D4
        case 15340:
            param = "1,3,1,Ae Hurricane,5";
            // End:0xEE51
            break;
        // End:0x63F4
        case 15341:
            param = "1,3,1,Trick,5";
            // End:0xEE51
            break;
        // End:0x6415
        case 15342:
            param = "1,3,1,Medusa,5";
            // End:0xEE51
            break;
        // End:0x643C
        case 15343:
            param = "1,3,1,Shadow Flare,5";
            // End:0xEE51
            break;
        // End:0x645D
        case 15344:
            param = "1,3,1,Unlock,5";
            // End:0xEE51
            break;
        // End:0x6486
        case 15345:
            param = "1,3,1,Vampiric Touch,5";
            // End:0xEE51
            break;
        // End:0x64AC
        case 15346:
            param = "1,3,1,Hydro Blast,5";
            // End:0xEE51
            break;
        // End:0x64D0
        case 15347:
            param = "1,3,1,Hurricane,5";
            // End:0xEE51
            break;
        // End:0x64FA
        case 15348:
            param = "1,3,3,Physical Winter,5";
            // End:0xEE51
            break;
        // End:0x6523
        case 15349:
            param = "1,3,3,Physical Bleed,5";
            // End:0xEE51
            break;
        // End:0x654B
        case 15350:
            param = "1,3,3,Physical Fear,5";
            // End:0xEE51
            break;
        // End:0x6573
        case 15351:
            param = "1,3,3,Physical Hold,5";
            // End:0xEE51
            break;
        // End:0x659D
        case 15352:
            param = "1,3,3,Physical Poison,5";
            // End:0xEE51
            break;
        // End:0x65C7
        case 15353:
            param = "1,3,3,Physical Medusa,5";
            // End:0xEE51
            break;
        // End:0x65F1
        case 15354:
            param = "1,3,3,Critical Winter,5";
            // End:0xEE51
            break;
        // End:0x661A
        case 15355:
            param = "1,3,3,Critical Bleed,5";
            // End:0xEE51
            break;
        // End:0x6642
        case 15356:
            param = "1,3,3,Critical Fear,5";
            // End:0xEE51
            break;
        // End:0x666A
        case 15357:
            param = "1,3,3,Critical Hold,5";
            // End:0xEE51
            break;
        // End:0x6694
        case 15358:
            param = "1,3,3,Critical Poison,5";
            // End:0xEE51
            break;
        // End:0x66BE
        case 15359:
            param = "1,3,3,Critical Medusa,5";
            // End:0xEE51
            break;
        // End:0x66DF
        case 15360:
            param = "1,3,3,Winter,5";
            // End:0xEE51
            break;
        // End:0x6701
        case 15361:
            param = "1,3,3,Agility,5";
            // End:0xEE51
            break;
        // End:0x6721
        case 15362:
            param = "1,3,3,Bleed,5";
            // End:0xEE51
            break;
        // End:0x6742
        case 15363:
            param = "1,3,3,Ritual,5";
            // End:0xEE51
            break;
        // End:0x6762
        case 15364:
            param = "1,3,3,Focus,5";
            // End:0xEE51
            break;
        // End:0x6782
        case 15365:
            param = "1,3,3,Charm,5";
            // End:0xEE51
            break;
        // End:0x67A5
        case 15366:
            param = "1,3,3,Guidance,5";
            // End:0xEE51
            break;
        // End:0x67C4
        case 15367:
            param = "1,3,3,Hold,5";
            // End:0xEE51
            break;
        // End:0x67E5
        case 15368:
            param = "1,3,3,Prayer,5";
            // End:0xEE51
            break;
        // End:0x6804
        case 15369:
            param = "1,3,3,Heal,5";
            // End:0xEE51
            break;
        // End:0x6826
        case 15370:
            param = "1,3,3,Empower,5";
            // End:0xEE51
            break;
        // End:0x684B
        case 15371:
            param = "1,3,3,Wild Magic,5";
            // End:0xEE51
            break;
        // End:0x686B
        case 15372:
            param = "1,3,3,Cheer,5";
            // End:0xEE51
            break;
        // End:0x6892
        case 15373:
            param = "1,3,3,Blessed Body,5";
            // End:0xEE51
            break;
        // End:0x68B9
        case 15374:
            param = "1,3,3,Blessed Soul,5";
            // End:0xEE51
            break;
        // End:0x68E1
        case 15375:
            param = "1,3,3,Magic Barrier,5";
            // End:0xEE51
            break;
        // End:0x6901
        case 15376:
            param = "1,3,3,Might,5";
            // End:0xEE51
            break;
        // End:0x6922
        case 15377:
            param = "1,3,3,Shield,5";
            // End:0xEE51
            break;
        // End:0x6943
        case 15378:
            param = "1,3,3,Poison,5";
            // End:0xEE51
            break;
        // End:0x696B
        case 15379:
            param = "1,3,3,Duel Weakness,5";
            // End:0xEE51
            break;
        // End:0x6990
        case 15380:
            param = "1,3,3,Duel Might,5";
            // End:0xEE51
            break;
        // End:0x69B0
        case 15381:
            param = "1,3,3,Sleep,5";
            // End:0xEE51
            break;
        // End:0x69CF
        case 15382:
            param = "1,3,3,Slow,5";
            // End:0xEE51
            break;
        // End:0x69F8
        case 15383:
            param = "1,3,3,Magical Winter,5";
            // End:0xEE51
            break;
        // End:0x6A20
        case 15384:
            param = "1,3,3,Magical Bleed,5";
            // End:0xEE51
            break;
        // End:0x6A47
        case 15385:
            param = "1,3,3,Magical Fear,5";
            // End:0xEE51
            break;
        // End:0x6A6E
        case 15386:
            param = "1,3,3,Magical Hold,5";
            // End:0xEE51
            break;
        // End:0x6A97
        case 15387:
            param = "1,3,3,Magical Poison,5";
            // End:0xEE51
            break;
        // End:0x6AC0
        case 15388:
            param = "1,3,3,Magical Medusa,5";
            // End:0xEE51
            break;
        // End:0x6AE7
        case 15389:
            param = "1,3,2,Heal Empower,5";
            // End:0xEE51
            break;
        // End:0x6B08
        case 15390:
            param = "1,3,2,Prayer,5";
            // End:0xEE51
            break;
        // End:0x6B2A
        case 15391:
            param = "1,3,2,Empower,5";
            // End:0xEE51
            break;
        // End:0x6B52
        case 15392:
            param = "1,3,2,Magic Barrier,5";
            // End:0xEE51
            break;
        // End:0x6B72
        case 15393:
            param = "1,3,2,Might,5";
            // End:0xEE51
            break;
        // End:0x6B93
        case 15394:
            param = "1,3,2,Shield,5";
            // End:0xEE51
            break;
        // End:0x6BB8
        case 15395:
            param = "1,3,2,Duel Might,5";
            // End:0xEE51
            break;
        // End:0x6BDF
        case 15396:
            param = "1,3,2,Weight Limit,5";
            // End:0xEE51
            break;
        // End:0x6C01
        case 15397:
            param = "1,4,1,Refresh,1";
            // End:0xEE51
            break;
        // End:0x6C23
        case 15398:
            param = "1,4,1,Clarity,1";
            // End:0xEE51
            break;
        // End:0x6C43
        case 15399:
            param = "1,4,1,Focus,5";
            // End:0xEE51
            break;
        // End:0x6C6C
        case 15400:
            param = "1,4,1,Reflect Damage,1";
            // End:0xEE51
            break;
        // End:0x6C8B
        case 15401:
            param = "1,4,1,Doom,5";
            // End:0xEE51
            break;
        // End:0x6CAC
        case 15402:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0x6CD7
        case 15403:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0x6CFC
        case 15404:
            param = "1,4,1,Wild Magic,5";
            // End:0xEE51
            break;
        // End:0x6D23
        case 15405:
            param = "1,4,1,Party Recall,2";
            // End:0xEE51
            break;
        // End:0x6D45
        case 15406:
            param = "1,4,1,Silence,5";
            // End:0xEE51
            break;
        // End:0x6D6D
        case 15407:
            param = "1,4,1,Skill Refresh,1";
            // End:0xEE51
            break;
        // End:0x6D95
        case 15408:
            param = "1,4,1,Skill Clarity,1";
            // End:0xEE51
            break;
        // End:0x6DBD
        case 15409:
            param = "1,4,1,Music Refresh,1";
            // End:0xEE51
            break;
        // End:0x6DE5
        case 15410:
            param = "1,4,1,Music Clarity,1";
            // End:0xEE51
            break;
        // End:0x6E0D
        case 15411:
            param = "1,4,1,Spell Refresh,1";
            // End:0xEE51
            break;
        // End:0x6E35
        case 15412:
            param = "1,4,1,Spell Clarity,1";
            // End:0xEE51
            break;
        // End:0x6E57
        case 15413:
            param = "1,4,1,Stealth,1";
            // End:0xEE51
            break;
        // End:0x6E7F
        case 15414:
            param = "1,4,1,Vampiric Rage,5";
            // End:0xEE51
            break;
        // End:0x6EA7
        case 15415:
            param = "1,4,3,Physical Doom,5";
            // End:0xEE51
            break;
        // End:0x6ED4
        case 15416:
            param = "1,4,3,Physical Mana Burn,5";
            // End:0xEE51
            break;
        // End:0x6F00
        case 15417:
            param = "1,4,3,Physical Paralyze,5";
            // End:0xEE51
            break;
        // End:0x6F2B
        case 15418:
            param = "1,4,3,Physical Silence,5";
            // End:0xEE51
            break;
        // End:0x6F54
        case 15419:
            param = "1,4,3,Physical Sleep,5";
            // End:0xEE51
            break;
        // End:0x6F7C
        case 15420:
            param = "1,4,3,Physical Stun,5";
            // End:0xEE51
            break;
        // End:0x6FA4
        case 15421:
            param = "1,4,3,Critical Doom,5";
            // End:0xEE51
            break;
        // End:0x6FD1
        case 15422:
            param = "1,4,3,Critical Mana Burn,5";
            // End:0xEE51
            break;
        // End:0x6FFD
        case 15423:
            param = "1,4,3,Critical Paralyze,5";
            // End:0xEE51
            break;
        // End:0x7028
        case 15424:
            param = "1,4,3,Critical Silence,5";
            // End:0xEE51
            break;
        // End:0x7051
        case 15425:
            param = "1,4,3,Critical Sleep,5";
            // End:0xEE51
            break;
        // End:0x7079
        case 15426:
            param = "1,4,3,Critical Stun,5";
            // End:0xEE51
            break;
        // End:0x7098
        case 15427:
            param = "1,4,3,Doom,5";
            // End:0xEE51
            break;
        // End:0x70B7
        case 15428:
            param = "1,4,3,Fear,5";
            // End:0xEE51
            break;
        // End:0x70DB
        case 15429:
            param = "1,4,3,Mana Gain,5";
            // End:0xEE51
            break;
        // End:0x70FE
        case 15430:
            param = "1,4,3,Recharge,5";
            // End:0xEE51
            break;
        // End:0x7121
        case 15431:
            param = "1,4,3,Paralyze,5";
            // End:0xEE51
            break;
        // End:0x7143
        case 15432:
            param = "1,4,3,Silence,5";
            // End:0xEE51
            break;
        // End:0x7162
        case 15433:
            param = "1,4,3,Stun,5";
            // End:0xEE51
            break;
        // End:0x7183
        case 15434:
            param = "1,4,3,Medusa,5";
            // End:0xEE51
            break;
        // End:0x71AA
        case 15435:
            param = "1,4,3,Magical Doom,5";
            // End:0xEE51
            break;
        // End:0x71D6
        case 15436:
            param = "1,4,3,Magical Mana Burn,5";
            // End:0xEE51
            break;
        // End:0x7201
        case 15437:
            param = "1,4,3,Magical Paralyze,5";
            // End:0xEE51
            break;
        // End:0x722B
        case 15438:
            param = "1,4,3,Magical Silence,5";
            // End:0xEE51
            break;
        // End:0x7253
        case 15439:
            param = "1,4,3,Magical Sleep,5";
            // End:0xEE51
            break;
        // End:0x727A
        case 15440:
            param = "1,4,3,Magical Stun,5";
            // End:0xEE51
            break;
        // End:0x729C
        case 15441:
            param = "1,4,2,Clarity,1";
            // End:0xEE51
            break;
        // End:0x72BE
        case 15442:
            param = "1,4,2,Agility,5";
            // End:0xEE51
            break;
        // End:0x72DE
        case 15443:
            param = "1,4,2,Focus,5";
            // End:0xEE51
            break;
        // End:0x7307
        case 15444:
            param = "1,4,2,Reflect Damage,1";
            // End:0xEE51
            break;
        // End:0x732A
        case 15445:
            param = "1,4,2,Guidance,5";
            // End:0xEE51
            break;
        // End:0x734F
        case 15446:
            param = "1,4,2,Wild Magic,5";
            // End:0xEE51
            break;
        // End:0x7373
        case 15447:
            param = "1,4,2,Mana Gain,5";
            // End:0xEE51
            break;
        // End:0x739B
        case 15448:
            param = "1,4,2,Skill Clarity,1";
            // End:0xEE51
            break;
        // End:0x73C3
        case 15449:
            param = "1,4,2,Music Clarity,1";
            // End:0xEE51
            break;
        // End:0x73EB
        case 15450:
            param = "1,4,2,Spell Clarity,1";
            // End:0xEE51
            break;
        // End:0x740C
        case 15468:
            param = "1,3,1,Winter,6";
            // End:0xEE51
            break;
        // End:0x742E
        case 15469:
            param = "1,3,1,Agility,6";
            // End:0xEE51
            break;
        // End:0x744E
        case 15470:
            param = "1,3,1,Bleed,6";
            // End:0xEE51
            break;
        // End:0x746F
        case 15471:
            param = "1,3,1,Ritual,6";
            // End:0xEE51
            break;
        // End:0x748F
        case 15472:
            param = "1,3,1,Stone,6";
            // End:0xEE51
            break;
        // End:0x74AE
        case 15473:
            param = "1,3,1,Fear,6";
            // End:0xEE51
            break;
        // End:0x74D3
        case 15474:
            param = "1,3,1,Prominence,6";
            // End:0xEE51
            break;
        // End:0x74F3
        case 15475:
            param = "1,3,1,Peace,6";
            // End:0xEE51
            break;
        // End:0x7513
        case 15476:
            param = "1,3,1,Charm,6";
            // End:0xEE51
            break;
        // End:0x7538
        case 15477:
            param = "1,3,1,Aggression,6";
            // End:0xEE51
            break;
        // End:0x755B
        case 15478:
            param = "1,3,1,Guidance,6";
            // End:0xEE51
            break;
        // End:0x757A
        case 15479:
            param = "1,3,1,Hold,6";
            // End:0xEE51
            break;
        // End:0x75A0
        case 15480:
            param = "1,3,1,Solar Flare,6";
            // End:0xEE51
            break;
        // End:0x75C7
        case 15481:
            param = "1,3,1,Heal Empower,6";
            // End:0xEE51
            break;
        // End:0x75E8
        case 15482:
            param = "1,3,1,Prayer,6";
            // End:0xEE51
            break;
        // End:0x7607
        case 15483:
            param = "1,3,1,Heal,6";
            // End:0xEE51
            break;
        // End:0x7629
        case 15484:
            param = "1,3,1,Empower,6";
            // End:0xEE51
            break;
        // End:0x7649
        case 15485:
            param = "1,3,1,Cheer,6";
            // End:0xEE51
            break;
        // End:0x766F
        case 15486:
            param = "1,3,1,Battle Roar,6";
            // End:0xEE51
            break;
        // End:0x7696
        case 15487:
            param = "1,3,1,Blessed Body,6";
            // End:0xEE51
            break;
        // End:0x76BD
        case 15488:
            param = "1,3,1,Blessed Soul,6";
            // End:0xEE51
            break;
        // End:0x76E5
        case 15489:
            param = "1,3,1,Magic Barrier,6";
            // End:0xEE51
            break;
        // End:0x7709
        case 15490:
            param = "1,3,1,Mana Burn,6";
            // End:0xEE51
            break;
        // End:0x772D
        case 15491:
            param = "1,3,1,Mana Gain,6";
            // End:0xEE51
            break;
        // End:0x7750
        case 15492:
            param = "1,3,1,Recharge,6";
            // End:0xEE51
            break;
        // End:0x7775
        case 15493:
            param = "1,3,1,Aura Flare,6";
            // End:0xEE51
            break;
        // End:0x7795
        case 15494:
            param = "1,3,1,Might,6";
            // End:0xEE51
            break;
        // End:0x77B8
        case 15495:
            param = "1,3,1,Paralyze,6";
            // End:0xEE51
            break;
        // End:0x77D9
        case 15496:
            param = "1,3,1,Shield,6";
            // End:0xEE51
            break;
        // End:0x77FA
        case 15497:
            param = "1,3,1,Poison,6";
            // End:0xEE51
            break;
        // End:0x7822
        case 15498:
            param = "1,3,1,Duel Weakness,6";
            // End:0xEE51
            break;
        // End:0x7847
        case 15499:
            param = "1,3,1,Duel Might,6";
            // End:0xEE51
            break;
        // End:0x7868
        case 15500:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0x788F
        case 15501:
            param = "1,3,1,Resurrection,6";
            // End:0xEE51
            break;
        // End:0x78B4
        case 15502:
            param = "1,3,1,Self Stone,6";
            // End:0xEE51
            break;
        // End:0x78DE
        case 15503:
            param = "1,3,1,Self Prominence,6";
            // End:0xEE51
            break;
        // End:0x7909
        case 15504:
            param = "1,3,1,Self Solar Flare,6";
            // End:0xEE51
            break;
        // End:0x7933
        case 15505:
            param = "1,3,1,Self Aura Flare,6";
            // End:0xEE51
            break;
        // End:0x795F
        case 15506:
            param = "1,3,1,Self Shadow Flare,6";
            // End:0xEE51
            break;
        // End:0x798A
        case 15507:
            param = "1,3,1,Self Hydro Blast,6";
            // End:0xEE51
            break;
        // End:0x79B3
        case 15508:
            param = "1,3,1,Self Hurricane,6";
            // End:0xEE51
            break;
        // End:0x79D3
        case 15509:
            param = "1,3,1,Sleep,6";
            // End:0xEE51
            break;
        // End:0x79F2
        case 15510:
            param = "1,3,1,Slow,6";
            // End:0xEE51
            break;
        // End:0x7A11
        case 15511:
            param = "1,3,1,Stun,6";
            // End:0xEE51
            break;
        // End:0x7A34
        case 15512:
            param = "1,3,1,Ae Stone,6";
            // End:0xEE51
            break;
        // End:0x7A5C
        case 15513:
            param = "1,3,1,Ae Prominence,6";
            // End:0xEE51
            break;
        // End:0x7A85
        case 15514:
            param = "1,3,1,Ae Solar Flare,6";
            // End:0xEE51
            break;
        // End:0x7AAD
        case 15515:
            param = "1,3,1,Ae Aura Flare,6";
            // End:0xEE51
            break;
        // End:0x7AD7
        case 15516:
            param = "1,3,1,Ae Shadow Flare,6";
            // End:0xEE51
            break;
        // End:0x7B00
        case 15517:
            param = "1,3,1,Ae Hydro Blast,6";
            // End:0xEE51
            break;
        // End:0x7B27
        case 15518:
            param = "1,3,1,Ae Hurricane,6";
            // End:0xEE51
            break;
        // End:0x7B47
        case 15519:
            param = "1,3,1,Trick,6";
            // End:0xEE51
            break;
        // End:0x7B68
        case 15520:
            param = "1,3,1,Medusa,6";
            // End:0xEE51
            break;
        // End:0x7B8F
        case 15521:
            param = "1,3,1,Shadow Flare,6";
            // End:0xEE51
            break;
        // End:0x7BB0
        case 15522:
            param = "1,3,1,Unlock,6";
            // End:0xEE51
            break;
        // End:0x7BD9
        case 15523:
            param = "1,3,1,Vampiric Touch,6";
            // End:0xEE51
            break;
        // End:0x7BFF
        case 15524:
            param = "1,3,1,Hydro Blast,6";
            // End:0xEE51
            break;
        // End:0x7C23
        case 15525:
            param = "1,3,1,Hurricane,6";
            // End:0xEE51
            break;
        // End:0x7C4D
        case 15526:
            param = "1,3,3,Physical Winter,6";
            // End:0xEE51
            break;
        // End:0x7C76
        case 15527:
            param = "1,3,3,Physical Bleed,6";
            // End:0xEE51
            break;
        // End:0x7C9E
        case 15528:
            param = "1,3,3,Physical Fear,6";
            // End:0xEE51
            break;
        // End:0x7CC6
        case 15529:
            param = "1,3,3,Physical Hold,6";
            // End:0xEE51
            break;
        // End:0x7CF0
        case 15530:
            param = "1,3,3,Physical Poison,6";
            // End:0xEE51
            break;
        // End:0x7D1A
        case 15531:
            param = "1,3,3,Physical Medusa,6";
            // End:0xEE51
            break;
        // End:0x7D44
        case 15532:
            param = "1,3,3,Critical Winter,6";
            // End:0xEE51
            break;
        // End:0x7D6D
        case 15533:
            param = "1,3,3,Critical Bleed,6";
            // End:0xEE51
            break;
        // End:0x7D95
        case 15534:
            param = "1,3,3,Critical Fear,6";
            // End:0xEE51
            break;
        // End:0x7DBD
        case 15535:
            param = "1,3,3,Critical Hold,6";
            // End:0xEE51
            break;
        // End:0x7DE7
        case 15536:
            param = "1,3,3,Critical Poison,6";
            // End:0xEE51
            break;
        // End:0x7E11
        case 15537:
            param = "1,3,3,Critical Medusa,6";
            // End:0xEE51
            break;
        // End:0x7E32
        case 15538:
            param = "1,3,3,Winter,6";
            // End:0xEE51
            break;
        // End:0x7E54
        case 15539:
            param = "1,3,3,Agility,6";
            // End:0xEE51
            break;
        // End:0x7E74
        case 15540:
            param = "1,3,3,Bleed,6";
            // End:0xEE51
            break;
        // End:0x7E95
        case 15541:
            param = "1,3,3,Ritual,6";
            // End:0xEE51
            break;
        // End:0x7EB5
        case 15542:
            param = "1,3,3,Focus,6";
            // End:0xEE51
            break;
        // End:0x7ED5
        case 15543:
            param = "1,3,3,Charm,6";
            // End:0xEE51
            break;
        // End:0x7EF8
        case 15544:
            param = "1,3,3,Guidance,6";
            // End:0xEE51
            break;
        // End:0x7F17
        case 15545:
            param = "1,3,3,Hold,6";
            // End:0xEE51
            break;
        // End:0x7F38
        case 15546:
            param = "1,3,3,Prayer,6";
            // End:0xEE51
            break;
        // End:0x7F57
        case 15547:
            param = "1,3,3,Heal,6";
            // End:0xEE51
            break;
        // End:0x7F79
        case 15548:
            param = "1,3,3,Empower,6";
            // End:0xEE51
            break;
        // End:0x7F9E
        case 15549:
            param = "1,3,3,Wild Magic,6";
            // End:0xEE51
            break;
        // End:0x7FBE
        case 15550:
            param = "1,3,3,Cheer,6";
            // End:0xEE51
            break;
        // End:0x7FE5
        case 15551:
            param = "1,3,3,Blessed Body,6";
            // End:0xEE51
            break;
        // End:0x800C
        case 15552:
            param = "1,3,3,Blessed Soul,6";
            // End:0xEE51
            break;
        // End:0x8034
        case 15553:
            param = "1,3,3,Magic Barrier,6";
            // End:0xEE51
            break;
        // End:0x8054
        case 15554:
            param = "1,3,3,Might,6";
            // End:0xEE51
            break;
        // End:0x8075
        case 15555:
            param = "1,3,3,Shield,6";
            // End:0xEE51
            break;
        // End:0x8096
        case 15556:
            param = "1,3,3,Poison,6";
            // End:0xEE51
            break;
        // End:0x80BE
        case 15557:
            param = "1,3,3,Duel Weakness,6";
            // End:0xEE51
            break;
        // End:0x80E3
        case 15558:
            param = "1,3,3,Duel Might,6";
            // End:0xEE51
            break;
        // End:0x8103
        case 15559:
            param = "1,3,3,Sleep,6";
            // End:0xEE51
            break;
        // End:0x8122
        case 15560:
            param = "1,3,3,Slow,6";
            // End:0xEE51
            break;
        // End:0x814B
        case 15561:
            param = "1,3,3,Magical Winter,6";
            // End:0xEE51
            break;
        // End:0x8173
        case 15562:
            param = "1,3,3,Magical Bleed,6";
            // End:0xEE51
            break;
        // End:0x819A
        case 15563:
            param = "1,3,3,Magical Fear,6";
            // End:0xEE51
            break;
        // End:0x81C1
        case 15564:
            param = "1,3,3,Magical Hold,6";
            // End:0xEE51
            break;
        // End:0x81EA
        case 15565:
            param = "1,3,3,Magical Poison,6";
            // End:0xEE51
            break;
        // End:0x8213
        case 15566:
            param = "1,3,3,Magical Medusa,6";
            // End:0xEE51
            break;
        // End:0x823A
        case 15567:
            param = "1,3,2,Heal Empower,6";
            // End:0xEE51
            break;
        // End:0x825B
        case 15568:
            param = "1,3,2,Prayer,6";
            // End:0xEE51
            break;
        // End:0x827D
        case 15569:
            param = "1,3,2,Empower,6";
            // End:0xEE51
            break;
        // End:0x82A5
        case 15570:
            param = "1,3,2,Magic Barrier,6";
            // End:0xEE51
            break;
        // End:0x82C5
        case 15571:
            param = "1,3,2,Might,6";
            // End:0xEE51
            break;
        // End:0x82E6
        case 15572:
            param = "1,3,2,Shield,6";
            // End:0xEE51
            break;
        // End:0x830B
        case 15573:
            param = "1,3,2,Duel Might,6";
            // End:0xEE51
            break;
        // End:0x8332
        case 15574:
            param = "1,3,2,Weight Limit,6";
            // End:0xEE51
            break;
        // End:0x8354
        case 15575:
            param = "1,4,1,Refresh,1";
            // End:0xEE51
            break;
        // End:0x8376
        case 15576:
            param = "1,4,1,Clarity,1";
            // End:0xEE51
            break;
        // End:0x8396
        case 15577:
            param = "1,4,1,Focus,6";
            // End:0xEE51
            break;
        // End:0x83BF
        case 15578:
            param = "1,4,1,Reflect Damage,1";
            // End:0xEE51
            break;
        // End:0x83DE
        case 15579:
            param = "1,4,1,Doom,6";
            // End:0xEE51
            break;
        // End:0x83FF
        case 15580:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0x842A
        case 15581:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0x844F
        case 15582:
            param = "1,4,1,Wild Magic,6";
            // End:0xEE51
            break;
        // End:0x8476
        case 15583:
            param = "1,4,1,Party Recall,2";
            // End:0xEE51
            break;
        // End:0x8498
        case 15584:
            param = "1,4,1,Silence,6";
            // End:0xEE51
            break;
        // End:0x84C0
        case 15585:
            param = "1,4,1,Skill Refresh,1";
            // End:0xEE51
            break;
        // End:0x84E8
        case 15586:
            param = "1,4,1,Skill Clarity,1";
            // End:0xEE51
            break;
        // End:0x8510
        case 15587:
            param = "1,4,1,Music Refresh,1";
            // End:0xEE51
            break;
        // End:0x8538
        case 15588:
            param = "1,4,1,Music Clarity,1";
            // End:0xEE51
            break;
        // End:0x8560
        case 15589:
            param = "1,4,1,Spell Refresh,1";
            // End:0xEE51
            break;
        // End:0x8588
        case 15590:
            param = "1,4,1,Spell Clarity,1";
            // End:0xEE51
            break;
        // End:0x85AA
        case 15591:
            param = "1,4,1,Stealth,1";
            // End:0xEE51
            break;
        // End:0x85D2
        case 15592:
            param = "1,4,1,Vampiric Rage,6";
            // End:0xEE51
            break;
        // End:0x85FA
        case 15593:
            param = "1,4,3,Physical Doom,6";
            // End:0xEE51
            break;
        // End:0x8627
        case 15594:
            param = "1,4,3,Physical Mana Burn,6";
            // End:0xEE51
            break;
        // End:0x8653
        case 15595:
            param = "1,4,3,Physical Paralyze,6";
            // End:0xEE51
            break;
        // End:0x867E
        case 15596:
            param = "1,4,3,Physical Silence,6";
            // End:0xEE51
            break;
        // End:0x86A7
        case 15597:
            param = "1,4,3,Physical Sleep,6";
            // End:0xEE51
            break;
        // End:0x86CF
        case 15598:
            param = "1,4,3,Physical Stun,6";
            // End:0xEE51
            break;
        // End:0x86F7
        case 15599:
            param = "1,4,3,Critical Doom,6";
            // End:0xEE51
            break;
        // End:0x8724
        case 15600:
            param = "1,4,3,Critical Mana Burn,6";
            // End:0xEE51
            break;
        // End:0x8750
        case 15601:
            param = "1,4,3,Critical Paralyze,6";
            // End:0xEE51
            break;
        // End:0x877B
        case 15602:
            param = "1,4,3,Critical Silence,6";
            // End:0xEE51
            break;
        // End:0x87A4
        case 15603:
            param = "1,4,3,Critical Sleep,6";
            // End:0xEE51
            break;
        // End:0x87CC
        case 15604:
            param = "1,4,3,Critical Stun,6";
            // End:0xEE51
            break;
        // End:0x87EB
        case 15605:
            param = "1,4,3,Doom,6";
            // End:0xEE51
            break;
        // End:0x880A
        case 15606:
            param = "1,4,3,Fear,6";
            // End:0xEE51
            break;
        // End:0x882E
        case 15607:
            param = "1,4,3,Mana Gain,6";
            // End:0xEE51
            break;
        // End:0x8851
        case 15608:
            param = "1,4,3,Recharge,6";
            // End:0xEE51
            break;
        // End:0x8874
        case 15609:
            param = "1,4,3,Paralyze,6";
            // End:0xEE51
            break;
        // End:0x8896
        case 15610:
            param = "1,4,3,Silence,6";
            // End:0xEE51
            break;
        // End:0x88B5
        case 15611:
            param = "1,4,3,Stun,6";
            // End:0xEE51
            break;
        // End:0x88D6
        case 15612:
            param = "1,4,3,Medusa,6";
            // End:0xEE51
            break;
        // End:0x88FD
        case 15613:
            param = "1,4,3,Magical Doom,6";
            // End:0xEE51
            break;
        // End:0x8929
        case 15614:
            param = "1,4,3,Magical Mana Burn,6";
            // End:0xEE51
            break;
        // End:0x8954
        case 15615:
            param = "1,4,3,Magical Paralyze,6";
            // End:0xEE51
            break;
        // End:0x897E
        case 15616:
            param = "1,4,3,Magical Silence,6";
            // End:0xEE51
            break;
        // End:0x89A6
        case 15617:
            param = "1,4,3,Magical Sleep,6";
            // End:0xEE51
            break;
        // End:0x89CD
        case 15618:
            param = "1,4,3,Magical Stun,6";
            // End:0xEE51
            break;
        // End:0x89EF
        case 15619:
            param = "1,4,2,Clarity,1";
            // End:0xEE51
            break;
        // End:0x8A11
        case 15620:
            param = "1,4,2,Agility,6";
            // End:0xEE51
            break;
        // End:0x8A31
        case 15621:
            param = "1,4,2,Focus,6";
            // End:0xEE51
            break;
        // End:0x8A5A
        case 15622:
            param = "1,4,2,Reflect Damage,1";
            // End:0xEE51
            break;
        // End:0x8A7D
        case 15623:
            param = "1,4,2,Guidance,6";
            // End:0xEE51
            break;
        // End:0x8AA2
        case 15624:
            param = "1,4,2,Wild Magic,6";
            // End:0xEE51
            break;
        // End:0x8AC6
        case 15625:
            param = "1,4,2,Mana Gain,6";
            // End:0xEE51
            break;
        // End:0x8AEE
        case 15626:
            param = "1,4,2,Skill Clarity,1";
            // End:0xEE51
            break;
        // End:0x8B16
        case 15627:
            param = "1,4,2,Music Clarity,1";
            // End:0xEE51
            break;
        // End:0x8B3E
        case 15628:
            param = "1,4,2,Spell Clarity,1";
            // End:0xEE51
            break;
        // End:0x8B5F
        case 15646:
            param = "1,3,1,Winter,7";
            // End:0xEE51
            break;
        // End:0x8B81
        case 15647:
            param = "1,3,1,Agility,7";
            // End:0xEE51
            break;
        // End:0x8BA1
        case 15648:
            param = "1,3,1,Bleed,7";
            // End:0xEE51
            break;
        // End:0x8BC2
        case 15649:
            param = "1,3,1,Ritual,7";
            // End:0xEE51
            break;
        // End:0x8BE2
        case 15650:
            param = "1,3,1,Stone,7";
            // End:0xEE51
            break;
        // End:0x8C01
        case 15651:
            param = "1,3,1,Fear,7";
            // End:0xEE51
            break;
        // End:0x8C26
        case 15652:
            param = "1,3,1,Prominence,7";
            // End:0xEE51
            break;
        // End:0x8C46
        case 15653:
            param = "1,3,1,Peace,7";
            // End:0xEE51
            break;
        // End:0x8C66
        case 15654:
            param = "1,3,1,Charm,7";
            // End:0xEE51
            break;
        // End:0x8C8B
        case 15655:
            param = "1,3,1,Aggression,7";
            // End:0xEE51
            break;
        // End:0x8CAE
        case 15656:
            param = "1,3,1,Guidance,7";
            // End:0xEE51
            break;
        // End:0x8CCD
        case 15657:
            param = "1,3,1,Hold,7";
            // End:0xEE51
            break;
        // End:0x8CF3
        case 15658:
            param = "1,3,1,Solar Flare,7";
            // End:0xEE51
            break;
        // End:0x8D1A
        case 15659:
            param = "1,3,1,Heal Empower,7";
            // End:0xEE51
            break;
        // End:0x8D3B
        case 15660:
            param = "1,3,1,Prayer,7";
            // End:0xEE51
            break;
        // End:0x8D5A
        case 15661:
            param = "1,3,1,Heal,7";
            // End:0xEE51
            break;
        // End:0x8D7C
        case 15662:
            param = "1,3,1,Empower,7";
            // End:0xEE51
            break;
        // End:0x8D9C
        case 15663:
            param = "1,3,1,Cheer,7";
            // End:0xEE51
            break;
        // End:0x8DC2
        case 15664:
            param = "1,3,1,Battle Roar,7";
            // End:0xEE51
            break;
        // End:0x8DE9
        case 15665:
            param = "1,3,1,Blessed Body,7";
            // End:0xEE51
            break;
        // End:0x8E10
        case 15666:
            param = "1,3,1,Blessed Soul,7";
            // End:0xEE51
            break;
        // End:0x8E38
        case 15667:
            param = "1,3,1,Magic Barrier,7";
            // End:0xEE51
            break;
        // End:0x8E5C
        case 15668:
            param = "1,3,1,Mana Burn,7";
            // End:0xEE51
            break;
        // End:0x8E80
        case 15669:
            param = "1,3,1,Mana Gain,7";
            // End:0xEE51
            break;
        // End:0x8EA3
        case 15670:
            param = "1,3,1,Recharge,7";
            // End:0xEE51
            break;
        // End:0x8EC8
        case 15671:
            param = "1,3,1,Aura Flare,7";
            // End:0xEE51
            break;
        // End:0x8EE8
        case 15672:
            param = "1,3,1,Might,7";
            // End:0xEE51
            break;
        // End:0x8F0B
        case 15673:
            param = "1,3,1,Paralyze,7";
            // End:0xEE51
            break;
        // End:0x8F2C
        case 15674:
            param = "1,3,1,Shield,7";
            // End:0xEE51
            break;
        // End:0x8F4D
        case 15675:
            param = "1,3,1,Poison,7";
            // End:0xEE51
            break;
        // End:0x8F75
        case 15676:
            param = "1,3,1,Duel Weakness,7";
            // End:0xEE51
            break;
        // End:0x8F9A
        case 15677:
            param = "1,3,1,Duel Might,7";
            // End:0xEE51
            break;
        // End:0x8FBB
        case 15678:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0x8FE2
        case 15679:
            param = "1,3,1,Resurrection,7";
            // End:0xEE51
            break;
        // End:0x9007
        case 15680:
            param = "1,3,1,Self Stone,7";
            // End:0xEE51
            break;
        // End:0x9031
        case 15681:
            param = "1,3,1,Self Prominence,7";
            // End:0xEE51
            break;
        // End:0x905C
        case 15682:
            param = "1,3,1,Self Solar Flare,7";
            // End:0xEE51
            break;
        // End:0x9086
        case 15683:
            param = "1,3,1,Self Aura Flare,7";
            // End:0xEE51
            break;
        // End:0x90B2
        case 15684:
            param = "1,3,1,Self Shadow Flare,7";
            // End:0xEE51
            break;
        // End:0x90DD
        case 15685:
            param = "1,3,1,Self Hydro Blast,7";
            // End:0xEE51
            break;
        // End:0x9106
        case 15686:
            param = "1,3,1,Self Hurricane,7";
            // End:0xEE51
            break;
        // End:0x9126
        case 15687:
            param = "1,3,1,Sleep,7";
            // End:0xEE51
            break;
        // End:0x9145
        case 15688:
            param = "1,3,1,Slow,7";
            // End:0xEE51
            break;
        // End:0x9164
        case 15689:
            param = "1,3,1,Stun,7";
            // End:0xEE51
            break;
        // End:0x9187
        case 15690:
            param = "1,3,1,Ae Stone,7";
            // End:0xEE51
            break;
        // End:0x91AF
        case 15691:
            param = "1,3,1,Ae Prominence,7";
            // End:0xEE51
            break;
        // End:0x91D8
        case 15692:
            param = "1,3,1,Ae Solar Flare,7";
            // End:0xEE51
            break;
        // End:0x9200
        case 15693:
            param = "1,3,1,Ae Aura Flare,7";
            // End:0xEE51
            break;
        // End:0x922A
        case 15694:
            param = "1,3,1,Ae Shadow Flare,7";
            // End:0xEE51
            break;
        // End:0x9253
        case 15695:
            param = "1,3,1,Ae Hydro Blast,7";
            // End:0xEE51
            break;
        // End:0x927A
        case 15696:
            param = "1,3,1,Ae Hurricane,7";
            // End:0xEE51
            break;
        // End:0x929A
        case 15697:
            param = "1,3,1,Trick,7";
            // End:0xEE51
            break;
        // End:0x92BB
        case 15698:
            param = "1,3,1,Medusa,7";
            // End:0xEE51
            break;
        // End:0x92E2
        case 15699:
            param = "1,3,1,Shadow Flare,7";
            // End:0xEE51
            break;
        // End:0x9303
        case 15700:
            param = "1,3,1,Unlock,7";
            // End:0xEE51
            break;
        // End:0x932C
        case 15701:
            param = "1,3,1,Vampiric Touch,7";
            // End:0xEE51
            break;
        // End:0x9352
        case 15702:
            param = "1,3,1,Hydro Blast,7";
            // End:0xEE51
            break;
        // End:0x9376
        case 15703:
            param = "1,3,1,Hurricane,7";
            // End:0xEE51
            break;
        // End:0x93A0
        case 15704:
            param = "1,3,3,Physical Winter,7";
            // End:0xEE51
            break;
        // End:0x93C9
        case 15705:
            param = "1,3,3,Physical Bleed,7";
            // End:0xEE51
            break;
        // End:0x93F1
        case 15706:
            param = "1,3,3,Physical Fear,7";
            // End:0xEE51
            break;
        // End:0x9419
        case 15707:
            param = "1,3,3,Physical Hold,7";
            // End:0xEE51
            break;
        // End:0x9443
        case 15708:
            param = "1,3,3,Physical Poison,7";
            // End:0xEE51
            break;
        // End:0x946D
        case 15709:
            param = "1,3,3,Physical Medusa,7";
            // End:0xEE51
            break;
        // End:0x9497
        case 15710:
            param = "1,3,3,Critical Winter,7";
            // End:0xEE51
            break;
        // End:0x94C0
        case 15711:
            param = "1,3,3,Critical Bleed,7";
            // End:0xEE51
            break;
        // End:0x94E8
        case 15712:
            param = "1,3,3,Critical Fear,7";
            // End:0xEE51
            break;
        // End:0x9510
        case 15713:
            param = "1,3,3,Critical Hold,7";
            // End:0xEE51
            break;
        // End:0x953A
        case 15714:
            param = "1,3,3,Critical Poison,7";
            // End:0xEE51
            break;
        // End:0x9564
        case 15715:
            param = "1,3,3,Critical Medusa,7";
            // End:0xEE51
            break;
        // End:0x9585
        case 15716:
            param = "1,3,3,Winter,7";
            // End:0xEE51
            break;
        // End:0x95A7
        case 15717:
            param = "1,3,3,Agility,7";
            // End:0xEE51
            break;
        // End:0x95C7
        case 15718:
            param = "1,3,3,Bleed,7";
            // End:0xEE51
            break;
        // End:0x95E8
        case 15719:
            param = "1,3,3,Ritual,7";
            // End:0xEE51
            break;
        // End:0x9608
        case 15720:
            param = "1,3,3,Focus,7";
            // End:0xEE51
            break;
        // End:0x9628
        case 15721:
            param = "1,3,3,Charm,7";
            // End:0xEE51
            break;
        // End:0x964B
        case 15722:
            param = "1,3,3,Guidance,7";
            // End:0xEE51
            break;
        // End:0x966A
        case 15723:
            param = "1,3,3,Hold,7";
            // End:0xEE51
            break;
        // End:0x968B
        case 15724:
            param = "1,3,3,Prayer,7";
            // End:0xEE51
            break;
        // End:0x96AA
        case 15725:
            param = "1,3,3,Heal,7";
            // End:0xEE51
            break;
        // End:0x96CC
        case 15726:
            param = "1,3,3,Empower,7";
            // End:0xEE51
            break;
        // End:0x96F1
        case 15727:
            param = "1,3,3,Wild Magic,7";
            // End:0xEE51
            break;
        // End:0x9711
        case 15728:
            param = "1,3,3,Cheer,7";
            // End:0xEE51
            break;
        // End:0x9738
        case 15729:
            param = "1,3,3,Blessed Body,7";
            // End:0xEE51
            break;
        // End:0x975F
        case 15730:
            param = "1,3,3,Blessed Soul,7";
            // End:0xEE51
            break;
        // End:0x9787
        case 15731:
            param = "1,3,3,Magic Barrier,7";
            // End:0xEE51
            break;
        // End:0x97A7
        case 15732:
            param = "1,3,3,Might,7";
            // End:0xEE51
            break;
        // End:0x97C8
        case 15733:
            param = "1,3,3,Shield,7";
            // End:0xEE51
            break;
        // End:0x97E9
        case 15734:
            param = "1,3,3,Poison,7";
            // End:0xEE51
            break;
        // End:0x9811
        case 15735:
            param = "1,3,3,Duel Weakness,7";
            // End:0xEE51
            break;
        // End:0x9836
        case 15736:
            param = "1,3,3,Duel Might,7";
            // End:0xEE51
            break;
        // End:0x9856
        case 15737:
            param = "1,3,3,Sleep,7";
            // End:0xEE51
            break;
        // End:0x9875
        case 15738:
            param = "1,3,3,Slow,7";
            // End:0xEE51
            break;
        // End:0x989E
        case 15739:
            param = "1,3,3,Magical Winter,7";
            // End:0xEE51
            break;
        // End:0x98C6
        case 15740:
            param = "1,3,3,Magical Bleed,7";
            // End:0xEE51
            break;
        // End:0x98ED
        case 15741:
            param = "1,3,3,Magical Fear,7";
            // End:0xEE51
            break;
        // End:0x9914
        case 15742:
            param = "1,3,3,Magical Hold,7";
            // End:0xEE51
            break;
        // End:0x993D
        case 15743:
            param = "1,3,3,Magical Poison,7";
            // End:0xEE51
            break;
        // End:0x9966
        case 15744:
            param = "1,3,3,Magical Medusa,7";
            // End:0xEE51
            break;
        // End:0x998D
        case 15745:
            param = "1,3,2,Heal Empower,7";
            // End:0xEE51
            break;
        // End:0x99AE
        case 15746:
            param = "1,3,2,Prayer,7";
            // End:0xEE51
            break;
        // End:0x99D0
        case 15747:
            param = "1,3,2,Empower,7";
            // End:0xEE51
            break;
        // End:0x99F8
        case 15748:
            param = "1,3,2,Magic Barrier,7";
            // End:0xEE51
            break;
        // End:0x9A18
        case 15749:
            param = "1,3,2,Might,7";
            // End:0xEE51
            break;
        // End:0x9A39
        case 15750:
            param = "1,3,2,Shield,7";
            // End:0xEE51
            break;
        // End:0x9A5E
        case 15751:
            param = "1,3,2,Duel Might,7";
            // End:0xEE51
            break;
        // End:0x9A85
        case 15752:
            param = "1,3,2,Weight Limit,7";
            // End:0xEE51
            break;
        // End:0x9AA7
        case 15753:
            param = "1,4,1,Refresh,2";
            // End:0xEE51
            break;
        // End:0x9AC9
        case 15754:
            param = "1,4,1,Clarity,2";
            // End:0xEE51
            break;
        // End:0x9AE9
        case 15755:
            param = "1,4,1,Focus,7";
            // End:0xEE51
            break;
        // End:0x9B12
        case 15756:
            param = "1,4,1,Reflect Damage,2";
            // End:0xEE51
            break;
        // End:0x9B31
        case 15757:
            param = "1,4,1,Doom,7";
            // End:0xEE51
            break;
        // End:0x9B52
        case 15758:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0x9B7D
        case 15759:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0x9BA2
        case 15760:
            param = "1,4,1,Wild Magic,7";
            // End:0xEE51
            break;
        // End:0x9BC9
        case 15761:
            param = "1,4,1,Party Recall,2";
            // End:0xEE51
            break;
        // End:0x9BEB
        case 15762:
            param = "1,4,1,Silence,7";
            // End:0xEE51
            break;
        // End:0x9C13
        case 15763:
            param = "1,4,1,Skill Refresh,2";
            // End:0xEE51
            break;
        // End:0x9C3B
        case 15764:
            param = "1,4,1,Skill Clarity,2";
            // End:0xEE51
            break;
        // End:0x9C63
        case 15765:
            param = "1,4,1,Music Refresh,2";
            // End:0xEE51
            break;
        // End:0x9C8B
        case 15766:
            param = "1,4,1,Music Clarity,2";
            // End:0xEE51
            break;
        // End:0x9CB3
        case 15767:
            param = "1,4,1,Spell Refresh,2";
            // End:0xEE51
            break;
        // End:0x9CDB
        case 15768:
            param = "1,4,1,Spell Clarity,2";
            // End:0xEE51
            break;
        // End:0x9CFD
        case 15769:
            param = "1,4,1,Stealth,1";
            // End:0xEE51
            break;
        // End:0x9D25
        case 15770:
            param = "1,4,1,Vampiric Rage,7";
            // End:0xEE51
            break;
        // End:0x9D4D
        case 15771:
            param = "1,4,3,Physical Doom,7";
            // End:0xEE51
            break;
        // End:0x9D7A
        case 15772:
            param = "1,4,3,Physical Mana Burn,7";
            // End:0xEE51
            break;
        // End:0x9DA6
        case 15773:
            param = "1,4,3,Physical Paralyze,7";
            // End:0xEE51
            break;
        // End:0x9DD1
        case 15774:
            param = "1,4,3,Physical Silence,7";
            // End:0xEE51
            break;
        // End:0x9DFA
        case 15775:
            param = "1,4,3,Physical Sleep,7";
            // End:0xEE51
            break;
        // End:0x9E22
        case 15776:
            param = "1,4,3,Physical Stun,7";
            // End:0xEE51
            break;
        // End:0x9E4A
        case 15777:
            param = "1,4,3,Critical Doom,7";
            // End:0xEE51
            break;
        // End:0x9E77
        case 15778:
            param = "1,4,3,Critical Mana Burn,7";
            // End:0xEE51
            break;
        // End:0x9EA3
        case 15779:
            param = "1,4,3,Critical Paralyze,7";
            // End:0xEE51
            break;
        // End:0x9ECE
        case 15780:
            param = "1,4,3,Critical Silence,7";
            // End:0xEE51
            break;
        // End:0x9EF7
        case 15781:
            param = "1,4,3,Critical Sleep,7";
            // End:0xEE51
            break;
        // End:0x9F1F
        case 15782:
            param = "1,4,3,Critical Stun,7";
            // End:0xEE51
            break;
        // End:0x9F3E
        case 15783:
            param = "1,4,3,Doom,7";
            // End:0xEE51
            break;
        // End:0x9F5D
        case 15784:
            param = "1,4,3,Fear,7";
            // End:0xEE51
            break;
        // End:0x9F81
        case 15785:
            param = "1,4,3,Mana Gain,7";
            // End:0xEE51
            break;
        // End:0x9FA4
        case 15786:
            param = "1,4,3,Recharge,7";
            // End:0xEE51
            break;
        // End:0x9FC7
        case 15787:
            param = "1,4,3,Paralyze,7";
            // End:0xEE51
            break;
        // End:0x9FE9
        case 15788:
            param = "1,4,3,Silence,7";
            // End:0xEE51
            break;
        // End:0xA008
        case 15789:
            param = "1,4,3,Stun,7";
            // End:0xEE51
            break;
        // End:0xA029
        case 15790:
            param = "1,4,3,Medusa,7";
            // End:0xEE51
            break;
        // End:0xA050
        case 15791:
            param = "1,4,3,Magical Doom,7";
            // End:0xEE51
            break;
        // End:0xA07C
        case 15792:
            param = "1,4,3,Magical Mana Burn,7";
            // End:0xEE51
            break;
        // End:0xA0A7
        case 15793:
            param = "1,4,3,Magical Paralyze,7";
            // End:0xEE51
            break;
        // End:0xA0D1
        case 15794:
            param = "1,4,3,Magical Silence,7";
            // End:0xEE51
            break;
        // End:0xA0F9
        case 15795:
            param = "1,4,3,Magical Sleep,7";
            // End:0xEE51
            break;
        // End:0xA120
        case 15796:
            param = "1,4,3,Magical Stun,7";
            // End:0xEE51
            break;
        // End:0xA142
        case 15797:
            param = "1,4,2,Clarity,2";
            // End:0xEE51
            break;
        // End:0xA164
        case 15798:
            param = "1,4,2,Agility,7";
            // End:0xEE51
            break;
        // End:0xA184
        case 15799:
            param = "1,4,2,Focus,7";
            // End:0xEE51
            break;
        // End:0xA1AD
        case 15800:
            param = "1,4,2,Reflect Damage,2";
            // End:0xEE51
            break;
        // End:0xA1D0
        case 15801:
            param = "1,4,2,Guidance,7";
            // End:0xEE51
            break;
        // End:0xA1F5
        case 15802:
            param = "1,4,2,Wild Magic,7";
            // End:0xEE51
            break;
        // End:0xA219
        case 15803:
            param = "1,4,2,Mana Gain,7";
            // End:0xEE51
            break;
        // End:0xA241
        case 15804:
            param = "1,4,2,Skill Clarity,2";
            // End:0xEE51
            break;
        // End:0xA269
        case 15805:
            param = "1,4,2,Music Clarity,2";
            // End:0xEE51
            break;
        // End:0xA291
        case 15806:
            param = "1,4,2,Spell Clarity,2";
            // End:0xEE51
            break;
        // End:0xA2B2
        case 15824:
            param = "1,3,1,Winter,8";
            // End:0xEE51
            break;
        // End:0xA2D4
        case 15825:
            param = "1,3,1,Agility,8";
            // End:0xEE51
            break;
        // End:0xA2F4
        case 15826:
            param = "1,3,1,Bleed,8";
            // End:0xEE51
            break;
        // End:0xA315
        case 15827:
            param = "1,3,1,Ritual,8";
            // End:0xEE51
            break;
        // End:0xA335
        case 15828:
            param = "1,3,1,Stone,8";
            // End:0xEE51
            break;
        // End:0xA354
        case 15829:
            param = "1,3,1,Fear,8";
            // End:0xEE51
            break;
        // End:0xA379
        case 15830:
            param = "1,3,1,Prominence,8";
            // End:0xEE51
            break;
        // End:0xA399
        case 15831:
            param = "1,3,1,Peace,8";
            // End:0xEE51
            break;
        // End:0xA3B9
        case 15832:
            param = "1,3,1,Charm,8";
            // End:0xEE51
            break;
        // End:0xA3DE
        case 15833:
            param = "1,3,1,Aggression,8";
            // End:0xEE51
            break;
        // End:0xA401
        case 15834:
            param = "1,3,1,Guidance,8";
            // End:0xEE51
            break;
        // End:0xA420
        case 15835:
            param = "1,3,1,Hold,8";
            // End:0xEE51
            break;
        // End:0xA446
        case 15836:
            param = "1,3,1,Solar Flare,8";
            // End:0xEE51
            break;
        // End:0xA46D
        case 15837:
            param = "1,3,1,Heal Empower,8";
            // End:0xEE51
            break;
        // End:0xA48E
        case 15838:
            param = "1,3,1,Prayer,8";
            // End:0xEE51
            break;
        // End:0xA4AD
        case 15839:
            param = "1,3,1,Heal,8";
            // End:0xEE51
            break;
        // End:0xA4CF
        case 15840:
            param = "1,3,1,Empower,8";
            // End:0xEE51
            break;
        // End:0xA4EF
        case 15841:
            param = "1,3,1,Cheer,8";
            // End:0xEE51
            break;
        // End:0xA515
        case 15842:
            param = "1,3,1,Battle Roar,8";
            // End:0xEE51
            break;
        // End:0xA53C
        case 15843:
            param = "1,3,1,Blessed Body,8";
            // End:0xEE51
            break;
        // End:0xA563
        case 15844:
            param = "1,3,1,Blessed Soul,8";
            // End:0xEE51
            break;
        // End:0xA58B
        case 15845:
            param = "1,3,1,Magic Barrier,8";
            // End:0xEE51
            break;
        // End:0xA5AF
        case 15846:
            param = "1,3,1,Mana Burn,8";
            // End:0xEE51
            break;
        // End:0xA5D3
        case 15847:
            param = "1,3,1,Mana Gain,8";
            // End:0xEE51
            break;
        // End:0xA5F6
        case 15848:
            param = "1,3,1,Recharge,8";
            // End:0xEE51
            break;
        // End:0xA61B
        case 15849:
            param = "1,3,1,Aura Flare,8";
            // End:0xEE51
            break;
        // End:0xA63B
        case 15850:
            param = "1,3,1,Might,8";
            // End:0xEE51
            break;
        // End:0xA65E
        case 15851:
            param = "1,3,1,Paralyze,8";
            // End:0xEE51
            break;
        // End:0xA67F
        case 15852:
            param = "1,3,1,Shield,8";
            // End:0xEE51
            break;
        // End:0xA6A0
        case 15853:
            param = "1,3,1,Poison,8";
            // End:0xEE51
            break;
        // End:0xA6C8
        case 15854:
            param = "1,3,1,Duel Weakness,8";
            // End:0xEE51
            break;
        // End:0xA6ED
        case 15855:
            param = "1,3,1,Duel Might,8";
            // End:0xEE51
            break;
        // End:0xA70E
        case 15856:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0xA735
        case 15857:
            param = "1,3,1,Resurrection,8";
            // End:0xEE51
            break;
        // End:0xA75A
        case 15858:
            param = "1,3,1,Self Stone,8";
            // End:0xEE51
            break;
        // End:0xA784
        case 15859:
            param = "1,3,1,Self Prominence,8";
            // End:0xEE51
            break;
        // End:0xA7AF
        case 15860:
            param = "1,3,1,Self Solar Flare,8";
            // End:0xEE51
            break;
        // End:0xA7D9
        case 15861:
            param = "1,3,1,Self Aura Flare,8";
            // End:0xEE51
            break;
        // End:0xA805
        case 15862:
            param = "1,3,1,Self Shadow Flare,8";
            // End:0xEE51
            break;
        // End:0xA830
        case 15863:
            param = "1,3,1,Self Hydro Blast,8";
            // End:0xEE51
            break;
        // End:0xA859
        case 15864:
            param = "1,3,1,Self Hurricane,8";
            // End:0xEE51
            break;
        // End:0xA879
        case 15865:
            param = "1,3,1,Sleep,8";
            // End:0xEE51
            break;
        // End:0xA898
        case 15866:
            param = "1,3,1,Slow,8";
            // End:0xEE51
            break;
        // End:0xA8B7
        case 15867:
            param = "1,3,1,Stun,8";
            // End:0xEE51
            break;
        // End:0xA8DA
        case 15868:
            param = "1,3,1,Ae Stone,8";
            // End:0xEE51
            break;
        // End:0xA902
        case 15869:
            param = "1,3,1,Ae Prominence,8";
            // End:0xEE51
            break;
        // End:0xA92B
        case 15870:
            param = "1,3,1,Ae Solar Flare,8";
            // End:0xEE51
            break;
        // End:0xA953
        case 15871:
            param = "1,3,1,Ae Aura Flare,8";
            // End:0xEE51
            break;
        // End:0xA97D
        case 15872:
            param = "1,3,1,Ae Shadow Flare,8";
            // End:0xEE51
            break;
        // End:0xA9A6
        case 15873:
            param = "1,3,1,Ae Hydro Blast,8";
            // End:0xEE51
            break;
        // End:0xA9CD
        case 15874:
            param = "1,3,1,Ae Hurricane,8";
            // End:0xEE51
            break;
        // End:0xA9ED
        case 15875:
            param = "1,3,1,Trick,8";
            // End:0xEE51
            break;
        // End:0xAA0E
        case 15876:
            param = "1,3,1,Medusa,8";
            // End:0xEE51
            break;
        // End:0xAA35
        case 15877:
            param = "1,3,1,Shadow Flare,8";
            // End:0xEE51
            break;
        // End:0xAA56
        case 15878:
            param = "1,3,1,Unlock,8";
            // End:0xEE51
            break;
        // End:0xAA7F
        case 15879:
            param = "1,3,1,Vampiric Touch,8";
            // End:0xEE51
            break;
        // End:0xAAA5
        case 15880:
            param = "1,3,1,Hydro Blast,8";
            // End:0xEE51
            break;
        // End:0xAAC9
        case 15881:
            param = "1,3,1,Hurricane,8";
            // End:0xEE51
            break;
        // End:0xAAF3
        case 15882:
            param = "1,3,3,Physical Winter,8";
            // End:0xEE51
            break;
        // End:0xAB1C
        case 15883:
            param = "1,3,3,Physical Bleed,8";
            // End:0xEE51
            break;
        // End:0xAB44
        case 15884:
            param = "1,3,3,Physical Fear,8";
            // End:0xEE51
            break;
        // End:0xAB6C
        case 15885:
            param = "1,3,3,Physical Hold,8";
            // End:0xEE51
            break;
        // End:0xAB96
        case 15886:
            param = "1,3,3,Physical Poison,8";
            // End:0xEE51
            break;
        // End:0xABC0
        case 15887:
            param = "1,3,3,Physical Medusa,8";
            // End:0xEE51
            break;
        // End:0xABEA
        case 15888:
            param = "1,3,3,Critical Winter,8";
            // End:0xEE51
            break;
        // End:0xAC13
        case 15889:
            param = "1,3,3,Critical Bleed,8";
            // End:0xEE51
            break;
        // End:0xAC3B
        case 15890:
            param = "1,3,3,Critical Fear,8";
            // End:0xEE51
            break;
        // End:0xAC63
        case 15891:
            param = "1,3,3,Critical Hold,8";
            // End:0xEE51
            break;
        // End:0xAC8D
        case 15892:
            param = "1,3,3,Critical Poison,8";
            // End:0xEE51
            break;
        // End:0xACB7
        case 15893:
            param = "1,3,3,Critical Medusa,8";
            // End:0xEE51
            break;
        // End:0xACD8
        case 15894:
            param = "1,3,3,Winter,8";
            // End:0xEE51
            break;
        // End:0xACFA
        case 15895:
            param = "1,3,3,Agility,8";
            // End:0xEE51
            break;
        // End:0xAD1A
        case 15896:
            param = "1,3,3,Bleed,8";
            // End:0xEE51
            break;
        // End:0xAD3B
        case 15897:
            param = "1,3,3,Ritual,8";
            // End:0xEE51
            break;
        // End:0xAD5B
        case 15898:
            param = "1,3,3,Focus,8";
            // End:0xEE51
            break;
        // End:0xAD7B
        case 15899:
            param = "1,3,3,Charm,8";
            // End:0xEE51
            break;
        // End:0xAD9E
        case 15900:
            param = "1,3,3,Guidance,8";
            // End:0xEE51
            break;
        // End:0xADBD
        case 15901:
            param = "1,3,3,Hold,8";
            // End:0xEE51
            break;
        // End:0xADDE
        case 15902:
            param = "1,3,3,Prayer,8";
            // End:0xEE51
            break;
        // End:0xADFD
        case 15903:
            param = "1,3,3,Heal,8";
            // End:0xEE51
            break;
        // End:0xAE1F
        case 15904:
            param = "1,3,3,Empower,8";
            // End:0xEE51
            break;
        // End:0xAE44
        case 15905:
            param = "1,3,3,Wild Magic,8";
            // End:0xEE51
            break;
        // End:0xAE64
        case 15906:
            param = "1,3,3,Cheer,8";
            // End:0xEE51
            break;
        // End:0xAE8B
        case 15907:
            param = "1,3,3,Blessed Body,8";
            // End:0xEE51
            break;
        // End:0xAEB2
        case 15908:
            param = "1,3,3,Blessed Soul,8";
            // End:0xEE51
            break;
        // End:0xAEDA
        case 15909:
            param = "1,3,3,Magic Barrier,8";
            // End:0xEE51
            break;
        // End:0xAEFA
        case 15910:
            param = "1,3,3,Might,8";
            // End:0xEE51
            break;
        // End:0xAF1B
        case 15911:
            param = "1,3,3,Shield,8";
            // End:0xEE51
            break;
        // End:0xAF3C
        case 15912:
            param = "1,3,3,Poison,8";
            // End:0xEE51
            break;
        // End:0xAF64
        case 15913:
            param = "1,3,3,Duel Weakness,8";
            // End:0xEE51
            break;
        // End:0xAF89
        case 15914:
            param = "1,3,3,Duel Might,8";
            // End:0xEE51
            break;
        // End:0xAFA9
        case 15915:
            param = "1,3,3,Sleep,8";
            // End:0xEE51
            break;
        // End:0xAFC8
        case 15916:
            param = "1,3,3,Slow,8";
            // End:0xEE51
            break;
        // End:0xAFF1
        case 15917:
            param = "1,3,3,Magical Winter,8";
            // End:0xEE51
            break;
        // End:0xB019
        case 15918:
            param = "1,3,3,Magical Bleed,8";
            // End:0xEE51
            break;
        // End:0xB040
        case 15919:
            param = "1,3,3,Magical Fear,8";
            // End:0xEE51
            break;
        // End:0xB067
        case 15920:
            param = "1,3,3,Magical Hold,8";
            // End:0xEE51
            break;
        // End:0xB090
        case 15921:
            param = "1,3,3,Magical Poison,8";
            // End:0xEE51
            break;
        // End:0xB0B9
        case 15922:
            param = "1,3,3,Magical Medusa,8";
            // End:0xEE51
            break;
        // End:0xB0E0
        case 15923:
            param = "1,3,2,Heal Empower,8";
            // End:0xEE51
            break;
        // End:0xB101
        case 15924:
            param = "1,3,2,Prayer,8";
            // End:0xEE51
            break;
        // End:0xB123
        case 15925:
            param = "1,3,2,Empower,8";
            // End:0xEE51
            break;
        // End:0xB14B
        case 15926:
            param = "1,3,2,Magic Barrier,8";
            // End:0xEE51
            break;
        // End:0xB16B
        case 15927:
            param = "1,3,2,Might,8";
            // End:0xEE51
            break;
        // End:0xB18C
        case 15928:
            param = "1,3,2,Shield,8";
            // End:0xEE51
            break;
        // End:0xB1B1
        case 15929:
            param = "1,3,2,Duel Might,8";
            // End:0xEE51
            break;
        // End:0xB1D8
        case 15930:
            param = "1,3,2,Weight Limit,8";
            // End:0xEE51
            break;
        // End:0xB1FA
        case 15931:
            param = "1,4,1,Refresh,2";
            // End:0xEE51
            break;
        // End:0xB21C
        case 15932:
            param = "1,4,1,Clarity,2";
            // End:0xEE51
            break;
        // End:0xB23C
        case 15933:
            param = "1,4,1,Focus,8";
            // End:0xEE51
            break;
        // End:0xB265
        case 15934:
            param = "1,4,1,Reflect Damage,2";
            // End:0xEE51
            break;
        // End:0xB284
        case 15935:
            param = "1,4,1,Doom,8";
            // End:0xEE51
            break;
        // End:0xB2A5
        case 15936:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0xB2D0
        case 15937:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0xB2F5
        case 15938:
            param = "1,4,1,Wild Magic,8";
            // End:0xEE51
            break;
        // End:0xB31C
        case 15939:
            param = "1,4,1,Party Recall,2";
            // End:0xEE51
            break;
        // End:0xB33E
        case 15940:
            param = "1,4,1,Silence,8";
            // End:0xEE51
            break;
        // End:0xB366
        case 15941:
            param = "1,4,1,Skill Refresh,2";
            // End:0xEE51
            break;
        // End:0xB38E
        case 15942:
            param = "1,4,1,Skill Clarity,2";
            // End:0xEE51
            break;
        // End:0xB3B6
        case 15943:
            param = "1,4,1,Music Refresh,2";
            // End:0xEE51
            break;
        // End:0xB3DE
        case 15944:
            param = "1,4,1,Music Clarity,2";
            // End:0xEE51
            break;
        // End:0xB406
        case 15945:
            param = "1,4,1,Spell Refresh,2";
            // End:0xEE51
            break;
        // End:0xB42E
        case 15946:
            param = "1,4,1,Spell Clarity,2";
            // End:0xEE51
            break;
        // End:0xB450
        case 15947:
            param = "1,4,1,Stealth,2";
            // End:0xEE51
            break;
        // End:0xB478
        case 15948:
            param = "1,4,1,Vampiric Rage,8";
            // End:0xEE51
            break;
        // End:0xB4A0
        case 15949:
            param = "1,4,3,Physical Doom,8";
            // End:0xEE51
            break;
        // End:0xB4CD
        case 15950:
            param = "1,4,3,Physical Mana Burn,8";
            // End:0xEE51
            break;
        // End:0xB4F9
        case 15951:
            param = "1,4,3,Physical Paralyze,8";
            // End:0xEE51
            break;
        // End:0xB524
        case 15952:
            param = "1,4,3,Physical Silence,8";
            // End:0xEE51
            break;
        // End:0xB54D
        case 15953:
            param = "1,4,3,Physical Sleep,8";
            // End:0xEE51
            break;
        // End:0xB575
        case 15954:
            param = "1,4,3,Physical Stun,8";
            // End:0xEE51
            break;
        // End:0xB59D
        case 15955:
            param = "1,4,3,Critical Doom,8";
            // End:0xEE51
            break;
        // End:0xB5CA
        case 15956:
            param = "1,4,3,Critical Mana Burn,8";
            // End:0xEE51
            break;
        // End:0xB5F6
        case 15957:
            param = "1,4,3,Critical Paralyze,8";
            // End:0xEE51
            break;
        // End:0xB621
        case 15958:
            param = "1,4,3,Critical Silence,8";
            // End:0xEE51
            break;
        // End:0xB64A
        case 15959:
            param = "1,4,3,Critical Sleep,8";
            // End:0xEE51
            break;
        // End:0xB672
        case 15960:
            param = "1,4,3,Critical Stun,8";
            // End:0xEE51
            break;
        // End:0xB691
        case 15961:
            param = "1,4,3,Doom,8";
            // End:0xEE51
            break;
        // End:0xB6B0
        case 15962:
            param = "1,4,3,Fear,8";
            // End:0xEE51
            break;
        // End:0xB6D4
        case 15963:
            param = "1,4,3,Mana Gain,8";
            // End:0xEE51
            break;
        // End:0xB6F7
        case 15964:
            param = "1,4,3,Recharge,8";
            // End:0xEE51
            break;
        // End:0xB71A
        case 15965:
            param = "1,4,3,Paralyze,8";
            // End:0xEE51
            break;
        // End:0xB73C
        case 15966:
            param = "1,4,3,Silence,8";
            // End:0xEE51
            break;
        // End:0xB75B
        case 15967:
            param = "1,4,3,Stun,8";
            // End:0xEE51
            break;
        // End:0xB77C
        case 15968:
            param = "1,4,3,Medusa,8";
            // End:0xEE51
            break;
        // End:0xB7A3
        case 15969:
            param = "1,4,3,Magical Doom,8";
            // End:0xEE51
            break;
        // End:0xB7CF
        case 15970:
            param = "1,4,3,Magical Mana Burn,8";
            // End:0xEE51
            break;
        // End:0xB7FA
        case 15971:
            param = "1,4,3,Magical Paralyze,8";
            // End:0xEE51
            break;
        // End:0xB824
        case 15972:
            param = "1,4,3,Magical Silence,8";
            // End:0xEE51
            break;
        // End:0xB84C
        case 15973:
            param = "1,4,3,Magical Sleep,8";
            // End:0xEE51
            break;
        // End:0xB873
        case 15974:
            param = "1,4,3,Magical Stun,8";
            // End:0xEE51
            break;
        // End:0xB895
        case 15975:
            param = "1,4,2,Clarity,2";
            // End:0xEE51
            break;
        // End:0xB8B7
        case 15976:
            param = "1,4,2,Agility,8";
            // End:0xEE51
            break;
        // End:0xB8D7
        case 15977:
            param = "1,4,2,Focus,8";
            // End:0xEE51
            break;
        // End:0xB900
        case 15978:
            param = "1,4,2,Reflect Damage,2";
            // End:0xEE51
            break;
        // End:0xB923
        case 15979:
            param = "1,4,2,Guidance,8";
            // End:0xEE51
            break;
        // End:0xB948
        case 15980:
            param = "1,4,2,Wild Magic,8";
            // End:0xEE51
            break;
        // End:0xB96C
        case 15981:
            param = "1,4,2,Mana Gain,8";
            // End:0xEE51
            break;
        // End:0xB994
        case 15982:
            param = "1,4,2,Skill Clarity,2";
            // End:0xEE51
            break;
        // End:0xB9BC
        case 15983:
            param = "1,4,2,Music Clarity,2";
            // End:0xEE51
            break;
        // End:0xB9E4
        case 15984:
            param = "1,4,2,Spell Clarity,2";
            // End:0xEE51
            break;
        // End:0xBA05
        case 16002:
            param = "1,3,1,Winter,9";
            // End:0xEE51
            break;
        // End:0xBA27
        case 16003:
            param = "1,3,1,Agility,9";
            // End:0xEE51
            break;
        // End:0xBA47
        case 16004:
            param = "1,3,1,Bleed,9";
            // End:0xEE51
            break;
        // End:0xBA68
        case 16005:
            param = "1,3,1,Ritual,9";
            // End:0xEE51
            break;
        // End:0xBA88
        case 16006:
            param = "1,3,1,Stone,9";
            // End:0xEE51
            break;
        // End:0xBAA7
        case 16007:
            param = "1,3,1,Fear,9";
            // End:0xEE51
            break;
        // End:0xBACC
        case 16008:
            param = "1,3,1,Prominence,9";
            // End:0xEE51
            break;
        // End:0xBAEC
        case 16009:
            param = "1,3,1,Peace,9";
            // End:0xEE51
            break;
        // End:0xBB0C
        case 16010:
            param = "1,3,1,Charm,9";
            // End:0xEE51
            break;
        // End:0xBB31
        case 16011:
            param = "1,3,1,Aggression,9";
            // End:0xEE51
            break;
        // End:0xBB54
        case 16012:
            param = "1,3,1,Guidance,9";
            // End:0xEE51
            break;
        // End:0xBB73
        case 16013:
            param = "1,3,1,Hold,9";
            // End:0xEE51
            break;
        // End:0xBB99
        case 16014:
            param = "1,3,1,Solar Flare,9";
            // End:0xEE51
            break;
        // End:0xBBC0
        case 16015:
            param = "1,3,1,Heal Empower,9";
            // End:0xEE51
            break;
        // End:0xBBE1
        case 16016:
            param = "1,3,1,Prayer,9";
            // End:0xEE51
            break;
        // End:0xBC00
        case 16017:
            param = "1,3,1,Heal,9";
            // End:0xEE51
            break;
        // End:0xBC22
        case 16018:
            param = "1,3,1,Empower,9";
            // End:0xEE51
            break;
        // End:0xBC42
        case 16019:
            param = "1,3,1,Cheer,9";
            // End:0xEE51
            break;
        // End:0xBC68
        case 16020:
            param = "1,3,1,Battle Roar,9";
            // End:0xEE51
            break;
        // End:0xBC8F
        case 16021:
            param = "1,3,1,Blessed Body,9";
            // End:0xEE51
            break;
        // End:0xBCB6
        case 16022:
            param = "1,3,1,Blessed Soul,9";
            // End:0xEE51
            break;
        // End:0xBCDE
        case 16023:
            param = "1,3,1,Magic Barrier,9";
            // End:0xEE51
            break;
        // End:0xBD02
        case 16024:
            param = "1,3,1,Mana Burn,9";
            // End:0xEE51
            break;
        // End:0xBD26
        case 16025:
            param = "1,3,1,Mana Gain,9";
            // End:0xEE51
            break;
        // End:0xBD49
        case 16026:
            param = "1,3,1,Recharge,9";
            // End:0xEE51
            break;
        // End:0xBD6E
        case 16027:
            param = "1,3,1,Aura Flare,9";
            // End:0xEE51
            break;
        // End:0xBD8E
        case 16028:
            param = "1,3,1,Might,9";
            // End:0xEE51
            break;
        // End:0xBDB1
        case 16029:
            param = "1,3,1,Paralyze,9";
            // End:0xEE51
            break;
        // End:0xBDD2
        case 16030:
            param = "1,3,1,Shield,9";
            // End:0xEE51
            break;
        // End:0xBDF3
        case 16031:
            param = "1,3,1,Poison,9";
            // End:0xEE51
            break;
        // End:0xBE1B
        case 16032:
            param = "1,3,1,Duel Weakness,9";
            // End:0xEE51
            break;
        // End:0xBE40
        case 16033:
            param = "1,3,1,Duel Might,9";
            // End:0xEE51
            break;
        // End:0xBE61
        case 16034:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0xBE88
        case 16035:
            param = "1,3,1,Resurrection,9";
            // End:0xEE51
            break;
        // End:0xBEAD
        case 16036:
            param = "1,3,1,Self Stone,9";
            // End:0xEE51
            break;
        // End:0xBED7
        case 16037:
            param = "1,3,1,Self Prominence,9";
            // End:0xEE51
            break;
        // End:0xBF02
        case 16038:
            param = "1,3,1,Self Solar Flare,9";
            // End:0xEE51
            break;
        // End:0xBF2C
        case 16039:
            param = "1,3,1,Self Aura Flare,9";
            // End:0xEE51
            break;
        // End:0xBF58
        case 16040:
            param = "1,3,1,Self Shadow Flare,9";
            // End:0xEE51
            break;
        // End:0xBF83
        case 16041:
            param = "1,3,1,Self Hydro Blast,9";
            // End:0xEE51
            break;
        // End:0xBFAC
        case 16042:
            param = "1,3,1,Self Hurricane,9";
            // End:0xEE51
            break;
        // End:0xBFCC
        case 16043:
            param = "1,3,1,Sleep,9";
            // End:0xEE51
            break;
        // End:0xBFEB
        case 16044:
            param = "1,3,1,Slow,9";
            // End:0xEE51
            break;
        // End:0xC00A
        case 16045:
            param = "1,3,1,Stun,9";
            // End:0xEE51
            break;
        // End:0xC02D
        case 16046:
            param = "1,3,1,Ae Stone,9";
            // End:0xEE51
            break;
        // End:0xC055
        case 16047:
            param = "1,3,1,Ae Prominence,9";
            // End:0xEE51
            break;
        // End:0xC07E
        case 16048:
            param = "1,3,1,Ae Solar Flare,9";
            // End:0xEE51
            break;
        // End:0xC0A6
        case 16049:
            param = "1,3,1,Ae Aura Flare,9";
            // End:0xEE51
            break;
        // End:0xC0D0
        case 16050:
            param = "1,3,1,Ae Shadow Flare,9";
            // End:0xEE51
            break;
        // End:0xC0F9
        case 16051:
            param = "1,3,1,Ae Hydro Blast,9";
            // End:0xEE51
            break;
        // End:0xC120
        case 16052:
            param = "1,3,1,Ae Hurricane,9";
            // End:0xEE51
            break;
        // End:0xC140
        case 16053:
            param = "1,3,1,Trick,9";
            // End:0xEE51
            break;
        // End:0xC161
        case 16054:
            param = "1,3,1,Medusa,9";
            // End:0xEE51
            break;
        // End:0xC188
        case 16055:
            param = "1,3,1,Shadow Flare,9";
            // End:0xEE51
            break;
        // End:0xC1A9
        case 16056:
            param = "1,3,1,Unlock,9";
            // End:0xEE51
            break;
        // End:0xC1D2
        case 16057:
            param = "1,3,1,Vampiric Touch,9";
            // End:0xEE51
            break;
        // End:0xC1F8
        case 16058:
            param = "1,3,1,Hydro Blast,9";
            // End:0xEE51
            break;
        // End:0xC21C
        case 16059:
            param = "1,3,1,Hurricane,9";
            // End:0xEE51
            break;
        // End:0xC246
        case 16060:
            param = "1,3,3,Physical Winter,9";
            // End:0xEE51
            break;
        // End:0xC26F
        case 16061:
            param = "1,3,3,Physical Bleed,9";
            // End:0xEE51
            break;
        // End:0xC297
        case 16062:
            param = "1,3,3,Physical Fear,9";
            // End:0xEE51
            break;
        // End:0xC2BF
        case 16063:
            param = "1,3,3,Physical Hold,9";
            // End:0xEE51
            break;
        // End:0xC2E9
        case 16064:
            param = "1,3,3,Physical Poison,9";
            // End:0xEE51
            break;
        // End:0xC313
        case 16065:
            param = "1,3,3,Physical Medusa,9";
            // End:0xEE51
            break;
        // End:0xC33D
        case 16066:
            param = "1,3,3,Critical Winter,9";
            // End:0xEE51
            break;
        // End:0xC366
        case 16067:
            param = "1,3,3,Critical Bleed,9";
            // End:0xEE51
            break;
        // End:0xC38E
        case 16068:
            param = "1,3,3,Critical Fear,9";
            // End:0xEE51
            break;
        // End:0xC3B6
        case 16069:
            param = "1,3,3,Critical Hold,9";
            // End:0xEE51
            break;
        // End:0xC3E0
        case 16070:
            param = "1,3,3,Critical Poison,9";
            // End:0xEE51
            break;
        // End:0xC40A
        case 16071:
            param = "1,3,3,Critical Medusa,9";
            // End:0xEE51
            break;
        // End:0xC42B
        case 16072:
            param = "1,3,3,Winter,9";
            // End:0xEE51
            break;
        // End:0xC44D
        case 16073:
            param = "1,3,3,Agility,9";
            // End:0xEE51
            break;
        // End:0xC46D
        case 16074:
            param = "1,3,3,Bleed,9";
            // End:0xEE51
            break;
        // End:0xC48E
        case 16075:
            param = "1,3,3,Ritual,9";
            // End:0xEE51
            break;
        // End:0xC4AE
        case 16076:
            param = "1,3,3,Focus,9";
            // End:0xEE51
            break;
        // End:0xC4CE
        case 16077:
            param = "1,3,3,Charm,9";
            // End:0xEE51
            break;
        // End:0xC4F1
        case 16078:
            param = "1,3,3,Guidance,9";
            // End:0xEE51
            break;
        // End:0xC510
        case 16079:
            param = "1,3,3,Hold,9";
            // End:0xEE51
            break;
        // End:0xC531
        case 16080:
            param = "1,3,3,Prayer,9";
            // End:0xEE51
            break;
        // End:0xC550
        case 16081:
            param = "1,3,3,Heal,9";
            // End:0xEE51
            break;
        // End:0xC572
        case 16082:
            param = "1,3,3,Empower,9";
            // End:0xEE51
            break;
        // End:0xC597
        case 16083:
            param = "1,3,3,Wild Magic,9";
            // End:0xEE51
            break;
        // End:0xC5B7
        case 16084:
            param = "1,3,3,Cheer,9";
            // End:0xEE51
            break;
        // End:0xC5DE
        case 16085:
            param = "1,3,3,Blessed Body,9";
            // End:0xEE51
            break;
        // End:0xC605
        case 16086:
            param = "1,3,3,Blessed Soul,9";
            // End:0xEE51
            break;
        // End:0xC62D
        case 16087:
            param = "1,3,3,Magic Barrier,9";
            // End:0xEE51
            break;
        // End:0xC64D
        case 16088:
            param = "1,3,3,Might,9";
            // End:0xEE51
            break;
        // End:0xC66E
        case 16089:
            param = "1,3,3,Shield,9";
            // End:0xEE51
            break;
        // End:0xC68F
        case 16090:
            param = "1,3,3,Poison,9";
            // End:0xEE51
            break;
        // End:0xC6B7
        case 16091:
            param = "1,3,3,Duel Weakness,9";
            // End:0xEE51
            break;
        // End:0xC6DC
        case 16092:
            param = "1,3,3,Duel Might,9";
            // End:0xEE51
            break;
        // End:0xC6FC
        case 16093:
            param = "1,3,3,Sleep,9";
            // End:0xEE51
            break;
        // End:0xC71B
        case 16094:
            param = "1,3,3,Slow,9";
            // End:0xEE51
            break;
        // End:0xC744
        case 16095:
            param = "1,3,3,Magical Winter,9";
            // End:0xEE51
            break;
        // End:0xC76C
        case 16096:
            param = "1,3,3,Magical Bleed,9";
            // End:0xEE51
            break;
        // End:0xC793
        case 16097:
            param = "1,3,3,Magical Fear,9";
            // End:0xEE51
            break;
        // End:0xC7BA
        case 16098:
            param = "1,3,3,Magical Hold,9";
            // End:0xEE51
            break;
        // End:0xC7E3
        case 16099:
            param = "1,3,3,Magical Poison,9";
            // End:0xEE51
            break;
        // End:0xC80C
        case 16100:
            param = "1,3,3,Magical Medusa,9";
            // End:0xEE51
            break;
        // End:0xC833
        case 16101:
            param = "1,3,2,Heal Empower,9";
            // End:0xEE51
            break;
        // End:0xC854
        case 16102:
            param = "1,3,2,Prayer,9";
            // End:0xEE51
            break;
        // End:0xC876
        case 16103:
            param = "1,3,2,Empower,9";
            // End:0xEE51
            break;
        // End:0xC89E
        case 16104:
            param = "1,3,2,Magic Barrier,9";
            // End:0xEE51
            break;
        // End:0xC8BE
        case 16105:
            param = "1,3,2,Might,9";
            // End:0xEE51
            break;
        // End:0xC8DF
        case 16106:
            param = "1,3,2,Shield,9";
            // End:0xEE51
            break;
        // End:0xC904
        case 16107:
            param = "1,3,2,Duel Might,9";
            // End:0xEE51
            break;
        // End:0xC92B
        case 16108:
            param = "1,3,2,Weight Limit,9";
            // End:0xEE51
            break;
        // End:0xC94D
        case 16109:
            param = "1,4,1,Refresh,2";
            // End:0xEE51
            break;
        // End:0xC96F
        case 16110:
            param = "1,4,1,Clarity,2";
            // End:0xEE51
            break;
        // End:0xC98F
        case 16111:
            param = "1,4,1,Focus,9";
            // End:0xEE51
            break;
        // End:0xC9B8
        case 16112:
            param = "1,4,1,Reflect Damage,2";
            // End:0xEE51
            break;
        // End:0xC9D7
        case 16113:
            param = "1,4,1,Doom,9";
            // End:0xEE51
            break;
        // End:0xC9F8
        case 16114:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0xCA23
        case 16115:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0xCA48
        case 16116:
            param = "1,4,1,Wild Magic,9";
            // End:0xEE51
            break;
        // End:0xCA6F
        case 16117:
            param = "1,4,1,Party Recall,2";
            // End:0xEE51
            break;
        // End:0xCA91
        case 16118:
            param = "1,4,1,Silence,9";
            // End:0xEE51
            break;
        // End:0xCAB9
        case 16119:
            param = "1,4,1,Skill Refresh,2";
            // End:0xEE51
            break;
        // End:0xCAE1
        case 16120:
            param = "1,4,1,Skill Clarity,2";
            // End:0xEE51
            break;
        // End:0xCB09
        case 16121:
            param = "1,4,1,Music Refresh,2";
            // End:0xEE51
            break;
        // End:0xCB31
        case 16122:
            param = "1,4,1,Music Clarity,2";
            // End:0xEE51
            break;
        // End:0xCB59
        case 16123:
            param = "1,4,1,Spell Refresh,2";
            // End:0xEE51
            break;
        // End:0xCB81
        case 16124:
            param = "1,4,1,Spell Clarity,2";
            // End:0xEE51
            break;
        // End:0xCBA3
        case 16125:
            param = "1,4,1,Stealth,2";
            // End:0xEE51
            break;
        // End:0xCBCB
        case 16126:
            param = "1,4,1,Vampiric Rage,9";
            // End:0xEE51
            break;
        // End:0xCBF3
        case 16127:
            param = "1,4,3,Physical Doom,9";
            // End:0xEE51
            break;
        // End:0xCC20
        case 16128:
            param = "1,4,3,Physical Mana Burn,9";
            // End:0xEE51
            break;
        // End:0xCC4C
        case 16129:
            param = "1,4,3,Physical Paralyze,9";
            // End:0xEE51
            break;
        // End:0xCC77
        case 16130:
            param = "1,4,3,Physical Silence,9";
            // End:0xEE51
            break;
        // End:0xCCA0
        case 16131:
            param = "1,4,3,Physical Sleep,9";
            // End:0xEE51
            break;
        // End:0xCCC8
        case 16132:
            param = "1,4,3,Physical Stun,9";
            // End:0xEE51
            break;
        // End:0xCCF0
        case 16133:
            param = "1,4,3,Critical Doom,9";
            // End:0xEE51
            break;
        // End:0xCD1D
        case 16134:
            param = "1,4,3,Critical Mana Burn,9";
            // End:0xEE51
            break;
        // End:0xCD49
        case 16135:
            param = "1,4,3,Critical Paralyze,9";
            // End:0xEE51
            break;
        // End:0xCD74
        case 16136:
            param = "1,4,3,Critical Silence,9";
            // End:0xEE51
            break;
        // End:0xCD9D
        case 16137:
            param = "1,4,3,Critical Sleep,9";
            // End:0xEE51
            break;
        // End:0xCDC5
        case 16138:
            param = "1,4,3,Critical Stun,9";
            // End:0xEE51
            break;
        // End:0xCDE4
        case 16139:
            param = "1,4,3,Doom,9";
            // End:0xEE51
            break;
        // End:0xCE03
        case 16140:
            param = "1,4,3,Fear,9";
            // End:0xEE51
            break;
        // End:0xCE27
        case 16141:
            param = "1,4,3,Mana Gain,9";
            // End:0xEE51
            break;
        // End:0xCE4A
        case 16142:
            param = "1,4,3,Recharge,9";
            // End:0xEE51
            break;
        // End:0xCE6D
        case 16143:
            param = "1,4,3,Paralyze,9";
            // End:0xEE51
            break;
        // End:0xCE8F
        case 16144:
            param = "1,4,3,Silence,9";
            // End:0xEE51
            break;
        // End:0xCEAE
        case 16145:
            param = "1,4,3,Stun,9";
            // End:0xEE51
            break;
        // End:0xCECF
        case 16146:
            param = "1,4,3,Medusa,9";
            // End:0xEE51
            break;
        // End:0xCEF6
        case 16147:
            param = "1,4,3,Magical Doom,9";
            // End:0xEE51
            break;
        // End:0xCF22
        case 16148:
            param = "1,4,3,Magical Mana Burn,9";
            // End:0xEE51
            break;
        // End:0xCF4D
        case 16149:
            param = "1,4,3,Magical Paralyze,9";
            // End:0xEE51
            break;
        // End:0xCF77
        case 16150:
            param = "1,4,3,Magical Silence,9";
            // End:0xEE51
            break;
        // End:0xCF9F
        case 16151:
            param = "1,4,3,Magical Sleep,9";
            // End:0xEE51
            break;
        // End:0xCFC6
        case 16152:
            param = "1,4,3,Magical Stun,9";
            // End:0xEE51
            break;
        // End:0xCFE8
        case 16153:
            param = "1,4,2,Clarity,2";
            // End:0xEE51
            break;
        // End:0xD00A
        case 16154:
            param = "1,4,2,Agility,9";
            // End:0xEE51
            break;
        // End:0xD02A
        case 16155:
            param = "1,4,2,Focus,9";
            // End:0xEE51
            break;
        // End:0xD053
        case 16156:
            param = "1,4,2,Reflect Damage,2";
            // End:0xEE51
            break;
        // End:0xD076
        case 16157:
            param = "1,4,2,Guidance,9";
            // End:0xEE51
            break;
        // End:0xD09B
        case 16158:
            param = "1,4,2,Wild Magic,9";
            // End:0xEE51
            break;
        // End:0xD0BF
        case 16159:
            param = "1,4,2,Mana Gain,9";
            // End:0xEE51
            break;
        // End:0xD0E7
        case 16160:
            param = "1,4,2,Skill Clarity,2";
            // End:0xEE51
            break;
        // End:0xD10F
        case 16161:
            param = "1,4,2,Music Clarity,2";
            // End:0xEE51
            break;
        // End:0xD137
        case 16162:
            param = "1,4,2,Spell Clarity,2";
            // End:0xEE51
            break;
        // End:0xD159
        case 16180:
            param = "1,3,1,Winter,10";
            // End:0xEE51
            break;
        // End:0xD17C
        case 16181:
            param = "1,3,1,Agility,10";
            // End:0xEE51
            break;
        // End:0xD19D
        case 16182:
            param = "1,3,1,Bleed,10";
            // End:0xEE51
            break;
        // End:0xD1BF
        case 16183:
            param = "1,3,1,Ritual,10";
            // End:0xEE51
            break;
        // End:0xD1E0
        case 16184:
            param = "1,3,1,Stone,10";
            // End:0xEE51
            break;
        // End:0xD200
        case 16185:
            param = "1,3,1,Fear,10";
            // End:0xEE51
            break;
        // End:0xD226
        case 16186:
            param = "1,3,1,Prominence,10";
            // End:0xEE51
            break;
        // End:0xD247
        case 16187:
            param = "1,3,1,Peace,10";
            // End:0xEE51
            break;
        // End:0xD268
        case 16188:
            param = "1,3,1,Charm,10";
            // End:0xEE51
            break;
        // End:0xD28E
        case 16189:
            param = "1,3,1,Aggression,10";
            // End:0xEE51
            break;
        // End:0xD2B2
        case 16190:
            param = "1,3,1,Guidance,10";
            // End:0xEE51
            break;
        // End:0xD2D2
        case 16191:
            param = "1,3,1,Hold,10";
            // End:0xEE51
            break;
        // End:0xD2F9
        case 16192:
            param = "1,3,1,Solar Flare,10";
            // End:0xEE51
            break;
        // End:0xD321
        case 16193:
            param = "1,3,1,Heal Empower,10";
            // End:0xEE51
            break;
        // End:0xD343
        case 16194:
            param = "1,3,1,Prayer,10";
            // End:0xEE51
            break;
        // End:0xD363
        case 16195:
            param = "1,3,1,Heal,10";
            // End:0xEE51
            break;
        // End:0xD386
        case 16196:
            param = "1,3,1,Empower,10";
            // End:0xEE51
            break;
        // End:0xD3A7
        case 16197:
            param = "1,3,1,Cheer,10";
            // End:0xEE51
            break;
        // End:0xD3CE
        case 16198:
            param = "1,3,1,Battle Roar,10";
            // End:0xEE51
            break;
        // End:0xD3F6
        case 16199:
            param = "1,3,1,Blessed Body,10";
            // End:0xEE51
            break;
        // End:0xD41E
        case 16200:
            param = "1,3,1,Blessed Soul,10";
            // End:0xEE51
            break;
        // End:0xD447
        case 16201:
            param = "1,3,1,Magic Barrier,10";
            // End:0xEE51
            break;
        // End:0xD46C
        case 16202:
            param = "1,3,1,Mana Burn,10";
            // End:0xEE51
            break;
        // End:0xD491
        case 16203:
            param = "1,3,1,Mana Gain,10";
            // End:0xEE51
            break;
        // End:0xD4B5
        case 16204:
            param = "1,3,1,Recharge,10";
            // End:0xEE51
            break;
        // End:0xD4DB
        case 16205:
            param = "1,3,1,Aura Flare,10";
            // End:0xEE51
            break;
        // End:0xD4FC
        case 16206:
            param = "1,3,1,Might,10";
            // End:0xEE51
            break;
        // End:0xD520
        case 16207:
            param = "1,3,1,Paralyze,10";
            // End:0xEE51
            break;
        // End:0xD542
        case 16208:
            param = "1,3,1,Shield,10";
            // End:0xEE51
            break;
        // End:0xD564
        case 16209:
            param = "1,3,1,Poison,10";
            // End:0xEE51
            break;
        // End:0xD58D
        case 16210:
            param = "1,3,1,Duel Weakness,10";
            // End:0xEE51
            break;
        // End:0xD5B3
        case 16211:
            param = "1,3,1,Duel Might,10";
            // End:0xEE51
            break;
        // End:0xD5D4
        case 16212:
            param = "1,3,1,Recall,1";
            // End:0xEE51
            break;
        // End:0xD5FB
        case 16213:
            param = "1,3,1,Resurrection,9";
            // End:0xEE51
            break;
        // End:0xD621
        case 16214:
            param = "1,3,1,Self Stone,10";
            // End:0xEE51
            break;
        // End:0xD64C
        case 16215:
            param = "1,3,1,Self Prominence,10";
            // End:0xEE51
            break;
        // End:0xD678
        case 16216:
            param = "1,3,1,Self Solar Flare,10";
            // End:0xEE51
            break;
        // End:0xD6A3
        case 16217:
            param = "1,3,1,Self Aura Flare,10";
            // End:0xEE51
            break;
        // End:0xD6D0
        case 16218:
            param = "1,3,1,Self Shadow Flare,10";
            // End:0xEE51
            break;
        // End:0xD6FC
        case 16219:
            param = "1,3,1,Self Hydro Blast,10";
            // End:0xEE51
            break;
        // End:0xD726
        case 16220:
            param = "1,3,1,Self Hurricane,10";
            // End:0xEE51
            break;
        // End:0xD747
        case 16221:
            param = "1,3,1,Sleep,10";
            // End:0xEE51
            break;
        // End:0xD767
        case 16222:
            param = "1,3,1,Slow,10";
            // End:0xEE51
            break;
        // End:0xD787
        case 16223:
            param = "1,3,1,Stun,10";
            // End:0xEE51
            break;
        // End:0xD7AB
        case 16224:
            param = "1,3,1,Ae Stone,10";
            // End:0xEE51
            break;
        // End:0xD7D4
        case 16225:
            param = "1,3,1,Ae Prominence,10";
            // End:0xEE51
            break;
        // End:0xD7FE
        case 16226:
            param = "1,3,1,Ae Solar Flare,10";
            // End:0xEE51
            break;
        // End:0xD827
        case 16227:
            param = "1,3,1,Ae Aura Flare,10";
            // End:0xEE51
            break;
        // End:0xD852
        case 16228:
            param = "1,3,1,Ae Shadow Flare,10";
            // End:0xEE51
            break;
        // End:0xD87C
        case 16229:
            param = "1,3,1,Ae Hydro Blast,10";
            // End:0xEE51
            break;
        // End:0xD8A4
        case 16230:
            param = "1,3,1,Ae Hurricane,10";
            // End:0xEE51
            break;
        // End:0xD8C5
        case 16231:
            param = "1,3,1,Trick,10";
            // End:0xEE51
            break;
        // End:0xD8E7
        case 16232:
            param = "1,3,1,Medusa,10";
            // End:0xEE51
            break;
        // End:0xD90F
        case 16233:
            param = "1,3,1,Shadow Flare,10";
            // End:0xEE51
            break;
        // End:0xD931
        case 16234:
            param = "1,3,1,Unlock,10";
            // End:0xEE51
            break;
        // End:0xD95B
        case 16235:
            param = "1,3,1,Vampiric Touch,10";
            // End:0xEE51
            break;
        // End:0xD982
        case 16236:
            param = "1,3,1,Hydro Blast,10";
            // End:0xEE51
            break;
        // End:0xD9A7
        case 16237:
            param = "1,3,1,Hurricane,10";
            // End:0xEE51
            break;
        // End:0xD9D2
        case 16238:
            param = "1,3,3,Physical Winter,10";
            // End:0xEE51
            break;
        // End:0xD9FC
        case 16239:
            param = "1,3,3,Physical Bleed,10";
            // End:0xEE51
            break;
        // End:0xDA25
        case 16240:
            param = "1,3,3,Physical Fear,10";
            // End:0xEE51
            break;
        // End:0xDA4E
        case 16241:
            param = "1,3,3,Physical Hold,10";
            // End:0xEE51
            break;
        // End:0xDA79
        case 16242:
            param = "1,3,3,Physical Poison,10";
            // End:0xEE51
            break;
        // End:0xDAA4
        case 16243:
            param = "1,3,3,Physical Medusa,10";
            // End:0xEE51
            break;
        // End:0xDACF
        case 16244:
            param = "1,3,3,Critical Winter,10";
            // End:0xEE51
            break;
        // End:0xDAF9
        case 16245:
            param = "1,3,3,Critical Bleed,10";
            // End:0xEE51
            break;
        // End:0xDB22
        case 16246:
            param = "1,3,3,Critical Fear,10";
            // End:0xEE51
            break;
        // End:0xDB4B
        case 16247:
            param = "1,3,3,Critical Hold,10";
            // End:0xEE51
            break;
        // End:0xDB76
        case 16248:
            param = "1,3,3,Critical Poison,10";
            // End:0xEE51
            break;
        // End:0xDBA1
        case 16249:
            param = "1,3,3,Critical Medusa,10";
            // End:0xEE51
            break;
        // End:0xDBC3
        case 16250:
            param = "1,3,3,Winter,10";
            // End:0xEE51
            break;
        // End:0xDBE6
        case 16251:
            param = "1,3,3,Agility,10";
            // End:0xEE51
            break;
        // End:0xDC07
        case 16252:
            param = "1,3,3,Bleed,10";
            // End:0xEE51
            break;
        // End:0xDC29
        case 16253:
            param = "1,3,3,Ritual,10";
            // End:0xEE51
            break;
        // End:0xDC4A
        case 16254:
            param = "1,3,3,Focus,10";
            // End:0xEE51
            break;
        // End:0xDC6B
        case 16255:
            param = "1,3,3,Charm,10";
            // End:0xEE51
            break;
        // End:0xDC8F
        case 16256:
            param = "1,3,3,Guidance,10";
            // End:0xEE51
            break;
        // End:0xDCAF
        case 16257:
            param = "1,3,3,Hold,10";
            // End:0xEE51
            break;
        // End:0xDCD1
        case 16258:
            param = "1,3,3,Prayer,10";
            // End:0xEE51
            break;
        // End:0xDCF1
        case 16259:
            param = "1,3,3,Heal,10";
            // End:0xEE51
            break;
        // End:0xDD14
        case 16260:
            param = "1,3,3,Empower,10";
            // End:0xEE51
            break;
        // End:0xDD3A
        case 16261:
            param = "1,3,3,Wild Magic,10";
            // End:0xEE51
            break;
        // End:0xDD5B
        case 16262:
            param = "1,3,3,Cheer,10";
            // End:0xEE51
            break;
        // End:0xDD83
        case 16263:
            param = "1,3,3,Blessed Body,10";
            // End:0xEE51
            break;
        // End:0xDDAB
        case 16264:
            param = "1,3,3,Blessed Soul,10";
            // End:0xEE51
            break;
        // End:0xDDD4
        case 16265:
            param = "1,3,3,Magic Barrier,10";
            // End:0xEE51
            break;
        // End:0xDDF5
        case 16266:
            param = "1,3,3,Might,10";
            // End:0xEE51
            break;
        // End:0xDE17
        case 16267:
            param = "1,3,3,Shield,10";
            // End:0xEE51
            break;
        // End:0xDE39
        case 16268:
            param = "1,3,3,Poison,10";
            // End:0xEE51
            break;
        // End:0xDE62
        case 16269:
            param = "1,3,3,Duel Weakness,10";
            // End:0xEE51
            break;
        // End:0xDE88
        case 16270:
            param = "1,3,3,Duel Might,10";
            // End:0xEE51
            break;
        // End:0xDEA9
        case 16271:
            param = "1,3,3,Sleep,10";
            // End:0xEE51
            break;
        // End:0xDEC9
        case 16272:
            param = "1,3,3,Slow,10";
            // End:0xEE51
            break;
        // End:0xDEF3
        case 16273:
            param = "1,3,3,Magical Winter,10";
            // End:0xEE51
            break;
        // End:0xDF1C
        case 16274:
            param = "1,3,3,Magical Bleed,10";
            // End:0xEE51
            break;
        // End:0xDF44
        case 16275:
            param = "1,3,3,Magical Fear,10";
            // End:0xEE51
            break;
        // End:0xDF6C
        case 16276:
            param = "1,3,3,Magical Hold,10";
            // End:0xEE51
            break;
        // End:0xDF96
        case 16277:
            param = "1,3,3,Magical Poison,10";
            // End:0xEE51
            break;
        // End:0xDFC0
        case 16278:
            param = "1,3,3,Magical Medusa,10";
            // End:0xEE51
            break;
        // End:0xDFE8
        case 16279:
            param = "1,3,2,Heal Empower,10";
            // End:0xEE51
            break;
        // End:0xE00A
        case 16280:
            param = "1,3,2,Prayer,10";
            // End:0xEE51
            break;
        // End:0xE02D
        case 16281:
            param = "1,3,2,Empower,10";
            // End:0xEE51
            break;
        // End:0xE056
        case 16282:
            param = "1,3,2,Magic Barrier,10";
            // End:0xEE51
            break;
        // End:0xE077
        case 16283:
            param = "1,3,2,Might,10";
            // End:0xEE51
            break;
        // End:0xE099
        case 16284:
            param = "1,3,2,Shield,10";
            // End:0xEE51
            break;
        // End:0xE0BF
        case 16285:
            param = "1,3,2,Duel Might,10";
            // End:0xEE51
            break;
        // End:0xE0E7
        case 16286:
            param = "1,3,2,Weight Limit,10";
            // End:0xEE51
            break;
        // End:0xE109
        case 16287:
            param = "1,4,1,Refresh,3";
            // End:0xEE51
            break;
        // End:0xE12B
        case 16288:
            param = "1,4,1,Clarity,3";
            // End:0xEE51
            break;
        // End:0xE14C
        case 16289:
            param = "1,4,1,Focus,10";
            // End:0xEE51
            break;
        // End:0xE175
        case 16290:
            param = "1,4,1,Reflect Damage,3";
            // End:0xEE51
            break;
        // End:0xE195
        case 16291:
            param = "1,4,1,Doom,10";
            // End:0xEE51
            break;
        // End:0xE1B6
        case 16292:
            param = "1,4,1,Recall,2";
            // End:0xEE51
            break;
        // End:0xE1E1
        case 16293:
            param = "1,4,1,Celestial Shield,1";
            // End:0xEE51
            break;
        // End:0xE207
        case 16294:
            param = "1,4,1,Wild Magic,10";
            // End:0xEE51
            break;
        // End:0xE22E
        case 16295:
            param = "1,4,1,Party Recall,2";
            // End:0xEE51
            break;
        // End:0xE251
        case 16296:
            param = "1,4,1,Silence,10";
            // End:0xEE51
            break;
        // End:0xE279
        case 16297:
            param = "1,4,1,Skill Refresh,3";
            // End:0xEE51
            break;
        // End:0xE2A1
        case 16298:
            param = "1,4,1,Skill Clarity,3";
            // End:0xEE51
            break;
        // End:0xE2C9
        case 16299:
            param = "1,4,1,Music Refresh,3";
            // End:0xEE51
            break;
        // End:0xE2F1
        case 16300:
            param = "1,4,1,Music Clarity,3";
            // End:0xEE51
            break;
        // End:0xE319
        case 16301:
            param = "1,4,1,Spell Refresh,3";
            // End:0xEE51
            break;
        // End:0xE341
        case 16302:
            param = "1,4,1,Spell Clarity,3";
            // End:0xEE51
            break;
        // End:0xE363
        case 16303:
            param = "1,4,1,Stealth,3";
            // End:0xEE51
            break;
        // End:0xE38C
        case 16304:
            param = "1,4,1,Vampiric Rage,10";
            // End:0xEE51
            break;
        // End:0xE3B5
        case 16305:
            param = "1,4,3,Physical Doom,10";
            // End:0xEE51
            break;
        // End:0xE3E3
        case 16306:
            param = "1,4,3,Physical Mana Burn,10";
            // End:0xEE51
            break;
        // End:0xE410
        case 16307:
            param = "1,4,3,Physical Paralyze,10";
            // End:0xEE51
            break;
        // End:0xE43C
        case 16308:
            param = "1,4,3,Physical Silence,10";
            // End:0xEE51
            break;
        // End:0xE466
        case 16309:
            param = "1,4,3,Physical Sleep,10";
            // End:0xEE51
            break;
        // End:0xE48F
        case 16310:
            param = "1,4,3,Physical Stun,10";
            // End:0xEE51
            break;
        // End:0xE4B8
        case 16311:
            param = "1,4,3,Critical Doom,10";
            // End:0xEE51
            break;
        // End:0xE4E6
        case 16312:
            param = "1,4,3,Critical Mana Burn,10";
            // End:0xEE51
            break;
        // End:0xE513
        case 16313:
            param = "1,4,3,Critical Paralyze,10";
            // End:0xEE51
            break;
        // End:0xE53F
        case 16314:
            param = "1,4,3,Critical Silence,10";
            // End:0xEE51
            break;
        // End:0xE569
        case 16315:
            param = "1,4,3,Critical Sleep,10";
            // End:0xEE51
            break;
        // End:0xE592
        case 16316:
            param = "1,4,3,Critical Stun,10";
            // End:0xEE51
            break;
        // End:0xE5B2
        case 16317:
            param = "1,4,3,Doom,10";
            // End:0xEE51
            break;
        // End:0xE5D2
        case 16318:
            param = "1,4,3,Fear,10";
            // End:0xEE51
            break;
        // End:0xE5F7
        case 16319:
            param = "1,4,3,Mana Gain,10";
            // End:0xEE51
            break;
        // End:0xE61B
        case 16320:
            param = "1,4,3,Recharge,10";
            // End:0xEE51
            break;
        // End:0xE63F
        case 16321:
            param = "1,4,3,Paralyze,10";
            // End:0xEE51
            break;
        // End:0xE662
        case 16322:
            param = "1,4,3,Silence,10";
            // End:0xEE51
            break;
        // End:0xE682
        case 16323:
            param = "1,4,3,Stun,10";
            // End:0xEE51
            break;
        // End:0xE6A4
        case 16324:
            param = "1,4,3,Medusa,10";
            // End:0xEE51
            break;
        // End:0xE6CC
        case 16325:
            param = "1,4,3,Magical Doom,10";
            // End:0xEE51
            break;
        // End:0xE6F9
        case 16326:
            param = "1,4,3,Magical Mana Burn,10";
            // End:0xEE51
            break;
        // End:0xE725
        case 16327:
            param = "1,4,3,Magical Paralyze,10";
            // End:0xEE51
            break;
        // End:0xE750
        case 16328:
            param = "1,4,3,Magical Silence,10";
            // End:0xEE51
            break;
        // End:0xE779
        case 16329:
            param = "1,4,3,Magical Sleep,10";
            // End:0xEE51
            break;
        // End:0xE7A1
        case 16330:
            param = "1,4,3,Magical Stun,10";
            // End:0xEE51
            break;
        // End:0xE7C3
        case 16331:
            param = "1,4,2,Clarity,3";
            // End:0xEE51
            break;
        // End:0xE7E6
        case 16332:
            param = "1,4,2,Agility,10";
            // End:0xEE51
            break;
        // End:0xE807
        case 16333:
            param = "1,4,2,Focus,10";
            // End:0xEE51
            break;
        // End:0xE830
        case 16334:
            param = "1,4,2,Reflect Damage,3";
            // End:0xEE51
            break;
        // End:0xE854
        case 16335:
            param = "1,4,2,Guidance,10";
            // End:0xEE51
            break;
        // End:0xE87A
        case 16336:
            param = "1,4,2,Wild Magic,10";
            // End:0xEE51
            break;
        // End:0xE89F
        case 16337:
            param = "1,4,2,Mana Gain,10";
            // End:0xEE51
            break;
        // End:0xE8C7
        case 16338:
            param = "1,4,2,Skill Clarity,3";
            // End:0xEE51
            break;
        // End:0xE8EF
        case 16339:
            param = "1,4,2,Music Clarity,3";
            // End:0xEE51
            break;
        // End:0xE917
        case 16340:
            param = "1,4,2,Spell Clarity,3";
            // End:0xEE51
            break;
        // End:0xE938
        case 16341:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xE959
        case 16342:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xE97A
        case 16343:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xE99B
        case 16344:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xE9BC
        case 16345:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xE9DD
        case 16346:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xE9FE
        case 16347:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xEA1F
        case 16348:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xEA40
        case 16349:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xEA61
        case 16350:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xEA82
        case 16351:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xEAA3
        case 16352:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xEAC4
        case 16353:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xEAE5
        case 16354:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xEB06
        case 16355:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xEB27
        case 16356:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xEB48
        case 16357:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xEB69
        case 16358:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xEB8A
        case 16359:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xEBAB
        case 16360:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xEBCC
        case 16361:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xEBED
        case 16362:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xEC0E
        case 16363:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xEC2F
        case 16364:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xEC50
        case 16365:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xEC71
        case 16366:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xEC92
        case 16367:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xECB3
        case 16368:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xECD4
        case 16369:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xECF5
        case 16370:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xED16
        case 16371:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xED37
        case 16372:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xED58
        case 16373:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xED79
        case 16374:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xED9A
        case 16375:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xEDBB
        case 16376:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xEDDC
        case 16377:
            param = "1,4,4,STR +1,1";
            // End:0xEE51
            break;
        // End:0xEDFD
        case 16378:
            param = "1,4,4,CON +1,1";
            // End:0xEE51
            break;
        // End:0xEE1E
        case 16379:
            param = "1,4,4,INT +1,1";
            // End:0xEE51
            break;
        // End:0xEE3F
        case 16380:
            param = "1,4,4,MEN +1,1";
            // End:0xEE51
            break;
        // End:0xFFFF
        default:
            param = ",,,,";
            // End:0xEE51
            break;
            break;
    }
    ResultParam = param;
    return;
}

function string GetClassIconCustom(int ClassIDCustom)
{
    local string tempString;

    tempString = "";
    switch(ClassIDCustom)
    {
        // End:0x2C
        case 0:
            tempString = "Icon.skill0141";
            // End:0xA7E
            break;
        // End:0x49
        case 1:
            tempString = "Icon.skill0078";
            // End:0xA7E
            break;
        // End:0x67
        case 2:
            tempString = "Icon.skill0008";
            // End:0xA7E
            break;
        // End:0x85
        case 3:
            tempString = "Icon.skill0286";
            // End:0xA7E
            break;
        // End:0xA3
        case 4:
            tempString = "Icon.skill0110";
            // End:0xA7E
            break;
        // End:0xC1
        case 5:
            tempString = "Icon.skill0406";
            // End:0xA7E
            break;
        // End:0xDF
        case 6:
            tempString = "Icon.skill0283";
            // End:0xA7E
            break;
        // End:0xFD
        case 7:
            tempString = "Icon.skill0111";
            // End:0xA7E
            break;
        // End:0x11B
        case 8:
            tempString = "Icon.skill0263";
            // End:0xA7E
            break;
        // End:0x139
        case 9:
            tempString = "Icon.skill0313";
            // End:0xA7E
            break;
        // End:0x157
        case 10:
            tempString = "Icon.skill0146";
            // End:0xA7E
            break;
        // End:0x175
        case 11:
            tempString = "Icon.skill1220";
            // End:0xA7E
            break;
        // End:0x193
        case 12:
            tempString = "Icon.skill1289";
            // End:0xA7E
            break;
        // End:0x1B1
        case 13:
            tempString = "Icon.skill1263";
            // End:0xA7E
            break;
        // End:0x1CF
        case 14:
            tempString = "Icon.skill1331";
            // End:0xA7E
            break;
        // End:0x1ED
        case 15:
            tempString = "Icon.skill1016";
            // End:0xA7E
            break;
        // End:0x20B
        case 16:
            tempString = "Icon.skill1307";
            // End:0xA7E
            break;
        // End:0x229
        case 17:
            tempString = "Icon.skill1062";
            // End:0xA7E
            break;
        // End:0x247
        case 18:
            tempString = "Icon.skill0141";
            // End:0xA7E
            break;
        // End:0x265
        case 19:
            tempString = "Icon.skill0110";
            // End:0xA7E
            break;
        // End:0x283
        case 20:
            tempString = "Icon.skill0067";
            // End:0xA7E
            break;
        // End:0x2A1
        case 21:
            tempString = "Icon.skill0098";
            // End:0xA7E
            break;
        // End:0x2BF
        case 22:
            tempString = "Icon.skill0111";
            // End:0xA7E
            break;
        // End:0x2DD
        case 23:
            tempString = "Icon.skill0321";
            // End:0xA7E
            break;
        // End:0x2FB
        case 24:
            tempString = "Icon.skill0416";
            // End:0xA7E
            break;
        // End:0x319
        case 25:
            tempString = "Icon.skill0146";
            // End:0xA7E
            break;
        // End:0x337
        case 26:
            tempString = "Icon.skill1175";
            // End:0xA7E
            break;
        // End:0x355
        case 27:
            tempString = "Icon.skill1290";
            // End:0xA7E
            break;
        // End:0x373
        case 28:
            tempString = "Icon.skill1332";
            // End:0xA7E
            break;
        // End:0x391
        case 29:
            tempString = "Icon.skill1013";
            // End:0xA7E
            break;
        // End:0x3AF
        case 30:
            tempString = "Icon.skill1430";
            // End:0xA7E
            break;
        // End:0x3CD
        case 31:
            tempString = "Icon.skill0141";
            // End:0xA7E
            break;
        // End:0x3EB
        case 32:
            tempString = "Icon.skill0110";
            // End:0xA7E
            break;
        // End:0x409
        case 33:
            tempString = "Icon.skill0022";
            // End:0xA7E
            break;
        // End:0x427
        case 34:
            tempString = "Icon.skill0408";
            // End:0xA7E
            break;
        // End:0x445
        case 35:
            tempString = "Icon.skill0111";
            // End:0xA7E
            break;
        // End:0x463
        case 36:
            tempString = "Icon.skill0321";
            // End:0xA7E
            break;
        // End:0x481
        case 37:
            tempString = "Icon.skill0314";
            // End:0xA7E
            break;
        // End:0x49F
        case 38:
            tempString = "Icon.skill0141";
            // End:0xA7E
            break;
        // End:0x4BD
        case 39:
            tempString = "Icon.skill1178";
            // End:0xA7E
            break;
        // End:0x4DB
        case 40:
            tempString = "Icon.skill1291";
            // End:0xA7E
            break;
        // End:0x4F9
        case 41:
            tempString = "Icon.skill1333";
            // End:0xA7E
            break;
        // End:0x517
        case 42:
            tempString = "Icon.skill1059";
            // End:0xA7E
            break;
        // End:0x535
        case 43:
            tempString = "Icon.skill1430";
            // End:0xA7E
            break;
        // End:0x553
        case 44:
            tempString = "Icon.skill0146";
            // End:0xA7E
            break;
        // End:0x571
        case 45:
            tempString = "Icon.skill0176";
            // End:0xA7E
            break;
        // End:0x58F
        case 46:
            tempString = "Icon.skill0176";
            // End:0xA7E
            break;
        // End:0x5AD
        case 47:
            tempString = "Icon.skill0050";
            // End:0xA7E
            break;
        // End:0x5CB
        case 48:
            tempString = "Icon.skill0222";
            // End:0xA7E
            break;
        // End:0x5E9
        case 49:
            tempString = "Icon.skill0141";
            // End:0xA7E
            break;
        // End:0x607
        case 50:
            tempString = "Icon.skill1090";
            // End:0xA7E
            break;
        // End:0x625
        case 51:
            tempString = "Icon.skill1283";
            // End:0xA7E
            break;
        // End:0x643
        case 52:
            tempString = "Icon.skill1001";
            // End:0xA7E
            break;
        // End:0x661
        case 53:
            tempString = "Icon.skill0146";
            // End:0xA7E
            break;
        // End:0x67F
        case 54:
            tempString = "Icon.skill0254";
            // End:0xA7E
            break;
        // End:0x69D
        case 55:
            tempString = "Icon.skill0302";
            // End:0xA7E
            break;
        // End:0x6BB
        case 56:
            tempString = "Icon.skill0025";
            // End:0xA7E
            break;
        // End:0x6D9
        case 57:
            tempString = "Icon.skill0301";
            // End:0xA7E
            break;
        // End:0x6F7
        case 88:
            tempString = "Icon.skill0442";
            // End:0xA7E
            break;
        // End:0x715
        case 89:
            tempString = "Icon.skill0361";
            // End:0xA7E
            break;
        // End:0x733
        case 90:
            tempString = "Icon.skill0341";
            // End:0xA7E
            break;
        // End:0x751
        case 91:
            tempString = "Icon.skill0342";
            // End:0xA7E
            break;
        // End:0x76F
        case 92:
            tempString = "Icon.skill0131";
            // End:0xA7E
            break;
        // End:0x78D
        case 93:
            tempString = "Icon.skill0445";
            // End:0xA7E
            break;
        // End:0x7AB
        case 94:
            tempString = "Icon.skill1339";
            // End:0xA7E
            break;
        // End:0x7C9
        case 95:
            tempString = "Icon.skill1343";
            // End:0xA7E
            break;
        // End:0x7E7
        case 96:
            tempString = "Icon.skill1406";
            // End:0xA7E
            break;
        // End:0x805
        case 97:
            tempString = "Icon.skill1335";
            // End:0xA7E
            break;
        // End:0x823
        case 98:
            tempString = "Icon.skill1356";
            // End:0xA7E
            break;
        // End:0x841
        case 99:
            tempString = "Icon.skill0341";
            // End:0xA7E
            break;
        // End:0x85F
        case 100:
            tempString = "Icon.skill0437";
            // End:0xA7E
            break;
        // End:0x87D
        case 101:
            tempString = "Icon.skill0355";
            // End:0xA7E
            break;
        // End:0x89B
        case 102:
            tempString = "Icon.skill0413";
            // End:0xA7E
            break;
        // End:0x8B9
        case 103:
            tempString = "Icon.skill1340";
            // End:0xA7E
            break;
        // End:0x8D7
        case 104:
            tempString = "Icon.skill1407";
            // End:0xA7E
            break;
        // End:0x8F5
        case 105:
            tempString = "Icon.skill1355";
            // End:0xA7E
            break;
        // End:0x913
        case 106:
            tempString = "Icon.skill0342";
            // End:0xA7E
            break;
        // End:0x931
        case 107:
            tempString = "Icon.skill0367";
            // End:0xA7E
            break;
        // End:0x94F
        case 108:
            tempString = "Icon.skill0355";
            // End:0xA7E
            break;
        // End:0x96D
        case 109:
            tempString = "Icon.skill0414";
            // End:0xA7E
            break;
        // End:0x98B
        case 110:
            tempString = "Icon.skill1341";
            // End:0xA7E
            break;
        // End:0x9A9
        case 111:
            tempString = "Icon.skill1408";
            // End:0xA7E
            break;
        // End:0x9C7
        case 112:
            tempString = "Icon.skill1357";
            // End:0xA7E
            break;
        // End:0x9E5
        case 113:
            tempString = "Icon.skill0094";
            // End:0xA7E
            break;
        // End:0xA03
        case 114:
            tempString = "Icon.skill0443";
            // End:0xA7E
            break;
        // End:0xA21
        case 115:
            tempString = "Icon.skill1416";
            // End:0xA7E
            break;
        // End:0xA3F
        case 116:
            tempString = "Icon.skill1413";
            // End:0xA7E
            break;
        // End:0xA5D
        case 117:
            tempString = "Icon.skill0348";
            // End:0xA7E
            break;
        // End:0xA7B
        case 118:
            tempString = "Icon.skill0013";
            // End:0xA7E
            break;
        // End:0xFFFF
        default:
            break;
    }
    return tempString;
}

function bool isSongDanceCustom(int Id)
{
    local bool ResultBool;

    switch(Id)
    {
        // End:0x0F
        case 276:
        // End:0x17
        case 273:
        // End:0x1F
        case 365:
        // End:0x27
        case 275:
        // End:0x2F
        case 274:
        // End:0x37
        case 271:
        // End:0x3F
        case 272:
        // End:0x47
        case 310:
        // End:0x4F
        case 264:
        // End:0x57
        case 265:
        // End:0x5F
        case 266:
        // End:0x67
        case 267:
        // End:0x6F
        case 268:
        // End:0x77
        case 269:
        // End:0x7F
        case 349:
        // End:0x87
        case 270:
        // End:0x8F
        case 304:
        // End:0x97
        case 305:
        // End:0x9F
        case 306:
        // End:0xA7
        case 308:
        // End:0xAF
        case 363:
        // End:0xB7
        case 364:
        // End:0xBF
        case 529:
        // End:0xC7
        case 277:
        // End:0xCF
        case 307:
        // End:0xD7
        case 309:
        // End:0xDF
        case 311:
        // End:0xE7
        case 366:
        // End:0xEF
        case 530:
        // End:0x102
        case 915:
            ResultBool = true;
            // End:0x105
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

function bool isNoblesseCustom(int Id)
{
    local bool ResultBool;

    ResultBool = false;
    switch(Id)
    {
        // End:0x22
        case 1323:
            ResultBool = true;
            // End:0x25
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

function bool isDebuffCustom(int Id)
{
    local bool ResultBool;

    ResultBool = false;
    switch(Id)
    {
        // End:0x14
        case 28:
        // End:0x19
        case 92:
        // End:0x1E
        case 101:
        // End:0x23
        case 102:
        // End:0x28
        case 105:
        // End:0x2D
        case 115:
        // End:0x32
        case 129:
        // End:0x3A
        case 1069:
        // End:0x42
        case 1083:
        // End:0x4A
        case 1160:
        // End:0x52
        case 1164:
        // End:0x5A
        case 1167:
        // End:0x62
        case 1168:
        // End:0x6A
        case 1184:
        // End:0x72
        case 1201:
        // End:0x7A
        case 1206:
        // End:0x82
        case 1222:
        // End:0x8A
        case 1223:
        // End:0x92
        case 1224:
        // End:0x97
        case 100:
        // End:0x9C
        case 95:
        // End:0xA1
        case 96:
        // End:0xA6
        case 120:
        // End:0xAB
        case 223:
        // End:0xB3
        case 1092:
        // End:0xBB
        case 1095:
        // End:0xC3
        case 1096:
        // End:0xCB
        case 1097:
        // End:0xD3
        case 1099:
        // End:0xDB
        case 1100:
        // End:0xE3
        case 1101:
        // End:0xEB
        case 1102:
        // End:0xF3
        case 1107:
        // End:0xFB
        case 1208:
        // End:0x103
        case 1209:
        // End:0x108
        case 18:
        // End:0x10D
        case 48:
        // End:0x112
        case 65:
        // End:0x117
        case 84:
        // End:0x11C
        case 97:
        // End:0x121
        case 98:
        // End:0x126
        case 103:
        // End:0x12B
        case 106:
        // End:0x130
        case 107:
        // End:0x135
        case 116:
        // End:0x13A
        case 122:
        // End:0x13F
        case 127:
        // End:0x147
        case 260:
        // End:0x14F
        case 279:
        // End:0x157
        case 281:
        // End:0x15F
        case 1042:
        // End:0x167
        case 1049:
        // End:0x16F
        case 1064:
        // End:0x177
        case 1071:
        // End:0x17F
        case 1072:
        // End:0x187
        case 1074:
        // End:0x18F
        case 1104:
        // End:0x197
        case 1108:
        // End:0x19F
        case 1169:
        // End:0x1A7
        case 1170:
        // End:0x1AF
        case 1183:
        // End:0x1B7
        case 1210:
        // End:0x1BF
        case 1231:
        // End:0x1C7
        case 1233:
        // End:0x1CF
        case 1236:
        // End:0x1D7
        case 1237:
        // End:0x1DF
        case 1244:
        // End:0x1E7
        case 1246:
        // End:0x1EF
        case 1247:
        // End:0x1F7
        case 1248:
        // End:0x1FF
        case 286:
        // End:0x207
        case 1263:
        // End:0x20F
        case 1269:
        // End:0x217
        case 1272:
        // End:0x21F
        case 1289:
        // End:0x227
        case 1290:
        // End:0x22F
        case 1291:
        // End:0x237
        case 1298:
        // End:0x23F
        case 342:
        // End:0x247
        case 352:
        // End:0x24F
        case 353:
        // End:0x257
        case 354:
        // End:0x25F
        case 358:
        // End:0x267
        case 361:
        // End:0x26F
        case 362:
        // End:0x277
        case 367:
        // End:0x27F
        case 1336:
        // End:0x287
        case 1337:
        // End:0x28F
        case 1338:
        // End:0x297
        case 1339:
        // End:0x29F
        case 1340:
        // End:0x2A7
        case 1341:
        // End:0x2AF
        case 1342:
        // End:0x2B7
        case 1343:
        // End:0x2BF
        case 1358:
        // End:0x2C7
        case 1359:
        // End:0x2CF
        case 1360:
        // End:0x2D7
        case 1361:
        // End:0x2DF
        case 1366:
        // End:0x2E7
        case 1367:
        // End:0x2EF
        case 1375:
        // End:0x2F7
        case 1376:
        // End:0x2FF
        case 400:
        // End:0x307
        case 401:
        // End:0x30F
        case 402:
        // End:0x317
        case 403:
        // End:0x31F
        case 404:
        // End:0x327
        case 407:
        // End:0x32F
        case 408:
        // End:0x337
        case 412:
        // End:0x33F
        case 1380:
        // End:0x347
        case 1381:
        // End:0x34F
        case 1382:
        // End:0x357
        case 1383:
        // End:0x35F
        case 1384:
        // End:0x367
        case 1385:
        // End:0x36F
        case 1386:
        // End:0x377
        case 1394:
        // End:0x37F
        case 1396:
        // End:0x387
        case 437:
        // End:0x38F
        case 452:
        // End:0x397
        case 485:
        // End:0x39F
        case 1435:
        // End:0x3A7
        case 494:
        // End:0x3AF
        case 495:
        // End:0x3B7
        case 501:
        // End:0x3BF
        case 1437:
        // End:0x3C7
        case 1445:
        // End:0x3CF
        case 1446:
        // End:0x3D7
        case 1447:
        // End:0x3DF
        case 1448:
        // End:0x3E7
        case 509:
        // End:0x3EF
        case 522:
        // End:0x3F7
        case 523:
        // End:0x3FF
        case 531:
        // End:0x407
        case 537:
        // End:0x40F
        case 1452:
        // End:0x417
        case 1454:
        // End:0x41F
        case 1455:
        // End:0x427
        case 1458:
        // End:0x42F
        case 1462:
        // End:0x437
        case 1467:
        // End:0x43F
        case 1468:
        // End:0x447
        case 559:
        // End:0x44F
        case 564:
        // End:0x457
        case 571:
        // End:0x45F
        case 573:
        // End:0x467
        case 578:
        // End:0x46F
        case 581:
        // End:0x477
        case 582:
        // End:0x47F
        case 588:
        // End:0x487
        case 1481:
        // End:0x48F
        case 1482:
        // End:0x497
        case 1483:
        // End:0x49F
        case 1484:
        // End:0x4A7
        case 1485:
        // End:0x4AF
        case 1486:
        // End:0x4B7
        case 627:
        // End:0x4BF
        case 680:
        // End:0x4C7
        case 681:
        // End:0x4CF
        case 682:
        // End:0x4D7
        case 683:
        // End:0x4DF
        case 686:
        // End:0x4E7
        case 688:
        // End:0x4EF
        case 692:
        // End:0x4F7
        case 695:
        // End:0x4FF
        case 696:
        // End:0x507
        case 708:
        // End:0x50F
        case 716:
        // End:0x517
        case 730:
        // End:0x51F
        case 732:
        // End:0x527
        case 736:
        // End:0x52F
        case 741:
        // End:0x537
        case 747:
        // End:0x53F
        case 749:
        // End:0x547
        case 752:
        // End:0x54F
        case 762:
        // End:0x557
        case 763:
        // End:0x55F
        case 774:
        // End:0x567
        case 775:
        // End:0x56F
        case 776:
        // End:0x577
        case 1495:
        // End:0x57F
        case 1508:
        // End:0x587
        case 1509:
        // End:0x58F
        case 1511:
        // End:0x597
        case 1512:
        // End:0x59F
        case 791:
        // End:0x5A7
        case 792:
        // End:0x5AF
        case 793:
        // End:0x5B7
        case 794:
        // End:0x5BF
        case 798:
        // End:0x5C7
        case 808:
        // End:0x5CF
        case 1524:
        // End:0x5D7
        case 1525:
        // End:0x5DF
        case 835:
        // End:0x5E7
        case 1529:
        // End:0x5EF
        case 877:
        // End:0x5F7
        case 879:
        // End:0x5FF
        case 883:
        // End:0x607
        case 886:
        // End:0x60F
        case 887:
        // End:0x617
        case 899:
        // End:0x61F
        case 904:
        // End:0x627
        case 905:
        // End:0x62F
        case 909:
        // End:0x637
        case 910:
        // End:0x63F
        case 927:
        // End:0x647
        case 1539:
        // End:0x64F
        case 1540:
        // End:0x657
        case 1541:
        // End:0x65F
        case 949:
        // End:0x667
        case 954:
        // End:0x66F
        case 1546:
        // End:0x677
        case 969:
        // End:0x67F
        case 973:
        // End:0x687
        case 974:
        // End:0x68F
        case 977:
        // End:0x697
        case 978:
        // End:0x69F
        case 979:
        // End:0x6A7
        case 980:
        // End:0x6AF
        case 981:
        // End:0x6B7
        case 985:
        // End:0x6BF
        case 991:
        // End:0x6C7
        case 1554:
        // End:0x6CF
        case 1555:
        // End:0x6D7
        case 995:
        // End:0x6DF
        case 996:
        // End:0x6E7
        case 997:
        // End:0x6EF
        case 2074:
        // End:0x6F7
        case 2234:
        // End:0x6FF
        case 2239:
        // End:0x707
        case 2399:
        // End:0x70F
        case 2839:
        // End:0x717
        case 3005:
        // End:0x71F
        case 3016:
        // End:0x727
        case 3020:
        // End:0x72F
        case 3021:
        // End:0x737
        case 3024:
        // End:0x73F
        case 3040:
        // End:0x747
        case 3041:
        // End:0x74F
        case 3052:
        // End:0x757
        case 3053:
        // End:0x75F
        case 3054:
        // End:0x767
        case 3055:
        // End:0x76F
        case 3061:
        // End:0x777
        case 3062:
        // End:0x77F
        case 3070:
        // End:0x787
        case 3074:
        // End:0x78F
        case 3075:
        // End:0x797
        case 3078:
        // End:0x79F
        case 3079:
        // End:0x7A7
        case 3571:
        // End:0x7AF
        case 3574:
        // End:0x7B7
        case 3577:
        // End:0x7BF
        case 3579:
        // End:0x7C7
        case 3584:
        // End:0x7CF
        case 3586:
        // End:0x7D7
        case 3588:
        // End:0x7DF
        case 3590:
        // End:0x7E7
        case 3594:
        // End:0x7EF
        case 3083:
        // End:0x7F7
        case 3084:
        // End:0x7FF
        case 3085:
        // End:0x807
        case 3086:
        // End:0x80F
        case 3087:
        // End:0x817
        case 3088:
        // End:0x81F
        case 3089:
        // End:0x827
        case 3090:
        // End:0x82F
        case 3091:
        // End:0x837
        case 3092:
        // End:0x83F
        case 3093:
        // End:0x847
        case 3094:
        // End:0x84F
        case 3096:
        // End:0x857
        case 3097:
        // End:0x85F
        case 3098:
        // End:0x867
        case 3099:
        // End:0x86F
        case 3100:
        // End:0x877
        case 3101:
        // End:0x87F
        case 3102:
        // End:0x887
        case 3103:
        // End:0x88F
        case 3104:
        // End:0x897
        case 3105:
        // End:0x89F
        case 3106:
        // End:0x8A7
        case 3107:
        // End:0x8AF
        case 3111:
        // End:0x8B7
        case 3112:
        // End:0x8BF
        case 3113:
        // End:0x8C7
        case 3114:
        // End:0x8CF
        case 3115:
        // End:0x8D7
        case 3116:
        // End:0x8DF
        case 3117:
        // End:0x8E7
        case 3118:
        // End:0x8EF
        case 3119:
        // End:0x8F7
        case 3120:
        // End:0x8FF
        case 3121:
        // End:0x907
        case 3122:
        // End:0x90F
        case 3137:
        // End:0x917
        case 3187:
        // End:0x91F
        case 3188:
        // End:0x927
        case 3189:
        // End:0x92F
        case 3190:
        // End:0x937
        case 3191:
        // End:0x93F
        case 3192:
        // End:0x947
        case 3193:
        // End:0x94F
        case 3194:
        // End:0x957
        case 3195:
        // End:0x95F
        case 3196:
        // End:0x967
        case 3197:
        // End:0x96F
        case 3198:
        // End:0x977
        case 3331:
        // End:0x97F
        case 8240:
        // End:0x987
        case 8276:
        // End:0x98F
        case 8357:
        // End:0x997
        case 7007:
        // End:0x99F
        case 4018:
        // End:0x9A7
        case 4019:
        // End:0x9AF
        case 4034:
        // End:0x9B7
        case 4035:
        // End:0x9BF
        case 4036:
        // End:0x9C7
        case 4037:
        // End:0x9CF
        case 4038:
        // End:0x9D7
        case 4046:
        // End:0x9DF
        case 4047:
        // End:0x9E7
        case 4052:
        // End:0x9EF
        case 4053:
        // End:0x9F7
        case 4054:
        // End:0x9FF
        case 4055:
        // End:0xA07
        case 4063:
        // End:0xA0F
        case 4064:
        // End:0xA17
        case 4070:
        // End:0xA1F
        case 4072:
        // End:0xA27
        case 4073:
        // End:0xA2F
        case 4075:
        // End:0xA37
        case 4076:
        // End:0xA3F
        case 4082:
        // End:0xA47
        case 4088:
        // End:0xA4F
        case 4098:
        // End:0xA57
        case 4102:
        // End:0xA5F
        case 4104:
        // End:0xA67
        case 4106:
        // End:0xA6F
        case 4107:
        // End:0xA77
        case 4108:
        // End:0xA7F
        case 4109:
        // End:0xA87
        case 4111:
        // End:0xA8F
        case 4117:
        // End:0xA97
        case 4118:
        // End:0xA9F
        case 4119:
        // End:0xAA7
        case 4120:
        // End:0xAAF
        case 4126:
        // End:0xAB7
        case 4131:
        // End:0xABF
        case 4140:
        // End:0xAC7
        case 4145:
        // End:0xACF
        case 4146:
        // End:0xAD7
        case 4148:
        // End:0xADF
        case 4149:
        // End:0xAE7
        case 4150:
        // End:0xAEF
        case 4153:
        // End:0xAF7
        case 4162:
        // End:0xAFF
        case 4164:
        // End:0xB07
        case 4165:
        // End:0xB0F
        case 4166:
        // End:0xB17
        case 4167:
        // End:0xB1F
        case 4182:
        // End:0xB27
        case 4183:
        // End:0xB2F
        case 4184:
        // End:0xB37
        case 4185:
        // End:0xB3F
        case 4186:
        // End:0xB47
        case 4187:
        // End:0xB4F
        case 4188:
        // End:0xB57
        case 4189:
        // End:0xB5F
        case 4190:
        // End:0xB67
        case 4196:
        // End:0xB6F
        case 4197:
        // End:0xB77
        case 4198:
        // End:0xB7F
        case 4199:
        // End:0xB87
        case 4200:
        // End:0xB8F
        case 4201:
        // End:0xB97
        case 4202:
        // End:0xB9F
        case 4203:
        // End:0xBA7
        case 4204:
        // End:0xBAF
        case 4205:
        // End:0xBB7
        case 4206:
        // End:0xBBF
        case 4215:
        // End:0xBC7
        case 4219:
        // End:0xBCF
        case 4236:
        // End:0xBD7
        case 4237:
        // End:0xBDF
        case 4238:
        // End:0xBE7
        case 4243:
        // End:0xBEF
        case 4245:
        // End:0xBF7
        case 4249:
        // End:0xBFF
        case 4258:
        // End:0xC07
        case 4259:
        // End:0xC0F
        case 4315:
        // End:0xC17
        case 4319:
        // End:0xC1F
        case 4320:
        // End:0xC27
        case 4321:
        // End:0xC2F
        case 4361:
        // End:0xC37
        case 4362:
        // End:0xC3F
        case 4363:
        // End:0xC47
        case 4382:
        // End:0xC4F
        case 4515:
        // End:0xC57
        case 4533:
        // End:0xC5F
        case 4534:
        // End:0xC67
        case 4535:
        // End:0xC6F
        case 4536:
        // End:0xC77
        case 4537:
        // End:0xC7F
        case 4538:
        // End:0xC87
        case 4539:
        // End:0xC8F
        case 4540:
        // End:0xC97
        case 4541:
        // End:0xC9F
        case 4547:
        // End:0xCA7
        case 4577:
        // End:0xCAF
        case 4578:
        // End:0xCB7
        case 4579:
        // End:0xCBF
        case 4580:
        // End:0xCC7
        case 4581:
        // End:0xCCF
        case 4582:
        // End:0xCD7
        case 4583:
        // End:0xCDF
        case 4584:
        // End:0xCE7
        case 4586:
        // End:0xCEF
        case 4587:
        // End:0xCF7
        case 4589:
        // End:0xCFF
        case 4590:
        // End:0xD07
        case 4591:
        // End:0xD0F
        case 4592:
        // End:0xD17
        case 4593:
        // End:0xD1F
        case 4594:
        // End:0xD27
        case 4596:
        // End:0xD2F
        case 4597:
        // End:0xD37
        case 4598:
        // End:0xD3F
        case 4599:
        // End:0xD47
        case 4600:
        // End:0xD4F
        case 4602:
        // End:0xD57
        case 4603:
        // End:0xD5F
        case 4604:
        // End:0xD67
        case 4605:
        // End:0xD6F
        case 4606:
        // End:0xD77
        case 4615:
        // End:0xD7F
        case 4620:
        // End:0xD87
        case 4624:
        // End:0xD8F
        case 4625:
        // End:0xD97
        case 4640:
        // End:0xD9F
        case 4643:
        // End:0xDA7
        case 4649:
        // End:0xDAF
        case 4657:
        // End:0xDB7
        case 4658:
        // End:0xDBF
        case 4659:
        // End:0xDC7
        case 4660:
        // End:0xDCF
        case 4661:
        // End:0xDD7
        case 4662:
        // End:0xDDF
        case 4670:
        // End:0xDE7
        case 4683:
        // End:0xDEF
        case 4684:
        // End:0xDF7
        case 4688:
        // End:0xDFF
        case 4689:
        // End:0xE07
        case 4694:
        // End:0xE0F
        case 4695:
        // End:0xE17
        case 4696:
        // End:0xE1F
        case 4705:
        // End:0xE27
        case 4706:
        // End:0xE2F
        case 4708:
        // End:0xE37
        case 4710:
        // End:0xE3F
        case 4169:
        // End:0xE47
        case 4724:
        // End:0xE4F
        case 4725:
        // End:0xE57
        case 4726:
        // End:0xE5F
        case 4727:
        // End:0xE67
        case 4728:
        // End:0xE6F
        case 4172:
        // End:0xE77
        case 4180:
        // End:0xE7F
        case 4744:
        // End:0xE87
        case 4745:
        // End:0xE8F
        case 4746:
        // End:0xE97
        case 4747:
        // End:0xE9F
        case 4748:
        // End:0xEA7
        case 4208:
        // End:0xEAF
        case 4759:
        // End:0xEB7
        case 4760:
        // End:0xEBF
        case 4761:
        // End:0xEC7
        case 4762:
        // End:0xECF
        case 4763:
        // End:0xED7
        case 4496:
        // End:0xEDF
        case 4769:
        // End:0xEE7
        case 4770:
        // End:0xEEF
        case 4771:
        // End:0xEF7
        case 4772:
        // End:0xEFF
        case 4773:
        // End:0xF07
        case 4463:
        // End:0xF0F
        case 4464:
        // End:0xF17
        case 4465:
        // End:0xF1F
        case 4466:
        // End:0xF27
        case 4467:
        // End:0xF2F
        case 4473:
        // End:0xF37
        case 4480:
        // End:0xF3F
        case 4481:
        // End:0xF47
        case 4482:
        // End:0xF4F
        case 4483:
        // End:0xF57
        case 4486:
        // End:0xF5F
        case 4487:
        // End:0xF67
        case 4488:
        // End:0xF6F
        case 4492:
        // End:0xF77
        case 4991:
        // End:0xF7F
        case 4992:
        // End:0xF87
        case 5004:
        // End:0xF8F
        case 5012:
        // End:0xF97
        case 5016:
        // End:0xF9F
        case 5020:
        // End:0xFA7
        case 5022:
        // End:0xFAF
        case 5023:
        // End:0xFB7
        case 5024:
        // End:0xFBF
        case 5037:
        // End:0xFC7
        case 5068:
        // End:0xFCF
        case 5069:
        // End:0xFD7
        case 5070:
        // End:0xFDF
        case 5071:
        // End:0xFE7
        case 5072:
        // End:0xFEF
        case 5081:
        // End:0xFF7
        case 5083:
        // End:0xFFF
        case 5085:
        // End:0x1007
        case 5086:
        // End:0x100F
        case 5092:
        // End:0x1017
        case 5112:
        // End:0x101F
        case 5114:
        // End:0x1027
        case 5116:
        // End:0x102F
        case 5117:
        // End:0x1037
        case 5120:
        // End:0x103F
        case 5134:
        // End:0x1047
        case 5137:
        // End:0x104F
        case 5138:
        // End:0x1057
        case 5140:
        // End:0x105F
        case 5145:
        // End:0x1067
        case 5160:
        // End:0x106F
        case 5166:
        // End:0x1077
        case 5167:
        // End:0x107F
        case 5168:
        // End:0x1087
        case 5169:
        // End:0x108F
        case 5170:
        // End:0x1097
        case 5171:
        // End:0x109F
        case 5172:
        // End:0x10A7
        case 5173:
        // End:0x10AF
        case 5174:
        // End:0x10B7
        case 5175:
        // End:0x10BF
        case 5176:
        // End:0x10C7
        case 5177:
        // End:0x10CF
        case 5183:
        // End:0x10D7
        case 5196:
        // End:0x10DF
        case 5197:
        // End:0x10E7
        case 5198:
        // End:0x10EF
        case 5199:
        // End:0x10F7
        case 5202:
        // End:0x10FF
        case 5203:
        // End:0x1107
        case 5206:
        // End:0x110F
        case 5207:
        // End:0x1117
        case 5219:
        // End:0x111F
        case 5220:
        // End:0x1127
        case 7066:
        // End:0x112F
        case 7067:
        // End:0x1137
        case 7076:
        // End:0x113F
        case 7077:
        // End:0x1147
        case 7080:
        // End:0x114F
        case 5229:
        // End:0x1157
        case 5230:
        // End:0x115F
        case 5231:
        // End:0x1167
        case 5232:
        // End:0x116F
        case 5238:
        // End:0x1177
        case 5240:
        // End:0x117F
        case 5241:
        // End:0x1187
        case 5242:
        // End:0x118F
        case 5243:
        // End:0x1197
        case 5247:
        // End:0x119F
        case 5250:
        // End:0x11A7
        case 5251:
        // End:0x11AF
        case 5252:
        // End:0x11B7
        case 5253:
        // End:0x11BF
        case 5254:
        // End:0x11C7
        case 5255:
        // End:0x11CF
        case 5256:
        // End:0x11D7
        case 5258:
        // End:0x11DF
        case 5259:
        // End:0x11E7
        case 5260:
        // End:0x11EF
        case 5261:
        // End:0x11F7
        case 5264:
        // End:0x11FF
        case 5266:
        // End:0x1207
        case 5268:
        // End:0x120F
        case 5269:
        // End:0x1217
        case 5270:
        // End:0x121F
        case 5271:
        // End:0x1227
        case 5301:
        // End:0x122F
        case 5302:
        // End:0x1237
        case 5303:
        // End:0x123F
        case 5304:
        // End:0x1247
        case 5305:
        // End:0x124F
        case 5306:
        // End:0x1257
        case 5307:
        // End:0x125F
        case 5308:
        // End:0x1267
        case 5309:
        // End:0x126F
        case 5333:
        // End:0x1277
        case 5362:
        // End:0x127F
        case 5363:
        // End:0x1287
        case 5364:
        // End:0x128F
        case 5365:
        // End:0x1297
        case 5366:
        // End:0x129F
        case 5367:
        // End:0x12A7
        case 5368:
        // End:0x12AF
        case 5369:
        // End:0x12B7
        case 5370:
        // End:0x12BF
        case 5394:
        // End:0x12C7
        case 5399:
        // End:0x12CF
        case 5401:
        // End:0x12D7
        case 5422:
        // End:0x12DF
        case 5423:
        // End:0x12E7
        case 5424:
        // End:0x12EF
        case 5431:
        // End:0x12F7
        case 5434:
        // End:0x12FF
        case 5435:
        // End:0x1307
        case 5443:
        // End:0x130F
        case 5444:
        // End:0x1317
        case 5447:
        // End:0x131F
        case 5456:
        // End:0x1327
        case 5459:
        // End:0x132F
        case 5460:
        // End:0x1337
        case 5481:
        // End:0x133F
        case 5482:
        // End:0x1347
        case 5495:
        // End:0x134F
        case 5496:
        // End:0x1357
        case 5497:
        // End:0x135F
        case 5500:
        // End:0x1367
        case 5501:
        // End:0x136F
        case 5502:
        // End:0x1377
        case 5505:
        // End:0x137F
        case 5506:
        // End:0x1387
        case 5507:
        // End:0x138F
        case 5508:
        // End:0x1397
        case 5509:
        // End:0x139F
        case 5510:
        // End:0x13A7
        case 5511:
        // End:0x13AF
        case 5512:
        // End:0x13B7
        case 5523:
        // End:0x13BF
        case 5529:
        // End:0x13C7
        case 5530:
        // End:0x13CF
        case 5551:
        // End:0x13D7
        case 5565:
        // End:0x13DF
        case 5566:
        // End:0x13E7
        case 5567:
        // End:0x13EF
        case 5568:
        // End:0x13F7
        case 5569:
        // End:0x13FF
        case 5581:
        // End:0x1407
        case 5583:
        // End:0x140F
        case 5584:
        // End:0x1417
        case 5585:
        // End:0x141F
        case 5592:
        // End:0x1427
        case 5594:
        // End:0x142F
        case 5595:
        // End:0x1437
        case 5596:
        // End:0x143F
        case 5600:
        // End:0x1447
        case 5602:
        // End:0x144F
        case 5623:
        // End:0x1457
        case 5624:
        // End:0x145F
        case 5625:
        // End:0x1467
        case 5660:
        // End:0x146F
        case 5661:
        // End:0x1477
        case 5665:
        // End:0x147F
        case 5666:
        // End:0x1487
        case 5667:
        // End:0x148F
        case 5668:
        // End:0x1497
        case 5669:
        // End:0x149F
        case 5670:
        // End:0x14A7
        case 5671:
        // End:0x14AF
        case 5672:
        // End:0x14B7
        case 5673:
        // End:0x14BF
        case 5679:
        // End:0x14C7
        case 5683:
        // End:0x14CF
        case 5687:
        // End:0x14D7
        case 5688:
        // End:0x14DF
        case 5693:
        // End:0x14E7
        case 5696:
        // End:0x14EF
        case 5697:
        // End:0x14F7
        case 5703:
        // End:0x14FF
        case 5706:
        // End:0x1507
        case 5707:
        // End:0x150F
        case 5715:
        // End:0x1517
        case 5716:
        // End:0x151F
        case 5733:
        // End:0x1527
        case 5735:
        // End:0x152F
        case 5747:
        // End:0x1537
        case 5764:
        // End:0x153F
        case 5778:
        // End:0x1547
        case 5794:
        // End:0x154F
        case 5795:
        // End:0x1557
        case 5796:
        // End:0x155F
        case 5797:
        // End:0x1567
        case 5798:
        // End:0x156F
        case 5799:
        // End:0x1577
        case 5800:
        // End:0x157F
        case 5801:
        // End:0x1587
        case 5802:
        // End:0x158F
        case 5803:
        // End:0x1597
        case 5804:
        // End:0x159F
        case 5806:
        // End:0x15A7
        case 5807:
        // End:0x15AF
        case 5808:
        // End:0x15B7
        case 5809:
        // End:0x15BF
        case 5810:
        // End:0x15C7
        case 5811:
        // End:0x15CF
        case 5812:
        // End:0x15D7
        case 5813:
        // End:0x15DF
        case 5814:
        // End:0x15E7
        case 5831:
        // End:0x15EF
        case 5832:
        // End:0x15F7
        case 5843:
        // End:0x15FF
        case 5846:
        // End:0x1607
        case 5849:
        // End:0x160F
        case 5851:
        // End:0x1617
        case 5854:
        // End:0x161F
        case 5855:
        // End:0x1627
        case 5860:
        // End:0x162F
        case 5861:
        // End:0x1637
        case 5866:
        // End:0x163F
        case 5867:
        // End:0x1647
        case 5868:
        // End:0x164F
        case 5869:
        // End:0x1657
        case 5870:
        // End:0x165F
        case 5871:
        // End:0x1667
        case 5872:
        // End:0x166F
        case 5873:
        // End:0x1677
        case 5874:
        // End:0x167F
        case 5875:
        // End:0x1687
        case 5876:
        // End:0x168F
        case 5877:
        // End:0x1697
        case 5878:
        // End:0x169F
        case 5879:
        // End:0x16A7
        case 5880:
        // End:0x16AF
        case 5881:
        // End:0x16B7
        case 5882:
        // End:0x16BF
        case 5883:
        // End:0x16C7
        case 5884:
        // End:0x16CF
        case 5885:
        // End:0x16D7
        case 5886:
        // End:0x16DF
        case 5887:
        // End:0x16E7
        case 5888:
        // End:0x16EF
        case 5889:
        // End:0x16F7
        case 5890:
        // End:0x16FF
        case 5891:
        // End:0x1707
        case 5892:
        // End:0x170F
        case 5893:
        // End:0x1717
        case 5894:
        // End:0x171F
        case 5895:
        // End:0x1727
        case 5896:
        // End:0x172F
        case 5897:
        // End:0x1737
        case 5898:
        // End:0x173F
        case 5899:
        // End:0x1747
        case 5900:
        // End:0x174F
        case 5901:
        // End:0x1757
        case 5903:
        // End:0x175F
        case 5904:
        // End:0x1767
        case 5905:
        // End:0x176F
        case 5907:
        // End:0x1777
        case 5908:
        // End:0x177F
        case 5912:
        // End:0x1787
        case 5914:
        // End:0x178F
        case 5919:
        // End:0x1797
        case 5921:
        // End:0x179F
        case 5922:
        // End:0x17A7
        case 5937:
        // End:0x17AF
        case 5941:
        // End:0x17B7
        case 5942:
        // End:0x17BF
        case 5943:
        // End:0x17C7
        case 5944:
        // End:0x17CF
        case 5945:
        // End:0x17D7
        case 5960:
        // End:0x17DF
        case 5961:
        // End:0x17E7
        case 5967:
        // End:0x17EF
        case 5969:
        // End:0x17F7
        case 5981:
        // End:0x17FF
        case 5984:
        // End:0x1807
        case 5992:
        // End:0x180F
        case 5993:
        // End:0x1817
        case 5994:
        // End:0x181F
        case 6024:
        // End:0x1827
        case 6033:
        // End:0x182F
        case 6090:
        // End:0x1837
        case 6091:
        // End:0x183F
        case 6092:
        // End:0x1847
        case 6095:
        // End:0x184F
        case 6125:
        // End:0x1857
        case 6126:
        // End:0x185F
        case 6129:
        // End:0x1867
        case 6130:
        // End:0x186F
        case 6131:
        // End:0x1877
        case 6132:
        // End:0x187F
        case 6133:
        // End:0x1887
        case 6134:
        // End:0x188F
        case 6135:
        // End:0x1897
        case 6140:
        // End:0x189F
        case 6141:
        // End:0x18A7
        case 6142:
        // End:0x18AF
        case 6146:
        // End:0x18B7
        case 6148:
        // End:0x18BF
        case 6149:
        // End:0x18C7
        case 6150:
        // End:0x18CF
        case 6151:
        // End:0x18D7
        case 6152:
        // End:0x18DF
        case 6153:
        // End:0x18E7
        case 6154:
        // End:0x18EF
        case 6155:
        // End:0x18F7
        case 6166:
        // End:0x18FF
        case 6167:
        // End:0x1907
        case 6168:
        // End:0x190F
        case 6169:
        // End:0x1917
        case 6187:
        // End:0x191F
        case 6189:
        // End:0x1927
        case 6190:
        // End:0x192F
        case 6205:
        // End:0x1937
        case 6206:
        // End:0x193F
        case 6237:
        // End:0x1947
        case 6238:
        // End:0x194F
        case 6240:
        // End:0x1957
        case 6250:
        // End:0x195F
        case 6263:
        // End:0x1967
        case 6266:
        // End:0x196F
        case 6269:
        // End:0x1977
        case 6273:
        // End:0x197F
        case 6274:
        // End:0x1987
        case 6275:
        // End:0x198F
        case 6276:
        // End:0x1997
        case 6280:
        // End:0x199F
        case 6281:
        // End:0x19A7
        case 6283:
        // End:0x19AF
        case 6299:
        // End:0x19B7
        case 6300:
        // End:0x19BF
        case 6304:
        // End:0x19C7
        case 6306:
        // End:0x19CF
        case 6307:
        // End:0x19D7
        case 6308:
        // End:0x19DF
        case 6309:
        // End:0x19E7
        case 6312:
        // End:0x19EF
        case 6314:
        // End:0x19F7
        case 6320:
        // End:0x19FF
        case 6326:
        // End:0x1A07
        case 6328:
        // End:0x1A0F
        case 6331:
        // End:0x1A17
        case 6332:
        // End:0x1A1F
        case 6333:
        // End:0x1A27
        case 6334:
        // End:0x1A2F
        case 6335:
        // End:0x1A37
        case 6336:
        // End:0x1A3F
        case 6339:
        // End:0x1A47
        case 6340:
        // End:0x1A4F
        case 6342:
        // End:0x1A57
        case 6370:
        // End:0x1A5F
        case 6373:
        // End:0x1A67
        case 6374:
        // End:0x1A6F
        case 6375:
        // End:0x1A77
        case 6378:
        // End:0x1A7F
        case 6379:
        // End:0x1A87
        case 6380:
        // End:0x1A8F
        case 6381:
        // End:0x1A97
        case 6382:
        // End:0x1A9F
        case 6383:
        // End:0x1AA7
        case 6384:
        // End:0x1AAF
        case 6385:
        // End:0x1AB7
        case 6386:
        // End:0x1ABF
        case 6389:
        // End:0x1AC7
        case 6390:
        // End:0x1ACF
        case 6391:
        // End:0x1AD7
        case 6392:
        // End:0x1ADF
        case 6395:
        // End:0x1AE7
        case 6396:
        // End:0x1AEF
        case 6397:
        // End:0x1AF7
        case 6398:
        // End:0x1AFF
        case 6400:
        // End:0x1B07
        case 6402:
        // End:0x1B0F
        case 6403:
        // End:0x1B17
        case 6404:
        // End:0x1B1F
        case 6406:
        // End:0x1B27
        case 6407:
        // End:0x1B2F
        case 6408:
        // End:0x1B37
        case 6410:
        // End:0x1B3F
        case 6414:
        // End:0x1B47
        case 6416:
        // End:0x1B4F
        case 6417:
        // End:0x1B57
        case 6418:
        // End:0x1B5F
        case 6423:
        // End:0x1B67
        case 6428:
        // End:0x1B6F
        case 6435:
        // End:0x1B77
        case 6436:
        // End:0x1B7F
        case 6437:
        // End:0x1B87
        case 6438:
        // End:0x1B8F
        case 6439:
        // End:0x1B97
        case 6440:
        // End:0x1B9F
        case 6441:
        // End:0x1BA7
        case 6618:
        // End:0x1BAF
        case 6619:
        // End:0x1BB7
        case 6622:
        // End:0x1BBF
        case 6624:
        // End:0x1BC7
        case 6650:
        // End:0x1BCF
        case 6651:
        // End:0x1BD7
        case 6662:
        // End:0x1BDF
        case 6677:
        // End:0x1BE7
        case 6688:
        // End:0x1BEF
        case 6690:
        // End:0x1BF7
        case 6697:
        // End:0x1BFF
        case 6698:
        // End:0x1C07
        case 6705:
        // End:0x1C0F
        case 6733:
        // End:0x1C17
        case 6734:
        // End:0x1C1F
        case 6735:
        // End:0x1C27
        case 6738:
        // End:0x1C2F
        case 6743:
        // End:0x1C37
        case 6744:
        // End:0x1C3F
        case 6746:
        // End:0x1C47
        case 6748:
        // End:0x1C4F
        case 6750:
        // End:0x1C57
        case 6751:
        // End:0x1C5F
        case 6754:
        // End:0x1C67
        case 6757:
        // End:0x1C6F
        case 6760:
        // End:0x1C77
        case 6761:
        // End:0x1C7F
        case 6763:
        // End:0x1C87
        case 6768:
        // End:0x1C8F
        case 6769:
        // End:0x1C97
        case 6772:
        // End:0x1C9F
        case 6774:
        // End:0x1CA7
        case 6775:
        // End:0x1CAF
        case 6776:
        // End:0x1CB7
        case 6777:
        // End:0x1CBF
        case 6779:
        // End:0x1CC7
        case 6815:
        // End:0x1CCF
        case 6816:
        // End:0x1CD7
        case 6819:
        // End:0x1CDF
        case 6821:
        // End:0x1CE7
        case 6822:
        // End:0x1CEF
        case 6825:
        // End:0x1CF7
        case 6827:
        // End:0x1CFF
        case 6828:
        // End:0x1D07
        case 6830:
        // End:0x1D0F
        case 6836:
        // End:0x1D17
        case 6840:
        // End:0x1D1F
        case 6853:
        // End:0x1D27
        case 6854:
        // End:0x1D2F
        case 6862:
        // End:0x1D37
        case 6863:
        // End:0x1D3F
        case 6865:
        // End:0x1D47
        case 6873:
        // End:0x1D4F
        case 6875:
        // End:0x1D57
        case 6878:
        // End:0x1D5F
        case 6880:
        // End:0x1D67
        case 6882:
        // End:0x1D6F
        case 6890:
        // End:0x1D77
        case 6897:
        // End:0x1D7F
        case 6912:
        // End:0x1D87
        case 23069:
        // End:0x1D8F
        case 23070:
        // End:0x1D97
        case 23071:
        // End:0x1D9F
        case 23124:
        // End:0x1DA7
        case 23169:
        // End:0x1DAF
        case 23170:
        // End:0x1DB7
        case 6921:
        // End:0x1DBF
        case 23298:
        // End:0x1DC7
        case 23299:
        // End:0x1DCF
        case 23300:
        // End:0x1DD7
        case 23319:
        // End:0x1DDF
        case 23320:
        // End:0x1DE7
        case 23321:
        // End:0x1DEF
        case 23322:
        // End:0x1E02
        case 23323:
            ResultBool = true;
            // End:0x1E05
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

static final function string ReplaceText(coerce string Text, coerce string Replace, coerce string With)
{
    local int i;
    local string output;

    i = InStr(Text, Replace);

    while(i != -1)
    {
        output = (output $ Left(Text, i)) $ With;
        Text = Mid(Text, i + Len(Replace));
        i = InStr(Text, Replace);
    }
    output = output $ Text;
    return output;
}

function string lowerDigitNumber(int idx)
{
    local string resultStr;

    switch(idx)
    {
        // End:0x17
        case 1:
            resultStr = "q";
            // End:0x314
            break;
        // End:0x28
        case 2:
            resultStr = "w";
            // End:0x314
            break;
        // End:0x39
        case 3:
            resultStr = "e";
            // End:0x314
            break;
        // End:0x4A
        case 4:
            resultStr = "r";
            // End:0x314
            break;
        // End:0x5B
        case 5:
            resultStr = "t";
            // End:0x314
            break;
        // End:0x6C
        case 6:
            resultStr = "y";
            // End:0x314
            break;
        // End:0x7D
        case 7:
            resultStr = "u";
            // End:0x314
            break;
        // End:0x8E
        case 8:
            resultStr = "i";
            // End:0x314
            break;
        // End:0x9F
        case 9:
            resultStr = "o";
            // End:0x314
            break;
        // End:0xB0
        case 10:
            resultStr = "p";
            // End:0x314
            break;
        // End:0xC1
        case 11:
            resultStr = "a";
            // End:0x314
            break;
        // End:0xD2
        case 12:
            resultStr = "s";
            // End:0x314
            break;
        // End:0xE3
        case 13:
            resultStr = "d";
            // End:0x314
            break;
        // End:0xF4
        case 14:
            resultStr = "f";
            // End:0x314
            break;
        // End:0x105
        case 15:
            resultStr = "g";
            // End:0x314
            break;
        // End:0x116
        case 16:
            resultStr = "h";
            // End:0x314
            break;
        // End:0x127
        case 17:
            resultStr = "j";
            // End:0x314
            break;
        // End:0x138
        case 18:
            resultStr = "k";
            // End:0x314
            break;
        // End:0x149
        case 19:
            resultStr = "l";
            // End:0x314
            break;
        // End:0x15A
        case 20:
            resultStr = "z";
            // End:0x314
            break;
        // End:0x16B
        case 21:
            resultStr = "x";
            // End:0x314
            break;
        // End:0x17C
        case 22:
            resultStr = "c";
            // End:0x314
            break;
        // End:0x18D
        case 23:
            resultStr = "v";
            // End:0x314
            break;
        // End:0x19E
        case 24:
            resultStr = "b";
            // End:0x314
            break;
        // End:0x1AF
        case 25:
            resultStr = "n";
            // End:0x314
            break;
        // End:0x1C0
        case 26:
            resultStr = "m";
            // End:0x314
            break;
        // End:0x1D1
        case 27:
            resultStr = "1";
            // End:0x314
            break;
        // End:0x1E2
        case 28:
            resultStr = "2";
            // End:0x314
            break;
        // End:0x1F3
        case 29:
            resultStr = "3";
            // End:0x314
            break;
        // End:0x204
        case 30:
            resultStr = "4";
            // End:0x314
            break;
        // End:0x215
        case 31:
            resultStr = "5";
            // End:0x314
            break;
        // End:0x226
        case 32:
            resultStr = "6";
            // End:0x314
            break;
        // End:0x237
        case 33:
            resultStr = "7";
            // End:0x314
            break;
        // End:0x248
        case 34:
            resultStr = "8";
            // End:0x314
            break;
        // End:0x259
        case 35:
            resultStr = "9";
            // End:0x314
            break;
        // End:0x26A
        case 36:
            resultStr = "0";
            // End:0x314
            break;
        // End:0x27B
        case 37:
            resultStr = ".";
            // End:0x314
            break;
        // End:0x28C
        case 38:
            resultStr = " ";
            // End:0x314
            break;
        // End:0x29A
        case 39:
            resultStr = ":";
        // End:0x2AB
        case 40:
            resultStr = "-";
            // End:0x314
            break;
        // End:0x2BC
        case 41:
            resultStr = "#";
            // End:0x314
            break;
        // End:0x2CD
        case 42:
            resultStr = "~";
            // End:0x314
            break;
        // End:0x2DE
        case 43:
            resultStr = "!";
            // End:0x314
            break;
        // End:0x2EF
        case 44:
            resultStr = "[";
            // End:0x314
            break;
        // End:0x300
        case 45:
            resultStr = "]";
            // End:0x314
            break;
        // End:0x311
        case 46:
            resultStr = "/";
            // End:0x314
            break;
        // End:0xFFFF
        default:
            break;
    }
    return resultStr;
}

function string upperDigit(int idx)
{
    local string resultStr;

    switch(idx)
    {
        // End:0x17
        case 1:
            resultStr = "Q";
            // End:0x1C3
            break;
        // End:0x28
        case 2:
            resultStr = "W";
            // End:0x1C3
            break;
        // End:0x39
        case 3:
            resultStr = "E";
            // End:0x1C3
            break;
        // End:0x4A
        case 4:
            resultStr = "R";
            // End:0x1C3
            break;
        // End:0x5B
        case 5:
            resultStr = "T";
            // End:0x1C3
            break;
        // End:0x6C
        case 6:
            resultStr = "Y";
            // End:0x1C3
            break;
        // End:0x7D
        case 7:
            resultStr = "U";
            // End:0x1C3
            break;
        // End:0x8E
        case 8:
            resultStr = "I";
            // End:0x1C3
            break;
        // End:0x9F
        case 9:
            resultStr = "O";
            // End:0x1C3
            break;
        // End:0xB0
        case 10:
            resultStr = "P";
            // End:0x1C3
            break;
        // End:0xC1
        case 11:
            resultStr = "A";
            // End:0x1C3
            break;
        // End:0xD2
        case 12:
            resultStr = "S";
            // End:0x1C3
            break;
        // End:0xE3
        case 13:
            resultStr = "D";
            // End:0x1C3
            break;
        // End:0xF4
        case 14:
            resultStr = "F";
            // End:0x1C3
            break;
        // End:0x105
        case 15:
            resultStr = "G";
            // End:0x1C3
            break;
        // End:0x116
        case 16:
            resultStr = "H";
            // End:0x1C3
            break;
        // End:0x127
        case 17:
            resultStr = "J";
            // End:0x1C3
            break;
        // End:0x138
        case 18:
            resultStr = "K";
            // End:0x1C3
            break;
        // End:0x149
        case 19:
            resultStr = "L";
            // End:0x1C3
            break;
        // End:0x15A
        case 20:
            resultStr = "Z";
            // End:0x1C3
            break;
        // End:0x16B
        case 21:
            resultStr = "X";
            // End:0x1C3
            break;
        // End:0x17C
        case 22:
            resultStr = "C";
            // End:0x1C3
            break;
        // End:0x18D
        case 23:
            resultStr = "V";
            // End:0x1C3
            break;
        // End:0x19E
        case 24:
            resultStr = "B";
            // End:0x1C3
            break;
        // End:0x1AF
        case 25:
            resultStr = "N";
            // End:0x1C3
            break;
        // End:0x1C0
        case 26:
            resultStr = "M";
            // End:0x1C3
            break;
        // End:0xFFFF
        default:
            break;
    }
    return resultStr;
}

function bool UnknownID123(int idx)
{
    local bool ResultBool;

    ResultBool = false;
    switch(idx)
    {
        // End:0x17
        case 2039:
        // End:0x1F
        case 2150:
        // End:0x27
        case 2151:
        // End:0x2F
        case 2152:
        // End:0x37
        case 2153:
        // End:0x3F
        case 2154:
        // End:0x47
        case 2047:
        // End:0x4F
        case 2155:
        // End:0x57
        case 2156:
        // End:0x5F
        case 2157:
        // End:0x67
        case 2158:
        // End:0x6F
        case 2159:
        // End:0x77
        case 2061:
        // End:0x7F
        case 2160:
        // End:0x87
        case 2161:
        // End:0x8F
        case 2162:
        // End:0x97
        case 2163:
        // End:0x9F
        case 2164:
        // End:0xA7
        case 26060:
        // End:0xAF
        case 26061:
        // End:0xB7
        case 26062:
        // End:0xBF
        case 26063:
        // End:0xC7
        case 26064:
        // End:0xCF
        case 22036:
        // End:0xD7
        case 22037:
        // End:0xDF
        case 22038:
        // End:0xE7
        case 2033:
        // End:0xEF
        case 2008:
        // End:0xF7
        case 2009:
        // End:0xFF
        case 26050:
        // End:0x107
        case 26051:
        // End:0x10F
        case 26052:
        // End:0x117
        case 26053:
        // End:0x11F
        case 26054:
        // End:0x127
        case 26055:
        // End:0x12F
        case 26056:
        // End:0x137
        case 26057:
        // End:0x13F
        case 26058:
        // End:0x147
        case 26059:
        // End:0x14F
        case 22369:
        // End:0x157
        case 728:
        // End:0x15F
        case 2240:
        // End:0x167
        case 2498:
        // End:0x16F
        case 2499:
        // End:0x177
        case 2359:
        // End:0x17F
        case 2166:
        // End:0x187
        case 2034:
        // End:0x18F
        case 2037:
        // End:0x197
        case 2035:
        // End:0x19F
        case 2036:
        // End:0x1A7
        case 2011:
        // End:0x1AF
        case 2032:
        // End:0x1B7
        case 2864:
        // End:0x1BF
        case 2398:
        // End:0x1C7
        case 2402:
        // End:0x1CF
        case 2403:
        // End:0x1D7
        case 2395:
        // End:0x1DF
        case 2401:
        // End:0x1E7
        case 2169:
        // End:0x1EF
        case 2397:
        // End:0x1F7
        case 2396:
        // End:0x1FF
        case 2012:
        // End:0x207
        case 2074:
        // End:0x20F
        case 2077:
        // End:0x217
        case 2592:
        // End:0x21F
        case 2038:
        // End:0x227
        case 2627:
        // End:0x22F
        case 2289:
        // End:0x237
        case 2287:
        // End:0x23F
        case 2288:
        // End:0x247
        case 2169:
        // End:0x24F
        case 2076:
        // End:0x257
        case 22042:
        // End:0x25F
        case 2903:
        // End:0x267
        case 2901:
        // End:0x26F
        case 2900:
        // End:0x277
        case 2902:
        // End:0x27F
        case 2897:
        // End:0x287
        case 22029:
        // End:0x28F
        case 2899:
        // End:0x297
        case 22031:
        // End:0x29F
        case 22164:
        // End:0x2A7
        case 2898:
        // End:0x2AF
        case 22030:
        // End:0x2B7
        case 22163:
        // End:0x2BF
        case 22162:
        // End:0x2C7
        case 22158:
        // End:0x2CF
        case 2282:
        // End:0x2D7
        case 2283:
        // End:0x2DF
        case 2284:
        // End:0x2E7
        case 2514:
        // End:0x2EF
        case 2513:
        // End:0x2F7
        case 2244:
        // End:0x2FF
        case 2278:
        // End:0x307
        case 2485:
        // End:0x30F
        case 2247:
        // End:0x317
        case 2281:
        // End:0x31F
        case 2486:
        // End:0x327
        case 2245:
        // End:0x32F
        case 2279:
        // End:0x337
        case 2246:
        // End:0x33F
        case 2280:
        // End:0x347
        case 2285:
        // End:0x34F
        case 2512:
        // End:0x362
        case 2580:
            ResultBool = true;
            // End:0x365
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

function bool UnknownID1234(int idx)
{
    local bool resultInt;

    resultInt = false;
    switch(idx)
    {
        // End:0x17
        case 347:
        // End:0x1C
        case 28:
        // End:0x21
        case 92:
        // End:0x26
        case 101:
        // End:0x2B
        case 102:
        // End:0x30
        case 105:
        // End:0x35
        case 115:
        // End:0x3A
        case 129:
        // End:0x42
        case 1069:
        // End:0x4A
        case 1083:
        // End:0x52
        case 1160:
        // End:0x5A
        case 1164:
        // End:0x62
        case 1167:
        // End:0x6A
        case 1168:
        // End:0x72
        case 1184:
        // End:0x7A
        case 1201:
        // End:0x82
        case 1206:
        // End:0x8A
        case 1222:
        // End:0x92
        case 1223:
        // End:0x9A
        case 1224:
        // End:0x9F
        case 100:
        // End:0xA4
        case 95:
        // End:0xA9
        case 96:
        // End:0xAE
        case 120:
        // End:0xB3
        case 223:
        // End:0xBB
        case 1092:
        // End:0xC3
        case 1095:
        // End:0xCB
        case 1096:
        // End:0xD3
        case 1097:
        // End:0xDB
        case 1099:
        // End:0xE3
        case 1100:
        // End:0xEB
        case 1101:
        // End:0xF3
        case 1102:
        // End:0xFB
        case 1107:
        // End:0x103
        case 1208:
        // End:0x10B
        case 1209:
        // End:0x110
        case 18:
        // End:0x115
        case 48:
        // End:0x11A
        case 65:
        // End:0x11F
        case 84:
        // End:0x124
        case 97:
        // End:0x129
        case 98:
        // End:0x12E
        case 103:
        // End:0x133
        case 106:
        // End:0x138
        case 107:
        // End:0x13D
        case 116:
        // End:0x142
        case 122:
        // End:0x147
        case 127:
        // End:0x14F
        case 260:
        // End:0x157
        case 279:
        // End:0x15F
        case 281:
        // End:0x167
        case 1042:
        // End:0x16F
        case 1049:
        // End:0x177
        case 1064:
        // End:0x17F
        case 1071:
        // End:0x187
        case 1072:
        // End:0x18F
        case 1074:
        // End:0x197
        case 1104:
        // End:0x19F
        case 1108:
        // End:0x1A7
        case 1169:
        // End:0x1AF
        case 1170:
        // End:0x1B7
        case 1183:
        // End:0x1BF
        case 1210:
        // End:0x1C7
        case 1231:
        // End:0x1CF
        case 1233:
        // End:0x1D7
        case 1236:
        // End:0x1DF
        case 1237:
        // End:0x1E7
        case 1244:
        // End:0x1EF
        case 1246:
        // End:0x1F7
        case 1247:
        // End:0x1FF
        case 1248:
        // End:0x207
        case 286:
        // End:0x20F
        case 1263:
        // End:0x217
        case 1269:
        // End:0x21F
        case 1272:
        // End:0x227
        case 1289:
        // End:0x22F
        case 1290:
        // End:0x237
        case 1291:
        // End:0x23F
        case 1298:
        // End:0x247
        case 342:
        // End:0x24F
        case 352:
        // End:0x257
        case 353:
        // End:0x25F
        case 354:
        // End:0x267
        case 358:
        // End:0x26F
        case 361:
        // End:0x277
        case 362:
        // End:0x27F
        case 367:
        // End:0x287
        case 1336:
        // End:0x28F
        case 1337:
        // End:0x297
        case 1338:
        // End:0x29F
        case 1339:
        // End:0x2A7
        case 1340:
        // End:0x2AF
        case 1341:
        // End:0x2B7
        case 1342:
        // End:0x2BF
        case 1343:
        // End:0x2C7
        case 1358:
        // End:0x2CF
        case 1359:
        // End:0x2D7
        case 1360:
        // End:0x2DF
        case 1361:
        // End:0x2E7
        case 1366:
        // End:0x2EF
        case 1367:
        // End:0x2F7
        case 1375:
        // End:0x2FF
        case 1376:
        // End:0x307
        case 400:
        // End:0x30F
        case 401:
        // End:0x317
        case 402:
        // End:0x31F
        case 403:
        // End:0x327
        case 404:
        // End:0x32F
        case 407:
        // End:0x337
        case 408:
        // End:0x33F
        case 412:
        // End:0x347
        case 1380:
        // End:0x34F
        case 1381:
        // End:0x357
        case 1382:
        // End:0x35F
        case 1383:
        // End:0x367
        case 1384:
        // End:0x36F
        case 1385:
        // End:0x377
        case 1386:
        // End:0x37F
        case 1394:
        // End:0x387
        case 1396:
        // End:0x38F
        case 437:
        // End:0x397
        case 452:
        // End:0x39F
        case 485:
        // End:0x3A7
        case 1435:
        // End:0x3AF
        case 494:
        // End:0x3B7
        case 495:
        // End:0x3BF
        case 501:
        // End:0x3C7
        case 1437:
        // End:0x3CF
        case 1445:
        // End:0x3D7
        case 1446:
        // End:0x3DF
        case 1447:
        // End:0x3E7
        case 1448:
        // End:0x3EF
        case 509:
        // End:0x3F7
        case 522:
        // End:0x3FF
        case 523:
        // End:0x407
        case 531:
        // End:0x40F
        case 537:
        // End:0x417
        case 1452:
        // End:0x41F
        case 1454:
        // End:0x427
        case 1455:
        // End:0x42F
        case 1458:
        // End:0x437
        case 1462:
        // End:0x43F
        case 1467:
        // End:0x447
        case 1468:
        // End:0x44F
        case 559:
        // End:0x457
        case 564:
        // End:0x45F
        case 571:
        // End:0x467
        case 573:
        // End:0x46F
        case 578:
        // End:0x477
        case 581:
        // End:0x47F
        case 582:
        // End:0x487
        case 588:
        // End:0x48F
        case 1481:
        // End:0x497
        case 1482:
        // End:0x49F
        case 1483:
        // End:0x4A7
        case 1484:
        // End:0x4AF
        case 1485:
        // End:0x4B7
        case 1486:
        // End:0x4BF
        case 627:
        // End:0x4C7
        case 680:
        // End:0x4CF
        case 681:
        // End:0x4D7
        case 682:
        // End:0x4DF
        case 683:
        // End:0x4E7
        case 686:
        // End:0x4EF
        case 688:
        // End:0x4F7
        case 692:
        // End:0x4FF
        case 695:
        // End:0x507
        case 696:
        // End:0x50F
        case 708:
        // End:0x517
        case 716:
        // End:0x51F
        case 730:
        // End:0x527
        case 732:
        // End:0x52F
        case 736:
        // End:0x537
        case 741:
        // End:0x53F
        case 747:
        // End:0x547
        case 749:
        // End:0x54F
        case 752:
        // End:0x557
        case 762:
        // End:0x55F
        case 763:
        // End:0x567
        case 774:
        // End:0x56F
        case 775:
        // End:0x577
        case 776:
        // End:0x57F
        case 1495:
        // End:0x587
        case 1508:
        // End:0x58F
        case 1509:
        // End:0x597
        case 1511:
        // End:0x59F
        case 1512:
        // End:0x5A7
        case 791:
        // End:0x5AF
        case 792:
        // End:0x5B7
        case 793:
        // End:0x5BF
        case 794:
        // End:0x5C7
        case 798:
        // End:0x5CF
        case 808:
        // End:0x5D7
        case 1524:
        // End:0x5DF
        case 1525:
        // End:0x5E7
        case 835:
        // End:0x5EF
        case 1529:
        // End:0x5F7
        case 877:
        // End:0x5FF
        case 879:
        // End:0x607
        case 883:
        // End:0x60F
        case 886:
        // End:0x617
        case 887:
        // End:0x61F
        case 899:
        // End:0x627
        case 904:
        // End:0x62F
        case 905:
        // End:0x637
        case 909:
        // End:0x63F
        case 910:
        // End:0x647
        case 927:
        // End:0x64F
        case 1539:
        // End:0x657
        case 1540:
        // End:0x65F
        case 1541:
        // End:0x667
        case 949:
        // End:0x66F
        case 954:
        // End:0x677
        case 1546:
        // End:0x67F
        case 969:
        // End:0x687
        case 973:
        // End:0x68F
        case 974:
        // End:0x697
        case 977:
        // End:0x69F
        case 978:
        // End:0x6A7
        case 979:
        // End:0x6AF
        case 980:
        // End:0x6B7
        case 981:
        // End:0x6BF
        case 985:
        // End:0x6C7
        case 991:
        // End:0x6CF
        case 1554:
        // End:0x6D7
        case 1555:
        // End:0x6DF
        case 995:
        // End:0x6E7
        case 996:
        // End:0x6EF
        case 997:
        // End:0x6F7
        case 2074:
        // End:0x6FF
        case 2234:
        // End:0x707
        case 2239:
        // End:0x70F
        case 2399:
        // End:0x717
        case 2839:
        // End:0x71F
        case 3005:
        // End:0x727
        case 3016:
        // End:0x72F
        case 3020:
        // End:0x737
        case 3021:
        // End:0x73F
        case 3024:
        // End:0x747
        case 3040:
        // End:0x74F
        case 3041:
        // End:0x757
        case 3052:
        // End:0x75F
        case 3053:
        // End:0x767
        case 3054:
        // End:0x76F
        case 3055:
        // End:0x777
        case 3061:
        // End:0x77F
        case 3062:
        // End:0x787
        case 3070:
        // End:0x78F
        case 3074:
        // End:0x797
        case 3075:
        // End:0x79F
        case 3078:
        // End:0x7A7
        case 3079:
        // End:0x7AF
        case 3571:
        // End:0x7B7
        case 3574:
        // End:0x7BF
        case 3577:
        // End:0x7C7
        case 3579:
        // End:0x7CF
        case 3584:
        // End:0x7D7
        case 3586:
        // End:0x7DF
        case 3588:
        // End:0x7E7
        case 3590:
        // End:0x7EF
        case 3594:
        // End:0x7F7
        case 3083:
        // End:0x7FF
        case 3084:
        // End:0x807
        case 3085:
        // End:0x80F
        case 3086:
        // End:0x817
        case 3087:
        // End:0x81F
        case 3088:
        // End:0x827
        case 3089:
        // End:0x82F
        case 3090:
        // End:0x837
        case 3091:
        // End:0x83F
        case 3092:
        // End:0x847
        case 3093:
        // End:0x84F
        case 3094:
        // End:0x857
        case 3096:
        // End:0x85F
        case 3097:
        // End:0x867
        case 3098:
        // End:0x86F
        case 3099:
        // End:0x877
        case 3100:
        // End:0x87F
        case 3101:
        // End:0x887
        case 3102:
        // End:0x88F
        case 3103:
        // End:0x897
        case 3104:
        // End:0x89F
        case 3105:
        // End:0x8A7
        case 3106:
        // End:0x8AF
        case 3107:
        // End:0x8B7
        case 3111:
        // End:0x8BF
        case 3112:
        // End:0x8C7
        case 3113:
        // End:0x8CF
        case 3114:
        // End:0x8D7
        case 3115:
        // End:0x8DF
        case 3116:
        // End:0x8E7
        case 3117:
        // End:0x8EF
        case 3118:
        // End:0x8F7
        case 3119:
        // End:0x8FF
        case 3120:
        // End:0x907
        case 3121:
        // End:0x90F
        case 3122:
        // End:0x917
        case 3137:
        // End:0x91F
        case 3187:
        // End:0x927
        case 3188:
        // End:0x92F
        case 3189:
        // End:0x937
        case 3190:
        // End:0x93F
        case 3191:
        // End:0x947
        case 3192:
        // End:0x94F
        case 3193:
        // End:0x957
        case 3194:
        // End:0x95F
        case 3195:
        // End:0x967
        case 3196:
        // End:0x96F
        case 3197:
        // End:0x977
        case 3198:
        // End:0x97F
        case 3331:
        // End:0x987
        case 8240:
        // End:0x98F
        case 8276:
        // End:0x997
        case 8357:
        // End:0x99F
        case 7007:
        // End:0x9A7
        case 4018:
        // End:0x9AF
        case 4019:
        // End:0x9B7
        case 4034:
        // End:0x9BF
        case 4035:
        // End:0x9C7
        case 4036:
        // End:0x9CF
        case 4037:
        // End:0x9D7
        case 4038:
        // End:0x9DF
        case 4046:
        // End:0x9E7
        case 4047:
        // End:0x9EF
        case 4052:
        // End:0x9F7
        case 4053:
        // End:0x9FF
        case 4054:
        // End:0xA07
        case 4055:
        // End:0xA0F
        case 4063:
        // End:0xA17
        case 4064:
        // End:0xA1F
        case 4070:
        // End:0xA27
        case 4072:
        // End:0xA2F
        case 4073:
        // End:0xA37
        case 4075:
        // End:0xA3F
        case 4076:
        // End:0xA47
        case 4082:
        // End:0xA4F
        case 4088:
        // End:0xA57
        case 4098:
        // End:0xA5F
        case 4102:
        // End:0xA67
        case 4104:
        // End:0xA6F
        case 4106:
        // End:0xA77
        case 4107:
        // End:0xA7F
        case 4108:
        // End:0xA87
        case 4109:
        // End:0xA8F
        case 4111:
        // End:0xA97
        case 4117:
        // End:0xA9F
        case 4118:
        // End:0xAA7
        case 4119:
        // End:0xAAF
        case 4120:
        // End:0xAB7
        case 4126:
        // End:0xABF
        case 4131:
        // End:0xAC7
        case 4140:
        // End:0xACF
        case 4145:
        // End:0xAD7
        case 4146:
        // End:0xADF
        case 4148:
        // End:0xAE7
        case 4149:
        // End:0xAEF
        case 4150:
        // End:0xAF7
        case 4153:
        // End:0xAFF
        case 4162:
        // End:0xB07
        case 4164:
        // End:0xB0F
        case 4165:
        // End:0xB17
        case 4166:
        // End:0xB1F
        case 4167:
        // End:0xB27
        case 4182:
        // End:0xB2F
        case 4183:
        // End:0xB37
        case 4184:
        // End:0xB3F
        case 4185:
        // End:0xB47
        case 4186:
        // End:0xB4F
        case 4187:
        // End:0xB57
        case 4188:
        // End:0xB5F
        case 4189:
        // End:0xB67
        case 4190:
        // End:0xB6F
        case 4196:
        // End:0xB77
        case 4197:
        // End:0xB7F
        case 4198:
        // End:0xB87
        case 4199:
        // End:0xB8F
        case 4200:
        // End:0xB97
        case 4201:
        // End:0xB9F
        case 4202:
        // End:0xBA7
        case 4203:
        // End:0xBAF
        case 4204:
        // End:0xBB7
        case 4205:
        // End:0xBBF
        case 4206:
        // End:0xBC7
        case 4215:
        // End:0xBCF
        case 4219:
        // End:0xBD7
        case 4236:
        // End:0xBDF
        case 4237:
        // End:0xBE7
        case 4238:
        // End:0xBEF
        case 4243:
        // End:0xBF7
        case 4245:
        // End:0xBFF
        case 4249:
        // End:0xC07
        case 4258:
        // End:0xC0F
        case 4259:
        // End:0xC17
        case 4315:
        // End:0xC1F
        case 4319:
        // End:0xC27
        case 4320:
        // End:0xC2F
        case 4321:
        // End:0xC37
        case 4361:
        // End:0xC3F
        case 4362:
        // End:0xC47
        case 4363:
        // End:0xC4F
        case 4382:
        // End:0xC57
        case 4515:
        // End:0xC5F
        case 4533:
        // End:0xC67
        case 4534:
        // End:0xC6F
        case 4535:
        // End:0xC77
        case 4536:
        // End:0xC7F
        case 4537:
        // End:0xC87
        case 4538:
        // End:0xC8F
        case 4539:
        // End:0xC97
        case 4540:
        // End:0xC9F
        case 4541:
        // End:0xCA7
        case 4547:
        // End:0xCAF
        case 4577:
        // End:0xCB7
        case 4578:
        // End:0xCBF
        case 4579:
        // End:0xCC7
        case 4580:
        // End:0xCCF
        case 4581:
        // End:0xCD7
        case 4582:
        // End:0xCDF
        case 4583:
        // End:0xCE7
        case 4584:
        // End:0xCEF
        case 4586:
        // End:0xCF7
        case 4587:
        // End:0xCFF
        case 4589:
        // End:0xD07
        case 4590:
        // End:0xD0F
        case 4591:
        // End:0xD17
        case 4592:
        // End:0xD1F
        case 4593:
        // End:0xD27
        case 4594:
        // End:0xD2F
        case 4596:
        // End:0xD37
        case 4597:
        // End:0xD3F
        case 4598:
        // End:0xD47
        case 4599:
        // End:0xD4F
        case 4600:
        // End:0xD57
        case 4602:
        // End:0xD5F
        case 4603:
        // End:0xD67
        case 4604:
        // End:0xD6F
        case 4605:
        // End:0xD77
        case 4606:
        // End:0xD7F
        case 4615:
        // End:0xD87
        case 4620:
        // End:0xD8F
        case 4624:
        // End:0xD97
        case 4625:
        // End:0xD9F
        case 4640:
        // End:0xDA7
        case 4643:
        // End:0xDAF
        case 4649:
        // End:0xDB7
        case 4657:
        // End:0xDBF
        case 4658:
        // End:0xDC7
        case 4659:
        // End:0xDCF
        case 4660:
        // End:0xDD7
        case 4661:
        // End:0xDDF
        case 4662:
        // End:0xDE7
        case 4670:
        // End:0xDEF
        case 4683:
        // End:0xDF7
        case 4684:
        // End:0xDFF
        case 4688:
        // End:0xE07
        case 4689:
        // End:0xE0F
        case 4694:
        // End:0xE17
        case 4695:
        // End:0xE1F
        case 4696:
        // End:0xE27
        case 4705:
        // End:0xE2F
        case 4706:
        // End:0xE37
        case 4708:
        // End:0xE3F
        case 4710:
        // End:0xE47
        case 4169:
        // End:0xE4F
        case 4724:
        // End:0xE57
        case 4725:
        // End:0xE5F
        case 4726:
        // End:0xE67
        case 4727:
        // End:0xE6F
        case 4728:
        // End:0xE77
        case 4172:
        // End:0xE7F
        case 4180:
        // End:0xE87
        case 4744:
        // End:0xE8F
        case 4745:
        // End:0xE97
        case 4746:
        // End:0xE9F
        case 4747:
        // End:0xEA7
        case 4748:
        // End:0xEAF
        case 4208:
        // End:0xEB7
        case 4759:
        // End:0xEBF
        case 4760:
        // End:0xEC7
        case 4761:
        // End:0xECF
        case 4762:
        // End:0xED7
        case 4763:
        // End:0xEDF
        case 4496:
        // End:0xEE7
        case 4769:
        // End:0xEEF
        case 4770:
        // End:0xEF7
        case 4771:
        // End:0xEFF
        case 4772:
        // End:0xF07
        case 4773:
        // End:0xF0F
        case 4463:
        // End:0xF17
        case 4464:
        // End:0xF1F
        case 4465:
        // End:0xF27
        case 4466:
        // End:0xF2F
        case 4467:
        // End:0xF37
        case 4473:
        // End:0xF3F
        case 4480:
        // End:0xF47
        case 4481:
        // End:0xF4F
        case 4482:
        // End:0xF57
        case 4483:
        // End:0xF5F
        case 4486:
        // End:0xF67
        case 4487:
        // End:0xF6F
        case 4488:
        // End:0xF77
        case 4492:
        // End:0xF7F
        case 4991:
        // End:0xF87
        case 4992:
        // End:0xF8F
        case 5004:
        // End:0xF97
        case 5012:
        // End:0xF9F
        case 5016:
        // End:0xFA7
        case 5020:
        // End:0xFAF
        case 5022:
        // End:0xFB7
        case 5023:
        // End:0xFBF
        case 5024:
        // End:0xFC7
        case 5037:
        // End:0xFCF
        case 5068:
        // End:0xFD7
        case 5069:
        // End:0xFDF
        case 5070:
        // End:0xFE7
        case 5071:
        // End:0xFEF
        case 5072:
        // End:0xFF7
        case 5081:
        // End:0xFFF
        case 5083:
        // End:0x1007
        case 5085:
        // End:0x100F
        case 5086:
        // End:0x1017
        case 5092:
        // End:0x101F
        case 5112:
        // End:0x1027
        case 5114:
        // End:0x102F
        case 5116:
        // End:0x1037
        case 5117:
        // End:0x103F
        case 5120:
        // End:0x1047
        case 5134:
        // End:0x104F
        case 5137:
        // End:0x1057
        case 5138:
        // End:0x105F
        case 5140:
        // End:0x1067
        case 5145:
        // End:0x106F
        case 5160:
        // End:0x1077
        case 5166:
        // End:0x107F
        case 5167:
        // End:0x1087
        case 5168:
        // End:0x108F
        case 5169:
        // End:0x1097
        case 5170:
        // End:0x109F
        case 5171:
        // End:0x10A7
        case 5172:
        // End:0x10AF
        case 5173:
        // End:0x10B7
        case 5174:
        // End:0x10BF
        case 5175:
        // End:0x10C7
        case 5176:
        // End:0x10CF
        case 5177:
        // End:0x10D7
        case 5183:
        // End:0x10DF
        case 5196:
        // End:0x10E7
        case 5197:
        // End:0x10EF
        case 5198:
        // End:0x10F7
        case 5199:
        // End:0x10FF
        case 5202:
        // End:0x1107
        case 5203:
        // End:0x110F
        case 5206:
        // End:0x1117
        case 5207:
        // End:0x111F
        case 5219:
        // End:0x1127
        case 5220:
        // End:0x112F
        case 7066:
        // End:0x1137
        case 7067:
        // End:0x113F
        case 7076:
        // End:0x1147
        case 7077:
        // End:0x114F
        case 7080:
        // End:0x1157
        case 5229:
        // End:0x115F
        case 5230:
        // End:0x1167
        case 5231:
        // End:0x116F
        case 5232:
        // End:0x1177
        case 5238:
        // End:0x117F
        case 5240:
        // End:0x1187
        case 5241:
        // End:0x118F
        case 5242:
        // End:0x1197
        case 5243:
        // End:0x119F
        case 5247:
        // End:0x11A7
        case 5250:
        // End:0x11AF
        case 5251:
        // End:0x11B7
        case 5252:
        // End:0x11BF
        case 5253:
        // End:0x11C7
        case 5254:
        // End:0x11CF
        case 5255:
        // End:0x11D7
        case 5256:
        // End:0x11DF
        case 5258:
        // End:0x11E7
        case 5259:
        // End:0x11EF
        case 5260:
        // End:0x11F7
        case 5261:
        // End:0x11FF
        case 5264:
        // End:0x1207
        case 5266:
        // End:0x120F
        case 5268:
        // End:0x1217
        case 5269:
        // End:0x121F
        case 5270:
        // End:0x1227
        case 5271:
        // End:0x122F
        case 5301:
        // End:0x1237
        case 5302:
        // End:0x123F
        case 5303:
        // End:0x1247
        case 5304:
        // End:0x124F
        case 5305:
        // End:0x1257
        case 5306:
        // End:0x125F
        case 5307:
        // End:0x1267
        case 5308:
        // End:0x126F
        case 5309:
        // End:0x1277
        case 5333:
        // End:0x127F
        case 5362:
        // End:0x1287
        case 5363:
        // End:0x128F
        case 5364:
        // End:0x1297
        case 5365:
        // End:0x129F
        case 5366:
        // End:0x12A7
        case 5367:
        // End:0x12AF
        case 5368:
        // End:0x12B7
        case 5369:
        // End:0x12BF
        case 5370:
        // End:0x12C7
        case 5394:
        // End:0x12CF
        case 5399:
        // End:0x12D7
        case 5401:
        // End:0x12DF
        case 5422:
        // End:0x12E7
        case 5423:
        // End:0x12EF
        case 5424:
        // End:0x12F7
        case 5431:
        // End:0x12FF
        case 5434:
        // End:0x1307
        case 5435:
        // End:0x130F
        case 5443:
        // End:0x1317
        case 5444:
        // End:0x131F
        case 5447:
        // End:0x1327
        case 5456:
        // End:0x132F
        case 5459:
        // End:0x1337
        case 5460:
        // End:0x133F
        case 5481:
        // End:0x1347
        case 5482:
        // End:0x134F
        case 5495:
        // End:0x1357
        case 5496:
        // End:0x135F
        case 5497:
        // End:0x1367
        case 5500:
        // End:0x136F
        case 5501:
        // End:0x1377
        case 5502:
        // End:0x137F
        case 5505:
        // End:0x1387
        case 5506:
        // End:0x138F
        case 5507:
        // End:0x1397
        case 5508:
        // End:0x139F
        case 5509:
        // End:0x13A7
        case 5510:
        // End:0x13AF
        case 5511:
        // End:0x13B7
        case 5512:
        // End:0x13BF
        case 5523:
        // End:0x13C7
        case 5529:
        // End:0x13CF
        case 5530:
        // End:0x13D7
        case 5551:
        // End:0x13DF
        case 5565:
        // End:0x13E7
        case 5566:
        // End:0x13EF
        case 5567:
        // End:0x13F7
        case 5568:
        // End:0x13FF
        case 5569:
        // End:0x1407
        case 5581:
        // End:0x140F
        case 5583:
        // End:0x1417
        case 5584:
        // End:0x141F
        case 5585:
        // End:0x1427
        case 5592:
        // End:0x142F
        case 5594:
        // End:0x1437
        case 5595:
        // End:0x143F
        case 5596:
        // End:0x1447
        case 5600:
        // End:0x144F
        case 5602:
        // End:0x1457
        case 5623:
        // End:0x145F
        case 5624:
        // End:0x1467
        case 5625:
        // End:0x146F
        case 5660:
        // End:0x1477
        case 5661:
        // End:0x147F
        case 5665:
        // End:0x1487
        case 5666:
        // End:0x148F
        case 5667:
        // End:0x1497
        case 5668:
        // End:0x149F
        case 5669:
        // End:0x14A7
        case 5670:
        // End:0x14AF
        case 5671:
        // End:0x14B7
        case 5672:
        // End:0x14BF
        case 5673:
        // End:0x14C7
        case 5679:
        // End:0x14CF
        case 5683:
        // End:0x14D7
        case 5687:
        // End:0x14DF
        case 5688:
        // End:0x14E7
        case 5693:
        // End:0x14EF
        case 5696:
        // End:0x14F7
        case 5697:
        // End:0x14FF
        case 5703:
        // End:0x1507
        case 5706:
        // End:0x150F
        case 5707:
        // End:0x1517
        case 5715:
        // End:0x151F
        case 5716:
        // End:0x1527
        case 5733:
        // End:0x152F
        case 5735:
        // End:0x1537
        case 5747:
        // End:0x153F
        case 5764:
        // End:0x1547
        case 5778:
        // End:0x154F
        case 5794:
        // End:0x1557
        case 5795:
        // End:0x155F
        case 5796:
        // End:0x1567
        case 5797:
        // End:0x156F
        case 5798:
        // End:0x1577
        case 5799:
        // End:0x157F
        case 5800:
        // End:0x1587
        case 5801:
        // End:0x158F
        case 5802:
        // End:0x1597
        case 5803:
        // End:0x159F
        case 5804:
        // End:0x15A7
        case 5806:
        // End:0x15AF
        case 5807:
        // End:0x15B7
        case 5808:
        // End:0x15BF
        case 5809:
        // End:0x15C7
        case 5810:
        // End:0x15CF
        case 5811:
        // End:0x15D7
        case 5812:
        // End:0x15DF
        case 5813:
        // End:0x15E7
        case 5814:
        // End:0x15EF
        case 5831:
        // End:0x15F7
        case 5832:
        // End:0x15FF
        case 5843:
        // End:0x1607
        case 5846:
        // End:0x160F
        case 5849:
        // End:0x1617
        case 5851:
        // End:0x161F
        case 5854:
        // End:0x1627
        case 5855:
        // End:0x162F
        case 5860:
        // End:0x1637
        case 5861:
        // End:0x163F
        case 5866:
        // End:0x1647
        case 5867:
        // End:0x164F
        case 5868:
        // End:0x1657
        case 5869:
        // End:0x165F
        case 5870:
        // End:0x1667
        case 5871:
        // End:0x166F
        case 5872:
        // End:0x1677
        case 5873:
        // End:0x167F
        case 5874:
        // End:0x1687
        case 5875:
        // End:0x168F
        case 5876:
        // End:0x1697
        case 5877:
        // End:0x169F
        case 5878:
        // End:0x16A7
        case 5879:
        // End:0x16AF
        case 5880:
        // End:0x16B7
        case 5881:
        // End:0x16BF
        case 5882:
        // End:0x16C7
        case 5883:
        // End:0x16CF
        case 5884:
        // End:0x16D7
        case 5885:
        // End:0x16DF
        case 5886:
        // End:0x16E7
        case 5887:
        // End:0x16EF
        case 5888:
        // End:0x16F7
        case 5889:
        // End:0x16FF
        case 5890:
        // End:0x1707
        case 5891:
        // End:0x170F
        case 5892:
        // End:0x1717
        case 5893:
        // End:0x171F
        case 5894:
        // End:0x1727
        case 5895:
        // End:0x172F
        case 5896:
        // End:0x1737
        case 5897:
        // End:0x173F
        case 5898:
        // End:0x1747
        case 5899:
        // End:0x174F
        case 5900:
        // End:0x1757
        case 5901:
        // End:0x175F
        case 5903:
        // End:0x1767
        case 5904:
        // End:0x176F
        case 5905:
        // End:0x1777
        case 5907:
        // End:0x177F
        case 5908:
        // End:0x1787
        case 5912:
        // End:0x178F
        case 5914:
        // End:0x1797
        case 5919:
        // End:0x179F
        case 5921:
        // End:0x17A7
        case 5922:
        // End:0x17AF
        case 5937:
        // End:0x17B7
        case 5941:
        // End:0x17BF
        case 5942:
        // End:0x17C7
        case 5943:
        // End:0x17CF
        case 5944:
        // End:0x17D7
        case 5945:
        // End:0x17DF
        case 5960:
        // End:0x17E7
        case 5961:
        // End:0x17EF
        case 5967:
        // End:0x17F7
        case 5969:
        // End:0x17FF
        case 5981:
        // End:0x1807
        case 5984:
        // End:0x180F
        case 5992:
        // End:0x1817
        case 5993:
        // End:0x181F
        case 5994:
        // End:0x1827
        case 6024:
        // End:0x182F
        case 6033:
        // End:0x1837
        case 6090:
        // End:0x183F
        case 6091:
        // End:0x1847
        case 6092:
        // End:0x184F
        case 6095:
        // End:0x1857
        case 6125:
        // End:0x185F
        case 6126:
        // End:0x1867
        case 6129:
        // End:0x186F
        case 6130:
        // End:0x1877
        case 6131:
        // End:0x187F
        case 6132:
        // End:0x1887
        case 6133:
        // End:0x188F
        case 6134:
        // End:0x1897
        case 6135:
        // End:0x189F
        case 6140:
        // End:0x18A7
        case 6141:
        // End:0x18AF
        case 6142:
        // End:0x18B7
        case 6146:
        // End:0x18BF
        case 6148:
        // End:0x18C7
        case 6149:
        // End:0x18CF
        case 6150:
        // End:0x18D7
        case 6151:
        // End:0x18DF
        case 6152:
        // End:0x18E7
        case 6153:
        // End:0x18EF
        case 6154:
        // End:0x18F7
        case 6155:
        // End:0x18FF
        case 6166:
        // End:0x1907
        case 6167:
        // End:0x190F
        case 6168:
        // End:0x1917
        case 6169:
        // End:0x191F
        case 6187:
        // End:0x1927
        case 6189:
        // End:0x192F
        case 6190:
        // End:0x1937
        case 6205:
        // End:0x193F
        case 6206:
        // End:0x1947
        case 6237:
        // End:0x194F
        case 6238:
        // End:0x1957
        case 6240:
        // End:0x195F
        case 6250:
        // End:0x1967
        case 6263:
        // End:0x196F
        case 6266:
        // End:0x1977
        case 6269:
        // End:0x197F
        case 6273:
        // End:0x1987
        case 6274:
        // End:0x198F
        case 6275:
        // End:0x1997
        case 6276:
        // End:0x199F
        case 6280:
        // End:0x19A7
        case 6281:
        // End:0x19AF
        case 6283:
        // End:0x19B7
        case 6299:
        // End:0x19BF
        case 6300:
        // End:0x19C7
        case 6304:
        // End:0x19CF
        case 6306:
        // End:0x19D7
        case 6307:
        // End:0x19DF
        case 6308:
        // End:0x19E7
        case 6309:
        // End:0x19EF
        case 6312:
        // End:0x19F7
        case 6314:
        // End:0x19FF
        case 6320:
        // End:0x1A07
        case 6326:
        // End:0x1A0F
        case 6328:
        // End:0x1A17
        case 6331:
        // End:0x1A1F
        case 6332:
        // End:0x1A27
        case 6333:
        // End:0x1A2F
        case 6334:
        // End:0x1A37
        case 6335:
        // End:0x1A3F
        case 6336:
        // End:0x1A47
        case 6339:
        // End:0x1A4F
        case 6340:
        // End:0x1A57
        case 6342:
        // End:0x1A5F
        case 6370:
        // End:0x1A67
        case 6373:
        // End:0x1A6F
        case 6374:
        // End:0x1A77
        case 6375:
        // End:0x1A7F
        case 6378:
        // End:0x1A87
        case 6379:
        // End:0x1A8F
        case 6380:
        // End:0x1A97
        case 6381:
        // End:0x1A9F
        case 6382:
        // End:0x1AA7
        case 6383:
        // End:0x1AAF
        case 6384:
        // End:0x1AB7
        case 6385:
        // End:0x1ABF
        case 6386:
        // End:0x1AC7
        case 6389:
        // End:0x1ACF
        case 6390:
        // End:0x1AD7
        case 6391:
        // End:0x1ADF
        case 6392:
        // End:0x1AE7
        case 6395:
        // End:0x1AEF
        case 6396:
        // End:0x1AF7
        case 6397:
        // End:0x1AFF
        case 6398:
        // End:0x1B07
        case 6400:
        // End:0x1B0F
        case 6402:
        // End:0x1B17
        case 6403:
        // End:0x1B1F
        case 6404:
        // End:0x1B27
        case 6406:
        // End:0x1B2F
        case 6407:
        // End:0x1B37
        case 6408:
        // End:0x1B3F
        case 6410:
        // End:0x1B47
        case 6414:
        // End:0x1B4F
        case 6416:
        // End:0x1B57
        case 6417:
        // End:0x1B5F
        case 6418:
        // End:0x1B67
        case 6423:
        // End:0x1B6F
        case 6428:
        // End:0x1B77
        case 6435:
        // End:0x1B7F
        case 6436:
        // End:0x1B87
        case 6437:
        // End:0x1B8F
        case 6438:
        // End:0x1B97
        case 6439:
        // End:0x1B9F
        case 6440:
        // End:0x1BA7
        case 6441:
        // End:0x1BAF
        case 6618:
        // End:0x1BB7
        case 6619:
        // End:0x1BBF
        case 6622:
        // End:0x1BC7
        case 6624:
        // End:0x1BCF
        case 6650:
        // End:0x1BD7
        case 6651:
        // End:0x1BDF
        case 6662:
        // End:0x1BE7
        case 6677:
        // End:0x1BEF
        case 6688:
        // End:0x1BF7
        case 6690:
        // End:0x1BFF
        case 6697:
        // End:0x1C07
        case 6698:
        // End:0x1C0F
        case 6705:
        // End:0x1C17
        case 6733:
        // End:0x1C1F
        case 6734:
        // End:0x1C27
        case 6735:
        // End:0x1C2F
        case 6738:
        // End:0x1C37
        case 6743:
        // End:0x1C3F
        case 6744:
        // End:0x1C47
        case 6746:
        // End:0x1C4F
        case 6748:
        // End:0x1C57
        case 6750:
        // End:0x1C5F
        case 6751:
        // End:0x1C67
        case 6754:
        // End:0x1C6F
        case 6757:
        // End:0x1C77
        case 6760:
        // End:0x1C7F
        case 6761:
        // End:0x1C87
        case 6763:
        // End:0x1C8F
        case 6768:
        // End:0x1C97
        case 6769:
        // End:0x1C9F
        case 6772:
        // End:0x1CA7
        case 6774:
        // End:0x1CAF
        case 6775:
        // End:0x1CB7
        case 6776:
        // End:0x1CBF
        case 6777:
        // End:0x1CC7
        case 6779:
        // End:0x1CCF
        case 6815:
        // End:0x1CD7
        case 6816:
        // End:0x1CDF
        case 6819:
        // End:0x1CE7
        case 6821:
        // End:0x1CEF
        case 6822:
        // End:0x1CF7
        case 6825:
        // End:0x1CFF
        case 6827:
        // End:0x1D07
        case 6828:
        // End:0x1D0F
        case 6830:
        // End:0x1D17
        case 6836:
        // End:0x1D1F
        case 6840:
        // End:0x1D27
        case 6853:
        // End:0x1D2F
        case 6854:
        // End:0x1D37
        case 6862:
        // End:0x1D3F
        case 6863:
        // End:0x1D47
        case 6865:
        // End:0x1D4F
        case 6873:
        // End:0x1D57
        case 6875:
        // End:0x1D5F
        case 6878:
        // End:0x1D67
        case 6880:
        // End:0x1D6F
        case 6882:
        // End:0x1D77
        case 6890:
        // End:0x1D7F
        case 6897:
        // End:0x1D87
        case 6912:
        // End:0x1D8F
        case 23069:
        // End:0x1D97
        case 23070:
        // End:0x1D9F
        case 23071:
        // End:0x1DA7
        case 23124:
        // End:0x1DAF
        case 23169:
        // End:0x1DB7
        case 23170:
        // End:0x1DBF
        case 6921:
        // End:0x1DC7
        case 23298:
        // End:0x1DCF
        case 23299:
        // End:0x1DD7
        case 23300:
        // End:0x1DDF
        case 23319:
        // End:0x1DE7
        case 23320:
        // End:0x1DEF
        case 23321:
        // End:0x1DF7
        case 23322:
        // End:0x1E07
        case 23323:
            resultInt = true;
        // End:0x1E3D
        case 1323:
            // End:0x1E3A
            if((GetOptionBool("Custom", "ShowNoble") == true))
            {
                resultInt = true;
            }
            // End:0x1E40
            break;
        // End:0xFFFF
        default:
            break;
    }
    return resultInt;
}

function string s_GetCustomClassIcon(int ClassID, int idx)
{
    local string resultString;

    resultString = "";
    switch(ClassID)
    {
        // End:0x14
        case 46:
        // End:0x2F
        case 113:
            resultString = "Was.Image_0";
            // End:0x2DC
            break;
        // End:0x34
        case 9:
        // End:0x39
        case 92:
        // End:0x3E
        case 24:
        // End:0x43
        case 102:
        // End:0x48
        case 37:
        // End:0x63
        case 109:
            resultString = "Was.Image_1";
            // End:0x2DC
            break;
        // End:0x68
        case 2:
        // End:0x83
        case 88:
            resultString = "Was.Image_2";
            // End:0x2DC
            break;
        // End:0x88
        case 3:
        // End:0xA3
        case 89:
            resultString = "Was.Image_3";
            // End:0x2DC
            break;
        // End:0xA8
        case 5:
        // End:0xAD
        case 90:
        // End:0xB2
        case 6:
        // End:0xB7
        case 91:
        // End:0xBC
        case 20:
        // End:0xC1
        case 99:
        // End:0xC6
        case 33:
        // End:0xE1
        case 106:
            resultString = "Was.Image_4";
            // End:0x2DC
            break;
        // End:0xE6
        case 8:
        // End:0xEB
        case 93:
        // End:0xF0
        case 23:
        // End:0xF5
        case 101:
        // End:0xFA
        case 36:
        // End:0x115
        case 108:
            resultString = "Was.Image_5";
            // End:0x2DC
            break;
        // End:0x11A
        case 11:
        // End:0x135
        case 94:
            resultString = "Was.Image_6";
            // End:0x2DC
            break;
        // End:0x13A
        case 13:
        // End:0x155
        case 95:
            resultString = "Was.Image_7";
            // End:0x2DC
            break;
        // End:0x15A
        case 14:
        // End:0x15F
        case 96:
        // End:0x164
        case 28:
        // End:0x169
        case 104:
        // End:0x16E
        case 41:
        // End:0x189
        case 111:
            resultString = "Was.Image_8";
            // End:0x2DC
            break;
        // End:0x18E
        case 17:
        // End:0x193
        case 98:
        // End:0x198
        case 30:
        // End:0x19D
        case 105:
        // End:0x1A2
        case 43:
        // End:0x1BD
        case 112:
            resultString = "Was.Image_9";
            // End:0x2DC
            break;
        // End:0x1C2
        case 16:
        // End:0x1DE
        case 97:
            resultString = "Was.Image_10";
            // End:0x2DC
            break;
        // End:0x1E3
        case 21:
        // End:0x1FF
        case 100:
            resultString = "Was.Image_11";
            // End:0x2DC
            break;
        // End:0x204
        case 34:
        // End:0x220
        case 107:
            resultString = "Was.Image_12";
            // End:0x2DC
            break;
        // End:0x225
        case 27:
        // End:0x241
        case 103:
            resultString = "Was.Image_18";
            // End:0x2DC
            break;
        // End:0x246
        case 40:
        // End:0x262
        case 110:
            resultString = "Was.Image_14";
            // End:0x2DC
            break;
        // End:0x267
        case 48:
        // End:0x283
        case 114:
            resultString = "Was.Image_15";
            // End:0x2DC
            break;
        // End:0x288
        case 51:
        // End:0x28D
        case 52:
        // End:0x292
        case 115:
        // End:0x2AE
        case 116:
            resultString = "Was.Image_16";
            // End:0x2DC
            break;
        // End:0x2B3
        case 55:
        // End:0x2B8
        case 56:
        // End:0x2BD
        case 118:
        // End:0x2D9
        case 117:
            resultString = "Was.Image_17";
            // End:0x2DC
            break;
        // End:0xFFFF
        default:
            break;
    }
    return resultString;
}

function string s_GetCustomClassIconTooltipText(int ClassID, int idx)
{
    local string resultString;

    resultString = "";
    switch(ClassID)
    {
        // End:0x14
        case 46:
        // End:0x2D
        case 113:
            resultString = "Destroyer";
            // End:0x279
            break;
        // End:0x32
        case 9:
        // End:0x37
        case 92:
        // End:0x3C
        case 24:
        // End:0x41
        case 102:
        // End:0x46
        case 37:
        // End:0x5C
        case 109:
            resultString = "Ranger";
            // End:0x279
            break;
        // End:0x61
        case 2:
        // End:0x7A
        case 88:
            resultString = "Gladiator";
            // End:0x279
            break;
        // End:0x7F
        case 3:
        // End:0x95
        case 89:
            resultString = "Poller";
            // End:0x279
            break;
        // End:0x9A
        case 5:
        // End:0x9F
        case 90:
        // End:0xA4
        case 6:
        // End:0xA9
        case 91:
        // End:0xAE
        case 20:
        // End:0xB3
        case 99:
        // End:0xB8
        case 33:
        // End:0xCC
        case 106:
            resultString = "Tank";
            // End:0x279
            break;
        // End:0xD1
        case 8:
        // End:0xD6
        case 93:
        // End:0xDB
        case 23:
        // End:0xE0
        case 101:
        // End:0xE5
        case 36:
        // End:0xFB
        case 108:
            resultString = "Lethal";
            // End:0x279
            break;
        // End:0x100
        case 11:
        // End:0x114
        case 94:
            resultString = "Fire";
            // End:0x279
            break;
        // End:0x119
        case 13:
        // End:0x12D
        case 95:
            resultString = "Dark";
            // End:0x279
            break;
        // End:0x132
        case 14:
        // End:0x137
        case 96:
        // End:0x13C
        case 28:
        // End:0x141
        case 104:
        // End:0x146
        case 41:
        // End:0x15E
        case 111:
            resultString = "Summoner";
            // End:0x279
            break;
        // End:0x163
        case 17:
        // End:0x168
        case 98:
        // End:0x16D
        case 30:
        // End:0x172
        case 105:
        // End:0x177
        case 43:
        // End:0x18C
        case 112:
            resultString = "Elder";
            // End:0x279
            break;
        // End:0x191
        case 16:
        // End:0x1A7
        case 97:
            resultString = "Bishop";
            // End:0x279
            break;
        // End:0x1AC
        case 21:
        // End:0x1C2
        case 100:
            resultString = "Songer";
            // End:0x279
            break;
        // End:0x1C7
        case 34:
        // End:0x1DD
        case 107:
            resultString = "Dancer";
            // End:0x279
            break;
        // End:0x1E2
        case 27:
        // End:0x1F7
        case 103:
            resultString = "Water";
            // End:0x279
            break;
        // End:0x1FC
        case 40:
        // End:0x210
        case 110:
            resultString = "Wind";
            // End:0x279
            break;
        // End:0x215
        case 48:
        // End:0x22B
        case 114:
            resultString = "Tyrant";
            // End:0x279
            break;
        // End:0x230
        case 51:
        // End:0x235
        case 52:
        // End:0x23A
        case 115:
        // End:0x250
        case 116:
            resultString = "Shaman";
            // End:0x279
            break;
        // End:0x255
        case 55:
        // End:0x25A
        case 56:
        // End:0x25F
        case 118:
        // End:0x276
        case 117:
            resultString = "Maestro";
            // End:0x279
            break;
        // End:0xFFFF
        default:
            break;
    }
    return resultString;
}

function int GetMacroNum(string param)
{
    local int idx;

    GetINIInt("MacroList", param, idx, "MacroGrp");
    return idx;
}

function Leave()
{
    RequestExit();
    return;
}

function SortItem(ItemWindowHandle Handle)
{
    local int int_1, int_2, int_3;
    local ItemInfo int_4;
    local byte EItemType;
    local int int_5, int_6, int_7, int_8, int_9, int_10,
	    int_11, int_12, int_13, int_14, int_15,
	    int_16, int_17, int_18, int_19, int_20;

    local array<ItemInfo> info_1, info_2, info_3, info_4, info_5, info_6,
	    info_7, info_8, info_9, info_10, info_11,
	    info_12, info_13, info_14;

    local ItemInfo info_15;

    Debug("Sorting Inven Item");
    int_5 = 0;
    int_6 = 0;
    int_7 = 0;
    int_8 = 0;
    int_14 = 0;
    int_9 = 0;
    int_10 = 0;
    int_11 = 0;
    int_12 = 0;
    int_13 = 0;
    int_14 = 0;
    int_15 = 0;
    int_16 = 0;
    int_17 = 0;
    int_18 = 0;
    int_19 = 0;
    int_3 = Handle.GetItemNum();
    int_1 = 0;

    while(int_1 < int_3)
    {
        Handle.GetItem(int_1, int_4);
        EItemType = byte(int_4.ItemType);
        switch(EItemType)
        {
            // End:0x112
            case 4:
                info_1[int_5] = int_4;
                int_5 = (int_5 + 1);
                // End:0x361
                break;
            // End:0x13D
            case 0:
                info_2[int_6] = int_4;
                int_6 = (int_6 + 1);
                // End:0x361
                break;
            // End:0x168
            case 1:
                info_3[int_7] = int_4;
                int_7 = (int_7 + 1);
                // End:0x361
                break;
            // End:0x193
            case 2:
                info_4[int_8] = int_4;
                int_8 = (int_8 + 1);
                // End:0x361
                break;
            // End:0x338
            case 5:
                int_20 = int_4.ItemSubType;
                switch(int_4.ItemSubType)
                {
                    // End:0x1DF
                    case 22:
                        info_6[int_10] = int_4;
                        int_10 = (int_10 + 1);
                        // End:0x335
                        break;
                    // End:0x20A
                    case 21:
                        info_7[int_11] = int_4;
                        int_11 = (int_11 + 1);
                        // End:0x335
                        break;
                    // End:0x235
                    case 20:
                        info_8[int_12] = int_4;
                        int_12 = (int_12 + 1);
                        // End:0x335
                        break;
                    // End:0x260
                    case 19:
                        info_9[int_13] = int_4;
                        int_13 = (int_13 + 1);
                        // End:0x335
                        break;
                    // End:0x28B
                    case 3:
                        info_10[int_14] = int_4;
                        int_14 = (int_14 + 1);
                        // End:0x335
                        break;
                    // End:0x2B6
                    case 24:
                        info_11[int_15] = int_4;
                        int_15 = (int_15 + 1);
                        // End:0x335
                        break;
                    // End:0x2E1
                    case 2:
                        info_12[int_16] = int_4;
                        int_16 = (int_16 + 1);
                        // End:0x335
                        break;
                    // End:0x30C
                    case 5:
                        info_14[int_18] = int_4;
                        int_18 = (int_18 + 1);
                        // End:0x335
                        break;
                    // End:0xFFFF
                    default:
                        info_5[int_9] = int_4;
                        int_9 = (int_9 + 1);
                        // End:0x335
                        break;
                        break;
                }
                // End:0x361
                break;
            // End:0xFFFF
            default:
                info_5[int_9] = int_4;
                int_9 = (int_9 + 1);
                // End:0x361
                break;
                break;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_5)
    {
        int_2 = 0;

        while(int_2 < (int_5 - int_1))
        {
            // End:0x42F
            if((int_2 < (int_5 - 1)))
            {
                // End:0x42F
                if((info_1[int_2].Weight < info_1[(int_2 + 1)].Weight))
                {
                    info_15 = info_1[int_2];
                    info_1[int_2] = info_1[(int_2 + 1)];
                    info_1[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_6)
    {
        int_2 = 0;

        while(int_2 < (int_6 - int_1))
        {
            // End:0x507
            if((int_2 < (int_6 - 1)))
            {
                // End:0x507
                if((info_2[int_2].Weight < info_2[(int_2 + 1)].Weight))
                {
                    info_15 = info_2[int_2];
                    info_2[int_2] = info_2[(int_2 + 1)];
                    info_2[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_7)
    {
        int_2 = 0;

        while(int_2 < (int_7 - int_1))
        {
            // End:0x5DF
            if((int_2 < (int_7 - 1)))
            {
                // End:0x5DF
                if((info_3[int_2].Weight < info_3[(int_2 + 1)].Weight))
                {
                    info_15 = info_3[int_2];
                    info_3[int_2] = info_3[(int_2 + 1)];
                    info_3[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_8)
    {
        int_2 = 0;

        while(int_2 < (int_8 - int_1))
        {
            // End:0x6B7
            if((int_2 < (int_8 - 1)))
            {
                // End:0x6B7
                if((info_4[int_2].Weight < info_4[(int_2 + 1)].Weight))
                {
                    info_15 = info_4[int_2];
                    info_4[int_2] = info_4[(int_2 + 1)];
                    info_4[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_10)
    {
        int_2 = 0;

        while(int_2 < (int_10 - int_1))
        {
            // End:0x78F
            if((int_2 < (int_10 - 1)))
            {
                // End:0x78F
                if((info_6[int_2].Weight < info_6[(int_2 + 1)].Weight))
                {
                    info_15 = info_6[int_2];
                    info_6[int_2] = info_6[(int_2 + 1)];
                    info_6[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_11)
    {
        int_2 = 0;

        while(int_2 < (int_11 - int_1))
        {
            // End:0x867
            if((int_2 < (int_11 - 1)))
            {
                // End:0x867
                if((info_7[int_2].Weight < info_7[(int_2 + 1)].Weight))
                {
                    info_15 = info_7[int_2];
                    info_7[int_2] = info_7[(int_2 + 1)];
                    info_7[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_12)
    {
        int_2 = 0;

        while(int_2 < (int_12 - int_1))
        {
            // End:0x93F
            if((int_2 < (int_12 - 1)))
            {
                // End:0x93F
                if((info_8[int_2].Weight < info_8[(int_2 + 1)].Weight))
                {
                    info_15 = info_8[int_2];
                    info_8[int_2] = info_8[(int_2 + 1)];
                    info_8[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_13)
    {
        int_2 = 0;

        while(int_2 < (int_13 - int_1))
        {
            // End:0xA17
            if((int_2 < (int_13 - 1)))
            {
                // End:0xA17
                if((info_9[int_2].Weight < info_9[(int_2 + 1)].Weight))
                {
                    info_15 = info_9[int_2];
                    info_9[int_2] = info_9[(int_2 + 1)];
                    info_9[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_14)
    {
        int_2 = 0;

        while(int_2 < (int_14 - int_1))
        {
            // End:0xAEF
            if((int_2 < (int_14 - 1)))
            {
                // End:0xAEF
                if((info_10[int_2].Weight < info_10[(int_2 + 1)].Weight))
                {
                    info_15 = info_10[int_2];
                    info_10[int_2] = info_10[(int_2 + 1)];
                    info_10[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_15)
    {
        int_2 = 0;

        while(int_2 < (int_15 - int_1))
        {
            // End:0xBC7
            if((int_2 < (int_15 - 1)))
            {
                // End:0xBC7
                if((info_11[int_2].Weight < info_11[(int_2 + 1)].Weight))
                {
                    info_15 = info_11[int_2];
                    info_11[int_2] = info_11[(int_2 + 1)];
                    info_11[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_16)
    {
        int_2 = 0;

        while(int_2 < (int_16 - int_1))
        {
            // End:0xC9F
            if((int_2 < (int_16 - 1)))
            {
                // End:0xC9F
                if((info_12[int_2].Weight < info_12[(int_2 + 1)].Weight))
                {
                    info_15 = info_12[int_2];
                    info_12[int_2] = info_12[(int_2 + 1)];
                    info_12[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_17)
    {
        int_2 = 0;

        while(int_2 < (int_17 - int_1))
        {
            // End:0xD77
            if((int_2 < (int_17 - 1)))
            {
                // End:0xD77
                if((info_13[int_2].Weight < info_13[(int_2 + 1)].Weight))
                {
                    info_15 = info_13[int_2];
                    info_13[int_2] = info_13[(int_2 + 1)];
                    info_13[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_18)
    {
        int_2 = 0;

        while(int_2 < (int_18 - int_1))
        {
            // End:0xE4F
            if((int_2 < (int_18 - 1)))
            {
                // End:0xE4F
                if((info_14[int_2].Weight < info_14[(int_2 + 1)].Weight))
                {
                    info_15 = info_13[int_2];
                    info_14[int_2] = info_14[(int_2 + 1)];
                    info_14[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_9)
    {
        int_2 = 0;

        while(int_2 < (int_9 - int_1))
        {
            // End:0xF27
            if((int_2 < (int_9 - 1)))
            {
                // End:0xF27
                if((info_5[int_2].Weight < info_5[(int_2 + 1)].Weight))
                {
                    info_15 = info_5[int_2];
                    info_5[int_2] = info_5[(int_2 + 1)];
                    info_5[(int_2 + 1)] = info_15;
                }
            }
            int_2++;
        }
        int_1++;
    }
    int_1 = 0;

    while(int_1 < int_5)
    {
        Handle.SetItem((int_19 + int_1), info_1[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_5);
    int_1 = 0;

    while(int_1 < int_6)
    {
        Handle.SetItem((int_19 + int_1), info_2[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_6);
    int_1 = 0;

    while(int_1 < int_7)
    {
        Handle.SetItem((int_19 + int_1), info_3[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_7);
    int_1 = 0;

    while(int_1 < int_8)
    {
        Handle.SetItem((int_19 + int_1), info_4[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_8);
    int_1 = 0;

    while(int_1 < int_10)
    {
        Handle.SetItem((int_19 + int_1), info_6[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_10);
    int_1 = 0;

    while(int_1 < int_11)
    {
        Handle.SetItem((int_19 + int_1), info_7[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_11);
    int_1 = 0;

    while(int_1 < int_12)
    {
        Handle.SetItem((int_19 + int_1), info_8[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_12);
    int_1 = 0;

    while(int_1 < int_13)
    {
        Handle.SetItem((int_19 + int_1), info_9[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_13);
    int_1 = 0;

    while(int_1 < int_14)
    {
        Handle.SetItem((int_19 + int_1), info_10[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_14);
    int_1 = 0;

    while(int_1 < int_15)
    {
        Handle.SetItem((int_19 + int_1), info_11[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_15);
    int_1 = 0;

    while(int_1 < int_16)
    {
        Handle.SetItem((int_19 + int_1), info_12[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_16);
    int_1 = 0;

    while(int_1 < int_18)
    {
        Handle.SetItem((int_19 + int_1), info_14[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_18);
    int_1 = 0;

    while(int_1 < int_9)
    {
        Handle.SetItem((int_19 + int_1), info_5[int_1]);
        int_1++;
    }
    int_19 = (int_19 + int_9);
    return;
}
