class InventoryWnd extends UICommonAPI;

const CONST_1 = 1111;
const CONST_2 = 2222;
const CONST_3 = 3333;
const CONST_4 = 4444;
const CONST_5 = 5555;
const CONST_6 = 6666;
const CONST_7 = 7777;
const CONST_8 = 8888;
const CONST_9 = 9999;
const CONST_10 = 10000;
const CONST_11 = 0;
const CONST_12 = 1;
const CONST_13 = 2;
const CONST_14 = 3;
const CONST_15 = 4;
const CONST_16 = 5;
const CONST_17 = 6;
const CONST_18 = 7;
const CONST_19 = 8;
const CONST_20 = 9;
const CONST_21 = 10;
const CONST_22 = 11;
const CONST_23 = 12;
const CONST_24 = 13;
const CONST_25 = 14;
const CONST_26 = 15;

var string string_1;
var ItemWindowHandle item_1;
var ItemWindowHandle item_2;
var ItemWindowHandle item_3[15];
var ItemWindowHandle item_4;
var TextBoxHandle text_1;
var ItemWindowHandle item_5;
var ItemWindowHandle item_6;
var ItemWindowHandle item_7;
var ButtonHandle button_1;
var ButtonHandle button_2;
var ButtonHandle button_3;
var ButtonHandle button_4;
var ButtonHandle button_5;
var array<int> int_1;
var Vector vector_1;
var array<ItemInfo> info_1;
var array<ItemInfo> info_2;
var bool bool_1;
var int int_2;
var bool m_FastDeleteEnabled;

function OnLoad()
{
    RegisterEvent(2570);
    RegisterEvent(2580);
    RegisterEvent(2590);
    RegisterEvent(2600);
    RegisterEvent(2610);
    RegisterEvent(2620);
    RegisterEvent(2630);
    RegisterEvent(2631);
    RegisterEvent(260);
    RegisterEvent(180);
    RegisterEvent(1710);
    RegisterEvent(1900);
    function1();
    function2();
    function3();
    return;
}

function function1()
{
    item_1 = ItemWindowHandle(GetHandle((string_1 $ ".InventoryItem")));
    item_2 = ItemWindowHandle(GetHandle((string_1 $ ".QuestItem")));
    item_5 = ItemWindowHandle(GetHandle((string_1 $ ".EquipmentItem")));
    item_6 = ItemWindowHandle(GetHandle((string_1 $ ".CraftingItem")));
    item_7 = ItemWindowHandle(GetHandle((string_1 $ ".SuppliesItem")));
    text_1 = TextBoxHandle(GetHandle((string_1 $ ".AdenaText")));
    item_3[0] = ItemWindowHandle(GetHandle("EquipItem_Underwear"));
    item_3[1] = ItemWindowHandle(GetHandle("EquipItem_Head"));
    item_3[2] = ItemWindowHandle(GetHandle("EquipItem_Hair"));
    item_3[3] = ItemWindowHandle(GetHandle("EquipItem_Hair2"));
    item_3[4] = ItemWindowHandle(GetHandle("EquipItem_Neck"));
    item_3[5] = ItemWindowHandle(GetHandle("EquipItem_RHand"));
    item_3[6] = ItemWindowHandle(GetHandle("EquipItem_Chest"));
    item_3[7] = ItemWindowHandle(GetHandle("EquipItem_LHand"));
    item_3[8] = ItemWindowHandle(GetHandle("EquipItem_REar"));
    item_3[9] = ItemWindowHandle(GetHandle("EquipItem_LEar"));
    item_3[10] = ItemWindowHandle(GetHandle("EquipItem_Gloves"));
    item_3[11] = ItemWindowHandle(GetHandle("EquipItem_Legs"));
    item_3[12] = ItemWindowHandle(GetHandle("EquipItem_Feet"));
    item_3[13] = ItemWindowHandle(GetHandle("EquipItem_RFinger"));
    item_3[14] = ItemWindowHandle(GetHandle("EquipItem_LFinger"));
    item_3[7].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
    item_3[1].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
    item_3[10].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
    item_3[11].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
    item_3[12].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
    item_3[3].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
    item_4 = ItemWindowHandle(GetHandle("HennaItem"));
    button_1 = ButtonHandle(GetHandle("InventoryWnd.SortButton"));
    button_2 = ButtonHandle(GetHandle("InventoryWnd.EnchantButton"));
    button_3 = ButtonHandle(GetHandle("InventoryWnd.FastDelete"));
    button_1.SetTooltipCustomType(function4("Sorting"));
    button_2.SetTooltipCustomType(function4("Enchant Item"));
    button_4 = ButtonHandle(GetHandle("InventoryWnd.RefineButton"));
    button_4.SetTooltipCustomType(function4("Augment Item"));
    button_5 = ButtonHandle(GetHandle("InventoryWnd.TrashButton"));
    UpdateTrashButtonTooltip();
    LoadFastDeleteOption();
    UpdateFastDeleteButton();
    return;
}

function OnEvent(int int_3, string string_2)
{
    switch(int_3)
    {
        // End:0x18
        case 2570:
            function17();
            // End:0xEF
            break;
        // End:0x29
        case 2580:
            function27();
            // End:0xEF
            break;
        // End:0x3A
        case 2590:
            function29();
            // End:0xEF
            break;
        // End:0x50
        case 2600:
            function30(string_2);
            // End:0xEF
            break;
        // End:0x66
        case 2610:
            function34(string_2);
            // End:0xEF
            break;
        // End:0x77
        case 2620:
            function35();
            // End:0xEF
            break;
        // End:0x8D
        case 2630:
            function37(string_2);
            // End:0xEF
            break;
        // End:0xA3
        case 260:
            function38(string_2);
            // End:0xEF
            break;
        // End:0xB4
        case 2631:
            function42();
            // End:0xEF
            break;
        // End:0xC5
        case 1710:
            function40();
            // End:0xEF
            break;
        // End:0xD3
        case 180:
            function41();
            // End:0xEF
            break;
        // End:0xE9
        case 260:
            function38(string_2);
            // End:0xEF
            break;
        case 1900:
            UpdateFastDeleteButton();
            UpdateTrashButtonTooltip();
            // End:0xEF
            break;
        // End:0xFFFF
        default:
            // End:0xEF
            break;
            break;
    }
    return;
}

function OnShow()
{
    // End:0x3A
    if(Class'NWindow.UIDATA_PLAYER'.static.HasCrystallizeAbility())
    {
        ShowWindow((string_1 $ ".CrystallizeButton"));
    }
    else
    {
        HideWindow((string_1 $ ".CrystallizeButton"));
    }
    function6();
    function7();
    function8();
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("InventoryWnd.SortButton");
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("InventoryWnd.FastDelete");
    SetFocus();
    return;
}

function OnHide()
{
    function9();
    return;
}

function OnDBClickItemWithHandle(ItemWindowHandle handle_1, int int_4)
{
    // End:0x19
    if(IsFastDeleteShortcutDown())
    {
        return;
    }
    function10(handle_1, int_4);
    return;
}

function OnRClickItemWithHandle(ItemWindowHandle handle_2, int int_4)
{
    function10(handle_2, int_4);
    return;
}

function OnClickButton(string string_3)
{
    switch(string_3)
    {
        // End:0x25
        case "SortButton":
            SortItem(function12());
            // End:0x1DD
            break;
        case "FastDelete":
            ToggleFastDeleteOption();
            break;
        // End:0x52
        case "BtnClose":
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InventoryWnd");
            // End:0x1DD
            break;
        // End:0x9E
        case "BtnMin":
            Class'NWindow.UIAPI_WINDOW'.static.Iconize("InventoryWnd", "Was.Icon_df_MenuWnd_Inventory", 195);
            // End:0x1DD
            break;
        // End:0x135
        case "RefineButton":
            // End:0x112
            if((!IsShowWindow("AugmentationWnd")))
            {
                Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("AugmentationWnd");
                Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AugmentationWnd");
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.HideWindow("AugmentationWnd");
            }
            // End:0x1DD
            break;
        // End:0x14E
        case "TrashButton":
            if(IsKeyDown(IK_Alt))
            {
                ClearAutoTrashList();
            }
            else
            {
                function13();
            }
            // End:0x1DD
            break;
        // End:0x1DA
        case "BtnExpand":
            // End:0x1AE
            if((GetOptionBool("Options", "ExpandedInventory") == true))
            {
                SetOptionBool("Options", "ExpandedInventory", false);
            }
            else
            {
                SetOptionBool("Options", "ExpandedInventory", true);
            }
            function3();
            // End:0x1DD
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnSelectItemWithHandle(ItemWindowHandle item_10, int int_5)
{
    local int int_6;
    local string string_4;
    local ItemInfo info_3;

    string_4 = Class'NWindow.UIAPI_EDITBOX'.static.GetString("ChatWnd.ChatEditBox");
    // End:0x71
    if(IsFastDeleteShortcutDown())
    {
        item_10.GetSelectedItem(info_3);
        if(info_3.ServerID > 0 && info_3.ItemNum > 0)
        {
            RequestDestroyItem(info_3.ServerID, info_3.ItemNum);
        }
        return;
    }
    // End:0xAF
    if((IsKeyDown(IK_LControl) && (!IsKeyDown(IK_Alt))))
    {
        item_10.GetSelectedItem(info_3);
        function14(info_3);
    }
    // End:0x4E5
    if(IsKeyDown(IK_Shift))
    {
        item_10.GetSelectedItem(info_3);
        // End:0x13E
        if((info_3.ItemNum > 1))
        {
            SetChatMessage(((((((("" $ string_4) $ "") $ info_3.Name) $ " ") $ "(") $ MakeCostString(string(info_3.ItemNum))) $ ") "));
        }
        else
        {
            // End:0x311
            if((info_3.ItemType == 0))
            {
                // End:0x1FC
                if(((info_3.AdditionalName != "") && (info_3.Enchanted > 0)))
                {
                    SetChatMessage((((((((((("" $ string_4) $ "") $ info_3.Name) $ " ") $ "+") $ string(info_3.Enchanted)) $ "") $ " (") $ info_3.AdditionalName) $ ") "));
                }
                else
                {
                    // End:0x26B
                    if((info_3.Enchanted > 0))
                    {
                        SetChatMessage(((((((("" $ string_4) $ "") $ info_3.Name) $ " ") $ "+") $ string(info_3.Enchanted)) $ " "));
                    }
                    else
                    {
                        // End:0x2DA
                        if((info_3.AdditionalName != ""))
                        {
                            SetChatMessage(((((((("" $ string_4) $ "") $ info_3.Name) $ " ") $ "(") $ info_3.AdditionalName) $ ") "));
                        }
                        else
                        {
                            SetChatMessage((((("" $ string_4) $ "") $ info_3.Name) $ " "));
                        }
                    }
                }
            }
            else
            {
                // End:0x48D
                if(((info_3.ItemType == 1) || (info_3.ItemType == 2)))
                {
                    // End:0x3E7
                    if(((info_3.AdditionalName != "") && (info_3.Enchanted > 0)))
                    {
                        SetChatMessage((((((((((("" $ string_4) $ "") $ info_3.Name) $ " ") $ "+") $ string(info_3.Enchanted)) $ "") $ " (") $ info_3.AdditionalName) $ ") "));
                    }
                    else
                    {
                        // End:0x456
                        if((info_3.Enchanted > 0))
                        {
                            SetChatMessage(((((((("" $ string_4) $ "") $ info_3.Name) $ " ") $ "+") $ string(info_3.Enchanted)) $ " "));
                        }
                        else
                        {
                            SetChatMessage((((("" $ string_4) $ "") $ info_3.Name) $ " "));
                        }
                    }
                }
                else
                {
                    SetChatMessage((((("" $ string_4) $ "") $ info_3.Name) $ " "));
                }
            }
        }
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ChatWnd.ChatEditBox");
    }
    // End:0x53C
    if(((((item_10 == item_1) || (item_10 == item_5)) || (item_10 == item_6)) || (item_10 == item_7)))
    {
        return;
    }
    // End:0x551
    if((item_10 == item_2))
    {
        return;
    }
    int_6 = 0;

    while(int_6 < 15)
    {
        // End:0x58E
        if(item_10 != item_3[int_6])
        {
            item_3[int_6].ClearSelect();
        }
        int_6++;
    }
    return;
}

function OnDropItem(string string_5, ItemInfo info_3, int X, int Y)
{
    local int int_7, int_8, int_6, string_4;

    // End:0xDD
    if(!((((((info_3.DragSrcName == "EquipmentItem") || info_3.DragSrcName == "CraftingItem") || info_3.DragSrcName == "SuppliesItem") || info_3.DragSrcName == "InventoryItem") || info_3.DragSrcName == "QuestItem") || -1 != InStr(info_3.DragSrcName, "EquipItem")) || info_3.DragSrcName == "PetInvenWnd")
    {
        return;
    }
    // End:0x42A
    if((((string_5 == "InventoryItem") || string_5 == "EquipmentItem") || string_5 == "CraftingItem") || string_5 == "SuppliesItem")
    {
        // End:0x2DE
        if((((info_3.DragSrcName == "InventoryItem") || info_3.DragSrcName == "EquipmentItem") || info_3.DragSrcName == "CraftingItem") || info_3.DragSrcName == "SuppliesItem")
        {
            int_7 = function12().GetIndexAt(X, Y, 1, 1);
            // End:0x28C
            if(int_7 >= 0)
            {
                int_8 = function12().FindItemWithServerID(info_3.ServerID);
                // End:0x289
                if(int_7 != int_8)
                {

                    while(int_8 < int_7)
                    {
                        function12().SwapItems(int_8, int_8 + 1);
                        ++int_8;
                    }

                    while(int_7 < int_8)
                    {
                        function12().SwapItems(int_8, int_8 - 1);
                        --int_8;
                    }
                }
            }
            else
            {
                int_8 = function12().GetItemNum();

                while(int_7 < (int_8 - 1))
                {
                    function12().SwapItems(int_7, int_7 + 1);
                    ++int_7;
                }
            }
        }
        else
        {
            // End:0x31C
            if(-1 != InStr(info_3.DragSrcName, "EquipItem"))
            {
                RequestUnequipItem(info_3.ServerID, info_3.SlotBitType);
            }
            else
            {
                // End:0x427
                if((info_3.DragSrcName == "PetInvenWnd"))
                {
                    // End:0x40C
                    if((IsStackableItem(info_3.ConsumeType) && (info_3.ItemNum > 1)))
                    {
                        // End:0x3BE
                        if((info_3.AllItemCount > 0))
                        {
                            // End:0x3BB
                            if(CheckItemLimit(info_3.ClassID, info_3.AllItemCount))
                            {
                                Class'NWindow.PetAPI'.static.RequestGetItemFromPet(info_3.ServerID, info_3.AllItemCount, false);
                            }
                        }
                        else
                        {
                            DialogSetID(10000);
                            DialogSetReservedInt(info_3.ServerID);
                            DialogSetParamInt(info_3.ItemNum);
                            DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), info_3.Name));
                        }
                    }
                    else
                    {
                        Class'NWindow.PetAPI'.static.RequestGetItemFromPet(info_3.ServerID, 1, false);
                    }
                }
            }
        }
    }
    else
    {
        // End:0x578
        if((string_5 == "QuestItem"))
        {
            // End:0x575
            if((info_3.DragSrcName == "QuestItem"))
            {
                int_7 = item_2.GetIndexAt(X, Y, 1, 1);
                // End:0x528
                if(int_7 >= 0)
                {
                    int_8 = item_2.FindItemWithServerID(info_3.ServerID);
                    // End:0x525
                    if(int_7 != int_8)
                    {

                        while(int_8 < int_7)
                        {
                            item_2.SwapItems(int_8, int_8 + 1);
                            ++int_8;
                        }

                        while(int_7 < int_8)
                        {
                            item_2.SwapItems(int_8, int_8 - 1);
                            --int_8;
                        }
                    }
                }
                else
                {
                    int_8 = item_1.GetItemNum();

                    while(int_7 < (int_8 - 1))
                    {
                        item_1.SwapItems(int_7, int_7 + 1);
                        ++int_7;
                    }
                }
            }
        }
        else
        {
            // End:0x61E
            if(-1 != InStr(string_5, "EquipItem"))
            {
                // End:0x5D2
                if((info_3.DragSrcName == "PetInvenWnd"))
                {
                    Class'NWindow.PetAPI'.static.RequestGetItemFromPet(info_3.ServerID, 1, true);
                }
                else
                {
                    // End:0x5F6
                    if(-1 != InStr(info_3.DragSrcName, "EquipItem"))
                    {
                    }
                    else
                    {
                        // End:0x61B
                        if((info_3.ItemType != 5))
                        {
                            RequestUseItem(info_3.ServerID);
                        }
                    }
                }
            }
            else
            {
                // End:0x822
                if(string_5 == "TrashButton")
                {
                    // End:0x70D
                    if(bool_1)
                    {
                        int_6 = 1;

                        while(int_6 < 100)
                        {
                            GetINIInt("TrashList", ("" $ string(int_6)), string_4, "TrashGrp");
                            // End:0x69A
                            if((string_4 == info_3.ClassID))
                            {
                                return;
                            }
                            int_6++;
                        }
                        SetINIInt("TrashList", string((int_2 + 1)), info_3.ClassID, "TrashGrp");
                        SetINIInt("TrashList", string((int_2 + 2)), 0, "TrashGrp");
                        int_2++;
                    }
                    // End:0x7E4
                    if(IsStackableItem(info_3.ConsumeType) && info_3.ItemNum > 1)
                    {
                        // End:0x796
                        if((info_3.AllItemCount > 0))
                        {
                            DialogSetID(7777);
                            DialogSetReservedInt(info_3.ServerID);
                            DialogSetReservedInt2(info_3.AllItemCount);
                            DialogShow(DIALOG_Warning, MakeFullSystemMsg(GetSystemMessage(74), info_3.Name, ""));
                        }
                        else
                        {
                            DialogSetID(8888);
                            DialogSetReservedInt(info_3.ServerID);
                            DialogSetParamInt(info_3.ItemNum);
                            DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(73), info_3.Name));
                        }
                    }
                    else
                    {
                        DialogSetID(6666);
                        DialogSetReservedInt(info_3.ServerID);
                        DialogShow(DIALOG_Warning, MakeFullSystemMsg(GetSystemMessage(74), info_3.Name));
                    }
                }
                else
                {
                    // End:0x8F8
                    if((string_5 == "CrystallizeButton"))
                    {
                        // End:0x8F8
                        if(((info_3.DragSrcName == "InventoryItem") || -1 != InStr(info_3.DragSrcName, "EquipItem")))
                        {
                            // End:0x8F8
                            if((Class'NWindow.UIDATA_PLAYER'.static.HasCrystallizeAbility() && Class'NWindow.UIDATA_ITEM'.static.IsCrystallizable(info_3.ClassID)))
                            {
                                DialogSetID(9999);
                                DialogSetReservedInt(info_3.ServerID);
                                DialogShow(DIALOG_Warning, MakeFullSystemMsg(GetSystemMessage(336), info_3.Name));
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function OnDropItemSource(string string_5, ItemInfo info_3)
{
    // End:0x214
    if((string_5 == "Console"))
    {
        // End:0x211
        if((((((info_3.DragSrcName == "InventoryItem") || info_3.DragSrcName == "QuestItem") || info_3.DragSrcName == "EquipmentItem") || info_3.DragSrcName == "SuppliesItem") || info_3.DragSrcName == "CraftingItem") || -1 != InStr(info_3.DragSrcName, "EquipItem"))
        {
            vector_1 = GetClickLocation();
            // End:0x1CB
            if((IsStackableItem(info_3.ConsumeType) && (info_3.ItemNum > 1)))
            {
                // End:0x175
                if((info_3.AllItemCount > 0))
                {
                    DialogHide();
                    DialogSetID(5555);
                    DialogSetReservedInt(info_3.ServerID);
                    DialogSetReservedInt2(info_3.AllItemCount);
                    DialogShow(DIALOG_Warning, MakeFullSystemMsg(GetSystemMessage(1833), info_3.Name, ""));
                }
                else
                {
                    DialogHide();
                    DialogSetID(4444);
                    DialogSetReservedInt(info_3.ServerID);
                    DialogSetParamInt(info_3.ItemNum);
                    DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(71), info_3.Name, ""));
                }
            }
            else
            {
                DialogHide();
                DialogSetID(3333);
                DialogSetReservedInt(info_3.ServerID);
                DialogShow(DIALOG_Warning, MakeFullSystemMsg(GetSystemMessage(400), info_3.Name, ""));
            }
        }
    }
    else
    {
        // End:0x313
        if(((string_5 == "AdenaText") || (string_5 == "NPHRN_BeltWnd")))
        {
            // End:0x313
            if((((((info_3.DragSrcName == "InventoryItem") || info_3.DragSrcName == "QuestItem") || info_3.DragSrcName == "EquipmentItem") || info_3.DragSrcName == "SuppliesItem") || info_3.DragSrcName == "CraftingItem") || -1 != InStr(info_3.DragSrcName, "EquipItem"))
            {
                function14(info_3);
            }
        }
    }
    return;
}

function function14(ItemInfo info_4)
{
    return;
}

function bool function15(out ItemInfo info_3)
{
    return info_3.bEquipped;
}

function bool function16(out ItemInfo info_3)
{
    return (info_3.ItemType == 3);
}

function function17()
{
    function18();
    item_1.Clear();
    item_2.Clear();
    info_1.Length = 0;
    info_2.Length = 0;
    item_5.Clear();
    item_6.Clear();
    item_7.Clear();
    return;
}

function int function19()
{
    local int int_6, ItemNum;

    int_6 = 0;

    while(int_6 < 15)
    {
        // End:0x51
        if(item_3[int_6].IsEnableWindow())
        {
            ItemNum = (ItemNum + item_3[int_6].GetItemNum());
        }
        int_6++;
    }
    return ItemNum;
}

function function18()
{
    local int int_6;

    int_6 = 0;

    while(int_6 < 15)
    {
        item_3[int_6].Clear();
        int_6++;
    }
    return;
}

function bool function20(int int_9)
{
    local int int_6, int_4;

    int_6 = 0;

    while(int_6 < 15)
    {
        int_4 = item_3[int_6].FindItemWithServerID(int_9);
        // End:0x48
        if((-1 != int_4))
        {
            return true;
        }
        int_6++;
    }
    return false;
}

function function21(int int_9)
{
    local int int_6, int_4;
    local ItemInfo info_5;

    int_6 = 0;

    while(int_6 < 15)
    {
        int_4 = item_3[int_6].FindItemWithServerID(int_9);
        // End:0xD9
        if((-1 != int_4))
        {
            item_3[int_6].Clear();
            // End:0xD9
            if((int_6 == 7))
            {
                // End:0xD9
                if(item_3[5].GetItem(0, info_5))
                {
                    // End:0xD9
                    if((info_5.SlotBitType == 16384))
                    {
                        item_3[7].Clear();
                        item_3[7].AddItem(info_5);
                        item_3[7].DisableWindow();
                    }
                }
            }
        }
        int_6++;
    }
    return;
}

function function22()
{
    local int int_6, int_10, int_11;

    int_10 = -1;
    int_11 = -1;
    int_6 = 0;

    while(int_6 < info_1.Length)
    {
        switch(function44(info_1[int_6].ServerID))
        {
            // End:0x5B
            case -1:
                int_10 = int_6;
                // End:0x83
                break;
            // End:0x6E
            case 0:
                info_1.Remove(int_6, 1);
                // End:0x83
                break;
            // End:0x80
            case 1:
                int_11 = int_6;
                // End:0x83
                break;
            // End:0xFFFF
            default:
                break;
        }
        int_6++;
    }
    // End:0xCF
    if((-1 != int_10))
    {
        item_3[9].Clear();
        item_3[9].AddItem(info_1[int_10]);
    }
    // End:0x111
    if((-1 != int_11))
    {
        item_3[8].Clear();
        item_3[8].AddItem(info_1[int_11]);
    }
    return;
}

function function23()
{
    local int int_6, int_12, int_13;

    int_12 = -1;
    int_13 = -1;
    int_6 = 0;

    while(int_6 < info_2.Length)
    {
        switch(function45(info_2[int_6].ServerID))
        {
            // End:0x5B
            case -1:
                int_12 = int_6;
                // End:0x83
                break;
            // End:0x6E
            case 0:
                info_2.Remove(int_6, 1);
                // End:0x83
                break;
            // End:0x80
            case 1:
                int_13 = int_6;
                // End:0x83
                break;
            // End:0xFFFF
            default:
                break;
        }
        int_6++;
    }
    // End:0xCF
    if((-1 != int_12))
    {
        item_3[14].Clear();
        item_3[14].AddItem(info_2[int_12]);
    }
    // End:0x111
    if((-1 != int_13))
    {
        item_3[13].Clear();
        item_3[13].AddItem(info_2[int_13]);
    }
    return;
}

function function24(ItemInfo info_6)
{
    local ItemWindowHandle item;
    local ItemInfo info_5;
    local bool bool_1;
    local ItemInfo info_9, info_10, info_3, info_4, info_7, info_8;

    local int int_6;

    switch(info_6.SlotBitType)
    {
        // End:0x20
        case 1:
            item = item_3[0];
            // End:0x672
            break;
        // End:0x25
        case 2:
        // End:0x2A
        case 4:
        // End:0xC4
        case 6:
            int_6 = 0;

            while(int_6 < info_1.Length)
            {
                // End:0x69
                if((info_1[int_6].ServerID == info_6.ServerID))
                {
                }
                int_6++;
            }
            // End:0xB4
            if((int_6 == info_1.Length))
            {
                info_1.Length = (info_1.Length + 1);
                info_1[(info_1.Length - 1)] = info_6;
            }
            item = none;
            function22();
            // End:0x672
            break;
        // End:0xDA
        case 8:
            item = item_3[4];
            // End:0x672
            break;
        // End:0xDF
        case 16:
        // End:0xE4
        case 32:
        // End:0x17E
        case 48:
            int_6 = 0;

            while(int_6 < info_2.Length)
            {
                // End:0x123
                if((info_2[int_6].ServerID == info_6.ServerID))
                {
                }
                int_6++;
            }
            // End:0x16E
            if((int_6 == info_2.Length))
            {
                info_2.Length = (info_2.Length + 1);
                info_2[(info_2.Length - 1)] = info_6;
            }
            item = none;
            function23();
            // End:0x672
            break;
        // End:0x1A2
        case 64:
            item = item_3[1];
            item.EnableWindow();
            // End:0x672
            break;
        // End:0x1B8
        case 128:
            item = item_3[5];
            // End:0x672
            break;
        // End:0x1E0
        case 256:
            item = item_3[7];
            item.EnableWindow();
            // End:0x672
            break;
        // End:0x208
        case 512:
            item = item_3[10];
            item.EnableWindow();
            // End:0x672
            break;
        // End:0x221
        case 1024:
            item = item_3[6];
            // End:0x672
            break;
        // End:0x249
        case 2048:
            item = item_3[11];
            item.EnableWindow();
            // End:0x672
            break;
        // End:0x271
        case 4096:
            item = item_3[12];
            item.EnableWindow();
            // End:0x672
            break;
        // End:0x289
        case 8192:
            item = item_3[0];
            // End:0x672
            break;
        // End:0x3E4
        case 16384:
            item = item_3[5];
            bool_1 = true;
            // End:0x2E6
            if(function25(info_6))
            {
                // End:0x2E6
                if(item_3[7].GetItem(0, info_5))
                {
                    // End:0x2E6
                    if(function26(info_5))
                    {
                        bool_1 = false;
                    }
                }
            }
            // End:0x3E1
            if(bool_1)
            {
                // End:0x3A6
                if((Len(info_6.IconNameEx1) != 0))
                {
                    info_9 = info_6;
                    info_10 = info_6;
                    info_9.IconIndex = 1;
                    info_10.IconIndex = 2;
                    item_3[5].Clear();
                    item_3[5].AddItem(info_9);
                    item_3[7].Clear();
                    item_3[7].AddItem(info_10);
                    item_3[7].DisableWindow();
                    item = none;
                }
                else
                {
                    item_3[7].Clear();
                    item_3[7].AddItem(info_6);
                    item_3[7].DisableWindow();
                }
            }
            // End:0x672
            break;
        // End:0x458
        case 32768:
            item = item_3[6];
            info_3 = info_6;
            info_3.IconName = info_6.IconNameEx2;
            item_3[11].Clear();
            item_3[11].AddItem(info_3);
            item_3[11].DisableWindow();
            // End:0x672
            break;
        // End:0x471
        case 65536:
            item = item_3[2];
            // End:0x672
            break;
        // End:0x5F3
        case 131072:
            item = item_3[6];
            info_8 = info_6;
            info_4 = info_6;
            info_3 = info_6;
            info_7 = info_6;
            info_8.IconName = info_6.IconNameEx1;
            info_4.IconName = info_6.IconNameEx2;
            info_3.IconName = info_6.IconNameEx3;
            info_7.IconName = info_6.IconNameEx4;
            item_3[1].Clear();
            item_3[1].AddItem(info_8);
            item_3[1].DisableWindow();
            item_3[10].Clear();
            item_3[10].AddItem(info_4);
            item_3[10].DisableWindow();
            item_3[11].Clear();
            item_3[11].AddItem(info_3);
            item_3[11].DisableWindow();
            item_3[12].Clear();
            item_3[12].AddItem(info_7);
            item_3[12].DisableWindow();
            // End:0x672
            break;
        // End:0x61B
        case 262144:
            item = item_3[3];
            item.EnableWindow();
            // End:0x672
            break;
        // End:0x66F
        case 524288:
            item = item_3[2];
            item_3[3].Clear();
            item_3[3].AddItem(info_6);
            item_3[3].DisableWindow();
            // End:0x672
            break;
        // End:0xFFFF
        default:
            break;
    }
    TryAutoEquipSet(info_6);
    // End:0x6A0
    if(none != item)
    {
        item.Clear();
        item.AddItem(info_6);
    }
    return;
}

function TryAutoEquipSet(ItemInfo EquippedItem)
{
    local array<int> SetItemIDs;
    local int i;
    local int Index;
    local ItemInfo SetItem;

    if(GetOptionBool("Custom", "DisableAutoEquipSet"))
    {
        return;
    }

    if((EquippedItem.SlotBitType != 1024) && (EquippedItem.SlotBitType != 32768))
    {
        return;
    }

    Class'NWindow.UIDATA_ITEM'.static.GetSetItemIDList(EquippedItem.ClassID, 0, SetItemIDs);
    i = 0;

    while(i < SetItemIDs.Length)
    {
        if(SetItemIDs[i] != EquippedItem.ClassID)
        {
            Index = item_1.FindItemWithClassID(SetItemIDs[i]);
            if((Index >= 0) && item_1.GetItem(Index, SetItem))
            {
                RequestUseItem(SetItem.ServerID);
            }
        }
        ++i;
    }
    return;
}

function function27()
{
    function28();
    ShowWindow(string_1);
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus(string_1);
    return;
}

function function29()
{
    HideWindow(string_1);
    return;
}

function function30(string string_2)
{
    local ItemInfo info_4;
    local bool bCanAutoTrash;

    ParamToItemInfo(string_2, info_4);
    // End:0x2C
    if(function15(info_4))
    {
        function24(info_4);
    }
    else
    {
        bCanAutoTrash = !function16(info_4);
        // End:0x51
        if(function16(info_4))
        {
            item_2.AddItem(info_4);
        }
        else
        {
            item_1.AddItem(info_4);
            // End:0x8A
            if(function31(info_4))
            {
                item_5.AddItem(info_4);
            }
            else
            {
                // End:0xAF
                if(function32(info_4))
                {
                    item_6.AddItem(info_4);
                }
                else
                {
                    // End:0xD1
                    if(function33(info_4))
                    {
                        item_7.AddItem(info_4);
                    }
                }
            }
        }
    }
    if(bCanAutoTrash)
    {
        TryAutoTrashItem(info_4);
    }
    return;
}

function bool function31(ItemInfo info_4)
{
    // End:0x45
    if((((info_4.ItemType == 0) || (info_4.ItemType == 1)) || (info_4.ItemType == 2)))
    {
        return true;
    }
    return false;
}

function bool function32(ItemInfo info_4)
{
    // End:0x2F
    if(((info_4.ItemSubType == 5) || (info_4.ItemSubType == 6)))
    {
        return true;
    }
    return false;
}

function bool function33(ItemInfo info_4)
{
    // End:0xAC
    if(((((((info_4.ItemSubType == 1) || (info_4.ItemSubType == 2)) || (info_4.ItemSubType == 24)) || (info_4.ItemSubType == 3)) || (Left(info_4.Name, 6) == "Elixir")) || (Left(info_4.Name, 8) == "Soulshot")))
    {
        return true;
    }
    return false;
}

function function34(string string_2)
{
    local string string_1;
    local ItemInfo info_3;
    local int int_4;
    local bool bCanAutoTrash;

    ParseString(string_2, "type", string_1);
    ParamToItemInfo(string_2, info_3);
    // End:0x26A
    if((string_1 == "add"))
    {
        // End:0x55
        if(function15(info_3))
        {
            function24(info_3);
        }
        else
        {
            bCanAutoTrash = !function16(info_3);
            // End:0xC3
            if(function16(info_3))
            {
                item_2.AddItem(info_3);
                int_4 = item_2.GetItemNum() - 1;

                while(int_4 > 0)
                {
                    item_2.SwapItems(int_4 - 1, int_4);
                    --int_4;
                }
            }
            else
            {
                item_1.AddItem(info_3);
                int_4 = item_1.GetItemNum() - 1;

                while(int_4 > 0)
                {
                    item_1.SwapItems(int_4 - 1, int_4);
                    --int_4;
                }
                // End:0x18E
                if(function31(info_3))
                {
                    item_5.AddItem(info_3);
                    int_4 = item_5.GetItemNum() - 1;

                    while(int_4 > 0)
                    {
                        item_5.SwapItems(int_4 - 1, int_4);
                        --int_4;
                    }
                }
                else
                {
                    // End:0x1FC
                    if(function32(info_3))
                    {
                        item_6.AddItem(info_3);
                        int_4 = item_6.GetItemNum() - 1;

                        while(int_4 > 0)
                        {
                            item_6.SwapItems(int_4 - 1, int_4);
                            --int_4;
                        }
                    }
                    else
                    {
                        // End:0x267
                        if(function33(info_3))
                        {
                            item_7.AddItem(info_3);
                            int_4 = item_7.GetItemNum() - 1;

                            while(int_4 > 0)
                            {
                                item_7.SwapItems(int_4 - 1, int_4);
                                --int_4;
                            }
                        }
                    }
                }
            }
        }
    }
    else
    {
        // End:0x6C2
        if((string_1 == "update"))
        {
            // End:0x405
            if(function15(info_3))
            {
                // End:0x2AF
                if(function20(info_3.ServerID))
                {
                    function24(info_3);
                }
                else
                {
                    int_4 = item_1.FindItemWithServerID(info_3.ServerID);
                    // End:0x2F5
                    if((int_4 != -1))
                    {
                        item_1.DeleteItem(int_4);
                    }
                    // End:0x34C
                    if(function31(info_3))
                    {
                        int_4 = item_5.FindItemWithServerID(info_3.ServerID);
                        // End:0x349
                        if((int_4 != -1))
                        {
                            item_5.DeleteItem(int_4);
                        }
                    }
                    else
                    {
                        // End:0x3A3
                        if(function32(info_3))
                        {
                            int_4 = item_6.FindItemWithServerID(info_3.ServerID);
                            // End:0x3A0
                            if((int_4 != -1))
                            {
                                item_6.DeleteItem(int_4);
                            }
                        }
                        else
                        {
                            // End:0x3F7
                            if(function33(info_3))
                            {
                                int_4 = item_7.FindItemWithServerID(info_3.ServerID);
                                // End:0x3F7
                                if((int_4 != -1))
                                {
                                    item_7.DeleteItem(int_4);
                                }
                            }
                        }
                    }
                    function24(info_3);
                }
            }
            else
            {
                bCanAutoTrash = !function16(info_3);
                // End:0x488
                if(function16(info_3))
                {
                    int_4 = item_2.FindItemWithServerID(info_3.ServerID);
                    // End:0x461
                    if((int_4 != -1))
                    {
                        item_2.SetItem(int_4, info_3);
                    }
                    else
                    {
                        function21(info_3.ServerID);
                        item_2.AddItem(info_3);
                    }
                }
                else
                {
                    // End:0x4E4
                    if(function31(info_3))
                    {
                        int_4 = item_5.FindItemWithServerID(info_3.ServerID);
                        // End:0x4E1
                        if((int_4 != -1))
                        {
                            item_5.SetItem(int_4, info_3);
                        }
                    }
                    else
                    {
                        // End:0x540
                        if(function32(info_3))
                        {
                            int_4 = item_6.FindItemWithServerID(info_3.ServerID);
                            // End:0x53D
                            if((int_4 != -1))
                            {
                                item_6.SetItem(int_4, info_3);
                            }
                        }
                        else
                        {
                            // End:0x599
                            if(function33(info_3))
                            {
                                int_4 = item_7.FindItemWithServerID(info_3.ServerID);
                                // End:0x599
                                if((int_4 != -1))
                                {
                                    item_7.SetItem(int_4, info_3);
                                }
                            }
                        }
                    }
                    int_4 = item_1.FindItemWithServerID(info_3.ServerID);
                    // End:0x5E7
                    if((int_4 != -1))
                    {
                        item_1.SetItem(int_4, info_3);
                    }
                    else
                    {
                        function21(info_3.ServerID);
                        item_1.AddItem(info_3);
                        int_4 = item_1.GetItemNum() - 1;

                        while(int_4 > 0)
                        {
                            item_1.SwapItems(int_4 - 1, int_4);
                            --int_4;
                        }
                        // End:0x6BF
                        if(function31(info_3))
                        {
                            item_5.AddItem(info_3);
                            int_4 = item_5.GetItemNum() - 1;

                            while(int_4 > 0)
                            {
                                item_5.SwapItems(int_4 - 1, int_4);
                                --int_4;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            // End:0x833
            if((string_1 == "delete"))
            {
                // End:0x6F9
                if(function15(info_3))
                {
                    function21(info_3.ServerID);
                }
                else
                {
                    // End:0x73D
                    if(function16(info_3))
                    {
                        int_4 = item_2.FindItemWithServerID(info_3.ServerID);
                        item_2.DeleteItem(int_4);
                    }
                    else
                    {
                        int_4 = item_1.FindItemWithServerID(info_3.ServerID);
                        item_1.DeleteItem(int_4);
                        // End:0x7B1
                        if(function31(info_3))
                        {
                            int_4 = item_5.FindItemWithServerID(info_3.ServerID);
                            item_5.DeleteItem(int_4);
                        }
                        // End:0x7F2
                        if(function32(info_3))
                        {
                            int_4 = item_6.FindItemWithServerID(info_3.ServerID);
                            item_6.DeleteItem(int_4);
                        }
                        // End:0x833
                        if(function33(info_3))
                        {
                            int_4 = item_7.FindItemWithServerID(info_3.ServerID);
                            item_7.DeleteItem(int_4);
                        }
                    }
                }
            }
        }
    }
    if(bCanAutoTrash)
    {
        TryAutoTrashItem(info_3);
    }
    function6();
    function7();
    return;
}

function function35()
{
    function6();
    function7();
    function36();
    return;
}

function function37(string string_2)
{
    function8();
    return;
}

function function38(string string_2)
{
    function8();
    return;
}

function function8()
{
    local int int_6, int_1, HennaID, int_2;
    local ItemInfo Info;
    local UserInfo UserInfo;
    local int int_3;

    // End:0x66
    if(GetPlayerInfo(UserInfo))
    {
        int_3 = GetClassStep(UserInfo.nSubClass);
        switch(int_3)
        {
            // End:0x2F
            case 1:
            // End:0x34
            case 2:
            // End:0x50
            case 3:
                item_4.SetRow(int_3);
                // End:0x66
                break;
            // End:0xFFFF
            default:
                item_4.SetRow(0);
                // End:0x66
                break;
                break;
        }
    }
    item_4.Clear();
    int_1 = Class'NWindow.HennaAPI'.static.GetHennaInfoCount();
    // End:0xA8
    if((int_1 > int_3))
    {
        int_1 = int_3;
    }
    int_6 = 0;

    while(int_6 < int_1)
    {
        // End:0x19D
        if(Class'NWindow.HennaAPI'.static.GetHennaInfo(int_6, HennaID, int_2))
        {
            // End:0x109
            if((!Class'NWindow.UIDATA_HENNA'.static.GetItemName(HennaID, Info.Name)))
            {
                break;
            }
            // End:0x133
            if((!Class'NWindow.UIDATA_HENNA'.static.GetDescription(HennaID, Info.Description)))
            {
                break;
            }
            // End:0x15D
            if((!Class'NWindow.UIDATA_HENNA'.static.GetIconTex(HennaID, Info.IconName)))
            {
                break;
            }
            // End:0x17C
            if((0 == int_2))
            {
                Info.bDisabled = true;
            }
            else
            {
                Info.bDisabled = false;
            }
            item_4.AddItem(Info);
        }
        int_6++;
    }

    return;
}

function function6()
{
    local string string_1;

    string_1 = MakeCostString(string(GetAdena()));
    text_1.SetText(string_1);
    text_1.SetTooltipString(ConvertNumToText(string(GetAdena())));
    return;
}

function function10(ItemWindowHandle Handle, int int_4)
{
    local ItemInfo info_3;

    // End:0xB5
    if(Handle.GetItem(int_4, info_3))
    {
        // End:0x5B
        if(info_3.bRecipe)
        {
            DialogSetReservedInt(info_3.ServerID);
            DialogSetID(1111);
            DialogShow(DIALOG_Warning, GetSystemMessage(798));
        }
        else
        {
            // End:0xA5
            if((info_3.PopMsgNum > 0))
            {
                DialogSetID(2222);
                DialogSetReservedInt(info_3.ServerID);
                DialogShow(DIALOG_Warning, GetSystemMessage(info_3.PopMsgNum));
            }
            else
            {
                RequestUseItem(info_3.ServerID);
            }
        }
    }
    return;
}

function function9()
{
    local ItemInfo info_3;
    local int int_6;

    int_1.Length = item_1.GetItemNum();
    int_6 = 0;

    while(int_6 < int_1.Length)
    {
        item_1.GetItem(int_6, info_3);
        int_1[int_6] = info_3.ClassID;
        int_6++;
    }
    SaveInventoryOrder(int_1);
    return;
}

function function28()
{
    LoadInventoryOrder(int_1);
    return;
}

function function36()
{
    local int int_4, ItemNum, int_2, int_3;
    local ItemInfo info_3;
    local bool bool_1;

    int_4 = 0;
    ItemNum = item_1.GetItemNum();
    int_2 = 0;

    while(int_2 < ItemNum)
    {
        item_1.GetItem(int_2, info_3);
        bool_1 = false;
        int_3 = 0;

        while(int_3 < int_1.Length)
        {
            // End:0x93
            if((info_3.ClassID == int_1[int_3]))
            {
                bool_1 = true;
                // [Explicit Continue]
            }
            int_3++;
        }
        // End:0xD0
        if((!bool_1))
        {
            item_1.SwapItems(int_2, int_4);
            ++int_4;
        }
        int_2++;
    }
    int_3 = 0;

    while(int_3 < int_1.Length)
    {
        int_2 = 0;

        while(int_2 < ItemNum)
        {
            item_1.GetItem(int_2, info_3);
            // End:0x165
            if((info_3.ClassID == int_1[int_3]))
            {
                item_1.SwapItems(int_2, int_4);
                ++int_4;
                // [Explicit Continue]
            }
            int_2++;
        }
        int_3++;
    }
    return;
}

function int function39()
{
    return Class'NWindow.UIDATA_PLAYER'.static.GetInventoryLimit();
}

function function7()
{
    local int int_1, int_2;
    local TextBoxHandle text_1;

    int_2 = ((item_1.GetItemNum() + item_2.GetItemNum()) + function19());
    int_1 = function39();
    text_1 = TextBoxHandle(GetHandle((string_1 $ ".ItemCount")));
    text_1.SetText((((("(" $ string(int_2)) $ "/") $ string(int_1)) $ ")"));
    return;
}

function function40()
{
    local int Id, Reserved, int_1, int_2;

    // End:0x195
    if(DialogIsMine())
    {
        Id = DialogGetID();
        Reserved = DialogGetReservedInt();
        int_1 = DialogGetReservedInt2();
        int_2 = int(DialogGetString());
        // End:0x69
        if((Id == 1111) || Id == 2222)
        {
            RequestUseItem(Reserved);
        }
        else
        {
            // End:0x8C
            if(Id == 3333)
            {
                RequestDropItem(Reserved, 1, vector_1);
            }
            else
            {
                // End:0xC5
                if(Id == 4444)
                {
                    // End:0xAD
                    if(int_2 == 0)
                    {
                        int_2 = 1;
                    }
                    RequestDropItem(Reserved, int_2, vector_1);
                }
                else
                {
                    // End:0xEC
                    if(Id == 5555)
                    {
                        RequestDropItem(Reserved, int_1, vector_1);
                    }
                    else
                    {
                        // End:0x10A
                        if(Id == 6666)
                        {
                            RequestDestroyItem(Reserved, 1);
                        }
                        else
                        {
                            // End:0x12C
                            if(Id == 8888)
                            {
                                RequestDestroyItem(Reserved, int_2);
                            }
                            else
                            {
                                // End:0x14E
                                if(Id == 7777)
                                {
                                    RequestDestroyItem(Reserved, int_1);
                                }
                                else
                                {
                                    // End:0x16C
                                    if(Id == 9999)
                                    {
                                        RequestCrystallizeItem(Reserved, 1);
                                    }
                                    else
                                    {
                                        // End:0x195
                                        if(Id == 10000)
                                        {
                                            Class'NWindow.PetAPI'.static.RequestGetItemFromPet(Reserved, int_2, false);
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

function function41()
{
    // End:0x1E
    if(m_hOwnerWnd.IsShowWindow())
    {
        function22();
        function23();
    }
    return;
}

function function42()
{
    // End:0x24
    if(m_hOwnerWnd.IsShowWindow())
    {
        m_hOwnerWnd.HideWindow();
    }
    else
    {
        // End:0x42
        if(function43())
        {
            RequestItemList();
            m_hOwnerWnd.ShowWindow();
        }
    }
    return;
}

function bool function43()
{
    local WindowHandle window_1, window_2, window_3, window_4, window_5, window_6;

    local PrivateShopWnd PrivateShopWnd;

    window_1 = GetHandle("WarehouseWnd");
    window_2 = GetHandle("PrivateShopWnd");
    window_3 = GetHandle("TradeWnd");
    window_4 = GetHandle("ShopWnd");
    window_5 = GetHandle("MultiSellWnd");
    window_6 = GetHandle("DeliverWnd");
    PrivateShopWnd = PrivateShopWnd(GetScript("PrivateShopWnd"));
    // End:0xC8
    if(window_1.IsShowWindow())
    {
        return false;
    }
    // End:0xDC
    if(window_1.IsShowWindow())
    {
        return false;
    }
    // End:0xF0
    if(window_3.IsShowWindow())
    {
        return false;
    }
    // End:0x104
    if(window_4.IsShowWindow())
    {
        return false;
    }
    // End:0x118
    if(window_5.IsShowWindow())
    {
        return false;
    }
    // End:0x12C
    if(window_6.IsShowWindow())
    {
        return false;
    }
    // End:0x15E
    if((window_2.IsShowWindow() && (int(PrivateShopWnd.m_Type) == 2)))
    {
        return false;
    }
    return true;
}

function int function44(int int_9)
{
    local int int_1, int_2, int_3, int_4;

    GetAccessoryServerID(int_1, int_2, int_3, int_4);
    // End:0x36
    if((int_9 == int_1))
    {
        return -1;
    }
    else
    {
        // End:0x4E
        if((int_9 == int_2))
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    return 0;
}

function int function45(int int_9)
{
    local int int_1, int_2, int_3, int_4;

    GetAccessoryServerID(int_1, int_2, int_3, int_4);
    // End:0x36
    if((int_9 == int_3))
    {
        return -1;
    }
    else
    {
        // End:0x4E
        if((int_9 == int_4))
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    return 0;
}

function bool function25(ItemInfo info_6)
{
    // End:0x2F
    if(((6 == info_6.WeaponType) || (10 == info_6.WeaponType)))
    {
        return true;
    }
    return false;
}

function bool function26(ItemInfo info_6)
{
    return info_6.bArrow;
}

function CustomTooltip function4(string string_1)
{
    local CustomTooltip ToolTip;
    local DrawItemInfo info_3;

    ToolTip.DrawList.Length = 1;
    info_3.eType = DIT_TEXT;
    info_3.t_strText = string_1;
    ToolTip.DrawList[0] = info_3;
    return ToolTip;
}

function CustomTooltip MakeFastDeleteTooltip()
{
    local CustomTooltip ToolTip;
    local DrawItemInfo info_3;

    ToolTip.DrawList.Length = 4;

    info_3.eType = DIT_TEXT;
    if(m_FastDeleteEnabled)
    {
        info_3.t_strText = GetLocalizedText("Fast delete: ON", "193,251,241,242,240,238,229,32,243,228,224,235,229,237,232,229,58,32,194,202,203");
        info_3.t_color.R = 120;
        info_3.t_color.G = 220;
        info_3.t_color.B = 120;
    }
    else
    {
        info_3.t_strText = GetLocalizedText("Fast delete: OFF", "193,251,241,242,240,238,229,32,243,228,224,235,229,237,232,229,58,32,194,219,202,203");
        info_3.t_color.R = 220;
        info_3.t_color.G = 120;
        info_3.t_color.B = 120;
    }
    info_3.t_color.A = byte(255);
    info_3.bLineBreak = true;
    info_3.t_bDrawOneLine = true;
    ToolTip.DrawList[0] = info_3;

    info_3.t_strText = GetLocalizedText("Ctrl + Alt + Click item", "67,116,114,108,32,43,32,65,108,116,32,43,32,234,235,232,234,32,239,238,32,239,240,229,228,236,229,242,243");
    info_3.t_color.R = 218;
    info_3.t_color.G = 190;
    info_3.t_color.B = 1;
    info_3.t_color.A = byte(255);
    info_3.bLineBreak = true;
    info_3.t_bDrawOneLine = true;
    ToolTip.DrawList[1] = info_3;

    info_3.t_strText = GetLocalizedText("Deletes the item immediately", "211,228,224,235,255,229,242,32,239,240,229,228,236,229,242,32,241,240,224,231,243");
    info_3.t_color.R = 176;
    info_3.t_color.G = 153;
    info_3.t_color.B = 121;
    info_3.t_color.A = byte(255);
    info_3.bLineBreak = true;
    info_3.t_bDrawOneLine = true;
    ToolTip.DrawList[2] = info_3;

    info_3.t_strText = GetLocalizedText("Click icon to toggle", "202,235,232,234,32,239,238,32,232,234,238,237,234,229,58,32,226,234,235,47,226,251,234,235");
    info_3.t_color.R = 176;
    info_3.t_color.G = 153;
    info_3.t_color.B = 121;
    info_3.t_color.A = byte(255);
    info_3.bLineBreak = true;
    info_3.t_bDrawOneLine = true;
    ToolTip.DrawList[3] = info_3;

    return ToolTip;
}

function bool IsFastDeleteShortcutDown()
{
    return m_FastDeleteEnabled && IsKeyDown(IK_Alt) && (IsKeyDown(IK_Ctrl) || IsKeyDown(IK_LControl));
}

function LoadFastDeleteOption()
{
    local int InitValue;
    local int EnabledValue;

    GetINIInt("Inventory", "FastDeleteInitialized", InitValue, "Option");
    if(InitValue == 0)
    {
        SetINIInt("Inventory", "FastDeleteInitialized", 1, "Option");
        SetINIInt("Inventory", "FastDeleteEnabled", 1, "Option");
        m_FastDeleteEnabled = true;
        return;
    }

    GetINIInt("Inventory", "FastDeleteEnabled", EnabledValue, "Option");
    m_FastDeleteEnabled = EnabledValue != 0;
}

function SaveFastDeleteOption()
{
    if(m_FastDeleteEnabled)
    {
        SetINIInt("Inventory", "FastDeleteEnabled", 1, "Option");
    }
    else
    {
        SetINIInt("Inventory", "FastDeleteEnabled", 0, "Option");
    }
}

function ToggleFastDeleteOption()
{
    m_FastDeleteEnabled = !m_FastDeleteEnabled;
    SaveFastDeleteOption();
    UpdateFastDeleteButton();
}

function UpdateFastDeleteButton()
{
    button_3.SetTooltipCustomType(MakeFastDeleteTooltip());
    if(m_FastDeleteEnabled)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("InventoryWnd.FastDelete", 255);
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("InventoryWnd.FastDelete", 110);
    }
}

function CustomTooltip MakeTrashButtonTooltip()
{
    local CustomTooltip ToolTip;
    local DrawItemInfo info_3;

    ToolTip.DrawList.Length = 5;

    info_3.eType = DIT_TEXT;
    if(bool_1)
    {
        info_3.t_strText = GetLocalizedText("Auto delete: ON", "192,226,242,238,243,228,224,235,229,237,232,229,58,32,194,202,203");
        info_3.t_color.R = 120;
        info_3.t_color.G = 220;
        info_3.t_color.B = 120;
    }
    else
    {
        info_3.t_strText = GetLocalizedText("Auto delete: OFF", "192,226,242,238,243,228,224,235,229,237,232,229,58,32,194,219,202,203");
        info_3.t_color.R = 220;
        info_3.t_color.G = 120;
        info_3.t_color.B = 120;
    }
    info_3.t_color.A = byte(255);
    info_3.bLineBreak = true;
    info_3.t_bDrawOneLine = true;
    ToolTip.DrawList[0] = info_3;

    info_3.t_strText = GetLocalizedText("Click trash to toggle auto mode", "202,235,232,234,32,239,238,32,234,238,240,231,232,237,229,58,32,226,234,235,47,226,251,234,235");
    info_3.t_color.R = 218;
    info_3.t_color.G = 190;
    info_3.t_color.B = 1;
    info_3.t_color.A = byte(255);
    info_3.bLineBreak = true;
    info_3.t_bDrawOneLine = true;
    ToolTip.DrawList[1] = info_3;

    info_3.t_strText = GetLocalizedText("Alt + Click trash to clear list", "65,108,116,32,43,32,234,235,232,234,58,32,238,247,232,241,242,232,242,252,32,241,239,232,241,238,234");
    info_3.t_color.R = 176;
    info_3.t_color.G = 153;
    info_3.t_color.B = 121;
    info_3.t_color.A = byte(255);
    info_3.bLineBreak = true;
    info_3.t_bDrawOneLine = true;
    ToolTip.DrawList[2] = info_3;

    info_3.t_strText = GetLocalizedText("Drag item here to delete it", "207,229,240,229,242,224,249,232,32,239,240,229,228,236,229,242,32,241,254,228,224,32,228,235,255,32,243,228,224,235,229,237,232,255");
    info_3.t_color.R = 176;
    info_3.t_color.G = 153;
    info_3.t_color.B = 121;
    info_3.t_color.A = byte(255);
    info_3.bLineBreak = true;
    info_3.t_bDrawOneLine = true;
    ToolTip.DrawList[3] = info_3;

    info_3.t_strText = GetLocalizedText("Remembered item types are destroyed", "199,224,239,238,236,237,229,237,237,251,229,32,239,240,229,228,236,229,242,251,32,243,228,224,235,255,254,242,241,255");
    info_3.t_color.R = 176;
    info_3.t_color.G = 153;
    info_3.t_color.B = 121;
    info_3.t_color.A = byte(255);
    info_3.bLineBreak = true;
    info_3.t_bDrawOneLine = true;
    ToolTip.DrawList[4] = info_3;

    return ToolTip;
}

function UpdateTrashButtonTooltip()
{
    button_5.SetTooltipCustomType(MakeTrashButtonTooltip());
}

function function2()
{
    local int int_6, string_4;

    int_2 = 0;
    int_6 = 1;

    while(int_6 < 100)
    {
        GetINIInt("TrashList", ("" $ string(int_6)), string_4, "TrashGrp");
        // End:0x66
        if((string_4 == 0))
        {
            int_2 = (int_6 - 1);
            return;
        }
        int_6++;
    }
    return;
}

function ClearAutoTrashList()
{
    local int int_6;

    int_6 = 1;
    while(int_6 < 100)
    {
        SetINIInt("TrashList", ("" $ string(int_6)), 0, "TrashGrp");
        int_6++;
    }
    int_2 = 0;
    UpdateTrashButtonTooltip();
    return;
}

function bool IsAutoTrashItemClass(int ClassID)
{
    local int int_6, SavedClassID;

    if(!bool_1)
    {
        return false;
    }

    int_6 = 1;
    while(int_6 < 100)
    {
        GetINIInt("TrashList", ("" $ string(int_6)), SavedClassID, "TrashGrp");
        if(SavedClassID == 0)
        {
            return false;
        }
        if(SavedClassID == ClassID)
        {
            return true;
        }
        int_6++;
    }
    return false;
}

function TryAutoTrashItem(ItemInfo info_3)
{
    if(info_3.ServerID <= 0 || info_3.ItemNum <= 0)
    {
        return;
    }

    if(IsAutoTrashItemClass(info_3.ClassID))
    {
        RequestDestroyItem(info_3.ServerID, info_3.ItemNum);
    }
    return;
}

function function13()
{
    // End:0x93
    if((!bool_1))
    {
        bool_1 = true;
        button_5.SetTexture("Was.Inventory_Btn_Trash_Auto", "Was.Inventory_Btn_Trash_Auto_Down", "Was.Inventory_Btn_Trash_Auto_Over");
        UpdateTrashButtonTooltip();
        function46();
    }
    else
    {
        bool_1 = false;
        button_5.SetTexture("Was.Inventory_Btn_Trash", "Was.Inventory_Btn_Trash_Down", "Was.Inventory_Btn_Trash_Drag");
        UpdateTrashButtonTooltip();
    }
    return;
}

function function47()
{
    SetINIInt("TrashList", ("" $ string(int_2)), -1, "TrashGrp");
    return;
}

function function46()
{
    local int int_6, int_4, string_4;
    local ItemInfo info_3;

    int_6 = 1;

    while(int_6 <= int_2)
    {
        GetINIInt("TrashList", ("" $ string(int_6)), string_4, "TrashGrp");
        // End:0xA7
        if((string_4 != 0))
        {
            int_4 = item_1.FindItemWithClassID(string_4);
            // End:0xA4
            if(item_1.GetItem(int_4, info_3))
            {
                RequestDestroyItem(info_3.ServerID, info_3.ItemNum);
            }

            int_6++;
            continue;
        }
        return;

        int_6++;
    }
    return;
}

function ItemWindowHandle function12()
{
    // End:0x1B
    if(item_1.IsShowWindow())
    {
        return item_1;
    }
    else
    {
        // End:0x36
        if(item_5.IsShowWindow())
        {
            return item_5;
        }
        else
        {
            // End:0x51
            if(item_7.IsShowWindow())
            {
                return item_7;
            }
            else
            {
                // End:0x6C
                if(item_6.IsShowWindow())
                {
                    return item_6;
                }
                else
                {
                    // End:0x84
                    if(item_2.IsShowWindow())
                    {
                        return item_2;
                    }
                }
            }
        }
    }
    return None;
}

function function3()
{
    local WindowHandle window_1;
    local TextureHandle texture_1, texture_2;
    local ButtonHandle text_1;

    window_1 = GetHandle("InventoryWnd");
    texture_1 = TextureHandle(GetHandle("InventoryWnd.Tex"));
    texture_2 = TextureHandle(GetHandle("InventoryWnd.Slots2"));
    text_1 = ButtonHandle(GetHandle("InventoryWnd.BtnExpand"));
    // End:0x267
    if((GetOptionBool("Options", "ExpandedInventory") == true))
    {
        window_1.SetWindowSize(673, 400);
        texture_1.SetWindowSize(680, 412);
        texture_1.SetTexture("Was.InventoryWnd_Max");
        texture_2.SetWindowSize(216, 288);
        item_1.SetWindowSize(447, 288);
        item_2.SetWindowSize(447, 288);
        item_5.SetWindowSize(447, 288);
        item_6.SetWindowSize(447, 288);
        item_7.SetWindowSize(447, 288);
        item_1.SetCol(12);
        item_2.SetCol(12);
        item_5.SetCol(12);
        item_6.SetCol(12);
        item_7.SetCol(12);
        text_1.SetTexture("Was.Frames_df_Btn_Minimize", "Was.Frames_df_Btn_Minimize_Down", "Was.Frames_df_Btn_Minimize_Over");
    }
    else
    {
        window_1.SetWindowSize(566, 400);
        texture_1.SetWindowSize(573, 412);
        texture_1.SetTexture("Was.InventoryWnd_Min");
        texture_2.SetWindowSize(108, 288);
        item_1.SetWindowSize(339, 288);
        item_2.SetWindowSize(339, 288);
        item_5.SetWindowSize(339, 288);
        item_6.SetWindowSize(339, 288);
        item_7.SetWindowSize(339, 288);
        item_1.SetCol(9);
        item_2.SetCol(9);
        item_5.SetCol(9);
        item_6.SetCol(9);
        item_7.SetCol(9);
        text_1.SetTexture("Was.Frames_df_Btn_Expand", "Was.Frames_df_Btn_Expand_Down", "Was.Frames_df_Btn_Expand_Over");
    }
    function48("InventoryWnd.BtnClose", "InventoryWnd.Tex", 3, -18, 18);
    function48("InventoryWnd.BtnMin", "InventoryWnd.Tex", 3, -34, 18);
    function48("InventoryWnd.BtnExpand", "InventoryWnd.Tex", 3, -50, 16);
    function48("InventoryWnd.ItemCount", "InventoryWnd", 3, -78, 5);
    function48("InventoryWnd.FastDelete", "InventoryWnd", 3, -31, 32);
    function48("InventoryWnd.Title", "InventoryWnd.Tex", 2, 0, 19);
    return;
}

function function48(string string_1, string string_2, int string_4, int X, int Y)
{
    switch(string_4)
    {
        // End:0x43
        case 1:
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor(string_1, string_2, "TopLeft", "TopLeft", X, Y);
            // End:0x213
            break;
        // End:0x84
        case 2:
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor(string_1, string_2, "TopCenter", "TopCenter", X, Y);
            // End:0x213
            break;
        // End:0xC3
        case 3:
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor(string_1, string_2, "TopRight", "TopRight", X, Y);
            // End:0x213
            break;
        // End:0x106
        case 4:
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor(string_1, string_2, "CenterLeft", "CenterLeft", X, Y);
            // End:0x213
            break;
        // End:0x141
        case 5:
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor(string_1, string_2, "Center", "Center", X, Y);
            // End:0x213
            break;
        // End:0x186
        case 6:
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor(string_1, string_2, "CenterRight", "CenterRight", X, Y);
            // End:0x213
            break;
        // End:0x1C9
        case 7:
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor(string_1, string_2, "BottomLeft", "BottomLeft", X, Y);
            // End:0x213
            break;
        // End:0x210
        case 8:
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor(string_1, string_2, "BottomCenter", "BottomCenter", X, Y);
            // End:0x213
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function SetFocus()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.ItemCount");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_Underwear");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_Head");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_Hair");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_Hair2");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_Neck");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_RHand");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_Chest");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_LHand");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_REar");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_LEar");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_Gloves");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_Legs");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_Feet");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_RFinger");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.EquipItem_LFinger");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.HennaItem");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.InventoryItem");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.QuestItem");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.InventoryTab");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.FastDelete");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.CrystallizeButton");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.TrashButton");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.AdenaText");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.AdenaIcon");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.InvenWeight");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("InventoryWnd.BtnClose");
    return;
}

defaultproperties
{
    string_1="InventoryWnd"
}
