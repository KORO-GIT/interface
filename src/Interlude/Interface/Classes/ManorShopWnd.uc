class ManorShopWnd extends ShopWnd;

function OnLoad()
{
    RegisterEvent(2680);
    RegisterEvent(2690);
    RegisterEvent(1710);
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x1D
        case 2680:
            HandleOpenWindow(param);
            // End:0x4A
            break;
        // End:0x33
        case 2690:
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

function MoveItemTopToBottom(int Index, bool bAllItem)
{
    local int bottomIndex;
    local ItemInfo Info, bottomInfo;

    // End:0x415
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".TopList", Index, Info))
    {
        // End:0xE2
        if((!bAllItem && IsStackableItem(Info.ConsumeType)) && Info.ItemNum != 1)
        {
            DialogSetID(111);
            DialogSetReservedInt(Info.ClassID);
            // End:0xAC
            if((int(m_shopType) == 2) || int(m_shopType) == 1)
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
            // End:0x215
            if(int(m_shopType) == 2)
            {
                bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".BottomList", Info.ClassID);
                // End:0x1C5
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
                // End:0x37E
                if(int(m_shopType) == 1)
                {
                    bottomIndex = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID(m_WindowName $ ".BottomList", Info.ClassID);
                    // End:0x2EB
                    if((bottomIndex >= 0) && IsStackableItem(Info.ConsumeType))
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem(m_WindowName $ ".BottomList", bottomIndex, bottomInfo);
                        bottomInfo.ItemNum += Info.ItemNum;
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem(m_WindowName $ ".BottomList", bottomIndex, bottomInfo);                        
                    }
                    else
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(m_WindowName $ ".BottomList", Info);
                        Class'NWindow.UIAPI_INVENWEIGHT'.static.AddWeight(m_WindowName $ ".InvenWeight", Info.Weight * Info.ItemNum);
                    }
                    // End:0x37B
                    if(bAllItem)
                    {
                        Class'NWindow.UIAPI_ITEMWINDOW'.static.DeleteItem(m_WindowName $ ".TopList", Index);
                    }                    
                }
                else
                {
                    // End:0x3F5
                    if(int(m_shopType) == 3)
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

function HandleOpenWindow(string param)
{
    super.HandleOpenWindow(param);
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle(m_WindowName, 738);
    Class'NWindow.UIAPI_WINDOW'.static.SetTooltipType(m_WindowName $ ".TopList", "InventoryPrice1HideEnchant");
    return;
}

function HandleAddItem(string param)
{
    local ItemInfo Info;

    ParamToItemInfo(param, Info);
    Info.bShowCount = false;
    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem(m_WindowName $ ".TopList", Info);
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
    if(int(m_shopType) == 1)
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
        RequestBuySeed(param);        
    }
    else
    {
        // End:0x37F
        if(int(m_shopType) == 2)
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
            RequestProcureCrop(param);            
        }
        else
        {
            // End:0x3B8
            if(int(m_shopType) == 3)
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
    m_WindowName="ManorShopWnd"
}
