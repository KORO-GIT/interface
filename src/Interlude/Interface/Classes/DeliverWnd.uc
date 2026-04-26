class DeliverWnd extends UICommonAPI;

const DIALOG_TOP_TO_BOTTOM = 111;
const DIALOG_BOTTOM_TO_TOP = 222;

var int m_targetID;

function OnLoad()
{
    RegisterEvent(2160);
    RegisterEvent(2170);
    RegisterEvent(1710);
    return;
}

function Clear()
{
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("DeliverWnd.TopList");
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("DeliverWnd.BottomList");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("DeliverWnd.PriceText", "0");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString("DeliverWnd.PriceText", "");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("DeliverWnd.AdenaText", "0");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString("DeliverWnd.AdenaText", "");
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x1D
        case 2160:
            HandleOpenWindow(param);
            // End:0x4A
            break;
        // End:0x33
        case 2170:
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

    // End:0x4F
    if(ControlName == "UpButton")
    {
        Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetSelectedNum("DeliverWnd.BottomList");
        MoveItemBottomToTop(Index, 0);        
    }
    else
    {
        // End:0x9D
        if(ControlName == "DownButton")
        {
            Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetSelectedNum("DeliverWnd.TopList");
            MoveItemTopToBottom(Index, 0);            
        }
        else
        {
            // End:0xBA
            if(ControlName == "OKButton")
            {
                HandleOKButton();                
            }
            else
            {
                // End:0xEA
                if(ControlName == "CancelButton")
                {
                    Clear();
                    HideWindow("DeliverWnd");
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
        MoveItemTopToBottom(Index, 0);        
    }
    else
    {
        // End:0x44
        if(ControlName == "BottomList")
        {
            MoveItemBottomToTop(Index, 0);
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

    // End:0x89
    if((strID == "TopList") && Info.DragSrcName == "BottomList")
    {
        Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("DeliverWnd.BottomList", Info.ClassID);
        // End:0x86
        if(Index >= 0)
        {
            MoveItemBottomToTop(Index, Info.AllItemCount);
        }        
    }
    else
    {
        // End:0x10C
        if((strID == "BottomList") && Info.DragSrcName == "TopList")
        {
            Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("DeliverWnd.TopList", Info.ClassID);
            // End:0x10C
            if(Index >= 0)
            {
                MoveItemTopToBottom(Index, Info.AllItemCount);
            }
        }
    }
    return;
}

function MoveItemTopToBottom(int Index, int AllItemCount)
{
    local ItemInfo Info;

    // End:0x12B
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("DeliverWnd.TopList", Index, Info))
    {
        // End:0xB9
        if(IsStackableItem(Info.ConsumeType))
        {
            // End:0x66
            if(AllItemCount > 0)
            {
                ItemTopToBottom(Info.ClassID, AllItemCount);                
            }
            else
            {
                DialogSetID(111);
                DialogSetReservedInt(Info.ClassID);
                DialogSetParamInt(Info.ItemNum);
                DialogSetDefaultOK();
                DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), Info.Name, ""));
            }            
        }
        else
        {
            Info.ItemNum = 1;
            Info.bShowCount = false;
            Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("DeliverWnd.BottomList", Info);
            Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("DeliverWnd.TopList", Index);
            AdjustPrice();
        }
    }
    return;
}

function MoveItemBottomToTop(int Index, int AllItemCount)
{
    local ItemInfo Info;

    // End:0x115
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("DeliverWnd.BottomList", Index, Info))
    {
        // End:0xBC
        if(IsStackableItem(Info.ConsumeType))
        {
            // End:0x69
            if(AllItemCount > 0)
            {
                ItemBottomToTop(Info.ClassID, AllItemCount);                
            }
            else
            {
                DialogSetID(222);
                DialogSetReservedInt(Info.ClassID);
                DialogSetParamInt(Info.ItemNum);
                DialogSetDefaultOK();
                DialogShow(DIALOG_NumberPad, MakeFullSystemMsg(GetSystemMessage(72), Info.Name, ""));
            }            
        }
        else
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("DeliverWnd.BottomList", Index);
            Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("DeliverWnd.TopList", Info);
            AdjustPrice();
        }
    }
    return;
}

function HandleDialogOK()
{
    local int Id, Num, ClassID;

    // End:0x70
    if(DialogIsMine())
    {
        Id = DialogGetID();
        Num = int(DialogGetString());
        ClassID = DialogGetReservedInt();
        // End:0x4E
        if(Id == 111)
        {
            ItemTopToBottom(ClassID, Num);            
        }
        else
        {
            // End:0x6A
            if(Id == 222)
            {
                ItemBottomToTop(ClassID, Num);
            }
        }
        AdjustPrice();
    }
    return;
}

function ItemTopToBottom(int ClassID, int Num)
{
    local int Index, topIndex;
    local ItemInfo Info, topInfo;

    topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("DeliverWnd.TopList", ClassID);
    // End:0x1E2
    if(topIndex >= 0)
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("DeliverWnd.TopList", topIndex, topInfo);
        Num = Min(Num, topInfo.ItemNum);
        Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("DeliverWnd.BottomList", ClassID);
        // End:0x116
        if(Index >= 0)
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("DeliverWnd.BottomList", Index, Info);
            Info.ItemNum += Num;
            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("DeliverWnd.BottomList", Index, Info);            
        }
        else
        {
            Info = topInfo;
            Info.ItemNum = Num;
            Info.bShowCount = false;
            Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("DeliverWnd.BottomList", Info);
        }
        topInfo.ItemNum -= Num;
        // End:0x1B5
        if(topInfo.ItemNum <= 0)
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("DeliverWnd.TopList", topIndex);            
        }
        else
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("DeliverWnd.TopList", topIndex, topInfo);
        }
    }
    return;
}

function ItemBottomToTop(int ClassID, int Num)
{
    local int Index, topIndex;
    local ItemInfo Info, topInfo;

    Index = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("DeliverWnd.BottomList", ClassID);
    // End:0x1DF
    if(Index >= 0)
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("DeliverWnd.BottomList", Index, Info);
        Num = Min(Num, Info.ItemNum);
        Info.ItemNum -= Num;
        // End:0xC0
        if(Info.ItemNum > 0)
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("DeliverWnd.BottomList", Index, Info);            
        }
        else
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem("DeliverWnd.BottomList", Index);
        }
        topIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("DeliverWnd.TopList", ClassID);
        // End:0x1A7
        if((topIndex >= 0) && IsStackableItem(Info.ConsumeType))
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("DeliverWnd.TopList", topIndex, topInfo);
            topInfo.ItemNum += Num;
            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("DeliverWnd.TopList", topIndex, topInfo);            
        }
        else
        {
            Info.ItemNum = Num;
            Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("DeliverWnd.TopList", Info);
        }
    }
    return;
}

function HandleOpenWindow(string param)
{
    local int Adena;
    local string adenaString;
    local WindowHandle m_inventoryWnd;

    m_inventoryWnd = GetHandle("InventoryWnd");
    Clear();
    ParseInt(param, "adena", Adena);
    ParseInt(param, "destinationID", m_targetID);
    adenaString = MakeCostString(string(Adena));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("DeliverWnd.AdenaText", adenaString);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString("DeliverWnd.AdenaText", ConvertNumToText(string(Adena)));
    // End:0xE6
    if(m_inventoryWnd.IsShowWindow())
    {
        m_inventoryWnd.HideWindow();
    }
    ShowWindow("DeliverWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("DeliverWnd");
    return;
}

function HandleAddItem(string param)
{
    local ItemInfo Info;

    ParamToItemInfo(param, Info);
    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("DeliverWnd.TopList", Info);
    return;
}

function AdjustPrice()
{
    local string Adena;
    local int Count;

    Count = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("DeliverWnd.BottomList");
    Adena = MakeCostString(string(Count * 1000));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("DeliverWnd.PriceText", Adena);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString("DeliverWnd.PriceText", ConvertNumToText(string(Count * 1000)));
    return;
}

function HandleOKButton()
{
    local string param;
    local int Count, Index;
    local ItemInfo ItemInfo;

    Count = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("DeliverWnd.BottomList");
    ParamAdd(param, "targetID", string(m_targetID));
    ParamAdd(param, "num", string(Count));
    Index = 0;

    while(Index < Count)
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("DeliverWnd.BottomList", Index, ItemInfo);
        ParamAdd(param, "dbID" $ string(Index), string(ItemInfo.Reserved));
        ParamAdd(param, "count" $ string(Index), string(ItemInfo.ItemNum));
        ++Index;
    }
    RequestPackageSend(param);
    HideWindow("DeliverWnd");
    return;
}
