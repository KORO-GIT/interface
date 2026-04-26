class ItemEnchantWnd extends UICommonAPI;

var WindowHandle Me;
var ItemWindowHandle ItemWnd;
var int EnchantScrollClassID;
var int SelectedEnchantServerID;
var array<ItemInfo> EnchantItemList;

function OnLoad()
{
    RegisterEvent(2860);
    RegisterEvent(2870);
    RegisterEvent(2880);
    RegisterEvent(2890);
    RegisterEvent(2610);
    Me = GetHandle("ItemEnchantWnd");
    ItemWnd = ItemWindowHandle(GetHandle("ItemEnchantWnd.ItemWnd"));
    EnchantScrollClassID = 0;
    SelectedEnchantServerID = 0;
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        case 2860:
            HandleEnchantShow(param);
            break;
        case 2870:
            HandleEnchantHide();
            break;
        case 2880:
            HandleEnchantItemList(param);
            break;
        case 2890:
            HandleEnchantResult(param);
            break;
        case 2610:
            HandleInventoryUpdateItem(param);
            break;
        default:
            break;
    }
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        case "btnOK":
            OnOKClick();
            break;
        case "btnCancel":
            OnCancelClick();
            break;
        default:
            break;
    }
    return;
}

function OnClickItem(string strID, int Index)
{
    local ItemInfo infItem;

    if(strID == "ItemWnd")
    {
        if(ItemWnd.GetItem(Index, infItem))
        {
            SelectedEnchantServerID = infItem.ServerID;
            UpdateEnchantItemDimming();
        }
    }
    return;
}

function OnOKClick()
{
    local ItemInfo infItem;
    local int TargetServerID;

    TargetServerID = SelectedEnchantServerID;
    if(TargetServerID <= 0)
    {
        if(ItemWnd.GetSelectedItem(infItem))
        {
            TargetServerID = infItem.ServerID;
            SelectedEnchantServerID = TargetServerID;
            UpdateEnchantItemDimming();
        }
    }
    if(TargetServerID > 0)
    {
        Class'NWindow.EnchantAPI'.static.RequestEnchantItem(TargetServerID);
    }
    return;
}

function OnCancelClick()
{
    Class'NWindow.EnchantAPI'.static.RequestEnchantItem(-1);
    Me.HideWindow();
    Clear();
    return;
}

function Clear()
{
    ItemWnd.Clear();
    EnchantItemList.Length = 0;
    SelectedEnchantServerID = 0;
    return;
}

function HandleEnchantShow(string param)
{
    local int ClassID;

    Clear();
    ParseInt(param, "ClassID", ClassID);
    EnchantScrollClassID = ClassID;
    Me.SetWindowTitle(((GetSystemString(1220) $ "(") $ Class'NWindow.UIDATA_ITEM'.static.GetItemName(ClassID)) $ ")");
    Me.ShowWindow();
    Me.SetFocus();
    return;
}

function HandleEnchantHide()
{
    Me.HideWindow();
    EnchantScrollClassID = 0;
    Clear();
    return;
}

function HandleEnchantItemList(string param)
{
    local ItemInfo infItem;

    ParamToItemInfo(param, infItem);
    PrepareEnchantItemInfo(infItem);
    if(IsItemAllowedForEnchantScroll(infItem))
    {
        AddEnchantItemToWindow(infItem, AddEnchantItemSorted(infItem));
    }
    return;
}

function HandleEnchantResult(string param)
{
    Me.HideWindow();
    Clear();
    return;
}

function PrepareEnchantItemInfo(out ItemInfo infItem)
{
    infItem.ItemNum = 0;
    infItem.bShowCount = false;
    UpdateEnchantForeTexture(infItem);
    return;
}

function UpdateEnchantForeTexture(out ItemInfo infItem)
{
    infItem.ForeTexture = "";
    if((infItem.Enchanted > 0) && (infItem.Enchanted <= 25))
    {
        infItem.ForeTexture = "Was.Inventory_ENCHANTNUMBER_SMALL_" $ string(infItem.Enchanted);
    }
    return;
}

function bool IsItemAllowedForEnchantScroll(ItemInfo infItem)
{
    local int ScrollGrade;

    if(!IsEnchantableItemType(infItem))
    {
        return false;
    }

    ScrollGrade = GetEnchantScrollGrade(EnchantScrollClassID);
    if((ScrollGrade > 0) && (infItem.CrystalType != ScrollGrade))
    {
        return false;
    }

    if(IsWeaponEnchantScroll(EnchantScrollClassID) && !IsWeaponEnchantItem(infItem))
    {
        return false;
    }

    if(IsArmorEnchantScroll(EnchantScrollClassID) && !IsArmorEnchantItem(infItem))
    {
        return false;
    }

    if(IsCustomAllGradeWeaponScroll(EnchantScrollClassID) && !IsWeaponEnchantItem(infItem))
    {
        return false;
    }

    if(IsCustomAllGradeArmorScroll(EnchantScrollClassID) && !IsArmorEnchantItem(infItem))
    {
        return false;
    }

    return true;
}

function bool IsEnchantableItemType(ItemInfo infItem)
{
    return (infItem.ItemType == 0) || (infItem.ItemType == 1) || (infItem.ItemType == 2);
}

function bool IsWeaponEnchantItem(ItemInfo infItem)
{
    return infItem.ItemType == 0;
}

function bool IsArmorEnchantItem(ItemInfo infItem)
{
    return (infItem.ItemType == 1) || (infItem.ItemType == 2);
}

function int GetEnchantScrollGrade(int ScrollID)
{
    switch(ScrollID)
    {
        case 959:
        case 960:
        case 961:
        case 962:
        case 6577:
        case 6578:
            return 5;
        case 729:
        case 730:
        case 731:
        case 732:
        case 6569:
        case 6570:
            return 4;
        case 947:
        case 948:
        case 949:
        case 950:
        case 6571:
        case 6572:
            return 3;
        case 951:
        case 952:
        case 953:
        case 954:
        case 6573:
        case 6574:
            return 2;
        case 955:
        case 956:
        case 957:
        case 958:
            return 1;
        default:
            break;
    }
    return 0;
}

function bool IsWeaponEnchantScroll(int ScrollID)
{
    switch(ScrollID)
    {
        case 959:
        case 961:
        case 6577:
        case 729:
        case 731:
        case 6569:
        case 947:
        case 949:
        case 6571:
        case 951:
        case 953:
        case 6573:
        case 955:
        case 957:
            return true;
        default:
            break;
    }
    return false;
}

function bool IsArmorEnchantScroll(int ScrollID)
{
    switch(ScrollID)
    {
        case 960:
        case 962:
        case 6578:
        case 730:
        case 732:
        case 6570:
        case 948:
        case 950:
        case 6572:
        case 952:
        case 954:
        case 6574:
        case 956:
        case 958:
            return true;
        default:
            break;
    }
    return false;
}

function bool IsCustomAllGradeWeaponScroll(int ScrollID)
{
    local string ScrollName;

    switch(ScrollID)
    {
        case 6575:
            return true;
        default:
            break;
    }

    ScrollName = Caps(Class'NWindow.UIDATA_ITEM'.static.GetItemName(ScrollID));
    if(-1 != InStr(ScrollName, "WEAPON"))
    {
        return true;
    }
    return false;
}

function bool IsCustomAllGradeArmorScroll(int ScrollID)
{
    local string ScrollName;

    switch(ScrollID)
    {
        case 6576:
            return true;
        default:
            break;
    }

    ScrollName = Caps(Class'NWindow.UIDATA_ITEM'.static.GetItemName(ScrollID));
    if((-1 != InStr(ScrollName, "ARMOR")) || (-1 != InStr(ScrollName, "ACCESSORY")))
    {
        return true;
    }
    return false;
}

function int AddEnchantItemSorted(ItemInfo NewItem)
{
    local int InsertIndex;

    InsertIndex = EnchantItemList.Length;
    EnchantItemList.Insert(InsertIndex, 1);
    EnchantItemList[InsertIndex] = NewItem;

    while((InsertIndex > 0) && ShouldEnchantItemComeBefore(EnchantItemList[InsertIndex], EnchantItemList[InsertIndex - 1]))
    {
        SwapEnchantItemCache(InsertIndex, InsertIndex - 1);
        --InsertIndex;
    }
    return InsertIndex;
}

function AddEnchantItemToWindow(ItemInfo NewItem, int InsertIndex)
{
    local int DrawIndex;

    NewItem.bDisabled = (SelectedEnchantServerID > 0) && (NewItem.ServerID != SelectedEnchantServerID);
    ItemWnd.AddItem(NewItem);
    DrawIndex = ItemWnd.GetItemNum() - 1;
    while(DrawIndex > InsertIndex)
    {
        ItemWnd.SwapItems(DrawIndex - 1, DrawIndex);
        --DrawIndex;
    }
    return;
}

function bool ShouldEnchantItemComeBefore(ItemInfo ItemA, ItemInfo ItemB)
{
    if(ItemA.CrystalType != ItemB.CrystalType)
    {
        return ItemA.CrystalType > ItemB.CrystalType;
    }
    return false;
}

function SwapEnchantItemCache(int IndexA, int IndexB)
{
    local ItemInfo TempItem;

    TempItem = EnchantItemList[IndexA];
    EnchantItemList[IndexA] = EnchantItemList[IndexB];
    EnchantItemList[IndexB] = TempItem;
    return;
}

function RedrawEnchantItems()
{
    local int i;
    local ItemInfo DrawItem;

    ItemWnd.Clear();
    i = 0;
    while(i < EnchantItemList.Length)
    {
        DrawItem = EnchantItemList[i];
        DrawItem.bDisabled = (SelectedEnchantServerID > 0) && (DrawItem.ServerID != SelectedEnchantServerID);
        ItemWnd.AddItem(DrawItem);
        ++i;
    }
    return;
}

function UpdateEnchantItemDimming()
{
    local int i;
    local ItemInfo infItem;

    i = 0;
    while(i < ItemWnd.GetItemNum())
    {
        if(ItemWnd.GetItem(i, infItem))
        {
            infItem.bDisabled = (SelectedEnchantServerID > 0) && (infItem.ServerID != SelectedEnchantServerID);
            ItemWnd.SetItem(i, infItem);
        }
        ++i;
    }
    return;
}

function HandleInventoryUpdateItem(string param)
{
    local string WorkType;
    local ItemInfo infItem;
    local int CacheIndex;
    local int WindowIndex;

    if(!Me.IsShowWindow())
    {
        return;
    }

    ParseString(param, "type", WorkType);
    ParamToItemInfo(param, infItem);
    CacheIndex = FindEnchantItemIndex(infItem.ServerID);
    if(CacheIndex < 0)
    {
        return;
    }

    if(WorkType == "delete")
    {
        if(SelectedEnchantServerID == infItem.ServerID)
        {
            SelectedEnchantServerID = 0;
        }
        EnchantItemList.Remove(CacheIndex, 1);
        WindowIndex = ItemWnd.FindItemWithServerID(infItem.ServerID);
        if(WindowIndex >= 0)
        {
            ItemWnd.DeleteItem(WindowIndex);
        }
        return;
    }

    PrepareEnchantItemInfo(infItem);
    if(IsItemAllowedForEnchantScroll(infItem))
    {
        EnchantItemList[CacheIndex] = infItem;
        SortEnchantItemCache();
        RedrawEnchantItems();
    }
    else
    {
        EnchantItemList.Remove(CacheIndex, 1);
        RedrawEnchantItems();
    }
    return;
}

function int FindEnchantItemIndex(int ServerID)
{
    local int i;

    i = 0;
    while(i < EnchantItemList.Length)
    {
        if(EnchantItemList[i].ServerID == ServerID)
        {
            return i;
        }
        ++i;
    }
    return -1;
}

function SortEnchantItemCache()
{
    local int i;
    local int j;

    i = 1;
    while(i < EnchantItemList.Length)
    {
        j = i;
        while((j > 0) && ShouldEnchantItemComeBefore(EnchantItemList[j], EnchantItemList[j - 1]))
        {
            SwapEnchantItemCache(j, j - 1);
            --j;
        }
        ++i;
    }
    return;
}
