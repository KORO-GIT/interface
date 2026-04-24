class TradeWnd extends UICommonAPI;

const DIALOG_ID_TRADE_REQUEST = 0;
const DIALOG_ID_ITEM_NUMBER = 1;

var array<ItemInfo> m_LocalTradeItemCache;

function OnLoad()
{
    RegisterEvent(1710);
    RegisterEvent(1720);
    RegisterEvent(1950);
    RegisterEvent(1960);
    RegisterEvent(1970);
    RegisterEvent(1980);
    RegisterEvent(1990);
    RegisterEvent(2000);
    return;
}

function OnSendPacketWhenHiding()
{
    RequestTradeDone(false);
    return;
}

function OnHide()
{
    Clear();
    return;
}

function OnEvent(int EventID, string param)
{
    switch(EventID)
    {
        // End:0x1D
        case 1950:
            HandleStartTrade(param);
            // End:0xB3
            break;
        // End:0x33
        case 1960:
            HandleTradeAddItem(param);
            // End:0xB3
            break;
        // End:0x49
        case 1970:
            HandleTradeDone(param);
            // End:0xB3
            break;
        // End:0x5F
        case 1980:
            HandleTradeOtherOK(param);
            // End:0xB3
            break;
        // End:0x75
        case 1990:
            HandleTradeUpdateInventoryItem(param);
            // End:0xB3
            break;
        // End:0x8B
        case 2000:
            HandleReceiveStartTrade(param);
            // End:0xB3
            break;
        // End:0x9C
        case 1710:
            HandleDialogOK();
            // End:0xB3
            break;
        // End:0xAD
        case 1720:
            HandleDialogCancel();
            // End:0xB3
            break;
        // End:0xFFFF
        default:
            // End:0xB3
            break;
            break;
    }
    return;
}

function OnClickButton(string ControlName)
{
    // End:0x3F
    if(ControlName == "OKButton")
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.SetFaded("TradeWnd.MyList", true);
        RequestTradeDone(true);        
    }
    else
    {
        // End:0x61
        if(ControlName == "CancelButton")
        {
            RequestTradeDone(false);            
        }
        else
        {
            // End:0x7D
            if(ControlName == "MoveButton")
            {
                HandleMoveButton();
            }
        }
    }
    return;
}

function OnDBClickItem(string ControlName, int Index)
{
    local ItemInfo Info;

    // End:0xCF
    if(ControlName == "InventoryList")
    {
        // End:0xCF
        if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("TradeWnd.InventoryList", Index, Info))
        {
            RememberLocalTradeItem(Info);
            // End:0xBE
            if(IsStackableItem(Info.ConsumeType) && Info.ItemNum != 1)
            {
                DialogSetID(1);
                DialogSetReservedInt(Info.ServerID);
                DialogSetParamInt(Info.ItemNum);
                DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), Info.Name, ""));                
            }
            else
            {
                RequestAddTradeItem(Info.ServerID, 1);
            }
        }
    }
    return;
}

function OnDropItem(string strID, ItemInfo Info, int X, int Y)
{
    // End:0xF3
    if((strID == "MyList") && Info.DragSrcName == "InventoryList")
    {
        RememberLocalTradeItem(Info);
        // End:0xE2
        if(IsStackableItem(Info.ConsumeType))
        {
            // End:0x72
            if(Info.AllItemCount > 0)
            {
                RequestAddTradeItem(Info.ServerID, Info.AllItemCount);                
            }
            else
            {
                // End:0x96
                if(Info.ItemNum == 1)
                {
                    RequestAddTradeItem(Info.ServerID, 1);                    
                }
                else
                {
                    DialogSetID(1);
                    DialogSetReservedInt(Info.ServerID);
                    DialogSetParamInt(Info.ItemNum);
                    DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), Info.Name, ""));
                }
            }            
        }
        else
        {
            RequestAddTradeItem(Info.ServerID, 1);
        }
    }
    return;
}

function MoveToMyList(int Index, int Num)
{
    local ItemInfo Info;

    // End:0x49
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("TradeWnd.InventoryList", Index, Info))
    {
        RememberLocalTradeItem(Info);
        RequestAddTradeItem(Info.ServerID, Num);
    }
    return;
}

function HandleMoveButton()
{
    local int selected;
    local ItemInfo Info;

    selected = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetSelectedNum("TradeWnd.InventoryList");
    // End:0xD1
    if(selected >= 0)
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("TradeWnd.InventoryList", selected, Info);
        RememberLocalTradeItem(Info);
        // End:0x88
        if(Info.ItemNum == 1)
        {
            MoveToMyList(selected, 1);            
        }
        else
        {
            DialogSetID(1);
            DialogSetReservedInt(Info.ServerID);
            DialogSetParamInt(Info.ItemNum);
            DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), Info.Name, ""));
        }
    }
    return;
}

function HandleStartTrade(string param)
{
    local int targetID;
    local UserInfo TargetInfo;
    local string ClanName;
    local WindowHandle m_inventoryWnd, m_warehouseWnd, m_privateShopWnd, m_shopWnd, m_multiSellWnd;

    m_inventoryWnd = GetHandle("InventoryWnd");
    m_warehouseWnd = GetHandle("WarehouseWnd");
    m_privateShopWnd = GetHandle("PrivateShopWnd");
    m_shopWnd = GetHandle("ShopWnd");
    m_multiSellWnd = GetHandle("MultiSellWnd");
    // End:0xA0
    if(m_inventoryWnd.IsShowWindow())
    {
        m_inventoryWnd.HideWindow();
    }
    // End:0xC1
    if(m_warehouseWnd.IsShowWindow())
    {
        m_warehouseWnd.HideWindow();
    }
    // End:0xE2
    if(m_privateShopWnd.IsShowWindow())
    {
        m_privateShopWnd.HideWindow();
    }
    // End:0x103
    if(m_shopWnd.IsShowWindow())
    {
        m_shopWnd.HideWindow();
    }
    // End:0x124
    if(m_multiSellWnd.IsShowWindow())
    {
        m_multiSellWnd.HideWindow();
    }
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TradeWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("TradeWnd");
    ParseInt(param, "targetId", targetID);
    // End:0x21E
    if(targetID > 0)
    {
        GetUserInfo(targetID, TargetInfo);
        // End:0x1F0
        if(TargetInfo.nClanID > 0)
        {
            ClanName = GetClanName(TargetInfo.nClanID);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TradeWnd.Targetname", (TargetInfo.Name $ " - ") $ ClanName);            
        }
        else
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TradeWnd.Targetname", TargetInfo.Name);
        }
    }
    return;
}

function HandleTradeAddItem(string param)
{
    local string strDest;
    local ItemInfo ItemInfo, tempInfo;
    local int Index;
    local bool bMyList;

    ParseString(param, "destination", strDest);
    ParamToItemInfo(param, ItemInfo);
    // End:0x67
    if(strDest == "inventoryList")
    {
        strDest = "TradeWnd.InventoryList";        
    }
    else
    {
        // End:0xCE
        if(strDest == "myList")
        {
            strDest = "TradeWnd.MyList";
            bMyList = true;
            Class'NWindow.UIAPI_INVENWEIGHT'.static.ReduceWeight("TradeWnd.InvenWeight", ItemInfo.ItemNum * ItemInfo.Weight);            
        }
        else
        {
            // End:0x138
            if(strDest == "otherList")
            {
                strDest = "TradeWnd.OtherList";
                Class'NWindow.UIAPI_INVENWEIGHT'.static.AddWeight("TradeWnd.InvenWeight", ItemInfo.ItemNum * ItemInfo.Weight);
            }
        }
    }
    if(bMyList)
    {
        ApplyLocalTradeItemDetails(ItemInfo);
    }
    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID(strDest, ItemInfo.ServerID);
    // End:0x1CF
    if(Index >= 0)
    {
        // End:0x1CC
        if(IsStackableItem(ItemInfo.ConsumeType))
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(strDest, Index, tempInfo);
            ItemInfo.ItemNum += tempInfo.ItemNum;
            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem(strDest, Index, ItemInfo);
        }        
    }
    else
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(strDest, ItemInfo);
    }
    return;
}

function HandleTradeDone(string param)
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TradeWnd");
    return;
}

function HandleTradeOtherOK(string param)
{
    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetFaded("TradeWnd.OtherList", true);
    return;
}

function HandleTradeUpdateInventoryItem(string param)
{
    local ItemInfo Info;
    local string Type;
    local int Index;

    ParseString(param, "type", Type);
    ParamToItemInfo(param, Info);
    RememberLocalTradeItem(Info);
    // End:0x64
    if(Type == "add")
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("TradeWnd.InventoryList", Info);        
    }
    else
    {
        // End:0xEC
        if(Type == "update")
        {
            Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("TradeWnd.InventoryList", Info.ServerID);
            // End:0xE9
            if(Index >= 0)
            {
                Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("TradeWnd.InventoryList", Index, Info);
            }            
        }
        else
        {
            // End:0x16C
            if(Type == "delete")
            {
                Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("TradeWnd.InventoryList", Info.ServerID);
                // End:0x16C
                if(Index >= 0)
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("TradeWnd.InventoryList", Index);
                }
            }
        }
    }
    return;
}

function HandleReceiveStartTrade(string param)
{
    local int targetID;
    local UserInfo Info;

    ParseInt(param, "targetID", targetID);
    // End:0x72
    if((targetID > 0) && GetUserInfo(targetID, Info))
    {
        DialogSetID(0);
        DialogSetParamInt(10 * 1000);
        DialogShow(DIALOG_Progress, MakeFullSystemMsg(GetSystemMessage(100), Info.Name, ""));
    }
    return;
}

function HandleDialogOK()
{
    local int ServerID, Num;

    // End:0x55
    if(DialogIsMine())
    {
        // End:0x1F
        if((DialogGetID()) == 0)
        {
            AnswerTradeRequest(true);            
        }
        else
        {
            // End:0x55
            if((DialogGetID()) == 1)
            {
                ServerID = DialogGetReservedInt();
                Num = int(DialogGetString());
                RequestAddTradeItem(ServerID, Num);
            }
        }
    }
    return;
}

function HandleDialogCancel()
{
    // End:0x1C
    if(DialogIsMine())
    {
        // End:0x1C
        if((DialogGetID()) == 0)
        {
            AnswerTradeRequest(false);
        }
    }
    return;
}

function Clear()
{
    m_LocalTradeItemCache.Length = 0;
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("TradeWnd.InventoryList");
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("TradeWnd.MyList");
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("TradeWnd.OtherList");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TradeWnd.TargetName", "");
    Class'NWindow.UIAPI_INVENWEIGHT'.static.ZeroWeight("TradeWnd.InvenWeight");
    return;
}

function int FindLocalTradeItemCacheIndex(int ServerID)
{
    local int idx;

    idx = 0;
    while(idx < m_LocalTradeItemCache.Length)
    {
        if(m_LocalTradeItemCache[idx].ServerID == ServerID)
        {
            return idx;
        }
        idx++;
    }
    return -1;
}

function RememberLocalTradeItem(ItemInfo Info)
{
    local int Index;
    local ItemInfo CachedInfo;

    if(Info.ServerID <= 0)
    {
        return;
    }
    Index = FindLocalTradeItemCacheIndex(Info.ServerID);
    if(Index >= 0)
    {
        CachedInfo = m_LocalTradeItemCache[Index];
        PreserveMissingLocalTradeItemDetails(Info, CachedInfo);
        m_LocalTradeItemCache[Index] = Info;
    }
    else
    {
        m_LocalTradeItemCache.Length = m_LocalTradeItemCache.Length + 1;
        m_LocalTradeItemCache[m_LocalTradeItemCache.Length - 1] = Info;
    }
    return;
}

function ApplyLocalTradeItemDetails(out ItemInfo Info)
{
    local int Index;
    local ItemInfo LocalInfo;

    if(Info.ServerID <= 0)
    {
        return;
    }
    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("TradeWnd.InventoryList", Info.ServerID);
    if(Index >= 0)
    {
        if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("TradeWnd.InventoryList", Index, LocalInfo))
        {
            RememberLocalTradeItem(LocalInfo);
            PreserveMissingLocalTradeItemDetails(Info, LocalInfo);
        }
    }
    Index = FindLocalTradeItemCacheIndex(Info.ServerID);
    if(Index >= 0)
    {
        PreserveMissingLocalTradeItemDetails(Info, m_LocalTradeItemCache[Index]);
    }
    return;
}

function PreserveMissingLocalTradeItemDetails(out ItemInfo Info, ItemInfo SourceInfo)
{
    if(Info.RefineryOp1 == 0)
    {
        Info.RefineryOp1 = SourceInfo.RefineryOp1;
    }
    if(Info.RefineryOp2 == 0)
    {
        Info.RefineryOp2 = SourceInfo.RefineryOp2;
    }
    if(Info.Description == "")
    {
        Info.Description = SourceInfo.Description;
    }
    if(Info.AdditionalName == "")
    {
        Info.AdditionalName = SourceInfo.AdditionalName;
    }
    if(Info.IconName == "")
    {
        Info.IconName = SourceInfo.IconName;
    }
    if(Info.IconNameEx1 == "")
    {
        Info.IconNameEx1 = SourceInfo.IconNameEx1;
    }
    if(Info.IconNameEx2 == "")
    {
        Info.IconNameEx2 = SourceInfo.IconNameEx2;
    }
    if(Info.IconNameEx3 == "")
    {
        Info.IconNameEx3 = SourceInfo.IconNameEx3;
    }
    if(Info.IconNameEx4 == "")
    {
        Info.IconNameEx4 = SourceInfo.IconNameEx4;
    }
    return;
}
