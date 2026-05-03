class UnionWnd extends UICommonAPI;

var bool m_bChOpened;
var WindowHandle Me;
var WindowHandle PartyMemberWnd;
var TextBoxHandle txtOwner;
var TextBoxHandle txtRoutingType;
var TextBoxHandle txtCountInfo;
var ButtonHandle banBtn;
var ButtonHandle quitBtn;
var ListCtrlHandle lstParty;
var string m_UserName;
var int m_PartyNum;
var int m_PartyMemberNum;
var int m_SearchedMasterID;

function bool HasPartyRecordData(LVDataRecord Record, int MinLength)
{
    return Record.LVDataList.Length >= MinLength;
}

function int ClampNonNegativeCount(int Count)
{
    if(Count < 0)
    {
        return 0;
    }
    return Count;
}

function OnLoad()
{
    RegisterEvent(1360);
    RegisterEvent(1370);
    RegisterEvent(1380);
    RegisterEvent(1390);
    RegisterEvent(1395);
    RegisterEvent(1400);
    m_bChOpened = false;
    m_PartyNum = 0;
    m_PartyMemberNum = 0;
    m_SearchedMasterID = 0;
    Me = GetHandle("UnionWnd");
    PartyMemberWnd = GetHandle("UnionDetailWnd");
    txtOwner = TextBoxHandle(GetHandle("UnionWnd.txtOwner"));
    txtRoutingType = TextBoxHandle(GetHandle("UnionWnd.txtRoutingType"));
    txtCountInfo = TextBoxHandle(GetHandle("UnionWnd.txtCountInfo"));
    lstParty = ListCtrlHandle(GetHandle("UnionWnd.lstParty"));
    banBtn = ButtonHandle(GetHandle("UnionWnd.btnBan"));
    quitBtn = ButtonHandle(GetHandle("UnionWnd.btnOut"));
    return;
}

function OnShow()
{
    local UserInfo a_UserInfo;

    GetPlayerInfo(a_UserInfo);
    m_UserName = a_UserInfo.Name;
    PartyMemberWnd.HideWindow();
    return;
}

function OnEnterState(name a_PreStateName)
{
    // End:0x1B
    if(m_bChOpened)
    {
        Me.ShowWindow();        
    }
    else
    {
        Me.HideWindow();
    }
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x18
    if(Event_ID == 1360)
    {
        HandleCommandChannelStart();        
    }
    else
    {
        // End:0x30
        if(Event_ID == 1370)
        {
            HandleCommandChannelEnd();            
        }
        else
        {
            // End:0x4D
            if(Event_ID == 1380)
            {
                HandleCommandChannelInfo(param);                
            }
            else
            {
                // End:0x6A
                if(Event_ID == 1390)
                {
                    HandleCommandChannelPartyList(param);                    
                }
                else
                {
                    // End:0x87
                    if(Event_ID == 1395)
                    {
                        HandleCommandChannelPartyUpdate(param);                        
                    }
                    else
                    {
                        // End:0xA1
                        if(Event_ID == 1400)
                        {
                            HandleCommandChannelRoutingType(param);
                        }
                    }
                }
            }
        }
    }
    return;
}

function OnDBClickListCtrlRecord(string strID)
{
    // End:0x1B
    if(strID == "lstParty")
    {
        RequestPartyMember(true);
    }
    return;
}

function Clear()
{
    MemberClear();
    txtOwner.SetText("");
    txtRoutingType.SetText(GetSystemString(1383));
    txtCountInfo.SetText("");
    return;
}

function MemberClear()
{
    lstParty.DeleteAllItem();
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1F
        case "btnRefresh":
            OnRefreshClick();
            // End:0x65
            break;
        // End:0x33
        case "btnBan":
            OnBanClick();
            // End:0x65
            break;
        // End:0x47
        case "btnOut":
            OnOutClick();
            // End:0x65
            break;
        // End:0x62
        case "btnMemberInfo":
            OnMemberInfoClick();
            // End:0x65
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnRefreshClick()
{
    RequestNewInfo();
    return;
}

function RequestNewInfo()
{
    Class'NWindow.CommandChannelAPI'.static.RequestCommandChannelInfo();
    return;
}

function OnBanClick()
{
    local int idx;
    local LVDataRecord Record;
    local string PartyMasterName;

    idx = lstParty.GetSelectedIndex();
    // End:0x76
    if(idx > -1)
    {
        Record = lstParty.GetRecord(idx);
        if(!HasPartyRecordData(Record, 1))
        {
            return;
        }
        PartyMasterName = Record.LVDataList[0].szData;
        // End:0x76
        if(Len(PartyMasterName) > 0)
        {
            Class'NWindow.CommandChannelAPI'.static.RequestCommandChannelBanParty(PartyMasterName);
        }
    }
    return;
}

function OnOutClick()
{
    Class'NWindow.CommandChannelAPI'.static.RequestCommandChannelWithdraw();
    return;
}

function OnMemberInfoClick()
{
    // End:0x24
    if(PartyMemberWnd.IsShowWindow())
    {
        PartyMemberWnd.HideWindow();        
    }
    else
    {
        RequestPartyMember(true);
    }
    return;
}

function RequestPartyMember(bool bShowWindow)
{
    local LVDataRecord Record;
    local string PartyMasterName;
    local int MasterID;
    local UnionDetailWnd script;

    script = UnionDetailWnd(GetScript("UnionDetailWnd"));
    if(script == none)
    {
        return;
    }
    m_SearchedMasterID = 0;
    Record = lstParty.GetSelectedRecord();
    if(!HasPartyRecordData(Record, 1))
    {
        return;
    }
    PartyMasterName = Record.LVDataList[0].szData;
    MasterID = Record.nReserved1;
    // End:0xE2
    if((Len(PartyMasterName) > 0) && MasterID > 0)
    {
        // End:0xAA
        if(bShowWindow)
        {
            // End:0xAA
            if(!PartyMemberWnd.IsShowWindow())
            {
                PartyMemberWnd.ShowWindow();
            }
        }
        m_SearchedMasterID = MasterID;
        script.SetMasterInfo(PartyMasterName, MasterID);
        Class'NWindow.CommandChannelAPI'.static.RequestCommandChannelPartyMembersInfo(MasterID);
    }
    return;
}

function HandleCommandChannelStart()
{
    Me.ShowWindow();
    Me.SetFocus();
    m_bChOpened = true;
    RequestNewInfo();
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("UnionWnd.btnBan");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("UnionWnd.btnOut");
    return;
}

function HandleCommandChannelEnd()
{
    Me.HideWindow();
    Clear();
    m_bChOpened = false;
    return;
}

function HandleCommandChannelInfo(string param)
{
    local string OwnerName;
    local int RoutingType, PartyNum, PartyMemberNum;

    MemberClear();
    ParseString(param, "OwnerName", OwnerName);
    ParseInt(param, "RoutingType", RoutingType);
    ParseInt(param, "PartyNum", PartyNum);
    ParseInt(param, "PartyMemberNum", PartyMemberNum);
    m_PartyNum = ClampNonNegativeCount(PartyNum);
    m_PartyMemberNum = ClampNonNegativeCount(PartyMemberNum);
    txtOwner.SetText(OwnerName);
    UpdateRoutingType(RoutingType);
    UpdateCountInfo();
    // End:0xE2
    if(OwnerName == m_UserName)
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("UnionWnd.btnBan");
    }
    return;
}

function HandleCommandChannelPartyList(string param)
{
    local LVDataRecord Record;
    local string MasterName;
    local int MasterID, PartyNum, TotalCount;

    ParseString(param, "MasterName", MasterName);
    ParseInt(param, "MasterID", MasterID);
    ParseInt(param, "PartyNum", PartyNum);
    if((MasterID < 1) || Len(MasterName) < 1)
    {
        return;
    }
    PartyNum = ClampNonNegativeCount(PartyNum);
    Record.LVDataList.Length = 2;
    Record.nReserved1 = MasterID;
    Record.LVDataList[0].szData = MasterName;
    Record.LVDataList[1].szData = string(PartyNum);
    lstParty.InsertRecord(Record);
    // End:0x11F
    if((m_SearchedMasterID > 0) && m_SearchedMasterID == MasterID)
    {
        // End:0x11F
        if(PartyMemberWnd.IsShowWindow())
        {
            TotalCount = lstParty.GetRecordCount();
            // End:0x118
            if(TotalCount > 0)
            {
                lstParty.SetSelectedIndex(TotalCount - 1, false);
            }
            RequestPartyMember(false);
        }
    }
    // End:0x14E
    if(MasterName == m_UserName)
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("UnionWnd.btnOut");
    }
    return;
}

function HandleCommandChannelPartyUpdate(string param)
{
    local LVDataRecord Record;
    local int SearchIdx;
    local string MasterName;
    local int MasterID, MemberCount, Type;
    local UnionDetailWnd script;

    ParseString(param, "MasterName", MasterName);
    ParseInt(param, "MasterID", MasterID);
    ParseInt(param, "MemberCount", MemberCount);
    ParseInt(param, "Type", Type);
    MemberCount = ClampNonNegativeCount(MemberCount);
    // End:0x76
    if(MasterID < 1)
    {
        return;
    }
    switch(Type)
    {
        // End:0x16E
        case 0:
            SearchIdx = FindMasterID(MasterID);
            // End:0x16B
            if(SearchIdx > -1)
            {
                Record = lstParty.GetRecord(SearchIdx);
                if(!HasPartyRecordData(Record, 2))
                {
                    return;
                }
                MemberCount = ClampNonNegativeCount(int(Record.LVDataList[1].szData));
                lstParty.DeleteRecord(SearchIdx);
                m_PartyNum = ClampNonNegativeCount(m_PartyNum - 1);
                m_PartyMemberNum = m_PartyMemberNum - MemberCount;
                m_PartyMemberNum = ClampNonNegativeCount(m_PartyMemberNum);
                // End:0x16B
                if(PartyMemberWnd.IsShowWindow())
                {
                    script = UnionDetailWnd(GetScript("UnionDetailWnd"));
                    // End:0x16B
                    if((script != none) && MasterID == script.GetMasterID())
                    {
                        script.Clear();
                        PartyMemberWnd.HideWindow();
                    }
                }
            }
            // End:0x1F3
            break;
        // End:0x1F0
        case 1:
            Record.LVDataList.Length = 2;
            Record.nReserved1 = MasterID;
            Record.LVDataList[0].szData = MasterName;
            Record.LVDataList[1].szData = string(MemberCount);
            lstParty.InsertRecord(Record);
            m_PartyNum++;
            m_PartyMemberNum = m_PartyMemberNum + MemberCount;
            // End:0x1F3
            break;
        // End:0xFFFF
        default:
            break;
    }
    UpdateCountInfo();
    // End:0x228
    if(MasterName == m_UserName)
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("UnionWnd.btnOut");
    }
    return;
}

function HandleCommandChannelRoutingType(string param)
{
    local int RoutingType;

    ParseInt(param, "RoutingType", RoutingType);
    UpdateRoutingType(RoutingType);
    return;
}

function UpdateRoutingType(int Type)
{
    // End:0x28
    if(Type == 0)
    {
        txtRoutingType.SetText(GetSystemString(1383));        
    }
    else
    {
        // End:0x4D
        if(Type == 1)
        {
            txtRoutingType.SetText(GetSystemString(1384));
        }
    }
    return;
}

function int FindMasterID(int MasterID)
{
    local int idx;
    local LVDataRecord Record;
    local int SearchIdx;

    SearchIdx = -1;
    idx = 0;

    while(idx < lstParty.GetRecordCount())
    {
        Record = lstParty.GetRecord(idx);
        // End:0x67
        if(Record.nReserved1 == MasterID)
        {
            SearchIdx = idx;
            break;
        }
        idx++;
    }

    return SearchIdx;
}

function UpdateCountInfo()
{
    txtCountInfo.SetText((((string(m_PartyNum) $ GetSystemString(440)) $ " / ") $ string(m_PartyMemberNum)) $ GetSystemString(1013));
    return;
}

function UpdatePartyMemberCount(int MasterID, int MemberCount)
{
    local int idx;
    local LVDataRecord Record;

    idx = FindMasterID(MasterID);
    // End:0x9E
    if(idx > -1)
    {
        Record = lstParty.GetRecord(idx);
        if(!HasPartyRecordData(Record, 2))
        {
            return;
        }
        MemberCount = ClampNonNegativeCount(MemberCount);
        m_PartyMemberNum = m_PartyMemberNum - ClampNonNegativeCount(int(Record.LVDataList[1].szData));
        m_PartyMemberNum = ClampNonNegativeCount(m_PartyMemberNum + MemberCount);
        Record.LVDataList[1].szData = string(MemberCount);
        lstParty.ModifyRecord(idx, Record);
    }
    UpdateCountInfo();
    return;
}

function OnExitState(name a_NextStateName)
{
    // End:0x15
    if(a_NextStateName == 'LoadingState')
    {
        HandleCommandChannelEnd();
    }
    return;
}
