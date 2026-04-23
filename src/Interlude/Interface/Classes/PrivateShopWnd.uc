class PrivateShopWnd extends UICommonAPI;

const DIALOG_TOP_TO_BOTTOM = 111;
const DIALOG_BOTTOM_TO_TOP = 222;
const DIALOG_ASK_PRICE = 333;
const DIALOG_CONFIRM_PRICE = 444;
const DIALOG_EDIT_SHOP_MESSAGE = 555;
const DIALOG_CONFIRM_PRICE_FINAL = 666;

enum PrivateShopType
{
    PT_None,                        // 0
    PT_Buy,                         // 1
    PT_Sell,                        // 2
    PT_BuyList,                     // 3
    PT_SellList                     // 4
};

var int m_merchantID;
var PrivateShopWnd.PrivateShopType m_Type;
var int m_buyMaxCount;
var int m_sellMaxCount;
var bool m_bBulk;

function OnLoad()
{
    RegisterEvent(2120);
    RegisterEvent(2130);
    RegisterEvent(2070);
    RegisterEvent(1710);
    m_merchantID = 0;
    m_buyMaxCount = 0;
    m_sellMaxCount = 0;
    return;
}

function OnSendPacketWhenHiding()
{
    RequestQuit();
    return;
}

function OnHide()
{
    local DialogBox DialogBox;

    DialogBox = DialogBox(GetScript("DialogBox"));
    // End:0x48
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("DialogBox"))
    {
        DialogBox.HandleCancel();
    }
    Clear();
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x1D
        case 2120:
            HandleOpenWindow(param);
            // End:0x60
            break;
        // End:0x33
        case 2130:
            HandleAddItem(param);
            // End:0x60
            break;
        // End:0x49
        case 2070:
            HandleSetMaxCount(param);
            // End:0x60
            break;
        // End:0x5A
        case 1710:
            HandleDialogOK();
            // End:0x60
            break;
        // End:0xFFFF
        default:
            // End:0x60
            break;
            break;
    }
    return;
}

function OnClickButton(string ControlName)
{
    local int Index;

    // End:0x53
    if(ControlName == "UpButton")
    {
        Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetSelectedNum("PrivateShopWnd.BottomList");
        MoveItemBottomToTop(Index, false);        
    }
    else
    {
        // End:0xA5
        if(ControlName == "DownButton")
        {
            Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetSelectedNum("PrivateShopWnd.TopList");
            MoveItemTopToBottom(Index, false);            
        }
        else
        {
            // End:0xC3
            if(ControlName == "OKButton")
            {
                HandleOKButton(true);                
            }
            else
            {
                // End:0xF8
                if(ControlName == "StopButton")
                {
                    RequestQuit();
                    HideWindow("PrivateShopWnd");                    
                }
                else
                {
                    // End:0x183
                    if(ControlName == "MessageButton")
                    {
                        DialogSetEditBoxMaxLength(29);
                        DialogSetID(555);
                        // End:0x149
                        if(m_Type == PT_SellList)
                        {
                            DialogSetString(GetPrivateShopMessage("sell"));                            
                        }
                        else
                        {
                            // End:0x16A
                            if(m_Type == PT_BuyList)
                            {
                                DialogSetString(GetPrivateShopMessage("buy"));
                            }
                        }
                        DialogSetDefaultOK();
                        DialogShow(DIALOG_OKCancelInput, GetSystemMessage(334));
                    }
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

function OnClickItem(string ControlName, int Index)
{
    local WindowHandle m_dialogWnd;

    m_dialogWnd = GetHandle("DialogBox");
    // End:0x5C
    if(ControlName == "TopList")
    {
        // End:0x5C
        if((DialogIsMine()) && m_dialogWnd.IsShowWindow())
        {
            DialogHide();
            m_dialogWnd.HideWindow();
        }
    }
    return;
}

function OnDropItem(string strID, ItemInfo Info, int X, int Y)
{
    local int Index;

    Index = -1;
    // End:0x11C
    if((strID == "TopList") && Info.DragSrcName == "BottomList")
    {
        // End:0x9A
        if((m_Type == PT_Buy) || m_Type == PT_SellList)
        {
            Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.BottomList", Info.ServerID);            
        }
        else
        {
            // End:0xF6
            if((m_Type == PT_Sell) || m_Type == PT_BuyList)
            {
                Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.BottomList", Info.ClassID);
            }
        }
        // End:0x119
        if(Index >= 0)
        {
            MoveItemBottomToTop(Index, Info.AllItemCount > 0);
        }        
    }
    else
    {
        // End:0x224
        if((strID == "BottomList") && Info.DragSrcName == "TopList")
        {
            // End:0x1A8
            if((m_Type == PT_Buy) || m_Type == PT_SellList)
            {
                Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.TopList", Info.ServerID);                
            }
            else
            {
                // End:0x201
                if((m_Type == PT_Sell) || m_Type == PT_BuyList)
                {
                    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.TopList", Info.ClassID);
                }
            }
            // End:0x224
            if(Index >= 0)
            {
                MoveItemTopToBottom(Index, Info.AllItemCount > 0);
            }
        }
    }
    return;
}

function Clear()
{
    m_Type = PT_None;
    m_merchantID = -1;
    m_bBulk = false;
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("PrivateShopWnd.TopList");
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("PrivateShopWnd.BottomList");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.PriceText", "0");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString("PrivateShopWnd.PriceText", "");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.AdenaText", "0");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString("PrivateShopWnd.AdenaText", "");
    return;
}

function RequestQuit()
{
    // End:0x1E
    if(m_Type == PT_BuyList)
    {
        RequestQuitPrivateShop("buy");        
    }
    else
    {
        // End:0x3A
        if(m_Type == PT_SellList)
        {
            RequestQuitPrivateShop("sell");
        }
    }
    return;
}

function MoveItemTopToBottom(int Index, bool bAllItem)
{
    local ItemInfo Info, bottomInfo;
    local int Num, i, bottomIndex;

    // End:0x4B1
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", Index, Info))
    {
        // End:0xA2
        if(m_Type == PT_SellList)
        {
            DialogSetID(333);
            DialogSetReservedInt(Info.ServerID);
            DialogSetReservedInt3(int(bAllItem));
            DialogSetEditType("number");
            DialogSetParamInt(-1);
            DialogSetDefaultOK();
            DialogShow(DIALOG_NumberPad, GetSystemMessage(322));            
        }
        else
        {
            // End:0x102
            if(m_Type == PT_BuyList)
            {
                DialogSetID(333);
                DialogSetReservedInt(Info.ClassID);
                DialogSetEditType("number");
                DialogSetParamInt(-1);
                DialogSetDefaultOK();
                DialogShow(DIALOG_NumberPad, GetSystemMessage(585));                
            }
            else
            {
                // End:0x4B1
                if((m_Type == PT_Sell) || m_Type == PT_Buy)
                {
                    // End:0x146
                    if((m_Type == PT_Sell) && Info.bDisabled)
                    {
                        return;
                    }
                    // End:0x244
                    if((m_Type == PT_Buy) && m_bBulk)
                    {
                        Num = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("PrivateShopWnd.TopList");
                        i = 0;

                        while(i < Num)
                        {
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", i, Info);
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.BottomList", Info);
                            ++i;
                        }
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("PrivateShopWnd.TopList");
                        AdjustPrice();
                        AdjustCount();                        
                    }
                    else
                    {
                        // End:0x2FC
                        if((!bAllItem && IsStackableItem(Info.ConsumeType)) && Info.ItemNum > 1)
                        {
                            DialogSetID(111);
                            // End:0x2A1
                            if(m_Type == PT_Sell)
                            {
                                DialogSetReservedInt(Info.ClassID);                                
                            }
                            else
                            {
                                // End:0x2C1
                                if(m_Type == PT_Buy)
                                {
                                    DialogSetReservedInt(Info.ServerID);
                                }
                            }
                            DialogSetParamInt(Info.ItemNum);
                            DialogSetDefaultOK();
                            DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), Info.Name, ""));                            
                        }
                        else
                        {
                            // End:0x349
                            if(m_Type == PT_Buy)
                            {
                                bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.BottomList", Info.ServerID);                                
                            }
                            else
                            {
                                // End:0x393
                                if(m_Type == PT_Sell)
                                {
                                    bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.BottomList", Info.ClassID);
                                }
                            }
                            // End:0x434
                            if((bottomIndex >= 0) && IsStackableItem(Info.ConsumeType))
                            {
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                                bottomInfo.ItemNum += Info.ItemNum;
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);                                
                            }
                            else
                            {
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.BottomList", Info);
                            }
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.TopList", Index);
                            AdjustPrice();
                            AdjustCount();
                        }
                    }
                    // End:0x4B1
                    if(m_Type == PT_Buy)
                    {
                        AdjustWeight();
                    }
                }
            }
        }
    }
    return;
}

function MoveItemBottomToTop(int Index, bool bAllItem)
{
    local ItemInfo Info, topInfo;
    local int stringIndex, Num, i, topIndex;

    // End:0x435
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", Index, Info))
    {
        // End:0x13B
        if((m_Type == PT_Buy) && m_bBulk)
        {
            Num = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("PrivateShopWnd.BottomList");
            i = 0;

            while(i < Num)
            {
                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", i, Info);
                Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.TopList", Info);
                ++i;
            }
            Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("PrivateShopWnd.BottomList");
            AdjustPrice();
            AdjustCount();            
        }
        else
        {
            // End:0x26A
            if((!bAllItem && IsStackableItem(Info.ConsumeType)) && Info.ItemNum > 1)
            {
                DialogSetID(222);
                // End:0x1AA
                if((m_Type == PT_Buy) || m_Type == PT_SellList)
                {
                    DialogSetReservedInt(Info.ServerID);                    
                }
                else
                {
                    // End:0x1DC
                    if((m_Type == PT_Sell) || m_Type == PT_BuyList)
                    {
                        DialogSetReservedInt(Info.ClassID);
                    }
                }
                DialogSetParamInt(Info.ItemNum);
                switch(m_Type)
                {
                    // End:0x203
                    case PT_SellList:
                        stringIndex = 72;
                        // End:0x23C
                        break;
                    // End:0x216
                    case PT_BuyList:
                        stringIndex = 571;
                        // End:0x23C
                        break;
                    // End:0x226
                    case PT_Sell:
                        stringIndex = 72;
                        // End:0x23C
                        break;
                    // End:0x236
                    case PT_Buy:
                        stringIndex = 72;
                        // End:0x23C
                        break;
                    // End:0xFFFF
                    default:
                        // End:0x23C
                        break;
                        break;
                }
                DialogSetDefaultOK();
                DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(stringIndex), Info.Name, ""));                
            }
            else
            {
                Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.BottomList", Index);
                // End:0x413
                if(m_Type != PT_BuyList)
                {
                    // End:0x305
                    if((m_Type == PT_Buy) || m_Type == PT_SellList)
                    {
                        topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.TopList", Info.ServerID);                        
                    }
                    else
                    {
                        // End:0x34C
                        if(m_Type == PT_Sell)
                        {
                            topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.TopList", Info.ClassID);
                        }
                    }
                    // End:0x3E7
                    if((topIndex >= 0) && IsStackableItem(Info.ConsumeType))
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                        topInfo.ItemNum += Info.ItemNum;
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.TopList", topIndex, topInfo);                        
                    }
                    else
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.TopList", Info);
                    }
                }
                AdjustPrice();
                AdjustCount();
            }
        }
        // End:0x435
        if(m_Type == PT_Buy)
        {
            AdjustWeight();
        }
    }
    return;
}

function HandleDialogOK()
{
    local int Id, inputNum, ItemID, bottomIndex, topIndex, i,
	    allItem;

    local ItemInfo bottomInfo, topInfo;

    // End:0x17CC
    if(DialogIsMine())
    {
        Id = DialogGetID();
        inputNum = int(DialogGetString());
        ItemID = DialogGetReservedInt();
        // End:0xAA7
        if(m_Type == PT_SellList)
        {
            // End:0x2AB
            if((Id == 111) && inputNum > 0)
            {
                topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.TopList", ItemID);
                // End:0x29C
                if(topIndex >= 0)
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                    bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.BottomList", ItemID);
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                    // End:0x1B4
                    if((bottomIndex >= 0) && IsStackableItem(bottomInfo.ConsumeType))
                    {
                        bottomInfo.Price = DialogGetReservedInt2();
                        bottomInfo.ItemNum += Min(inputNum, topInfo.ItemNum);
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);                        
                    }
                    else
                    {
                        bottomInfo = topInfo;
                        bottomInfo.ItemNum = Min(inputNum, topInfo.ItemNum);
                        bottomInfo.Price = DialogGetReservedInt2();
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.BottomList", bottomInfo);
                    }
                    topInfo.ItemNum -= inputNum;
                    // End:0x26B
                    if(topInfo.ItemNum <= 0)
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.TopList", topIndex);                        
                    }
                    else
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                    }
                }
                AdjustPrice();
                AdjustCount();                
            }
            else
            {
                // End:0x4F5
                if((Id == 222) && inputNum > 0)
                {
                    bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.BottomList", ItemID);
                    // End:0x4E6
                    if(bottomIndex >= 0)
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                        topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.TopList", ItemID);
                        // End:0x40C
                        if((topIndex >= 0) && IsStackableItem(bottomInfo.ConsumeType))
                        {
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                            topInfo.ItemNum += Min(inputNum, bottomInfo.ItemNum);
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.TopList", topIndex, topInfo);                            
                        }
                        else
                        {
                            topInfo = bottomInfo;
                            topInfo.ItemNum = Min(inputNum, bottomInfo.ItemNum);
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.TopList", topInfo);
                        }
                        bottomInfo.ItemNum -= inputNum;
                        // End:0x4B7
                        if(bottomInfo.ItemNum > 0)
                        {
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);                            
                        }
                        else
                        {
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.BottomList", bottomIndex);
                        }
                    }
                    AdjustPrice();
                    AdjustCount();                    
                }
                else
                {
                    // End:0x77C
                    if(Id == 444)
                    {
                        topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.TopList", ItemID);
                        // End:0x779
                        if(topIndex >= 0)
                        {
                            allItem = DialogGetReservedInt3();
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                            // End:0x60F
                            if(((allItem == 0) && IsStackableItem(topInfo.ConsumeType)) && topInfo.ItemNum != 1)
                            {
                                DialogSetID(111);
                                // End:0x5D4
                                if(topInfo.ItemNum == 0)
                                {
                                    topInfo.ItemNum = 1;
                                }
                                DialogSetParamInt(topInfo.ItemNum);
                                DialogSetDefaultOK();
                                DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), topInfo.Name, ""));                                
                            }
                            else
                            {
                                // End:0x626
                                if(allItem == 0)
                                {
                                    topInfo.ItemNum = 1;
                                }
                                topInfo.Price = DialogGetReservedInt2();
                                bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.BottomList", topInfo.ServerID);
                                // End:0x712
                                if((bottomIndex >= 0) && IsStackableItem(topInfo.ConsumeType))
                                {
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                                    topInfo.ItemNum += bottomInfo.ItemNum;
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.BottomList", bottomIndex, topInfo);                                    
                                }
                                else
                                {
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.BottomList", topInfo);
                                }
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.TopList", topIndex);
                                AdjustPrice();
                                AdjustCount();
                            }
                        }                        
                    }
                    else
                    {
                        // End:0xA83
                        if((Id == 333) && inputNum > 0)
                        {
                            topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.TopList", ItemID);
                            // End:0xA80
                            if(topIndex >= 0)
                            {
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                                // End:0x82B
                                if(inputNum >= 2000000000)
                                {
                                    DialogShow(DIALOG_Notice, GetSystemMessage(1369));                                    
                                }
                                else
                                {
                                    // End:0x882
                                    if(!IsProperPrice(topInfo, inputNum))
                                    {
                                        DialogSetID(444);
                                        DialogSetReservedInt(topInfo.ServerID);
                                        DialogSetReservedInt2(inputNum);
                                        DialogSetDefaultOK();
                                        DialogShow(DIALOG_Warning, GetSystemMessage(569));                                        
                                    }
                                    else
                                    {
                                        allItem = DialogGetReservedInt3();
                                        // End:0x917
                                        if((allItem == 0) && IsStackableItem(topInfo.ConsumeType))
                                        {
                                            DialogSetID(111);
                                            DialogSetReservedInt(topInfo.ServerID);
                                            DialogSetReservedInt2(inputNum);
                                            DialogSetReservedInt3(allItem);
                                            DialogSetParamInt(topInfo.ItemNum);
                                            DialogSetDefaultOK();
                                            DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), topInfo.Name, ""));                                            
                                        }
                                        else
                                        {
                                            // End:0x92E
                                            if(allItem == 0)
                                            {
                                                topInfo.ItemNum = 1;
                                            }
                                            topInfo.Price = inputNum;
                                            bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.BottomList", topInfo.ServerID);
                                            // End:0xA19
                                            if((bottomIndex >= 0) && IsStackableItem(topInfo.ConsumeType))
                                            {
                                                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                                                topInfo.ItemNum += bottomInfo.ItemNum;
                                                Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.BottomList", bottomIndex, topInfo);                                                
                                            }
                                            else
                                            {
                                                Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.BottomList", topInfo);
                                            }
                                            Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.TopList", topIndex);
                                            AdjustPrice();
                                            AdjustCount();
                                        }
                                    }
                                }
                            }                            
                        }
                        else
                        {
                            // End:0xAA4
                            if(Id == 555)
                            {
                                SetPrivateShopMessage("sell", DialogGetString());
                            }
                        }
                    }
                }
            }            
        }
        else
        {
            // End:0x115D
            if(m_Type == PT_BuyList)
            {
                // End:0xDDD
                if((Id == 111) && inputNum > 0)
                {
                    topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.TopList", ItemID);
                    // End:0xDCE
                    if(topIndex >= 0)
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                        bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.BottomList", ItemID);
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                        // End:0xC1F
                        if((bottomIndex >= 0) && IsStackableItem(bottomInfo.ConsumeType))
                        {
                            bottomInfo.Price = DialogGetReservedInt2();
                            bottomInfo.ItemNum += inputNum;
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                            return;
                        }
                        // End:0xCE6
                        if(bottomIndex >= 0)
                        {
                            i = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("PrivateShopWnd.BottomList");

                            while(i >= 0)
                            {
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", i, bottomInfo);
                                // End:0xCDC
                                if(bottomInfo.ClassID == ItemID)
                                {
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.BottomList", i);
                                }
                                --i;
                            }
                        }
                        // End:0xD57
                        if(IsStackableItem(topInfo.ConsumeType))
                        {
                            bottomInfo = topInfo;
                            bottomInfo.ItemNum = inputNum;
                            bottomInfo.Price = DialogGetReservedInt2();
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.BottomList", bottomInfo);                            
                        }
                        else
                        {
                            bottomInfo = topInfo;
                            bottomInfo.ItemNum = 1;
                            bottomInfo.Price = DialogGetReservedInt2();
                            i = 0;

                            while(i < inputNum)
                            {
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.BottomList", bottomInfo);
                                ++i;
                            }
                        }
                    }
                    AdjustPrice();
                    AdjustCount();                    
                }
                else
                {
                    // End:0xEF4
                    if((Id == 222) && inputNum > 0)
                    {
                        bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.BottomList", ItemID);
                        // End:0xEF1
                        if(bottomIndex >= 0)
                        {
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                            bottomInfo.ItemNum -= inputNum;
                            // End:0xEC2
                            if(bottomInfo.ItemNum > 0)
                            {
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);                                
                            }
                            else
                            {
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.BottomList", bottomIndex);
                            }
                        }                        
                    }
                    else
                    {
                        // End:0xFD3
                        if(Id == 444)
                        {
                            topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.TopList", ItemID);
                            // End:0xFC4
                            if(topIndex >= 0)
                            {
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                                DialogSetID(111);
                                DialogSetReservedInt(topInfo.ClassID);
                                DialogSetParamInt(topInfo.ItemNum);
                                DialogSetDefaultOK();
                                DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(570), topInfo.Name, ""));
                            }
                            AdjustPrice();
                            AdjustCount();                            
                        }
                        else
                        {
                            // End:0x113A
                            if((Id == 333) && inputNum > 0)
                            {
                                topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.TopList", ItemID);
                                // End:0x1137
                                if(topIndex >= 0)
                                {
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                                    // End:0x1082
                                    if(inputNum >= 2000000000)
                                    {
                                        DialogShow(DIALOG_Notice, GetSystemMessage(1369));                                        
                                    }
                                    else
                                    {
                                        // End:0x10D9
                                        if(!IsProperPrice(topInfo, inputNum))
                                        {
                                            DialogSetID(444);
                                            DialogSetReservedInt(topInfo.ClassID);
                                            DialogSetReservedInt2(inputNum);
                                            DialogSetDefaultOK();
                                            DialogShow(DIALOG_Warning, GetSystemMessage(569));                                            
                                        }
                                        else
                                        {
                                            DialogSetID(111);
                                            DialogSetReservedInt(topInfo.ClassID);
                                            DialogSetReservedInt2(inputNum);
                                            DialogSetParamInt(topInfo.ItemNum);
                                            DialogSetDefaultOK();
                                            DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(570), topInfo.Name, ""));
                                        }
                                    }
                                }                                
                            }
                            else
                            {
                                // End:0x115A
                                if(Id == 555)
                                {
                                    SetPrivateShopMessage("buy", DialogGetString());
                                }
                            }
                        }
                    }
                }                
            }
            else
            {
                // End:0x17CC
                if((m_Type == PT_Buy) || m_Type == PT_Sell)
                {
                    // End:0x14A8
                    if((Id == 111) && inputNum > 0)
                    {
                        topIndex = -1;
                        // End:0x11E8
                        if(m_Type == PT_Buy)
                        {
                            topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.TopList", ItemID);                            
                        }
                        else
                        {
                            // End:0x122A
                            if(m_Type == PT_Sell)
                            {
                                topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.TopList", ItemID);
                            }
                        }
                        // End:0x1499
                        if(topIndex >= 0)
                        {
                            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                            // End:0x12A2
                            if((m_Type == PT_Sell) && topInfo.Reserved < inputNum)
                            {
                                DialogShow(DIALOG_Notice, GetSystemMessage(1036));                                
                            }
                            else
                            {
                                // End:0x12EA
                                if(m_Type == PT_Buy)
                                {
                                    bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.BottomList", ItemID);                                    
                                }
                                else
                                {
                                    // End:0x132F
                                    if(m_Type == PT_Sell)
                                    {
                                        bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.BottomList", ItemID);
                                    }
                                }
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                                // End:0x13C2
                                if(bottomIndex >= 0)
                                {
                                    bottomInfo.ItemNum += Min(inputNum, topInfo.ItemNum);
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);                                    
                                }
                                else
                                {
                                    bottomInfo = topInfo;
                                    bottomInfo.ItemNum = Min(inputNum, topInfo.ItemNum);
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.BottomList", bottomInfo);
                                }
                                topInfo.ItemNum -= inputNum;
                                // End:0x1468
                                if(topInfo.ItemNum <= 0)
                                {
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.TopList", topIndex);                                    
                                }
                                else
                                {
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                                }
                            }
                        }
                        AdjustPrice();
                        AdjustCount();                        
                    }
                    else
                    {
                        // End:0x17A0
                        if((Id == 222) && inputNum > 0)
                        {
                            bottomIndex = -1;
                            // End:0x1514
                            if(m_Type == PT_Buy)
                            {
                                bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.BottomList", ItemID);                                
                            }
                            else
                            {
                                // End:0x1559
                                if(m_Type == PT_Sell)
                                {
                                    bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.BottomList", ItemID);
                                }
                            }
                            // End:0x1791
                            if(bottomIndex >= 0)
                            {
                                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);
                                topIndex = -1;
                                // End:0x15E8
                                if(m_Type == PT_Buy)
                                {
                                    topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithServerID("PrivateShopWnd.TopList", ItemID);                                    
                                }
                                else
                                {
                                    // End:0x162A
                                    if(m_Type == PT_Sell)
                                    {
                                        topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("PrivateShopWnd.TopList", ItemID);
                                    }
                                }
                                // End:0x16B7
                                if(topIndex >= 0)
                                {
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.TopList", topIndex, topInfo);
                                    topInfo.ItemNum += Min(inputNum, bottomInfo.ItemNum);
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.TopList", topIndex, topInfo);                                    
                                }
                                else
                                {
                                    topInfo = bottomInfo;
                                    topInfo.ItemNum = Min(inputNum, bottomInfo.ItemNum);
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.TopList", topInfo);
                                }
                                bottomInfo.ItemNum -= inputNum;
                                // End:0x1762
                                if(bottomInfo.ItemNum > 0)
                                {
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("PrivateShopWnd.BottomList", bottomIndex, bottomInfo);                                    
                                }
                                else
                                {
                                    Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("PrivateShopWnd.BottomList", bottomIndex);
                                }
                            }
                            AdjustPrice();
                            AdjustCount();                            
                        }
                        else
                        {
                            // End:0x17B6
                            if(Id == 666)
                            {
                                HandleOKButton(false);
                            }
                        }
                    }
                    // End:0x17CC
                    if(m_Type == PT_Buy)
                    {
                        AdjustWeight();
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
    local int Adena, bulk;
    local string adenaString;
    local UserInfo User;
    local WindowHandle m_inventoryWnd;

    m_inventoryWnd = GetHandle("InventoryWnd");
    Clear();
    ParseString(param, "type", Type);
    ParseInt(param, "adena", Adena);
    ParseInt(param, "userID", m_merchantID);
    ParseInt(param, "bulk", bulk);
    // End:0x91
    if(bulk > 0)
    {
        m_bBulk = true;        
    }
    else
    {
        m_bBulk = false;
    }
    switch(Type)
    {
        // End:0xB3
        case "buy":
            m_Type = PT_Buy;
            // End:0xFC
            break;
        // End:0xC7
        case "sell":
            m_Type = PT_Sell;
            // End:0xFC
            break;
        // End:0xDE
        case "buyList":
            m_Type = PT_BuyList;
            // End:0xFC
            break;
        // End:0xF6
        case "sellList":
            m_Type = PT_SellList;
            // End:0xFC
            break;
        // End:0xFFFF
        default:
            // End:0xFC
            break;
            break;
    }
    adenaString = MakeCostString(string(Adena));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.AdenaText", adenaString);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString("PrivateShopWnd.AdenaText", ConvertNumToText(string(Adena)));
    // End:0x194
    if(m_inventoryWnd.IsShowWindow())
    {
        m_inventoryWnd.HideWindow();
    }
    ShowWindow("PrivateShopWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("PrivateShopWnd");
    // End:0x3FA
    if(m_Type == PT_BuyList)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType("PrivateShopWnd.TopList", "Inventory");
        Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType("PrivateShopWnd.BottomList", "InventoryPrice1");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.TopText", GetSystemString(1));
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.BottomText", GetSystemString(502));
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.PriceConstText", GetSystemString(142));
        Class'NWindow.UIAPI_BUTTON'.static.SetButtonName("PrivateShopWnd.OKButton", 428);
        ShowWindow("PrivateShopWnd.BottomCountText");
        ShowWindow("PrivateShopWnd.StopButton");
        ShowWindow("PrivateShopWnd.MessageButton");
        ShowWindow("PrivateShopWnd.OKButton");
        HideWindow("PrivateShopWnd.CheckBulk");
        Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitleByText("PrivateShopWnd", ((GetSystemString(498) $ "(") $ GetSystemString(1434)) $ ")");        
    }
    else
    {
        // End:0x68A
        if(m_Type == PT_SellList)
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType("PrivateShopWnd.TopList", "Inventory");
            Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType("PrivateShopWnd.BottomList", "InventoryPrice1");
            // End:0x4AF
            if(bulk > 0)
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("PrivateShopWnd.CheckBulk", true);                
            }
            else
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("PrivateShopWnd.CheckBulk", false);
            }
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.TopText", GetSystemString(1));
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.BottomText", GetSystemString(137));
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.PriceConstText", GetSystemString(143));
            Class'NWindow.UIAPI_BUTTON'.static.SetButtonName("PrivateShopWnd.OKButton", 428);
            ShowWindow("PrivateShopWnd.BottomCountText");
            ShowWindow("PrivateShopWnd.StopButton");
            ShowWindow("PrivateShopWnd.MessageButton");
            ShowWindow("PrivateShopWnd.OKButton");
            ShowWindow("PrivateShopWnd.CheckBulk");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitleByText("PrivateShopWnd", ((GetSystemString(498) $ "(") $ GetSystemString(1157)) $ ")");            
        }
        else
        {
            // End:0x933
            if(m_Type == PT_Buy)
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType("PrivateShopWnd.TopList", "InventoryPrice1");
                Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType("PrivateShopWnd.BottomList", "Inventory");
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.TopText", GetSystemString(137));
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.BottomText", GetSystemString(139));
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.PriceConstText", GetSystemString(142));
                Class'NWindow.UIAPI_BUTTON'.static.SetButtonName("PrivateShopWnd.OKButton", 140);
                HideWindow("PrivateShopWnd.BottomCountText");
                HideWindow("PrivateShopWnd.StopButton");
                HideWindow("PrivateShopWnd.MessageButton");
                ShowWindow("PrivateShopWnd.OKButton");
                HideWindow("PrivateShopWnd.CheckBulk");
                GetUserInfo(m_merchantID, User);
                // End:0x8E0
                if(bulk > 0)
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitleByText("PrivateShopWnd", (((GetSystemString(498) $ "(") $ GetSystemString(1198)) $ ") - ") $ User.Name);                    
                }
                else
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitleByText("PrivateShopWnd", (((GetSystemString(498) $ "(") $ GetSystemString(1157)) $ ") - ") $ User.Name);
                }                
            }
            else
            {
                // End:0xB89
                if(m_Type == PT_Sell)
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType("PrivateShopWnd.TopList", "InventoryPrice2PrivateShop");
                    Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType("PrivateShopWnd.BottomList", "Inventory");
                    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.TopText", GetSystemString(503));
                    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.BottomText", GetSystemString(137));
                    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.PriceConstText", GetSystemString(143));
                    Class'NWindow.UIAPI_BUTTON'.static.SetButtonName("PrivateShopWnd.OKButton", 140);
                    HideWindow("PrivateShopWnd.BottomCountText");
                    HideWindow("PrivateShopWnd.StopButton");
                    HideWindow("PrivateShopWnd.MessageButton");
                    ShowWindow("PrivateShopWnd.OKButton");
                    HideWindow("PrivateShopWnd.CheckBulk");
                    GetUserInfo(m_merchantID, User);
                    Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitleByText("PrivateShopWnd", (((GetSystemString(498) $ "(") $ GetSystemString(1434)) $ ") - ") $ User.Name);
                }
            }
        }
    }
    return;
}

function HandleAddItem(string param)
{
    local ItemInfo Info;
    local string Target;

    ParseString(param, "target", Target);
    ParamToItemInfo(param, Info);
    // End:0x99
    if(Target == "topList")
    {
        // End:0x6A
        if((m_Type == PT_Sell) && Info.ItemNum == 0)
        {
            Info.bDisabled = true;
        }
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.TopList", Info);        
    }
    else
    {
        // End:0xDE
        if(Target == "bottomList")
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("PrivateShopWnd.BottomList", Info);
        }
    }
    AdjustPrice();
    AdjustCount();
    return;
}

function AdjustPrice()
{
    local string Adena;
    local int Count;
    local INT64 Price, addPrice64;
    local ItemInfo Info;

    Count = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("PrivateShopWnd.BottomList");
    Price = Int2Int64(0);
    addPrice64 = Int2Int64(0);

    while(Count > 0)
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", Count - 1, Info);
        addPrice64 = Int64Mul(Info.Price, Info.ItemNum);
        Price = Int64Add(Price, addPrice64);
        --Count;
    }
    // End:0xFB
    if((Price.nLeft < 0) || Price.nRight < 0)
    {
        Price = Int2Int64(0);
    }
    Adena = MakeCostStringInt64(Price);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.PriceText", Adena);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString("PrivateShopWnd.PriceText", ConvertNumToText(MakeCostStringInt64(Price)));
    return;
}

function AdjustCount()
{
    local int Num, maxNum;

    // End:0x9C
    if(m_Type == PT_SellList)
    {
        maxNum = m_sellMaxCount;
        Num = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("PrivateShopWnd.BottomList");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.BottomCountText", ((("(" $ string(Num)) $ "/") $ string(maxNum)) $ ")");        
    }
    else
    {
        // End:0x135
        if(m_Type == PT_BuyList)
        {
            maxNum = m_buyMaxCount;
            Num = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("PrivateShopWnd.BottomList");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PrivateShopWnd.BottomCountText", ((("(" $ string(Num)) $ "/") $ string(maxNum)) $ ")");
        }
    }
    return;
}

function AdjustWeight()
{
    local int Count, Weight;
    local ItemInfo Info;

    Class'NWindow.UIAPI_INVENWEIGHT'.static.ZeroWeight("PrivateShopWnd.InvenWeight");
    Count = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("PrivateShopWnd.BottomList");
    Weight = 0;

    while(Count > 0)
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", Count - 1, Info);
        Weight += (Info.Weight * Info.ItemNum);
        --Count;
    }
    Class'NWindow.UIAPI_INVENWEIGHT'.static.AddWeight("PrivateShopWnd.InvenWeight", Weight);
    return;
}

function HandleOKButton(bool bPriceCheck)
{
    local string param;
    local int ItemCount, itemIndex;
    local ItemInfo ItemInfo;

    ItemCount = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("PrivateShopWnd.BottomList");
    // End:0x192
    if(m_Type == PT_SellList)
    {
        // End:0x83
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("PrivateShopWnd.CheckBulk"))
        {
            ParamAdd(param, "bulk", "1");            
        }
        else
        {
            ParamAdd(param, "bulk", "0");
        }
        ParamAdd(param, "num", string(ItemCount));
        itemIndex = 0;

        while(itemIndex < ItemCount)
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", itemIndex, ItemInfo);
            ParamAdd(param, "serverID" $ string(itemIndex), string(ItemInfo.ServerID));
            ParamAdd(param, "count" $ string(itemIndex), string(ItemInfo.ItemNum));
            ParamAdd(param, "price" $ string(itemIndex), string(ItemInfo.Price));
            ++itemIndex;
        }
        SendPrivateShopList("sellList", param);        
    }
    else
    {
        // End:0x31B
        if(m_Type == PT_Buy)
        {
            ParamAdd(param, "merchantID", string(m_merchantID));
            ParamAdd(param, "num", string(ItemCount));
            itemIndex = 0;

            while(itemIndex < ItemCount)
            {
                Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", itemIndex, ItemInfo);
                // End:0x249
                if(bPriceCheck && !IsProperPrice(ItemInfo, ItemInfo.Price))
                {
                    break;
                }
                ParamAdd(param, "serverID" $ string(itemIndex), string(ItemInfo.ServerID));
                ParamAdd(param, "count" $ string(itemIndex), string(ItemInfo.ItemNum));
                ParamAdd(param, "price" $ string(itemIndex), string(ItemInfo.Price));
                ++itemIndex;
            }

            // End:0x308
            if(bPriceCheck && itemIndex < ItemCount)
            {
                DialogSetID(666);
                DialogShow(DIALOG_Warning, GetSystemMessage(569));
                return;                
            }
            else
            {
                SendPrivateShopList("buy", param);
            }            
        }
        else
        {
            // End:0x478
            if(m_Type == PT_BuyList)
            {
                ParamAdd(param, "num", string(ItemCount));
                itemIndex = 0;

                while(itemIndex < ItemCount)
                {
                    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", itemIndex, ItemInfo);
                    ParamAdd(param, "classID" $ string(itemIndex), string(ItemInfo.ClassID));
                    ParamAdd(param, "enchanted" $ string(itemIndex), string(ItemInfo.Enchanted));
                    ParamAdd(param, "damaged" $ string(itemIndex), string(ItemInfo.Damaged));
                    ParamAdd(param, "count" $ string(itemIndex), string(ItemInfo.ItemNum));
                    ParamAdd(param, "price" $ string(itemIndex), string(ItemInfo.Price));
                    ++itemIndex;
                }
                SendPrivateShopList("buyList", param);                
            }
            else
            {
                // End:0x67C
                if(m_Type == PT_Sell)
                {
                    ParamAdd(param, "merchantID", string(m_merchantID));
                    ParamAdd(param, "num", string(ItemCount));
                    itemIndex = 0;

                    while(itemIndex < ItemCount)
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("PrivateShopWnd.BottomList", itemIndex, ItemInfo);
                        // End:0x52F
                        if(bPriceCheck && !IsProperPrice(ItemInfo, ItemInfo.Price))
                        {
                            break;
                        }
                        ParamAdd(param, "serverID" $ string(itemIndex), string(ItemInfo.ServerID));
                        ParamAdd(param, "classID" $ string(itemIndex), string(ItemInfo.ClassID));
                        ParamAdd(param, "enchanted" $ string(itemIndex), string(ItemInfo.Enchanted));
                        ParamAdd(param, "damaged" $ string(itemIndex), string(ItemInfo.Damaged));
                        ParamAdd(param, "count" $ string(itemIndex), string(ItemInfo.ItemNum));
                        ParamAdd(param, "price" $ string(itemIndex), string(ItemInfo.Price));
                        ++itemIndex;
                    }

                    // End:0x66B
                    if(bPriceCheck && itemIndex < ItemCount)
                    {
                        DialogSetID(666);
                        DialogShow(DIALOG_Warning, GetSystemMessage(569));
                        return;                        
                    }
                    else
                    {
                        SendPrivateShopList("sell", param);
                    }
                }
            }
        }
    }
    HideWindow("PrivateShopWnd");
    Clear();
    return;
}

function HandleSetMaxCount(string param)
{
    ParseInt(param, "privateShopSell", m_sellMaxCount);
    ParseInt(param, "privateShopBuy", m_buyMaxCount);
    return;
}

function bool IsProperPrice(out ItemInfo Info, int Price)
{
    // End:0x46
    if((Info.DefaultPrice > 0) && (Price <= (Info.DefaultPrice / 5)) || Price >= (Info.DefaultPrice * 5))
    {
        return false;
    }
    return true;
}
