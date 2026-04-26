class ShopWnd extends UICommonAPI;

const DIALOG_TOP_TO_BOTTOM = 111;
const DIALOG_BOTTOM_TO_TOP = 222;
const DIALOG_PREVIEW = 333;

enum ShopType
{
    ShopNone,                       // 0
    ShopBuy,                        // 1
    ShopSell,                       // 2
    ShopPreview                     // 3
};

var string m_WindowName;
var ShopWnd.ShopType m_shopType;
var int m_merchantID;
var int m_npcID;
var INT64 m_currentPrice;

function OnLoad()
{
    RegisterEvent(2080);
    RegisterEvent(2090);
    RegisterEvent(1710);
    return;
}

function Clear()
{
    m_shopType = ShopNone;
    m_merchantID = -1;
    m_npcID = -1;
    m_currentPrice = Int2Int64(0);
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear(m_WindowName $ ".TopList");
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear(m_WindowName $ ".BottomList");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".PriceText", "0");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString(m_WindowName $ ".PriceText", "");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".AdenaText", "0");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString(m_WindowName $ ".AdenaText", "");
    Class'NWindow.UIAPI_INVENWEIGHT'.static.ZeroWeight(m_WindowName $ ".InvenWeight");
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x1D
        case 2080:
            HandleOpenWindow(param);
            // End:0x4A
            break;
        // End:0x33
        case 2090:
            HandleAddItem(param);
            // End:0x4A
            break;
        // End:0x44
        case 1710:
            HandleDialogOK();
            // End:0x4A
            break;
        // End:0xFFFF
        default:
            // End:0x4A
            break;
            break;
    }
    return;
}

function OnClickButton(string ControlName)
{
    local int Index;

    // End:0x4C
    if(ControlName == "UpButton")
    {
        Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetSelectedNum(m_WindowName $ ".BottomList");
        MoveItemBottomToTop(Index, false);        
    }
    else
    {
        // End:0x97
        if(ControlName == "DownButton")
        {
            Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetSelectedNum(m_WindowName $ ".TopList");
            MoveItemTopToBottom(Index, false);            
        }
        else
        {
            // End:0xB4
            if(ControlName == "OKButton")
            {
                HandleOKButton();                
            }
            else
            {
                // End:0xDD
                if(ControlName == "CancelButton")
                {
                    Clear();
                    HideWindow(m_WindowName);
                }
            }
        }
    }
    return;
}

function OnDBClickItem(string ControlName, int Index)
{
    // End:0x22
    if(ControlName == "TopList")
    {
        MoveItemTopToBottom(Index, false);        
    }
    else
    {
        // End:0x44
        if(ControlName == "BottomList")
        {
            MoveItemBottomToTop(Index, false);
        }
    }
    return;
}

function OnDropItem(string strID, ItemInfo Info, int X, int Y)
{
    local int Index;

    // End:0x89
    if((strID == "TopList") && Info.DragSrcName == "BottomList")
    {
        Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".BottomList", Info.ClassID);
        // End:0x86
        if(Index >= 0)
        {
            MoveItemBottomToTop(Index, Info.AllItemCount > 0);
        }        
    }
    else
    {
        // End:0x10C
        if((strID == "BottomList") && Info.DragSrcName == "TopList")
        {
            Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".TopList", Info.ClassID);
            // End:0x10C
            if(Index >= 0)
            {
                MoveItemTopToBottom(Index, Info.AllItemCount > 0);
            }
        }
    }
    return;
}

function MoveItemTopToBottom(int Index, bool bAllItem)
{
    local int bottomIndex;
    local ItemInfo Info, bottomInfo;

    // End:0x321
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".TopList", Index, Info))
    {
        // End:0xD6
        if((!bAllItem && IsStackableItem(Info.ConsumeType)) && Info.ItemNum != 1)
        {
            DialogSetID(111);
            DialogSetReservedInt(Info.ClassID);
            DialogSetDefaultOK();
            // End:0xA0
            if(m_shopType == ShopSell)
            {
                DialogSetParamInt(Info.ItemNum);                
            }
            else
            {
                DialogSetParamInt(-1);
            }
            DialogSetDefaultOK();
            DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), Info.Name, ""));            
        }
        else
        {
            Info.bShowCount = false;
            // End:0x209
            if(m_shopType == ShopSell)
            {
                bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".BottomList", Info.ClassID);
                // End:0x1B9
                if((bottomIndex >= 0) && IsStackableItem(Info.ConsumeType))
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".BottomList", bottomIndex, bottomInfo);
                    bottomInfo.ItemNum += Info.ItemNum;
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem(m_WindowName $ ".BottomList", bottomIndex, bottomInfo);                    
                }
                else
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(m_WindowName $ ".BottomList", Info);
                }
                Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem(m_WindowName $ ".TopList", Index);                
            }
            else
            {
                // End:0x28A
                if(m_shopType == ShopBuy)
                {
                    Info.ItemNum = 1;
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(m_WindowName $ ".BottomList", Info);
                    Class'NWindow.UIAPI_INVENWEIGHT'.static.AddWeight(m_WindowName $ ".InvenWeight", Info.Weight * Info.ItemNum);                    
                }
                else
                {
                    // End:0x301
                    if(m_shopType == ShopPreview)
                    {
                        bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".BottomList", Info.ClassID);
                        Info.ItemNum = 1;
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(m_WindowName $ ".BottomList", Info);
                    }
                }
            }
            AddPrice(Int64Mul(Info.Price, Info.ItemNum));
        }
    }
    return;
}

function MoveItemBottomToTop(int Index, bool bAllItem)
{
    local ItemInfo Info, info2;
    local int bottomIndex;

    // End:0x221
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".BottomList", Index, Info))
    {
        // End:0xA9
        if(!bAllItem && IsStackableItem(Info.ConsumeType))
        {
            DialogSetID(222);
            DialogSetDefaultOK();
            DialogSetReservedInt(Info.ClassID);
            DialogSetParamInt(Info.ItemNum);
            DialogSetDefaultOK();
            DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), Info.Name, ""));            
        }
        else
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem(m_WindowName $ ".BottomList", Index);
            // End:0x1B5
            if(m_shopType == ShopSell)
            {
                bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID(m_WindowName $ ".TopList", Info.ServerID);
                // End:0x148
                if(bottomIndex == -1)
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(m_WindowName $ ".TopList", Info);                    
                }
                else
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".TopList", bottomIndex, info2);
                    info2.ItemNum += Info.ItemNum;
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem(m_WindowName $ ".TopList", bottomIndex, info2);
                }                
            }
            else
            {
                // End:0x1FF
                if(m_shopType == ShopBuy)
                {
                    Class'NWindow.UIAPI_INVENWEIGHT'.static.ReduceWeight(m_WindowName $ ".InvenWeight", Info.Weight * Info.ItemNum);
                }
            }
            AddPrice(Int64Mul(-Info.Price, Info.ItemNum));
        }
    }
    return;
}

function HandleDialogOK()
{
    local int Id, Num, ClassID, Index, topIndex;

    local ItemInfo Info, topInfo;
    local string param;

    // End:0x630
    if(DialogIsMine())
    {
        Id = DialogGetID();
        Num = int(DialogGetString());
        ClassID = DialogGetReservedInt();
        // End:0x2CA
        if((Id == 111) && Num > 0)
        {
            topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".TopList", ClassID);
            // End:0x2C7
            if(topIndex >= 0)
            {
                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".TopList", topIndex, topInfo);
                // End:0xCF
                if((m_shopType == ShopSell) || topInfo.ItemNum > 0)
                {
                    Num = Min(Num, topInfo.ItemNum);
                }
                Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".BottomList", ClassID);
                // End:0x191
                if(Index >= 0)
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".BottomList", Index, Info);
                    Info.ItemNum += Num;
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem(m_WindowName $ ".BottomList", Index, Info);
                    AddPrice(Int64Mul(Num, Info.Price));                    
                }
                else
                {
                    Info = topInfo;
                    Info.ItemNum = Num;
                    Info.bShowCount = false;
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(m_WindowName $ ".BottomList", Info);
                    AddPrice(Int64Mul(Num, Info.Price));
                }
                // End:0x282
                if(m_shopType == ShopSell)
                {
                    topInfo.ItemNum -= Num;
                    // End:0x255
                    if(topInfo.ItemNum <= 0)
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem(m_WindowName $ ".TopList", topIndex);                        
                    }
                    else
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem(m_WindowName $ ".TopList", topIndex, topInfo);
                    }                    
                }
                else
                {
                    // End:0x2C7
                    if(m_shopType == ShopBuy)
                    {
                        Class'NWindow.UIAPI_INVENWEIGHT'.static.AddWeight(m_WindowName $ ".InvenWeight", Info.Weight * Num);
                    }
                }
            }            
        }
        else
        {
            // End:0x522
            if((Id == 222) && Num > 0)
            {
                Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".BottomList", ClassID);
                // End:0x51F
                if(Index >= 0)
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".BottomList", Index, Info);
                    Num = Min(Num, Info.ItemNum);
                    Info.ItemNum -= Num;
                    // End:0x39A
                    if(Info.ItemNum > 0)
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem(m_WindowName $ ".BottomList", Index, Info);                        
                    }
                    else
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem(m_WindowName $ ".BottomList", Index);
                    }
                    // End:0x4BD
                    if(m_shopType == ShopSell)
                    {
                        topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".TopList", ClassID);
                        // End:0x485
                        if((topIndex >= 0) && IsStackableItem(Info.ConsumeType))
                        {
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".TopList", topIndex, topInfo);
                            topInfo.ItemNum += Num;
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem(m_WindowName $ ".TopList", topIndex, topInfo);                            
                        }
                        else
                        {
                            Info.ItemNum = Num;
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(m_WindowName $ ".TopList", Info);
                        }                        
                    }
                    else
                    {
                        // End:0x502
                        if(m_shopType == ShopBuy)
                        {
                            Class'NWindow.UIAPI_INVENWEIGHT'.static.ReduceWeight(m_WindowName $ ".InvenWeight", Info.Weight * Num);
                        }
                    }
                    AddPrice(Int64Mul(-Num, Info.Price));
                }                
            }
            else
            {
                // End:0x630
                if(Id == 333)
                {
                    Num = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum(m_WindowName $ ".BottomList");
                    // End:0x630
                    if(Num > 0)
                    {
                        ParamAdd(param, "merchant", string(m_merchantID));
                        ParamAdd(param, "npc", string(m_npcID));
                        ParamAdd(param, "num", string(Num));
                        Index = 0;

                        while(Index < Num)
                        {
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".BottomList", Index, Info);
                            ParamAdd(param, "classID" $ string(Index), string(Info.ClassID));
                            ++Index;
                        }
                        RequestPreviewItem(param);
                    }
                }
            }
        }
    }
    return;
}

function HandleOpenWindow(string param)
{
    local string Type;
    local int Adena;
    local string adenaString;
    local WindowHandle m_inventoryWnd;

    m_inventoryWnd = GetHandle("InventoryWnd");
    Clear();
    ParseString(param, "type", Type);
    ParseInt(param, "merchant", m_merchantID);
    ParseInt(param, "adena", Adena);
    // End:0x81
    if(Type == "buy")
    {
        m_shopType = ShopBuy;        
    }
    else
    {
        // End:0x9C
        if(Type == "sell")
        {
            m_shopType = ShopSell;            
        }
        else
        {
            // End:0xBA
            if(Type == "preview")
            {
                m_shopType = ShopPreview;                
            }
            else
            {
                m_shopType = ShopNone;
            }
        }
    }
    adenaString = MakeCostString(string(Adena));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".AdenaText", adenaString);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString(m_WindowName $ ".AdenaText", ConvertNumToText(string(Adena)));
    // End:0x14C
    if(m_inventoryWnd.IsShowWindow())
    {
        m_inventoryWnd.HideWindow();
    }
    ShowWindow(m_WindowName);
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus(m_WindowName);
    // End:0x28E
    if(Type == "buy")
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType(m_WindowName $ ".TopList", "InventoryPrice1HideEnchantStackable");
        Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType(m_WindowName $ ".BottomList", "InventoryPrice1");
        Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle(m_WindowName, 136);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".TopText", GetSystemString(137));
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".BottomText", GetSystemString(139));
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".PriceConstText", GetSystemString(142));        
    }
    else
    {
        // End:0x39E
        if(Type == "sell")
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType(m_WindowName $ ".TopList", "InventoryPrice2");
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType(m_WindowName $ ".BottomList", "InventoryPrice2");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle(m_WindowName, 136);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".TopText", GetSystemString(138));
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".BottomText", GetSystemString(137));
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".PriceConstText", GetSystemString(143));            
        }
        else
        {
            // End:0x4E3
            if(Type == "preview")
            {
                ParseInt(param, "npc", m_npcID);
                Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType(m_WindowName $ ".TopList", "InventoryPrice1HideEnchantStackable");
                Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType(m_WindowName $ ".BottomList", "InventoryPrice1");
                Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle(m_WindowName, 847);
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".TopText", GetSystemString(811));
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".BottomText", GetSystemString(812));
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".PriceConstText", GetSystemString(813));
            }
        }
    }
    return;
}

function HandleAddItem(string param)
{
    local ItemInfo Info;

    ParamToItemInfo(param, Info);
    // End:0x3F
    if((m_shopType == ShopBuy) && Info.ItemNum > 0)
    {
        Info.bShowCount = true;
    }
    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(m_WindowName $ ".TopList", Info);
    return;
}

function AddPrice(INT64 Price)
{
    local string Adena;

    m_currentPrice = Int64Add(m_currentPrice, Price);
    // End:0x45
    if((m_currentPrice.nLeft < 0) || m_currentPrice.nRight < 0)
    {
        m_currentPrice = Int2Int64(0);
    }
    Adena = MakeCostStringInt64(m_currentPrice);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".PriceText", Adena);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString(m_WindowName $ ".PriceText", ConvertNumToText(Int64ToString(m_currentPrice)));
    return;
}

function HandleOKButton()
{
    local string param;
    local int topCount, bottomCount, topIndex, bottomIndex;
    local ItemInfo topInfo, bottomInfo;
    local int limitedItemCount;

    bottomCount = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum(m_WindowName $ ".BottomList");
    // End:0x267
    if(m_shopType == ShopBuy)
    {
        topCount = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum(m_WindowName $ ".TopList");
        topIndex = 0;

        while(topIndex < topCount)
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".TopList", topIndex, topInfo);
            // End:0x17F
            if(topInfo.ItemNum > 0)
            {
                limitedItemCount = 0;
                bottomCount = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum(m_WindowName $ ".BottomList");
                bottomIndex = 0;

                while(bottomIndex < bottomCount)
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".BottomList", bottomIndex, bottomInfo);
                    // End:0x14C
                    if(bottomInfo.ClassID == topInfo.ClassID)
                    {
                        limitedItemCount += bottomInfo.ItemNum;
                    }
                    ++bottomIndex;
                }
                // End:0x17F
                if(limitedItemCount > topInfo.ItemNum)
                {
                    DialogShow(DIALOG_Warning, GetSystemMessage(1338));
                    return;
                }
            }
            ++topIndex;
        }
        ParamAdd(param, "merchant", string(m_merchantID));
        ParamAdd(param, "num", string(bottomCount));
        bottomIndex = 0;

        while(bottomIndex < bottomCount)
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".BottomList", bottomIndex, bottomInfo);
            ParamAdd(param, "classID" $ string(bottomIndex), string(bottomInfo.ClassID));
            ParamAdd(param, "count" $ string(bottomIndex), string(bottomInfo.ItemNum));
            ++bottomIndex;
        }
        RequestBuyItem(param);        
    }
    else
    {
        // End:0x37F
        if(m_shopType == ShopSell)
        {
            ParamAdd(param, "merchant", string(m_merchantID));
            ParamAdd(param, "num", string(bottomCount));
            bottomIndex = 0;

            while(bottomIndex < bottomCount)
            {
                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".BottomList", bottomIndex, bottomInfo);
                ParamAdd(param, "serverID" $ string(bottomIndex), string(bottomInfo.ServerID));
                ParamAdd(param, "classID" $ string(bottomIndex), string(bottomInfo.ClassID));
                ParamAdd(param, "count" $ string(bottomIndex), string(bottomInfo.ItemNum));
                ++bottomIndex;
            }
            RequestSellItem(param);            
        }
        else
        {
            // End:0x3B8
            if(m_shopType == ShopPreview)
            {
                // End:0x3B8
                if(bottomCount > 0)
                {
                    DialogSetID(333);
                    DialogShow(DIALOG_Warning, GetSystemMessage(1157));
                }
            }
        }
    }
    HideWindow(m_WindowName);
    return;
}

defaultproperties
{
    m_WindowName="ShopWnd"
}
