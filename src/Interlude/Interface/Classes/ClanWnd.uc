class ClanWnd extends UISublimityCommonAPI;

var int m_clanID;
var string m_clanName;
var int m_clanRank;
var int m_clanLevel;
var int m_clanNameValue;
var int m_bMoreInfo;
var int m_currentShowIndex;
var int G_CurrentRecord;
var string G_CurrentSzData;
var bool G_CurrentAlias;
var bool G_IamNobless;
var bool G_IamHero;
var int G_ClanMember;
var string m_WindowName;
var int m_myClanType;
var string m_myName;
var string m_myClanName;
var int m_indexNum;
var bool m_currentactivestatus1;
var bool m_currentactivestatus2;
var bool m_currentactivestatus3;
var bool m_currentactivestatus4;
var bool m_currentactivestatus5;
var bool m_currentactivestatus6;
var bool m_currentactivestatus7;
var bool m_currentactivestatus8;
var int m_bClanMaster;
var int m_bJoin;
var int m_bNickName;
var int m_bCrest;
var int m_bWar;
var int m_bGrade;
var int m_bManageMaster;
var int m_bOustMember;
var string m_CurrentclanMasterName;
var string m_CurrentclanMasterReal;
var int m_CurrentNHType;
var array<ClanInfo> m_memberList;

function getmyClanInfo()
{
    local UserInfo UserInfo;

    // End:0x63
    if(GetPlayerInfo(UserInfo))
    {
        m_myName = UserInfo.Name;
        m_myClanType = findmyClanData(m_myName);
        G_IamNobless = UserInfo.bNobless;
        G_IamHero = UserInfo.bHero;
        G_ClanMember = UserInfo.nClanID;
    }
    return;
}

function int findmyClanData(string C_Name)
{
    local int i, j, clannum;

    i = 0;
    J0x07:

    // End:0x93 [Loop If]
    if(i < m_memberList.Length)
    {
        j = 0;
        J0x1E:

        // End:0x89 [Loop If]
        if(j < m_memberList[i].m_array.Length)
        {
            // End:0x7F
            if(m_memberList[i].m_array[j].sName == C_Name)
            {
                clannum = m_memberList[i].m_array[j].clanType;
            }
            ++j;
            // [Loop Continue]
            goto J0x1E;
        }
        ++i;
        // [Loop Continue]
        goto J0x07;
    }
    return clannum;
}

function OnLoad()
{
    RegisterEvents();
    m_memberList.Length = 8;
    m_currentShowIndex = 0;
    m_bMoreInfo = 0;
    G_CurrentAlias = false;
    Clear();
    m_currentactivestatus1 = false;
    m_currentactivestatus2 = false;
    m_currentactivestatus3 = false;
    m_currentactivestatus4 = false;
    m_currentactivestatus5 = false;
    m_currentactivestatus6 = false;
    m_currentactivestatus7 = false;
    return;
}

function RegisterEvents()
{
    RegisterEvent(320);
    RegisterEvent(330);
    RegisterEvent(420);
    RegisterEvent(400);
    RegisterEvent(440);
    RegisterEvent(410);
    RegisterEvent(450);
    RegisterEvent(150);
    RegisterEvent(160);
    RegisterEvent(340);
    RegisterEvent(480);
    return;
}

function int GetClanTypeFromIndex(int Index)
{
    local int Type;

    // End:0x12
    if(Index == 0)
    {
        Type = 0;
    }
    // End:0x25
    if(Index == 1)
    {
        Type = 100;
    }
    // End:0x39
    if(Index == 2)
    {
        Type = 200;
    }
    // End:0x50
    if(Index == 3)
    {
        Type = 1001;
    }
    // End:0x67
    if(Index == 4)
    {
        Type = 1002;
    }
    // End:0x7E
    if(Index == 5)
    {
        Type = 2001;
    }
    // End:0x95
    if(Index == 6)
    {
        Type = 2002;
    }
    // End:0xAC
    if(Index == 7)
    {
        Type = -1;
    }
    return Type;
}

function UpdateOnline()
{
    local int i, N, m_Online;
    local string m_Param;

    m_Online = 1;
    i = 0;
    J0x0E:

    // End:0x7C [Loop If]
    if(i < m_memberList.Length)
    {
        N = 0;
        J0x25:

        // End:0x72 [Loop If]
        if(N < m_memberList[i].m_array.Length)
        {
            // End:0x68
            if(m_memberList[i].m_array[N].Id > 0)
            {
                m_Online++;
            }
            N++;
            // [Loop Continue]
            goto J0x25;
        }
        i++;
        // [Loop Continue]
        goto J0x0E;
    }
    ParamAdd(m_Param, "Count", string(m_Online));
    ExecuteEvent(200000, m_Param);
    return;
}

function string GetClanTypeNameFromIndex(int Index)
{
    local string Type;

    // End:0x1C
    if(Index == 0)
    {
        Type = GetSystemString(1399);
    }
    // End:0x39
    if(Index == 100)
    {
        Type = GetSystemString(1400);
    }
    // End:0x56
    if(Index == 200)
    {
        Type = GetSystemString(1401);
    }
    // End:0x76
    if(Index == 1001)
    {
        Type = GetSystemString(1402);
    }
    // End:0x96
    if(Index == 1002)
    {
        Type = GetSystemString(1403);
    }
    // End:0xB6
    if(Index == 2001)
    {
        Type = GetSystemString(1404);
    }
    // End:0xD6
    if(Index == 2002)
    {
        Type = GetSystemString(1405);
    }
    // End:0xF6
    if(Index == -1)
    {
        Type = GetSystemString(1452);
    }
    return Type;
}

function OnShow()
{
    local int i;

    getmyClanInfo();
    RefreshCombobox();
    resetBtnShowHide();
    NoblessMenuValidate();
    i = 10;
    J0x20:

    // End:0xA1 [Loop If]
    if(i >= 0)
    {
        // End:0x97
        if(Class'NWindow.UIAPI_COMBOBOX'.static.GetReserved(m_WindowName $ ".ComboboxMainClanWnd", i) == m_myClanType)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum(m_WindowName $ ".ComboboxMainClanWnd", i);
        }
        --i;
        // [Loop Continue]
        goto J0x20;
    }
    ShowList(m_myClanType);
    Class'NWindow.UIAPI_LISTCTRL'.static.SetSelectedIndex(m_WindowName $ ".ClanMemberList", m_indexNum, true);
    // End:0x118
    if(m_myClanType == -1)
    {
        Class'NWindow.UIAPI_LISTCTRL'.static.SetSelectedIndex(m_WindowName $ ".ClanMemberList", m_indexNum - 1, true);
    }
    return;
}

function NoblessMenuValidate()
{
    // End:0xB9
    if(G_ClanMember == 0)
    {
        // End:0x6F
        if((G_IamHero == true) || G_IamNobless == true)
        {
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(m_WindowName $ ".HeroBtn");
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow(m_WindowName $ ".ClanMemInfoBtn");            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow(m_WindowName $ ".HeroBtn");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(m_WindowName $ ".ClanMemInfoBtn");
        }        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow(m_WindowName $ ".HeroBtn");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(m_WindowName $ ".ClanMemInfoBtn");
    }
    return;
}

function OnHide()
{
    return;
}

function OnEnterState(name a_PreStateName)
{
    getmyClanInfo();
    NoblessMenuValidate();
    // End:0x27
    if(a_PreStateName == 'GamingState')
    {
        getmyClanInfo();
        NoblessMenuValidate();
    }
    return;
}

function OnClickButton(string strID)
{
    local ClanDrawerWnd script;
    local LVDataRecord Record;
    local string strParam;

    Record.LVDataList.Length = 10;
    script = ClanDrawerWnd(GetScript("ClanDrawerWnd"));

    if(strID == "ClanMemInfoBtn")
    {
        if(m_currentactivestatus1 == false)
        {
            ResetOpeningVariables();
            m_currentactivestatus1 = true;
            if(GetSelectedListCtrlItem(Record))
            {
                RequestClanMemberInfo(Record.nReserved1, Record.LVDataList[0].szData);
                G_CurrentRecord = Record.nReserved1;
                G_CurrentSzData = Record.LVDataList[0].szData;
                if(Record.LVDataList[3].szData == "0")
                {
                    G_CurrentAlias = true;
                }
                else
                {
                    G_CurrentAlias = false;
                }
                script.SetStateAndShow("ClanMemberInfoState");
            }
        }
        else
        {
            m_currentactivestatus1 = false;
            script.HideWindow();
        }
    }
    else if(strID == "ClanMemAuthBtn")
    {
        if(m_currentactivestatus2 == false)
        {
            ResetOpeningVariables();
            m_currentactivestatus2 = true;
            if(GetSelectedListCtrlItem(Record))
            {
                RequestClanMemberAuth(Record.nReserved1, Record.LVDataList[0].szData);
                script.SetStateAndShow("ClanMemberAuthState");
            }
        }
        else
        {
            m_currentactivestatus2 = false;
            script.HideWindow();
        }
    }
    else if(strID == "ClanBoardBtn")
    {
        ParamAdd(strParam, "Index", "3");
        ExecuteEvent(EV_ShowBBS, strParam);
    }
    else if(strID == "ClanInfoBtn")
    {
        if(m_currentactivestatus3 == false)
        {
            ResetOpeningVariables();
            m_currentactivestatus3 = true;
            script.SetStateAndShow("ClanInfoState");
        }
        else
        {
            m_currentactivestatus3 = false;
            script.HideWindow();
        }
    }
    else if(strID == "ClanPenaltyBtn")
    {
        ExecuteCommandFromAction("pledgepenalty");
    }
    else if(strID == "ClanQuitBtn")
    {
        RequestClanLeave(m_clanName, m_myClanType);
    }
    else if(strID == "ClanWarInfoBtn")
    {
        if(m_currentactivestatus5 == false)
        {
            ResetOpeningVariables();
            m_currentactivestatus5 = true;
            script.m_clanWarListPage = -1;
            RequestClanWarList(0, 0);
            script.SetStateAndShow("ClanWarManagementWndState");
        }
        else
        {
            m_currentactivestatus5 = false;
            script.HideWindow();
        }
    }
    else if(strID == "ClanWarDeclareBtn")
    {
        RequestClanDeclareWar();
    }
    else if(strID == "ClanWarCancleBtn")
    {
        RequestClanWithdrawWar();
    }
    else if(strID == "ClanAskJoinBtn")
    {
        AskJoin();
    }
    else if(strID == "ClanAuthEditBtn")
    {
        if(m_currentactivestatus6 == false)
        {
            ResetOpeningVariables();
            m_currentactivestatus6 = true;
            RequestClanGradeList();
            script.SetStateAndShow("ClanAuthManageWndState");
        }
        else
        {
            m_currentactivestatus6 = false;
            script.HideWindow();
        }
    }
    else if(strID == "ClanTitleManageBtn")
    {
        if(m_currentactivestatus7 == false)
        {
            ResetOpeningVariables();
            m_currentactivestatus7 = true;
            script.SetStateAndShow("ClanEmblemManageWndState");
        }
        else
        {
            m_currentactivestatus7 = false;
            script.HideWindow();
        }
    }
    else if(strID == "HeroBtn")
    {
        if(m_currentactivestatus8 == false)
        {
            m_currentactivestatus8 = true;
            script.SetStateAndShow("ClanHeroWndState");
        }
        else
        {
            m_currentactivestatus8 = false;
            script.HideWindow();
        }
    }

    return;
}
function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x18
        case 420:
            Clear();
            // End:0xDC
            break;
        // End:0x26
        case 160:
            Clear();
            // End:0xDC
            break;
        // End:0x3C
        case 320:
            HandleClanInfo(a_Param);
            // End:0xDC
            break;
        // End:0x52
        case 410:
            HandleAddClanMemberMultiple(a_Param);
            // End:0xDC
            break;
        // End:0x68
        case 440:
            HandleMemberInfoUpdate(a_Param);
            // End:0xDC
            break;
        // End:0x7E
        case 400:
            HandleAddClanMember(a_Param);
            // End:0xDC
            break;
        // End:0x94
        case 450:
            HandleDeleteMember(a_Param);
            // End:0xDC
            break;
        // End:0xAA
        case 330:
            HandleClanInfoUpdate(a_Param);
            // End:0xDC
            break;
        // End:0xC0
        case 480:
            HandleSubClanUpdated(a_Param);
            // End:0xDC
            break;
        // End:0xD6
        case 340:
            HandleClanMyAuth(a_Param);
            // End:0xDC
            break;
        // End:0xFFFF
        default:
            // End:0xDC
            break;
            break;
    }
    return;
}

function OnComboBoxItemSelected(string sName, int Index)
{
    ClearList();
    ShowList(Class'NWindow.UIAPI_COMBOBOX'.static.GetReserved(m_WindowName $ ".ComboboxMainClanWnd", Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum(m_WindowName $ ".ComboboxMainClanWnd")));
    return;
}

function OnClickListCtrlRecord(string ListCtrlID)
{
    local ClanDrawerWnd script;
    local LVDataRecord Record;

    Record.LVDataList.Length = 10;
    script = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
    // End:0x176
    if(ListCtrlID == "ClanMemberList")
    {
        // End:0x109
        if(m_currentactivestatus1 == true)
        {
            ResetOpeningVariables();
            m_currentactivestatus1 = true;
            // End:0x109
            if(GetSelectedListCtrlItem(Record))
            {
                RequestClanMemberInfo(Record.nReserved1, Record.LVDataList[0].szData);
                G_CurrentRecord = Record.nReserved1;
                G_CurrentSzData = Record.LVDataList[0].szData;
                // End:0xDD
                if(Record.LVDataList[3].szData == "0")
                {
                    G_CurrentAlias = true;                    
                }
                else
                {
                    G_CurrentAlias = false;
                }
                script.SetStateAndShow("ClanMemberInfoState");
            }
        }
        // End:0x176
        if(m_currentactivestatus2 == true)
        {
            ResetOpeningVariables();
            m_currentactivestatus2 = true;
            // End:0x176
            if(GetSelectedListCtrlItem(Record))
            {
                RequestClanMemberAuth(Record.nReserved1, Record.LVDataList[0].szData);
                script.SetStateAndShow("ClanMemberAuthState");
            }
        }
    }
    return;
}

function OnDBClickListCtrlRecord(string ListCtrlID)
{
    local ClanDrawerWnd script;
    local LVDataRecord Record;

    Record.LVDataList.Length = 10;
    script = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
    // End:0x194
    if(ListCtrlID == "ClanMemberList")
    {
        // End:0x10C
        if(m_currentactivestatus1 == false)
        {
            ResetOpeningVariables();
            m_currentactivestatus1 = true;
            // End:0x109
            if(GetSelectedListCtrlItem(Record))
            {
                RequestClanMemberInfo(Record.nReserved1, Record.LVDataList[0].szData);
                G_CurrentRecord = Record.nReserved1;
                G_CurrentSzData = Record.LVDataList[0].szData;
                // End:0xDD
                if(Record.LVDataList[3].szData == "0")
                {
                    G_CurrentAlias = true;                    
                }
                else
                {
                    G_CurrentAlias = false;
                }
                script.SetStateAndShow("ClanMemberInfoState");
            }            
        }
        else
        {
            ResetOpeningVariables();
            m_currentactivestatus1 = true;
            // End:0x194
            if(GetSelectedListCtrlItem(Record))
            {
                RequestClanMemberInfo(Record.nReserved1, Record.LVDataList[0].szData);
                G_CurrentRecord = Record.nReserved1;
                G_CurrentSzData = Record.LVDataList[0].szData;
                script.SetStateAndShow("ClanMemberInfoState");
            }
        }
    }
    return;
}

function resetBtnShowHide()
{
    local ClanDrawerWnd script;

    script = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
    NoblessMenuValidate();
    // End:0x1E3
    if(m_clanID == 0)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanMemInfoBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanMemAuthBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanBoardBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanInfoBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanQuitBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarInfoBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarDeclareBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarCancleBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAskJoinBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAuthEditBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanTitleManageBtn");        
    }
    else
    {
        // End:0x4DD
        if(m_clanLevel > 5)
        {
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemInfoBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemAuthBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanBoardBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanInfoBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanPenaltyBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanQuitBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarInfoBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarDeclareBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarCancleBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanAskJoinBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAuthEditBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanTitleManageBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");            
        }
        else
        {
            switch(m_clanLevel)
            {
                // End:0x7D6
                case 0:
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemAuthBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanBoardBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanPenaltyBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanQuitBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarDeclareBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarCancleBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanAskJoinBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAuthEditBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanTitleManageBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
                    // End:0x1697
                    break;
                // End:0xAC8
                case 1:
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemAuthBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanBoardBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanPenaltyBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanQuitBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarDeclareBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarCancleBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanAskJoinBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAuthEditBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanTitleManageBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
                    // End:0x1697
                    break;
                // End:0xDBB
                case 2:
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemAuthBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanBoardBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanPenaltyBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanQuitBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarDeclareBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarCancleBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanAskJoinBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAuthEditBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanTitleManageBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
                    // End:0x1697
                    break;
                // End:0x10AE
                case 3:
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemAuthBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanBoardBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanPenaltyBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanQuitBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarDeclareBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarCancleBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanAskJoinBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAuthEditBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanTitleManageBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
                    // End:0x1697
                    break;
                // End:0x13A1
                case 4:
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemAuthBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanBoardBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanPenaltyBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanQuitBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarDeclareBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarCancleBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanAskJoinBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAuthEditBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanTitleManageBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
                    // End:0x1697
                    break;
                // End:0x1694
                case 5:
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanMemAuthBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanBoardBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanPenaltyBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanQuitBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarInfoBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarDeclareBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanWarCancleBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanAskJoinBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAuthEditBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanTitleManageBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
                    // End:0x1697
                    break;
                // End:0xFFFF
                default:
                    break;
            }
        }
        // End:0x1728
        if(m_bClanMaster > 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanQuitBtn");
            // End:0x16FD
            if(m_clanLevel > 2)
            {
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanTitleManageBtn");
            }
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanAuthEditBtn");            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
            // End:0x186F
            if(m_bJoin == 0)
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanAskJoinBtn");
            }
            // End:0x18A8
            if(m_bCrest == 0)
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanTitleManageBtn");                
            }
            else
            {
                // End:0x18DF
                if(m_clanLevel > 2)
                {
                    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow(m_WindowName $ ".ClanTitleManageBtn");
                }
            }
            // End:0x193D
            if(m_bWar == 0)
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarDeclareBtn");
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow(m_WindowName $ ".ClanWarCancleBtn");
            }
        }
        script.CheckandCompareMyNameandDisableThings();
    }
    NoblessMenuValidate();
    return;
}

function Clear()
{
    local ClanDrawerWnd script;
    local int i;

    ClearList();
    script = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
    script.Clear();
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InviteClanPopWnd");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanNameText", "");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanMasterNameText", "");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanAgitText", GetSystemString(27));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanStatusText", "");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt(m_WindowName $ ".ClanLevelText", 0);
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear(m_WindowName $ ".ComboboxMainClanWnd");
    m_clanID = 0;
    m_clanName = "";
    m_clanRank = 0;
    m_clanLevel = 0;
    m_clanNameValue = 0;
    m_bMoreInfo = 0;
    m_currentShowIndex = 0;
    m_bClanMaster = 0;
    m_bJoin = 0;
    m_bNickName = 0;
    m_bCrest = 0;
    m_bWar = 0;
    m_bGrade = 0;
    m_bManageMaster = 0;
    m_bOustMember = 0;
    i = 0;
    J0x1E2:

    // End:0x241 [Loop If]
    if(i < 8)
    {
        m_memberList[i].m_array.Remove(0, m_memberList[i].m_array.Length);
        m_memberList[i].m_sName = "";
        m_memberList[i].m_sMasterName = "";
        ++i;
        // [Loop Continue]
        goto J0x1E2;
    }
    return;
}

function HandleClanInfo(string a_Param)
{
    local string clanMasterName, ClanName;
    local int crestID, SkillLevel, castleID, AgitID, Status, bGuilty,
	    allianceID;

    local string allianceName;
    local int AllianceCrestID, bInWar, clanType, clanRank, clanNameValue, clanID;

    ParseInt(a_Param, "ClanID", clanID);
    ParseInt(a_Param, "ClanType", clanType);
    m_CurrentNHType = clanType;
    ParseString(a_Param, "ClanName", ClanName);
    ParseString(a_Param, "ClanMasterName", clanMasterName);
    m_CurrentclanMasterName = clanMasterName;
    // End:0x98
    if(clanType == 0)
    {
        m_CurrentclanMasterReal = clanMasterName;
    }
    ParseInt(a_Param, "CrestID", crestID);
    ParseInt(a_Param, "SkillLevel", SkillLevel);
    ParseInt(a_Param, "CastleID", castleID);
    ParseInt(a_Param, "AgitID", AgitID);
    ParseInt(a_Param, "ClanRank", clanRank);
    ParseInt(a_Param, "ClanNameValue", clanNameValue);
    ParseInt(a_Param, "Status", Status);
    ParseInt(a_Param, "Guilty", bGuilty);
    ParseInt(a_Param, "AllianceID", allianceID);
    ParseString(a_Param, "AllianceName", allianceName);
    ParseInt(a_Param, "AllianceCrestID", AllianceCrestID);
    ParseInt(a_Param, "InWar", bInWar);
    // End:0x21C
    if(clanType == 0)
    {
        m_clanName = ClanName;
        m_clanRank = clanRank;
        m_clanNameValue = clanNameValue;
        m_clanLevel = SkillLevel;
        m_clanID = clanID;
    }
    m_memberList[GetIndexFromType(clanType)].m_sName = ClanName;
    m_memberList[GetIndexFromType(clanType)].m_sMasterName = clanMasterName;
    // End:0x440
    if(clanType == 0)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanNameText", ClanName);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanMasterNameText", m_CurrentclanMasterReal);
        // End:0x2F7
        if(AgitID > 0)
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanAgitText", GetCastleName(AgitID));            
        }
        else
        {
            // End:0x335
            if(castleID > 0)
            {
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanAgitText", GetCastleName(castleID));                
            }
            else
            {
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanAgitText", GetSystemString(27));
            }
        }
        // End:0x3A3
        if(Status == 3)
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanStatusText", GetSystemString(341));            
        }
        else
        {
            // End:0x3E3
            if(bInWar == 0)
            {
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanStatusText", GetSystemString(894));                
            }
            else
            {
                Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanStatusText", GetSystemString(340));
            }
        }
        Class'NWindow.UIAPI_TEXTBOX'.static.SetInt(m_WindowName $ ".ClanLevelText", SkillLevel);
    }
    RefreshCombobox();
    getmyClanInfo();
    return;
}

function HandleClanInfoUpdate(string a_Param)
{
    local int PledgeCrestID, castleID, AgitID, Status, bGuilty, allianceID;

    local string sAllianceName;
    local int AllianceCrestID, InWar, LargePledgeCrestID;
    local ClanDrawerWnd script;

    ParseInt(a_Param, "ClanID", m_clanID);
    ParseInt(a_Param, "CrestID", PledgeCrestID);
    ParseInt(a_Param, "SkillLevel", m_clanLevel);
    ParseInt(a_Param, "CastleID", castleID);
    ParseInt(a_Param, "AgitID", AgitID);
    ParseInt(a_Param, "ClanRank", m_clanRank);
    ParseInt(a_Param, "ClanNameValue", m_clanNameValue);
    ParseInt(a_Param, "Status", Status);
    ParseInt(a_Param, "Guilty", bGuilty);
    ParseInt(a_Param, "AllianceID", allianceID);
    ParseString(a_Param, "AllianceName", sAllianceName);
    ParseInt(a_Param, "AllianceCrestID", AllianceCrestID);
    ParseInt(a_Param, "InWar", InWar);
    ParseInt(a_Param, "LargeCrestID", LargePledgeCrestID);
    // End:0x1D4
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("ClanDrawerWnd.ClanInfoWnd"))
    {
        script = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
        script.InitializeClanInfoWnd();
    }
    // End:0x212
    if(AgitID > 0)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanAgitText", GetCastleName(AgitID));        
    }
    else
    {
        // End:0x250
        if(castleID > 0)
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanAgitText", GetCastleName(castleID));            
        }
        else
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanAgitText", GetSystemString(27));
        }
    }
    // End:0x2BE
    if(Status == 3)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanStatusText", GetSystemString(341));        
    }
    else
    {
        // End:0x2FE
        if(InWar == 0)
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanStatusText", GetSystemString(894));            
        }
        else
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanStatusText", GetSystemString(340));
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt(m_WindowName $ ".ClanLevelText", m_clanLevel);
    resetBtnShowHide();
    getmyClanInfo();
    return;
}

function HandleAddClanMemberMultiple(string a_Param)
{
    local ClanMemberInfo Info;
    local int Count, Index;

    ParseInt(a_Param, "ClanType", Info.clanType);
    Index = GetIndexFromType(Info.clanType);
    ParseString(a_Param, "Name", Info.sName);
    ParseInt(a_Param, "Level", Info.Level);
    ParseInt(a_Param, "Class", Info.ClassID);
    ParseInt(a_Param, "Gender", Info.gender);
    ParseInt(a_Param, "Race", Info.Race);
    ParseInt(a_Param, "ID", Info.Id);
    ParseInt(a_Param, "HaveMaster", Info.bHaveMaster);
    Count = m_memberList[Index].m_array.Length;
    m_memberList[Index].m_array.Length = Count + 1;
    m_memberList[Index].m_array[Count] = Info;
    UpdateOnline();
    // End:0x16C
    if(Index == m_currentShowIndex)
    {
        ShowList(Info.clanType);
    }
    return;
}

function ClearList()
{
    Class'NWindow.UIAPI_LISTCTRL'.static.DeleteAllItem(m_WindowName $ ".ClanMemberList");
    return;
}

function ShowList(int clanType)
{
    local int Index;

    Index = GetIndexFromType(clanType);
    m_currentShowIndex = Index;
    ClearList();
    AddToList(Index);
    return;
}

function int getClanKnighthoodMasterInfo(string NameVal)
{
    local int i, ReturnVal;

    i = 0;
    J0x07:

    // End:0x54 [Loop If]
    if(i < m_memberList[0].m_array.Length)
    {
        // End:0x4A
        if(m_memberList[0].m_array[i].sName == NameVal)
        {
            ReturnVal = i;
        }
        ++i;
        // [Loop Continue]
        goto J0x07;
    }
    return ReturnVal;
}

function AddToList(int idx)
{
    local Color White, Yellow, Blue, BrightWhite, Gold;

    local int i, OnLineNum;
    local LVDataRecord Record;

    BrightWhite.R = byte(255);
    BrightWhite.G = byte(255);
    BrightWhite.B = byte(255);
    White.R = 170;
    White.G = 170;
    White.B = 170;
    Yellow.R = 235;
    Yellow.G = 205;
    Yellow.B = 0;
    Blue.R = 102;
    Blue.G = 150;
    Blue.B = 253;
    Gold.R = 176;
    Gold.G = 153;
    Gold.B = 121;
    OnLineNum = 0;
    Record.LVDataList.Length = 4;
    // End:0xF2
    if((GetClanTypeFromIndex(m_currentShowIndex)) <= 0)
    {        
    }
    else
    {
        // End:0x1C5
        if(m_memberList[m_currentShowIndex].m_sMasterName == "")
        {
            i = getClanKnighthoodMasterInfo(m_memberList[m_currentShowIndex].m_sMasterName);
            Record.LVDataList[0].bUseTextColor = true;
            Record.LVDataList[0].szData = GetSystemString(1445);
            Record.LVDataList[0].TextColor = Gold;
            Record.LVDataList[1].szData = "";
            Record.LVDataList[2].szData = "";
            Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord(m_WindowName $ ".ClanMemberList", Record);            
        }
        else
        {
            i = getClanKnighthoodMasterInfo(m_memberList[m_currentShowIndex].m_sMasterName);
            Record.LVDataList[0].bUseTextColor = true;
            Record.LVDataList[0].szData = m_memberList[m_currentShowIndex].m_sMasterName;
            Record.LVDataList[0].TextColor = Gold;
            Record.LVDataList[1].bUseTextColor = true;
            Record.LVDataList[1].TextColor = White;
            Record.LVDataList[1].szData = string(m_memberList[0].m_array[i].Level);
            Record.LVDataList[2].szData = string(m_memberList[0].m_array[i].ClassID);
            Record.LVDataList[2].szTexture = GetClassIconName(m_memberList[0].m_array[i].ClassID);
            Record.LVDataList[2].nTextureWidth = 11;
            Record.LVDataList[2].nTextureHeight = 11;
            Record.LVDataList[3].nTextureWidth = 31;
            Record.LVDataList[3].nTextureHeight = 11;
            Record.nReserved1 = 0;
            // End:0x3BD
            if(m_memberList[0].m_array[i].Id > 0)
            {
                Record.LVDataList[3].szData = "0";
                Record.LVDataList[3].szTexture = "L2UI_CH3.BloodHoodWnd.BloodHood_Logon";
                OnLineNum = OnLineNum++;                
            }
            else
            {
                Record.LVDataList[3].szData = "0";
                Record.LVDataList[3].szTexture = "L2UI_CH3.BloodHoodWnd.BloodHood_Logoff";
            }
            Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord(m_WindowName $ ".ClanMemberList", Record);
        }
        i = 0;
    }
    i = 0;
    J0x448:

    // End:0x7F5 [Loop If]
    if(i < m_memberList[idx].m_array.Length)
    {
        Record.LVDataList[0].bUseTextColor = true;
        Record.LVDataList[0].szData = m_memberList[idx].m_array[i].sName;
        // End:0x4DF
        if(m_memberList[idx].m_array[i].bHaveMaster == 0)
        {
            Record.LVDataList[0].TextColor = White;            
        }
        else
        {
            Record.LVDataList[0].TextColor = Yellow;
        }
        // End:0x576
        if(m_memberList[idx].m_array[i].sName == m_myName)
        {
            Record.LVDataList[0].TextColor = BrightWhite;
            Record.LVDataList[1].TextColor = BrightWhite;
            // End:0x568
            if((GetClanTypeFromIndex(m_currentShowIndex)) == 0)
            {
                m_indexNum = i;                
            }
            else
            {
                m_indexNum = i + 1;
            }
        }
        Record.LVDataList[1].bUseTextColor = true;
        // End:0x5C9
        if(m_memberList[idx].m_array[i].sName == m_myName)
        {
            Record.LVDataList[1].TextColor = BrightWhite;            
        }
        else
        {
            Record.LVDataList[1].TextColor = White;
        }
        Record.LVDataList[1].szData = string(m_memberList[idx].m_array[i].Level);
        Record.LVDataList[2].szData = string(m_memberList[idx].m_array[i].ClassID);
        Record.LVDataList[2].szTexture = GetClassIconName(m_memberList[idx].m_array[i].ClassID);
        Record.LVDataList[2].nTextureWidth = 11;
        Record.LVDataList[2].nTextureHeight = 11;
        Record.LVDataList[3].nTextureWidth = 31;
        Record.LVDataList[3].nTextureHeight = 11;
        Record.nReserved1 = m_memberList[idx].m_array[i].clanType;
        // End:0x76E
        if(m_memberList[idx].m_array[i].Id > 0)
        {
            Record.LVDataList[3].szData = "1";
            Record.LVDataList[3].szTexture = "L2UI_CH3.BloodHoodWnd.BloodHood_Logon";
            OnLineNum = OnLineNum++;            
        }
        else
        {
            Record.LVDataList[3].szData = "2";
            Record.LVDataList[3].szTexture = "L2UI_CH3.BloodHoodWnd.BloodHood_Logoff";
        }
        Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord(m_WindowName $ ".ClanMemberList", Record);
        ++i;
        // [Loop Continue]
        goto J0x448;
    }
    // End:0x85B
    if((GetClanTypeFromIndex(m_currentShowIndex)) <= 0)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanCurrentNum", ((("(" $ string(OnLineNum)) $ "/") $ string(m_memberList[idx].m_array.Length)) $ ")");        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".ClanCurrentNum", ((("(" $ string(OnLineNum)) $ "/") $ string(m_memberList[idx].m_array.Length + 1)) $ ")");
    }
    return;
}

function bool GetSelectedListCtrlItem(out LVDataRecord Record)
{
    local int Index;

    Index = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedIndex(m_WindowName $ ".ClanMemberList");
    // End:0x6C
    if(Index >= 0)
    {
        Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetRecord(m_WindowName $ ".ClanMemberList", Index);
        return true;
    }
    return false;
}

function HandleMemberInfoUpdate(string a_Param)
{
    local ClanMemberInfo Info;
    local int i, j, Count;
    local ClanDrawerWnd script;
    local bool bHaveMasterChanged, bMemberChanged;
    local int process_length, process_clanindex;

    bHaveMasterChanged = false;
    bMemberChanged = false;
    ParseString(a_Param, "Name", Info.sName);
    ParseInt(a_Param, "Level", Info.Level);
    ParseInt(a_Param, "Class", Info.ClassID);
    ParseInt(a_Param, "Gender", Info.gender);
    ParseInt(a_Param, "Race", Info.Race);
    ParseInt(a_Param, "ID", Info.Id);
    ParseInt(a_Param, "PledgeType", Info.clanType);
    ParseInt(a_Param, "HaveMaster", Info.bHaveMaster);
    i = 0;
    J0xFD:

    // End:0x451 [Loop If]
    if(i < 8)
    {
        Count = m_memberList[i].m_array.Length;
        j = 0;
        J0x127:

        // End:0x435 [Loop If]
        if(j < Count)
        {
            // End:0x42B
            if(m_memberList[i].m_array[j].sName == Info.sName)
            {
                // End:0x1D6
                if(m_memberList[i].m_array[j].bHaveMaster != Info.bHaveMaster)
                {
                    bHaveMasterChanged = true;
                    m_memberList[i].m_array[j] = Info;
                    Debug("멤버정보 변경 이벤트 날아왔음222");
                }
                // End:0x3FC
                if(m_memberList[i].m_array[j].clanType != Info.clanType)
                {
                    bMemberChanged = true;
                    Debug("멤버이동 처리");
                    m_memberList[i].m_array.Remove(j, 1);
                    process_clanindex = GetIndexFromType(Info.clanType);
                    process_length = m_memberList[process_clanindex].m_array.Length;
                    m_memberList[process_clanindex].m_array.Insert(process_length, 1);
                    m_memberList[process_clanindex].m_array[process_length].sName = Info.sName;
                    m_memberList[process_clanindex].m_array[process_length].clanType = Info.clanType;
                    m_memberList[process_clanindex].m_array[process_length].Level = Info.Level;
                    m_memberList[process_clanindex].m_array[process_length].ClassID = Info.ClassID;
                    m_memberList[process_clanindex].m_array[process_length].gender = Info.gender;
                    m_memberList[process_clanindex].m_array[process_length].Race = Info.Race;
                    m_memberList[process_clanindex].m_array[process_length].Id = Info.Id;
                    m_memberList[process_clanindex].m_array[process_length].bHaveMaster = Info.bHaveMaster;
                    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberGrade", "");
                    ShowList(Info.clanType);                    
                }
                else
                {
                    m_memberList[i].m_array[j] = Info;
                    ShowList(Info.clanType);
                }
                // [Explicit Break]
                goto J0x435;
            }
            ++j;
            // [Loop Continue]
            goto J0x127;
        }
        J0x435:

        // End:0x447
        if(j < Count)
        {
            // [Explicit Break]
            goto J0x451;
        }
        ++i;
        // [Loop Continue]
        goto J0xFD;
    }
    J0x451:

    // End:0x51B
    if(bHaveMasterChanged && Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("ClanDrawerWnd.ClanMemberInfoWnd"))
    {
        script = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
        // End:0x4E6
        if(script.m_currentName == Info.sName)
        {
            RequestClanMemberInfo(Info.clanType, Info.sName);
        }
        // End:0x510
        if((GetIndexFromType(Info.clanType)) == m_currentShowIndex)
        {
            ShowList(Info.clanType);
        }
        ShowList(m_currentShowIndex);
    }
    UpdateOnline();
    // End:0x585
    if(bMemberChanged && Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("ClanDrawerWnd.ClanMemberInfoWnd"))
    {
        ClearList();
        ShowList(Info.clanType);
        RefreshCombobox1(Info.clanType);
    }
    return;
}

function RefreshCombobox1(int ClanT)
{
    local int i;

    i = 0;
    J0x07:

    // End:0xAA [Loop If]
    if(i < 10)
    {
        // End:0xA0
        if(Class'NWindow.UIAPI_COMBOBOX'.static.GetReserved(m_WindowName $ ".ComboboxMainClanWnd", i) == ClanT)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum(m_WindowName $ ".ComboboxMainClanWnd", i);
            Debug("CurrentSelected:" @ string(i));
        }
        ++i;
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function HandleAddClanMember(string a_Param)
{
    local int Count;
    local ClanMemberInfo Info;

    ParseString(a_Param, "Name", Info.sName);
    ParseInt(a_Param, "Level", Info.Level);
    ParseInt(a_Param, "Class", Info.ClassID);
    ParseInt(a_Param, "Gender", Info.gender);
    ParseInt(a_Param, "Race", Info.Race);
    ParseInt(a_Param, "ID", Info.Id);
    ParseInt(a_Param, "ClanType", Info.clanType);
    Info.bHaveMaster = 0;
    Count = m_memberList[GetIndexFromType(Info.clanType)].m_array.Length;
    m_memberList[GetIndexFromType(Info.clanType)].m_array.Length = Count + 1;
    m_memberList[GetIndexFromType(Info.clanType)].m_array[Count] = Info;
    // End:0x167
    if((GetIndexFromType(Info.clanType)) == m_currentShowIndex)
    {
        ShowList(Info.clanType);
    }
    UpdateOnline();
    return;
}

function int GetIndexFromType(int Type)
{
    local int i;

    i = -1;
    // End:0x20
    if(Type == 0)
    {
        i = 0;        
    }
    else
    {
        // End:0x36
        if(Type == 100)
        {
            i = 1;            
        }
        else
        {
            // End:0x4D
            if(Type == 200)
            {
                i = 2;                
            }
            else
            {
                // End:0x67
                if(Type == 1001)
                {
                    i = 3;                    
                }
                else
                {
                    // End:0x81
                    if(Type == 1002)
                    {
                        i = 4;                        
                    }
                    else
                    {
                        // End:0x9B
                        if(Type == 2001)
                        {
                            i = 5;                            
                        }
                        else
                        {
                            // End:0xB5
                            if(Type == 2002)
                            {
                                i = 6;                                
                            }
                            else
                            {
                                // End:0xCC
                                if(Type == -1)
                                {
                                    i = 7;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return i;
}

function HandleDeleteMember(string a_Param)
{
    local int i, j, k, Count;
    local string sName;

    ParseString(a_Param, "Name", sName);
    i = 0;
    J0x1D:

    // End:0x115 [Loop If]
    if(i < 8)
    {
        Count = m_memberList[i].m_array.Length;
        j = 0;
        J0x47:

        // End:0xF9 [Loop If]
        if(j < Count)
        {
            // End:0xEF
            if(m_memberList[i].m_array[j].sName == sName)
            {
                k = j;
                J0x86:

                // End:0xD2 [Loop If]
                if(k < (Count - 1))
                {
                    m_memberList[i].m_array[k] = m_memberList[i].m_array[k + 1];
                    ++k;
                    // [Loop Continue]
                    goto J0x86;
                }
                m_memberList[i].m_array.Length = Count - 1;
                // [Explicit Break]
                goto J0xF9;
            }
            ++j;
            // [Loop Continue]
            goto J0x47;
        }
        J0xF9:

        // End:0x10B
        if(j < Count)
        {
            // [Explicit Break]
            goto J0x115;
        }
        ++i;
        // [Loop Continue]
        goto J0x1D;
    }
    J0x115:

    // End:0x12F
    if(i == m_currentShowIndex)
    {
        ShowList(i);
    }
    UpdateOnline();
    return;
}

function RefreshCombobox()
{
    local int i, Index, newIndex, addedCount;

    Index = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum(m_WindowName $ ".ComboboxMainClanWnd");
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear(m_WindowName $ ".ComboboxMainClanWnd");
    addedCount = -1;
    i = 0;
    J0x70:

    // End:0x11D [Loop If]
    if(i < 8)
    {
        // End:0x113
        if(m_memberList[i].m_sName != "")
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved(m_WindowName $ ".ComboboxMainClanWnd", ((GetClanTypeNameFromIndex(GetClanTypeFromIndex(i))) @ "-") @ m_memberList[i].m_sName, GetClanTypeFromIndex(i));
            ++addedCount;
            // End:0x113
            if(i == m_currentShowIndex)
            {
                newIndex = addedCount;
            }
        }
        ++i;
        // [Loop Continue]
        goto J0x70;
    }
    i = 0;
    J0x124:

    // End:0x1A6 [Loop If]
    if(i < 10)
    {
        // End:0x19C
        if(Class'NWindow.UIAPI_COMBOBOX'.static.GetReserved(m_WindowName $ ".ComboboxMainClanWnd", i) == m_myClanType)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum(m_WindowName $ ".ComboboxMainClanWnd", i);
        }
        ++i;
        // [Loop Continue]
        goto J0x124;
    }
    return;
}

function HandleSubClanUpdated(string a_Param)
{
    local int Id, Type;
    local string sName, sMasterName;
    local ClanDrawerWnd script;

    ParseInt(a_Param, "ClanID", Id);
    ParseInt(a_Param, "ClanType", Type);
    ParseString(a_Param, "ClanName", sName);
    ParseString(a_Param, "MasterName", sMasterName);
    m_memberList[GetIndexFromType(Type)].m_sName = sName;
    m_memberList[GetIndexFromType(Type)].m_sMasterName = sMasterName;
    RefreshCombobox();
    // End:0x102
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("ClanDrawerWnd.ClanInfoWnd"))
    {
        script = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
        script.InitializeClanInfoWnd();
    }
    return;
}

function AskJoin()
{
    local UserInfo User;

    // End:0x3F
    if(GetTargetInfo(User))
    {
        // End:0x3F
        if(User.nID > 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("InviteClanPopWnd");
        }
    }
    return;
}

function HandleClanMyAuth(string a_Param)
{
    ParseInt(a_Param, "ClanMaster", m_bClanMaster);
    ParseInt(a_Param, "Join", m_bJoin);
    ParseInt(a_Param, "NickName", m_bNickName);
    ParseInt(a_Param, "ClanCrest", m_bCrest);
    ParseInt(a_Param, "War", m_bWar);
    ParseInt(a_Param, "Grade", m_bGrade);
    ParseInt(a_Param, "ManageMaster", m_bManageMaster);
    ParseInt(a_Param, "OustMember", m_bOustMember);
    resetBtnShowHide();
    return;
}

function ResetOpeningVariables()
{
    m_currentactivestatus1 = false;
    m_currentactivestatus2 = false;
    m_currentactivestatus3 = false;
    m_currentactivestatus4 = false;
    m_currentactivestatus5 = false;
    m_currentactivestatus6 = false;
    m_currentactivestatus7 = false;
    m_currentactivestatus8 = false;
    return;
}

defaultproperties
{
    m_WindowName="ClanWnd"
}
