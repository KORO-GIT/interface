class MultiSellWnd extends UICommonAPI;

const MULTISELLWND_DIALOG_OK = 1122;
const MAX_CUSTOM_NEEDED_ITEMS = 4;

struct NeededItem
{
    var int Id;
    var string Name;
    var int Count;
    var string IconName;
    var int Enchant;
    var int CrystalType;
    var int ItemType;
    var int RefineryOp1;
    var int RefineryOp2;
};

struct ItemList
{
    var int MultiSellType;
    var int NeededItemNum;
    var array<ItemInfo> ItemInfoList;
    var array<NeededItem> NeededItemList;
};

var array<ItemList> m_itemLIst;
var int m_ShopID;
var int pre_itemList;

function OnLoad()
{
    RegisterEvent(2530);
    RegisterEvent(2540);
    RegisterEvent(2550);
    RegisterEvent(2560);
    RegisterEvent(1710);
    pre_itemList = -1;
    HideCustomNeededItemList();
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MultiSellWnd.NeededItem");
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x1D
        case 2530:
            HandleShopID(param);
            // End:0x76
            break;
        // End:0x33
        case 2540:
            HandleItemList(param);
            // End:0x76
            break;
        // End:0x49
        case 2550:
            HandleNeededItemList(param);
            // End:0x76
            break;
        // End:0x5F
        case 2560:
            HandleItemListEnd(param);
            // End:0x76
            break;
        // End:0x70
        case 1710:
            HandleDialogOK();
            // End:0x76
            break;
        // End:0xFFFF
        default:
            // End:0x76
            break;
            break;
    }
    return;
}

function OnShow()
{
    Class'NWindow.UIAPI_EDITBOX'.static.Clear("MultiSellWnd.ItemCountEdit");
    HideCustomNeededItemList();
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MultiSellWnd.NeededItem");
    return;
}

function OnHide()
{
    return;
}

function OnClickButton(string ControlName)
{
    // End:0x1D
    if(ControlName == "OKButton")
    {
        HandleOKButton();        
    }
    else
    {
        // End:0x4F
        if(ControlName == "CancelButton")
        {
            Clear();
            HideWindow("MultiSellWnd");
        }
    }
    return;
}

function OnClickItem(string strID, int Index)
{
    local int i, HaveCount;

    Class'NWindow.UIAPI_MULTISELLITEMINFO'.static.Clear("MultiSellWnd.ItemInfo");
    Class'NWindow.UIAPI_MULTISELLNEEDEDITEM'.static.Clear("MultiSellWnd.NeededItem");
    HideCustomNeededItemList();
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MultiSellWnd.NeededItem");
    // End:0x3BF
    if(strID == "ItemList")
    {
        // End:0x3BF
        if((Index >= 0) && Index < m_itemLIst.Length)
        {
            i = 0;

            while(i < m_itemLIst[Index].NeededItemList.Length)
            {
                HaveCount = GetInventoryItemCount(m_itemLIst[Index].NeededItemList[i].Id);
                if(i < MAX_CUSTOM_NEEDED_ITEMS)
                {
                    ShowCustomNeededItem(i, m_itemLIst[Index].NeededItemList[i], HaveCount);
                }
                ++i;
            }
            i = 0;

            while(i < m_itemLIst[Index].NeededItemNum)
            {
                Class'NWindow.UIAPI_MULTISELLITEMINFO'.static.SetItemInfo("MultiSellWnd.ItemInfo", i, m_itemLIst[Index].ItemInfoList[i]);
                ++i;
            }
            Class'NWindow.UIAPI_EDITBOX'.static.Clear("MultiSellWnd.ItemCountEdit");
            // End:0x332
            if(m_itemLIst[Index].MultiSellType == 0)
            {
                Class'NWindow.UIAPI_EDITBOX'.static.SetString("MultiSellWnd.ItemCountEdit", "1");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("MultiSellWnd.ItemCountEdit");                
            }
            else
            {
                // End:0x3A1
                if(m_itemLIst[Index].MultiSellType == 1)
                {
                    Class'NWindow.UIAPI_EDITBOX'.static.SetString("MultiSellWnd.ItemCountEdit", "1");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("MultiSellWnd.ItemCountEdit");
                }
            }
            // End:0x3BF
            if(pre_itemList != Index)
            {
                // End:0x3BF
                if(DialogIsMine())
                {
                    DialogHide();
                }
            }
        }
    }
    return;
}

function HideCustomNeededItemList()
{
    local int i;

    i = 0;

    while(i < MAX_CUSTOM_NEEDED_ITEMS)
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MultiSellWnd.NeededCustomIcon" $ string(i));
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MultiSellWnd.NeededCustomName" $ string(i));
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MultiSellWnd.NeededCustomCount" $ string(i));
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MultiSellWnd.NeededCustomHave" $ string(i));
        ++i;
    }
    return;
}

function ShowCustomNeededItem(int RowIndex, NeededItem Item, int HaveCount)
{
    local string Prefix, IconName, NameText, CountText, HaveText;
    local int CountWidth, CountHeight, RowY;
    local Rect WindowRect;
    local Color TextColor, HaveColor;

    Prefix = "MultiSellWnd.NeededCustom";
    IconName = Prefix $ "Icon" $ string(RowIndex);
    NameText = Prefix $ "Name" $ string(RowIndex);
    CountText = "x " $ MakeCostString(string(Item.Count));
    HaveText = "(" $ MakeCostString(string(HaveCount)) $ ")";
    RowY = 240 + (RowIndex * 35);

    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture(IconName, Item.IconName);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(NameText, Item.Name);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(Prefix $ "Count" $ string(RowIndex), CountText);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(Prefix $ "Have" $ string(RowIndex), HaveText);

    TextColor.R = byte(220);
    TextColor.G = byte(220);
    TextColor.B = byte(220);
    TextColor.A = byte(255);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(NameText, TextColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(Prefix $ "Count" $ string(RowIndex), TextColor);

    if(HaveCount >= Item.Count)
    {
        HaveColor.R = 120;
        HaveColor.G = 160;
        HaveColor.B = byte(255);
    }
    else
    {
        HaveColor.R = byte(255);
        HaveColor.G = 90;
        HaveColor.B = 90;
    }
    HaveColor.A = byte(255);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(Prefix $ "Have" $ string(RowIndex), HaveColor);

    GetTextSize(CountText, CountWidth, CountHeight);
    WindowRect = Class'NWindow.UIAPI_WINDOW'.static.GetRect("MultiSellWnd");
    Class'NWindow.UIAPI_WINDOW'.static.MoveTo(Prefix $ "Have" $ string(RowIndex), WindowRect.nX + 316 + CountWidth + 10, WindowRect.nY + RowY);

    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(IconName);
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(NameText);
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(Prefix $ "Count" $ string(RowIndex));
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(Prefix $ "Have" $ string(RowIndex));
    return;
}

function Print()
{
    local int i, j;

    i = 0;

    while(i < m_itemLIst.Length)
    {
        j = 0;

        while(j < m_itemLIst[i].NeededItemList.Length)
        {
            Debug((((("Print (" $ string(i)) $ ",") $ string(j)) $ "), ") $ m_itemLIst[i].NeededItemList[j].Name);
            ++j;
        }
        ++i;
    }
    return;
}

function HandleShopID(string param)
{
    Clear();
    ParseInt(param, "shopID", m_ShopID);
    return;
}

function Clear()
{
    m_itemLIst.Length = 0;
    Class'NWindow.UIAPI_MULTISELLITEMINFO'.static.Clear("MultiSellWnd.ItemInfo");
    Class'NWindow.UIAPI_MULTISELLNEEDEDITEM'.static.Clear("MultiSellWnd.NeededItem");
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("MultiSellWnd.ItemList");
    HideCustomNeededItemList();
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MultiSellWnd.NeededItem");
    return;
}

function HandleItemList(string param)
{
    local ItemInfo Info;
    local int Index, Type, i, ClassID;
    local bool bMatchFound;

    ParseInt(param, "classID", ClassID);
    Class'NWindow.UIDATA_ITEM'.static.GetItemInfo(ClassID, Info);
    Info.ClassID = ClassID;
    ParseInt(param, "index", Index);
    ParseInt(param, "type", Type);
    ParseInt(param, "ID", Info.Reserved);
    ParseInt(param, "slotBitType", Info.SlotBitType);
    ParseInt(param, "itemType", Info.ItemType);
    ParseInt(param, "itemCount", Info.ItemNum);
    if(!ParseInt(param, "Enchant", Info.Enchanted))
    {
        ParseInt(param, "enchant", Info.Enchanted);
    }
    ParseInt(param, "OutputRefineryOp1", Info.RefineryOp1);
    ParseInt(param, "OutputRefineryOp2", Info.RefineryOp2);
    if((Info.Enchanted > 0) && (Info.Enchanted <= 25))
    {
        Info.ForeTexture = ("Was.Inventory_ENCHANTNUMBER_SMALL_" $ string(Info.Enchanted));
    }
    // End:0x15E
    if(0 < Info.Durability)
    {
        Info.CurrentDurability = Info.Durability;
    }
    // End:0x1E5
    if(Index == 0)
    {
        i = m_itemLIst.Length;
        m_itemLIst.Length = i + 1;
        m_itemLIst[i].MultiSellType = Type;
        m_itemLIst[i].NeededItemNum = 1;
        m_itemLIst[i].ItemInfoList.Length = Index + 1;
        m_itemLIst[i].ItemInfoList[Index] = Info;        
    }
    else
    {
        // End:0x33E
        if(Index > 0)
        {
            bMatchFound = false;
            i = m_itemLIst.Length - 1;

            while(i >= 0)
            {
                // End:0x293
                if(((m_itemLIst[i].ItemInfoList[0].Reserved == Info.Reserved) && m_itemLIst[i].ItemInfoList[0].RefineryOp1 == Info.RefineryOp1) && m_itemLIst[i].ItemInfoList[0].RefineryOp2 == Info.RefineryOp2)
                {
                    bMatchFound = true;
                    break;
                }
                --i;
            }

            // End:0x322
            if(bMatchFound)
            {
                // End:0x2DB
                if(m_itemLIst[i].ItemInfoList.Length <= Index)
                {
                    m_itemLIst[i].ItemInfoList.Length = Index + 1;
                }
                m_itemLIst[i].MultiSellType = Type;
                m_itemLIst[i].ItemInfoList[Index] = Info;
                ++m_itemLIst[i].NeededItemNum;                
            }
            else
            {
                Debug("MultiSellWnd Error!!");
            }
        }
    }
    return;
}

function HandleNeededItemList(string param)
{
    local NeededItem item;
    local int i, Id, Index, RefineryOp1, RefineryOp2;

    ParseInt(param, "ID", Id);
    ParseInt(param, "refineryOp1", RefineryOp1);
    ParseInt(param, "refineryOp2", RefineryOp2);
    ParseInt(param, "ClassID", item.Id);
    ParseInt(param, "count", item.Count);
    ParseInt(param, "enchant", item.Enchant);
    ParseInt(param, "inputRefineryOp1", item.RefineryOp1);
    ParseInt(param, "inputRefineryOp2", item.RefineryOp2);
    // End:0x175
    if(item.Id == -100)
    {
        item.Name = GetSystemString(1277);
        item.IconName = "icon.etc_i.etc_pccafe_point_i00";
        item.Enchant = 0;
        item.ItemType = -1;
        item.Id = 0;        
    }
    else
    {
        // End:0x1FB
        if(item.Id == -200)
        {
            item.Name = GetSystemString(1311);
            item.IconName = "icon.etc_i.etc_bloodpledge_point_i00";
            item.Enchant = 0;
            item.ItemType = -1;
            item.Id = 0;            
        }
        else
        {
            item.Name = Class'NWindow.UIDATA_ITEM'.static.GetItemName(item.Id);
            item.IconName = Class'NWindow.UIDATA_ITEM'.static.GetItemTextureName(item.Id);
        }
    }
    i = m_itemLIst.Length - 1;

    while(i >= 0)
    {
        // End:0x35C
        if(((m_itemLIst[i].ItemInfoList[0].Reserved == Id) && m_itemLIst[i].ItemInfoList[0].RefineryOp1 == RefineryOp1) && m_itemLIst[i].ItemInfoList[0].RefineryOp2 == RefineryOp2)
        {
            Index = m_itemLIst[i].NeededItemList.Length;
            m_itemLIst[i].NeededItemList.Length = Index + 1;
            item.ItemType = Class'NWindow.UIDATA_ITEM'.static.GetItemDataType(item.Id);
            item.CrystalType = Class'NWindow.UIDATA_ITEM'.static.GetItemCrystalType(item.Id);
            m_itemLIst[i].NeededItemList[Index] = item;
            break;
        }
        --i;
    }

    return;
}

function HandleItemListEnd(string param)
{
    local WindowHandle m_inventoryWnd;

    m_inventoryWnd = GetHandle("InventoryWnd");
    // End:0x3B
    if(m_inventoryWnd.IsShowWindow())
    {
        m_inventoryWnd.HideWindow();
    }
    ShowWindow("MultiSellWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MultiSellWnd");
    ShowItemList();
    return;
}

function ShowItemList()
{
    local ItemInfo Info;
    local int i;

    i = 0;

    while(i < m_itemLIst.Length)
    {
        Info = m_itemLIst[i].ItemInfoList[0];
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("MultiSellWnd.ItemList", Info);
        ++i;
    }
    return;
}

function HandleOKButton()
{
    local int SelectedIndex, ItemNum;

    SelectedIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetSelectedNum("MultiSellWnd.ItemList");
    ItemNum = int(Class'NWindow.UIAPI_EDITBOX'.static.GetString("MultiSellWnd.ItemCountEdit"));
    // End:0xA9
    if(SelectedIndex >= 0)
    {
        DialogSetReservedInt(SelectedIndex);
        DialogSetReservedInt2(ItemNum);
        DialogSetID(1122);
        DialogShow(DIALOG_Warning, GetSystemMessage(1383));
        pre_itemList = SelectedIndex;
    }
    return;
}

function HandleDialogOK()
{
    local string param;
    local int SelectedIndex;

    // End:0xE6
    if(DialogIsMine())
    {
        SelectedIndex = DialogGetReservedInt();
        ParamAdd(param, "ShopID", string(m_ShopID));
        ParamAdd(param, "ItemID", string(m_itemLIst[SelectedIndex].ItemInfoList[0].Reserved));
        ParamAdd(param, "RefineryOp1", string(m_itemLIst[SelectedIndex].ItemInfoList[0].RefineryOp1));
        ParamAdd(param, "RefineryOp2", string(m_itemLIst[SelectedIndex].ItemInfoList[0].RefineryOp2));
        ParamAdd(param, "ItemCount", string(DialogGetReservedInt2()));
        RequestMultiSellChoose(param);
    }
    return;
}
