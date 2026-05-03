class PartyMatchOutWaitListWnd extends PartyMatchWndCommon;

var int entire_page;
var int current_page;
var int MinLevel;
var int MaxLevel;

function bool HasWaitListRecordData(LVDataRecord Record)
{
    return Record.LVDataList.Length > 0;
}

function int ClampWaitListPage(int Page)
{
    if(Page < 1)
    {
        return 1;
    }
    if(Page > entire_page)
    {
        return entire_page;
    }
    return Page;
}

function OnLoad()
{
    RegisterEvent(1610);
    RegisterEvent(1620);
    entire_page = 1;
    current_page = 1;
    Class'NWindow.UIAPI_EDITBOX'.static.SetString("PartyMatchOutWaitListWnd.MinLevel", "1");
    Class'NWindow.UIAPI_EDITBOX'.static.SetString("PartyMatchOutWaitListWnd.MaxLevel", "80");
    return;
}

function OnShow()
{
    current_page = 1;
    return;
}

function OnEvent(int a_EventID, string param)
{
    switch(a_EventID)
    {
        // End:0x1D
        case 1610:
            HandlePartyMatchWaitListStart(param);
            // End:0x36
            break;
        // End:0x33
        case 1620:
            HandlePartyMatchWaitList(param);
            // End:0x36
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandlePartyMatchWaitListStart(string param)
{
    local int AllCount, Count;
    local string totalPages, currentPage, page_info;

    ParseInt(param, "AllCount", AllCount);
    ParseInt(param, "Count", Count);
    if(AllCount < 0)
    {
        AllCount = 0;
    }
    entire_page = (AllCount + 63) / 64;
    if(entire_page < 1)
    {
        entire_page = 1;
    }
    current_page = ClampWaitListPage(current_page);
    totalPages = string(entire_page);
    currentPage = string(current_page);
    page_info = (currentPage $ "/") $ totalPages;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("PartyMatchOutWaitListWnd.MemberCount", page_info);
    Class'NWindow.UIAPI_LISTCTRL'.static.DeleteAllItem("PartyMatchOutWaitListWnd.WaitListCtrl");
    CheckButtonAlive();
    return;
}

function HandlePartyMatchWaitList(string param)
{
    local string Name;
    local int ClassID, Level;
    local LVDataRecord Record;

    ParseString(param, "Name", Name);
    ParseInt(param, "ClassID", ClassID);
    ParseInt(param, "Level", Level);
    Record.LVDataList.Length = 3;
    Record.LVDataList[0].szData = Name;
    Record.LVDataList[1].szTexture = GetClassIconName(ClassID);
    Record.LVDataList[1].nTextureWidth = 11;
    Record.LVDataList[1].nTextureHeight = 11;
    Record.LVDataList[1].szData = string(ClassID);
    Record.LVDataList[2].szData = GetAmbiguousLevelString(Level, false);
    Record.nReserved1 = Level;
    Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord("PartyMatchOutWaitListWnd.WaitListCtrl", Record);
    return;
}

function OnClickButton(string a_strButtonName)
{
    switch(a_strButtonName)
    {
        // End:0x22
        case "RefreshButton":
            OnRefreshButtonClick();
            // End:0xBC
            break;
        // End:0x3D
        case "WhisperButton":
            OnWhisperButtonClick();
            // End:0xBC
            break;
        // End:0x5C
        case "PartyInviteButton":
            OnInviteButtonClick();
            // End:0xBC
            break;
        // End:0x75
        case "CloseButton":
            OnCloseButtonClick();
            // End:0xBC
            break;
        // End:0x8D
        case "btn_Search":
            OnSearchBtnClick();
            // End:0xBC
            break;
        // End:0xA3
        case "prev_btn":
            OnPrevbuttonClick();
            // End:0xBC
            break;
        // End:0xB9
        case "next_btn":
            OnNextbuttonClick();
            // End:0xBC
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnRefreshButtonClick()
{
    MinLevel = int(Class'NWindow.UIAPI_EDITBOX'.static.GetString("PartyMatchOutWaitListWnd.MinLevel"));
    MaxLevel = int(Class'NWindow.UIAPI_EDITBOX'.static.GetString("PartyMatchOutWaitListWnd.MaxLevel"));
    current_page = ClampWaitListPage(current_page);
    Class'NWindow.PartyMatchAPI'.static.RequestPartyMatchWaitList(current_page, MinLevel, MaxLevel, 1);
    return;
}

function OnNextbuttonClick()
{
    current_page = ClampWaitListPage(current_page + 1);
    Class'NWindow.PartyMatchAPI'.static.RequestPartyMatchWaitList(current_page, MinLevel, MaxLevel, 1);
    return;
}

function OnPrevbuttonClick()
{
    current_page = ClampWaitListPage(current_page - 1);
    Class'NWindow.PartyMatchAPI'.static.RequestPartyMatchWaitList(current_page, MinLevel, MaxLevel, 1);
    return;
}

function OnSearchBtnClick()
{
    MinLevel = int(Class'NWindow.UIAPI_EDITBOX'.static.GetString("PartyMatchOutWaitListWnd.MinLevel"));
    MaxLevel = int(Class'NWindow.UIAPI_EDITBOX'.static.GetString("PartyMatchOutWaitListWnd.MaxLevel"));
    current_page = 1;
    Class'NWindow.PartyMatchAPI'.static.RequestPartyMatchWaitList(current_page, MinLevel, MaxLevel, 1);
    return;
}

function OnWhisperButtonClick()
{
    local LVDataRecord Record;
    local string szData1;

    Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedRecord("PartyMatchOutWaitListWnd.WaitListCtrl");
    if(!HasWaitListRecordData(Record))
    {
        return;
    }
    szData1 = Record.LVDataList[0].szData;
    // End:0x74
    if(szData1 != "")
    {
        SetChatMessage(("\"" $ szData1) $ " ");
    }
    return;
}

function OnInviteButtonClick()
{
    local LVDataRecord Record;

    Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedRecord("PartyMatchOutWaitListWnd.WaitListCtrl");
    if(!HasWaitListRecordData(Record))
    {
        return;
    }
    MakeRoomFirst(Record.nReserved1, Record.LVDataList[0].szData);
    return;
}

function OnCloseButtonClick()
{
    local PartyMatchWnd script;

    script = PartyMatchWnd(GetScript("PartyMatchWnd"));
    // End:0x4A
    if(script != none)
    {
        script.SetWaitListWnd(false);
        script.ShowHideWaitListWnd();
    }
    return;
}

function OnDBClickListCtrlRecord(string a_ListCtrlName)
{
    local LVDataRecord Record;

    // End:0x1A
    if(a_ListCtrlName != "WaitListCtrl")
    {
        return;
    }
    Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedRecord("PartyMatchOutWaitListWnd.WaitListCtrl");
    if(!HasWaitListRecordData(Record))
    {
        return;
    }
    SetChatMessage(("\"" $ Record.LVDataList[0].szData) $ " ");
    return;
}

function MakeRoomFirst(int TargetLevel, string InviteTargetName)
{
    local PartyMatchMakeRoomWnd script;
    local UserInfo PlayerInfo;
    local int LevelMin, LevelMax;

    script = PartyMatchMakeRoomWnd(GetScript("PartyMatchMakeRoomWnd"));
    // End:0x163
    if(script != none)
    {
        script.InviteState = 1;
        script.InvitedName = InviteTargetName;
        script.SetRoomNumber(0);
        script.SetTitle(GetSystemMessage(1398));
        script.SetMaxPartyMemberCount(12);
        // End:0x163
        if(GetPlayerInfo(PlayerInfo))
        {
            // End:0xD2
            if(TargetLevel < PlayerInfo.nLevel)
            {
                LevelMin = TargetLevel;
                LevelMax = PlayerInfo.nLevel;                
            }
            else
            {
                LevelMin = PlayerInfo.nLevel;
                LevelMax = TargetLevel;
            }
            // End:0x117
            if((LevelMin - 5) > 0)
            {
                script.SetMinLevel(LevelMin - 5);                
            }
            else
            {
                script.SetMinLevel(1);
            }
            // End:0x152
            if((LevelMax + 5) <= 80)
            {
                script.SetMaxLevel(LevelMax + 5);                
            }
            else
            {
                script.SetMaxLevel(80);
            }
        }
    }
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("PartyMatchMakeRoomWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("PartyMatchMakeRoomWnd");
    return;
}

function CheckButtonAlive()
{
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("PartyMatchOutWaitListWnd.prev_btn");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("PartyMatchOutWaitListWnd.next_btn");
    // End:0xA1
    if(current_page == 1)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("PartyMatchOutWaitListWnd.prev_btn");
    }
    // End:0xE2
    if(current_page == entire_page)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("PartyMatchOutWaitListWnd.next_btn");
    }
    return;
}
