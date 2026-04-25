class GMInventoryWnd extends InventoryWnd;

struct GMHennaInfo
{
    var int HennaID;
    var int IsActive;
};

var bool bShow;
var int m_ObservingUserInvenLimit;
var int m_Adena;
var bool m_HasLEar;
var bool m_HasLFinger;
var array<GMHennaInfo> m_HennaInfoList;

function OnLoad()
{
    local WindowHandle hCrystallizeButton, hTrashButton, hFastDeleteButton, hInvenWeight;

    RegisterEvent(2401);
    RegisterEvent(2402);
    RegisterEvent(2403);
    RegisterEvent(2404);
    function1();
    bShow = false;
    m_hOwnerWnd.SetWindowTitle(" ");
    hCrystallizeButton = GetHandle("CrystallizeButton");
    hTrashButton = GetHandle("TrashButton");
    hFastDeleteButton = GetHandle("FastDelete");
    hInvenWeight = GetHandle("InvenWeight");
    hCrystallizeButton.HideWindow();
    hTrashButton.HideWindow();
    hFastDeleteButton.HideWindow();
    hInvenWeight.HideWindow();
    return;
}

function OnShow()
{
    SetAdenaText();
    SetFocus();
    return;
}

function ShowInventory(string a_Param)
{
    // End:0x0E
    if(a_Param == "")
    {
        return;
    }
    // End:0x37
    if(bShow)
    {
        function7();
        m_hOwnerWnd.HideWindow();
        bShow = false;        
    }
    else
    {
        Class'NWindow.GMAPI'.static.RequestGMCommand(GMCOMMAND_InventoryInfo, a_Param);
        bShow = true;
    }
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x1D
        case 2401:
            HandleGMObservingInventoryAddItem(a_Param);
            // End:0x62
            break;
        // End:0x33
        case 2402:
            HandleGMObservingInventoryClear(a_Param);
            // End:0x62
            break;
        // End:0x49
        case 2403:
            HandleGMAddHennaInfo(a_Param);
            // End:0x62
            break;
        // End:0x5F
        case 2404:
            HandleGMUpdateHennaInfo(a_Param);
            // End:0x62
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleGMObservingInventoryAddItem(string a_Param)
{
    HandleAddItem(a_Param);
    function7();
    return;
}

function HandleAddItem(string param)
{
    local ItemInfo Info;

    ParamToItemInfo(param, Info);
    // End:0x2C
    if(function15(Info))
    {
        EquipItemUpdate(Info);        
    }
    else
    {
        // End:0x51
        if(function16(Info))
        {
            item_2.AddItem(Info);            
        }
        else
        {
            // End:0x72
            if(Info.ClassID == 57)
            {
                SetAdena(Info.ItemNum);
            }
            item_1.AddItem(Info);
        }
    }
    return;
}

function SetAdena(int a_Adena)
{
    m_Adena = a_Adena;
    SetAdenaText();
    return;
}

function SetAdenaText()
{
    local string adenaString;

    adenaString = MakeCostString(string(m_Adena));
    text_1.SetText(adenaString);
    text_1.SetTooltipString(ConvertNumToText(string(m_Adena)));
    return;
}

function int GetMyInventoryLimit()
{
    return m_ObservingUserInvenLimit;
}

function HandleGMObservingInventoryClear(string a_Param)
{
    function17();
    ParseInt(a_Param, "InvenLimit", m_ObservingUserInvenLimit);
    m_hOwnerWnd.ShowWindow();
    m_hOwnerWnd.SetFocus();
    return;
}

function HandleGMAddHennaInfo(string a_Param)
{
    m_HennaInfoList.Length = m_HennaInfoList.Length + 1;
    ParseInt(a_Param, "ID", m_HennaInfoList[m_HennaInfoList.Length - 1].HennaID);
    ParseInt(a_Param, "bActive", m_HennaInfoList[m_HennaInfoList.Length - 1].IsActive);
    UpdateHennaInfo();
    return;
}

function HandleGMUpdateHennaInfo(string a_Param)
{
    m_HennaInfoList.Length = 0;
    return;
}

function OnDropItem(string strTarget, ItemInfo Info, int X, int Y)
{
    return;
}

function OnDropItemSource(string strTarget, ItemInfo Info)
{
    return;
}

function OnDBClickItem(string strID, int Index)
{
    return;
}

function OnRClickItem(string strID, int Index)
{
    return;
}

function EquipItemUpdate(ItemInfo a_Info)
{
    local ItemWindowHandle hItemWnd;

    function24(a_Info);
    switch(a_Info.SlotBitType)
    {
        // End:0x1C
        case 2:
        // End:0x21
        case 4:
        // End:0x60
        case 6:
            // End:0x4F
            if(0 == item_3[8].GetItemNum())
            {
                hItemWnd = item_3[8];                
            }
            else
            {
                hItemWnd = item_3[9];
            }
            // End:0xAC
            break;
        // End:0x65
        case 16:
        // End:0x6A
        case 32:
        // End:0xA9
        case 48:
            // End:0x98
            if(0 == item_3[13].GetItemNum())
            {
                hItemWnd = item_3[13];                
            }
            else
            {
                hItemWnd = item_3[14];
            }
            // End:0xAC
            break;
        // End:0xFFFF
        default:
            break;
    }
    // End:0xDA
    if(none != hItemWnd)
    {
        hItemWnd.Clear();
        hItemWnd.AddItem(a_Info);
    }
    return;
}

function int IsLOrREar(int a_ServerID)
{
    return 0;
}

function int IsLOrRFinger(int a_ServerID)
{
    return 0;
}

function UpdateHennaInfo()
{
    local int i;
    local ItemInfo HennaItemInfo;

    item_4.Clear();
    item_4.SetRow(m_HennaInfoList.Length);
    i = 0;

    while(i < m_HennaInfoList.Length)
    {
        // End:0x6C
        if(!Class'NWindow.UIDATA_HENNA'.static.GetItemName(m_HennaInfoList[i].HennaID, HennaItemInfo.Name))
        {
            break;
        }
        // End:0x9D
        if(!Class'NWindow.UIDATA_HENNA'.static.GetDescription(m_HennaInfoList[i].HennaID, HennaItemInfo.Description))
        {
            break;
        }
        // End:0xCE
        if(!Class'NWindow.UIDATA_HENNA'.static.GetIconTex(m_HennaInfoList[i].HennaID, HennaItemInfo.IconName))
        {
            break;
        }
        // End:0xF4
        if(0 == m_HennaInfoList[i].IsActive)
        {
            HennaItemInfo.bDisabled = true;            
        }
        else
        {
            HennaItemInfo.bDisabled = false;
        }
        item_4.AddItem(HennaItemInfo);
        ++i;
    }

    return;
}

function OnClickButton(string Name)
{
    switch(Name)
    {
        // End:0x36
        case "BtnClose":
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("GMInventoryWnd");
            // End:0x39
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function SetFocus()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.ItemCount");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_Underwear");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_Head");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_Hair");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_Hair2");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_Neck");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_RHand");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_Chest");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_LHand");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_REar");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_LEar");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_Gloves");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_Legs");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_Feet");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_RFinger");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.EquipItem_LFinger");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.HennaItem");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.InventoryItem");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.QuestItem");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.InventoryTab");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.CrystallizeButton");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.TrashButton");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.AdenaText");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.AdenaIcon");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("GMInventoryWnd.InvenWeight");
    return;
}

defaultproperties
{
    string_1="GMInventoryWnd"
}
