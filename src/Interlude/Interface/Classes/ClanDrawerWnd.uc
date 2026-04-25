class ClanDrawerWnd extends UIScript;

const c_maxranklimit = 100;
const changelineval1 = 23;

var string m_State;
var int m_clanType;
var int m_clanWarListPage;
var int m_currentEditGradeID;
var string m_currentName;
var string m_myName;
var int m_currentMaster;
var string currentMasterName;
var WindowHandle Clan3_OrgIcon[8];

function OnLoad()
{
    RegisterEvent(350);
    RegisterEvent(360);
    RegisterEvent(370);
    RegisterEvent(380);
    RegisterEvent(430);
    RegisterEvent(460);
    RegisterEvent(490);
    RegisterEvent(500);
    RegisterEvent(160);
    RegisterEvent(470);
    InitHandle();
    InitializeGradeComboBox();
    HideAll();
    m_clanWarListPage = -1;
    return;
}

function InitHandle()
{
    local int i;

    i = 0;

    while(i < 8)
    {
        Clan3_OrgIcon[i] = GetHandle("ClanDrawerWnd.Clan3_OrgIcon" $ string(i + 1));
        ++i;
    }
    return;
}

function OnShow()
{
    local ClanWnd script;

    script = ClanWnd(GetScript("ClanWnd"));
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
    // End:0x2A8
    if(script.m_bClanMaster == 0)
    {
        // End:0x18F
        if(script.m_bNickName == 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
        }
        // End:0x1DC
        if(script.m_bGrade == 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
        }
        // End:0x260
        if(script.m_bManageMaster == 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
        }
        // End:0x2A8
        if(script.m_bOustMember == 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
        }
    }
    return;
}

function Clear()
{
    m_State = "";
    m_clanType = -1;
    m_clanWarListPage = -1;
    m_currentEditGradeID = -1;
    m_currentName = "";
    return;
}

function SetStateAndShow(string State)
{
    local ClanWnd script;
    local int i;
    local string string1, string2, string3, string4;

    m_State = State;
    // End:0x4C
    if(!Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("ClanDrawerWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd");
    }
    HideAll();
    // End:0x18F
    if(m_State == "ClanMemberInfoState")
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.ClanMemberInfoWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");        
    }
    else
    {
        // End:0x2DA
        if(m_State == "ClanMemberAuthState")
        {
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.ClanMemberAuthWnd");
            i = 0;

            while(i <= 9)
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan2_Check10" $ string(i), true);
                ++i;
            }
            i = 0;

            while(i <= 5)
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan2_Check20" $ string(i), true);
                ++i;
            }
            i = 0;

            while(i <= 8)
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan2_Check30" $ string(i), true);
                ++i;
            }            
        }
        else
        {
            // End:0x326
            if(m_State == "ClanInfoState")
            {
                Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.ClanInfoWnd");
                InitializeClanInfoWnd();                
            }
            else
            {
                // End:0x37B
                if(m_State == "ClanAuthManageWndState")
                {
                    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.ClanAuthManageWnd");                    
                }
                else
                {
                    // End:0x53B
                    if(m_State == "ClanEmblemManageWndState")
                    {
                        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.ClanEmblemManageWnd");
                        string1 = Left(GetSystemMessage(211), 23);
                        string2 = Right(GetSystemMessage(211), Len(GetSystemMessage(211)) - 23);
                        string3 = Left(GetSystemMessage(1478), 23);
                        string4 = Right(GetSystemMessage(1478), Len(GetSystemMessage(1478)) - 23);
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan7_ManageEmb1Text1", string1);
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan7_ManageEmb1Text2", string2);
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan7_ManageEmb2Text1", string3);
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan7_ManageEmb2Text2", string4);
                        script = ClanWnd(GetScript("ClanWnd"));                        
                    }
                    else
                    {
                        // End:0x5C5
                        if(m_State == "ClanWarManagementWndState")
                        {
                            Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("ClanDrawerWnd.ClanWarTabCtrl", 0, true);
                            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.ClanWarManagementWnd");                            
                        }
                        else
                        {
                            // End:0x616
                            if(m_State == "ClanAuthEditWndState")
                            {
                                Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.ClanAuthEditWnd");                                
                            }
                            else
                            {
                                // End:0x65C
                                if(m_State == "ClanHeroWndState")
                                {
                                    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.ClanHeroWnd");
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function HideAll()
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.ClanMemberInfoWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.ClanMemberAuthWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.ClanInfoWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.ClanPenaltyWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.ClanWarManagementWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.ClanAuthManageWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.ClanAuthEditWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.ClanEmblemManageWnd");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.ClanHeroWnd");
    return;
}

function OnClickButton(string strID)
{
    local LVDataRecord Record;
    local int i;
    local ClanWnd script;

    script = ClanWnd(GetScript("ClanWnd"));
    if(strID == "Clan1_AskJoinPartyBtn")
    {
        RequestInviteParty(Class'NWindow.UIAPI_TEXTBOX'.static.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"));
    }
    else if(strID == "Clan1_ChangeMemberNameBtn")
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
        Class'NWindow.UIAPI_EDITBOX'.static.SetString("ClanDrawerWnd.Clan1_ChangeNameTextEditbox", "");
    }
    else if(strID == "Clan1_ChangeMemberGradeBtn")
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
    }
    else if(strID == "Clan1_ChangeBanishBtn")
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
        RequestClanExpelMember(m_clanType, Class'NWindow.UIAPI_TEXTBOX'.static.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"));
    }
    else if(strID == "Clan1_AssignApprenticeBtn")
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
        InitializeAcademyList();
    }
    else if(strID == "Clan1_ChangeMemberKHOpen")
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
        KnighthoodCombobox();
    }
    else if(strID == "Clan1_DeleteApprenticeBtn")
    {
        RequestClanDeletePupil(Class'NWindow.UIAPI_TEXTBOX'.static.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"), Class'NWindow.UIAPI_TEXTBOX'.static.GetText("ClanDrawerWnd.Clan1_CurrentSelectedApprentice"));
        RecallCurrentMemberInfo();
    }
    else if(strID == "Clan1_OKBtn")
    {
        HideWindow();
    }
    else if(strID == "Clan1_ChangeNameAssignBtn")
    {
        RequestClanChangeNickName(Class'NWindow.UIAPI_TEXTBOX'.static.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"), Class'NWindow.UIAPI_EDITBOX'.static.GetString("ClanDrawerWnd.Clan1_ChangeNameTextEditbox"));
        Class'NWindow.UIAPI_EDITBOX'.static.SetString("ClanDrawerWnd.Clan1_ChangeNameTextEditbox", "");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
        RecallCurrentMemberInfo();
    }
    else if(strID == "Clan1_ChangeNameDeleteBtn")
    {
        RequestClanChangeNickName(Class'NWindow.UIAPI_TEXTBOX'.static.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"), "");
        Class'NWindow.UIAPI_EDITBOX'.static.SetString("ClanDrawerWnd.Clan1_ChangeNameTextEditbox", "");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
        RecallCurrentMemberInfo();
    }
    else if(strID == "Clan1_ChangeMemberGradeAssignBtn")
    {
        if(Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("ClanDrawerWnd.Clan1_MemberGradeList") <= 5)
        {
            RequestClanChangeGrade(Class'NWindow.UIAPI_TEXTBOX'.static.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"), Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("ClanDrawerWnd.Clan1_MemberGradeList"));
        }
        else
        {
            RequestClanChangeGrade(Class'NWindow.UIAPI_TEXTBOX'.static.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"), getCurrentGradebyClanType());
        }
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
        RecallCurrentMemberInfo();
    }
    else if(strID == "Clan1_ApprenticeAssignBtn")
    {
        i = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedIndex("ClanDrawerWnd.Clan1_AssignApprenticeList");
        if((i >= 0) && m_currentName != "")
        {
            Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetRecord("ClanDrawerWnd.Clan1_AssignApprenticeList", i);
            RequestClanAssignPupil(m_currentName, Record.LVDataList[0].szData);
        }
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
    }
    else if(strID == "Clan1_ChangeMemberKnightHoodBtn")
    {
        proc_swapmember();
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
    }
    else if(strID == "Clan1_Cancel1")
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
    }
    else if(strID == "Clan1_Cancel2")
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
    }
    else if(strID == "Clan1_Cancel3")
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
    }
    else if(strID == "Clan1_Cancel4")
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
    }
    else if(strID == "Clan7_RegEmbBtn")
    {
        RequestClanRegisterCrest();
    }
    else if(strID == "Clan7_RmEmbBtn")
    {
        RequestClanUnregisterCrest();
    }
    else if(strID == "Clan7_RegEmb2Btn")
    {
        RequestClanRegisterEmblem();
    }
    else if(strID == "Clan7_RmEmb2Btn")
    {
        RequestClanUnregisterEmblem();
    }
    else if(strID == "Clan8_CancelWar1Btn")
    {
        HandleCancelWar1();
    }
    else if(strID == "Clan8_DeclareWar1Btn")
    {
        HandleDeclareWar();
    }
    else if(strID == "Clan8_CancelWar2Btn")
    {
        HandleCancelWar2();
    }
    else if(strID == "Clan8_ViewMoreBtn")
    {
        RequestClanWarList(++m_clanWarListPage, 1);
    }
    else if(strID == "Clan2_OKBtn")
    {
        HideWindow();
    }
    else if(strID == "Clan3_OKBtn")
    {
        HideWindow();
    }
    else if(strID == "Clan4_OKBtn")
    {
        HideWindow();
    }
    else if(strID == "Clan5_OKBtn")
    {
        HideWindow();
    }
    else if(strID == "Clan7_OKBtn")
    {
        HideWindow();
    }
    else if(strID == "ClanWar_OKBtn")
    {
        HideWindow();
    }
    else if(strID == "Clan5_ManageBtn")
    {
        EditAuthGrade();
    }
    else if(strID == "Clan5_ManageBtn2")
    {
        EditAuthGrade2();
    }
    else if(strID == "Clan6_ApplyBtn")
    {
        ApplyEditGrade();
        SetStateAndShow("ClanAuthManageWndState");
    }
    else if(strID == "Clan6_CancelBtn")
    {
        SetStateAndShow("ClanAuthManageWndState");
    }
    else if(strID == "ClanWarTabCtrl0")
    {
        RequestClanWarList(0, 0);
    }
    else if(strID == "ClanWarTabCtrl1")
    {
        RequestClanWarList(m_clanWarListPage, 1);
    }
    else if(strID == "Clan1_ChangeNameAssignNobBtn")
    {
        RequestClanChangeNickName(script.m_myName, Class'NWindow.UIAPI_EDITBOX'.static.GetString("ClanDrawerWnd.Clan1_ChangeNobNameTextEditbox"));
        Class'NWindow.UIAPI_EDITBOX'.static.SetString("ClanDrawerWnd.Clan1_ChangeNobNameTextEditbox", "");
    }
    else if(strID == "Clan1_NobCancel1")
    {
        HideWindow();
    }
    else if(strID == "Clan1_ChangeNameDeleteNobBtn")
    {
        RequestClanChangeNickName(script.m_myName, "");
    }
    return;
}
function OnDBClickListCtrlRecord(string ListCtrlID)
{
    local int i;
    local LVDataRecord Record;

    // End:0x24
    if(ListCtrlID == "Clan5_AuthListCtrl")
    {
        EditAuthGrade();
    }
    // End:0x49
    if(ListCtrlID == "Clan5_AuthListCtrl2")
    {
        EditAuthGrade2();
    }
    // End:0x15F
    if(ListCtrlID == "Clan1_AssignApprenticeList")
    {
        i = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedIndex("ClanDrawerWnd.Clan1_AssignApprenticeList");
        // End:0x127
        if((i >= 0) && m_currentName != "")
        {
            Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetRecord("ClanDrawerWnd.Clan1_AssignApprenticeList", i);
            RequestClanAssignPupil(m_currentName, Record.LVDataList[0].szData);
        }
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
    }
    return;
}

function RecallCurrentMemberInfo()
{
    local ClanWnd script;

    script = ClanWnd(GetScript("ClanWnd"));
    RequestClanMemberInfo(script.G_CurrentRecord, script.G_CurrentSzData);
    SetStateAndShow("ClanMemberInfoState");
    return;
}

function OnClickCheckBox(string CheckBoxID)
{
    local string CheckboxNum, CheckboxName;
    local bool CheckedStat;
    local int i;

    CheckboxName = Left(CheckBoxID, 12);
    // End:0x1AB
    if(CheckboxName == "Clan6_Check1")
    {
        CheckboxNum = Right(CheckBoxID, 2);
        // End:0x13A
        if(CheckboxNum == "00")
        {
            CheckedStat = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ClanDrawerWnd.Clan6_Check100");
            switch(CheckedStat)
            {
                // End:0xDA
                case true:
                    i = 0;

                    while(i <= 9)
                    {
                        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check10" $ string(i), true);
                        ++i;
                    }
                    // End:0x137
                    break;
                // End:0x134
                case false:
                    i = 0;

                    while(i <= 9)
                    {
                        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check10" $ string(i), false);
                        ++i;
                    }
                    // End:0x137
                    break;
                // End:0xFFFF
                default:
                    break;
            }            
        }
        else
        {
            // End:0x17D
            if((count_all_check("10", 9)) == true)
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check100", true);                
            }
            else
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check100", false);
            }
        }
    }
    // End:0x347
    if(CheckboxName == "Clan6_Check2")
    {
        CheckboxNum = Right(CheckBoxID, 2);
        // End:0x2D6
        if(CheckboxNum == "00")
        {
            CheckedStat = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ClanDrawerWnd.Clan6_Check200");
            switch(CheckedStat)
            {
                // End:0x276
                case true:
                    i = 0;

                    while(i <= 5)
                    {
                        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check20" $ string(i), true);
                        ++i;
                    }
                    // End:0x2D3
                    break;
                // End:0x2D0
                case false:
                    i = 0;

                    while(i <= 5)
                    {
                        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check20" $ string(i), false);
                        ++i;
                    }
                    // End:0x2D3
                    break;
                // End:0xFFFF
                default:
                    break;
            }            
        }
        else
        {
            // End:0x319
            if((count_all_check("20", 8)) == true)
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check200", true);                
            }
            else
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check200", false);
            }
        }
    }
    // End:0x4E3
    if(CheckboxName == "Clan6_Check3")
    {
        CheckboxNum = Right(CheckBoxID, 2);
        // End:0x472
        if(CheckboxNum == "00")
        {
            CheckedStat = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ClanDrawerWnd.Clan6_Check300");
            switch(CheckedStat)
            {
                // End:0x412
                case true:
                    i = 0;

                    while(i <= 9)
                    {
                        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check30" $ string(i), true);
                        ++i;
                    }
                    // End:0x46F
                    break;
                // End:0x46C
                case false:
                    i = 0;

                    while(i <= 9)
                    {
                        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check30" $ string(i), false);
                        ++i;
                    }
                    // End:0x46F
                    break;
                // End:0xFFFF
                default:
                    break;
            }            
        }
        else
        {
            // End:0x4B5
            if((count_all_check("30", 9)) == true)
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check300", true);                
            }
            else
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check300", false);
            }
        }
    }
    return;
}

function bool count_all_check(string numString, int TotalNum)
{
    local bool checkall, currentcheck;
    local int i;

    checkall = false;
    i = 1;

    while(i <= TotalNum)
    {
        currentcheck = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked(("ClanDrawerWnd.Clan6_Check" $ numString) $ string(i));
        // End:0x73
        if(currentcheck == true)
        {
            checkall = true;
        }
        ++i;
    }
    return checkall;
}

function bool count_all_check2(string numString, int TotalNum)
{
    local bool checkall, currentcheck;
    local int i;

    checkall = false;
    i = 1;

    while(i <= TotalNum)
    {
        currentcheck = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked(("ClanDrawerWnd.Clan2_Check" $ numString) $ string(i));
        // End:0x73
        if(currentcheck == true)
        {
            checkall = true;
        }
        ++i;
    }
    return checkall;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x1D
        case 350:
            HandleClanAuthGradeList(a_Param);
            // End:0xF6
            break;
        // End:0x33
        case 460:
            HandleClanWarList(a_Param);
            // End:0xF6
            break;
        // End:0x46
        case 360:
            HandleCrestChange(a_Param);
        // End:0x5C
        case 430:
            HandleClanMemberInfo(a_Param);
            // End:0xF6
            break;
        // End:0x72
        case 490:
            HandleSkillList(a_Param);
            // End:0xF6
            break;
        // End:0x88
        case 500:
            HandleSkillListAdd(a_Param);
            // End:0xF6
            break;
        // End:0x9E
        case 370:
            HandleClanAuth(a_Param);
            // End:0xF6
            break;
        // End:0xB4
        case 380:
            HandleClanAuthMember(a_Param);
            // End:0xF6
            break;
        // End:0xDA
        case 160:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
            // End:0xF6
            break;
        // End:0xF0
        case 470:
            HandleClearWarList(a_Param);
            // End:0xF6
            break;
        // End:0xFFFF
        default:
            // End:0xF6
            break;
            break;
    }
    return;
}

function HandleClanAuthGradeList(string a_Param)
{
    local int Count, Id, members, i;
    local LVDataRecord Record;
    local LVData Data;

    Record.LVDataList.Length = 2;
    Class'NWindow.UIAPI_LISTCTRL'.static.DeleteAllItem("ClanDrawerWnd.Clan5_AuthListCtrl");
    Class'NWindow.UIAPI_LISTCTRL'.static.DeleteAllItem("ClanDrawerWnd.Clan5_AuthListCtrl2");
    ParseInt(a_Param, "Count", Count);
    i = 0;

    while(i < 5)
    {
        ParseInt(a_Param, "GradeID" $ string(i), Id);
        ParseInt(a_Param, "GradeMemberCount" $ string(i), members);
        Data.szData = GetStringByGradeID(Id);
        Record.LVDataList[0] = Data;
        Data.szData = string(members);
        Record.LVDataList[1] = Data;
        Record.nReserved1 = Id;
        Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord("ClanDrawerWnd.Clan5_AuthListCtrl", Record);
        ++i;
    }
    i = 5;

    while(i < 9)
    {
        ParseInt(a_Param, "GradeID" $ string(i), Id);
        ParseInt(a_Param, "GradeMemberCount" $ string(i), members);
        Data.szData = GetStringByGradeID(Id);
        Record.LVDataList[0] = Data;
        Data.szData = string(members);
        Record.LVDataList[1] = Data;
        Record.nReserved1 = Id;
        Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord("ClanDrawerWnd.Clan5_AuthListCtrl2", Record);
        ++i;
    }
    Class'NWindow.UIAPI_LISTCTRL'.static.SetSelectedIndex("ClanDrawerWnd.Clan5_AuthListCtrl", 0, true);
    Class'NWindow.UIAPI_LISTCTRL'.static.SetSelectedIndex("ClanDrawerWnd.Clan5_AuthListCtrl2", 0, true);
    return;
}

function HandleClanWarList(string a_Param)
{
    local string sClanName;
    local int Type, period;
    local LVDataRecord Record;
    local int page;

    ParseInt(a_Param, "Page", page);
    ParseString(a_Param, "ClanName", sClanName);
    ParseInt(a_Param, "Type", Type);
    ParseInt(a_Param, "Period", period);
    Record.LVDataList.Length = 3;
    Record.LVDataList[0].szData = sClanName;
    Record.LVDataList[1].szData = GetWarStateString(Type);
    Record.LVDataList[2].szData = string(period);
    // End:0x13F
    if((Type == 0) || Type == 2)
    {
        Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("ClanDrawerWnd.ClanWarTabCtrl", 0, true);
        Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord("ClanDrawerWnd.Clan8_DeclaredListCtrl", Record);        
    }
    else
    {
        Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("ClanDrawerWnd.ClanWarTabCtrl", 1, true);
        m_clanWarListPage = page;
        Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord("ClanDrawerWnd.Clan8_GotDeclaredListCtrl", Record);
    }
    return;
}

function HandleClanMemberInfo(string a_Param)
{
    local string nickname;
    local int gradeID;
    local string organization, MasterName;
    local ClanWnd script;
    local string organizationtext;

    script = ClanWnd(GetScript("ClanWnd"));
    ParseInt(a_Param, "ClanType", m_clanType);
    ParseString(a_Param, "Name", m_currentName);
    ParseString(a_Param, "NickName", nickname);
    ParseInt(a_Param, "GradeID", gradeID);
    ParseString(a_Param, "OrderName", organization);
    ParseString(a_Param, "MasterName", MasterName);
    currentMasterName = MasterName;
    // End:0xD9
    if(MasterName == "")
    {
        MasterName = GetSystemString(27);
    }
    organizationtext = ((getClanOrderString(m_clanType)) @ "-") @ organization;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName", m_currentName);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberSName", nickname);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberGrade", GetStringByGradeID(gradeID));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberOrderName", organizationtext);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedApprentice", MasterName);
    // End:0x2C8
    if(script.m_CurrentclanMasterReal == m_currentName)
    {
        // End:0x2C8
        if(script.m_currentShowIndex == 0)
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberGrade", GetSystemString(342));
        }
    }
    // End:0x398
    if(m_clanType == -1)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedApprenticeTitle", GetSystemString(1332));        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
        // End:0x487
        if(currentMasterName != "")
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
        }
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedApprenticeTitle", GetSystemString(1431));
    }
    script.resetBtnShowHide();
    CheckandCompareMyNameandDisableThings();
    return;
}

function CheckandCompareMyNameandDisableThings()
{
    local ClanWnd script;
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    m_myName = UserInfo.Name;
    script = ClanWnd(GetScript("ClanWnd"));
    // End:0x1F3
    if(script.m_bClanMaster > 0)
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
        // End:0x180
        if(currentMasterName != "")
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
            // End:0x17D
            if(script.G_CurrentAlias == true)
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
            }            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
        }        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
        Proc_AuthValidation();
        // End:0x3F4
        if(script.GetClanTypeFromIndex(script.m_currentShowIndex) < script.m_myClanType)
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
            // End:0x3BC
            if(m_clanType == -1)
            {                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
            }
        }
        // End:0x555
        if(script.m_myClanType > 1)
        {
            // End:0x555
            if(script.GetClanTypeFromIndex(script.m_currentShowIndex) != 0)
            {
                // End:0x464
                if((script.m_myClanType - script.GetClanTypeFromIndex(script.m_currentShowIndex)) == 1)
                {
                    Proc_AuthValidation();
                }
                // End:0x4A1
                if((script.m_myClanType - script.GetClanTypeFromIndex(script.m_currentShowIndex)) == 1000)
                {
                    Proc_AuthValidation();
                }
                // End:0x4DB
                if((script.m_myClanType - script.GetClanTypeFromIndex(script.m_currentShowIndex)) == 100)
                {
                    Proc_AuthValidation();
                }
                // End:0x518
                if((script.m_myClanType - script.GetClanTypeFromIndex(script.m_currentShowIndex)) == 999)
                {
                    Proc_AuthValidation();
                }
                // End:0x555
                if((script.m_myClanType - script.GetClanTypeFromIndex(script.m_currentShowIndex)) == 1001)
                {
                    Proc_AuthValidation();
                }
            }
        }
        // End:0x6B6
        if(script.G_CurrentAlias == true)
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
        }
        // End:0x81A
        if(script.m_CurrentclanMasterReal == m_currentName)
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
        }
    }
    // End:0x8CD
    if(m_currentName == m_myName)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
    }
    // End:0x985
    if(m_clanType == -1)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
    }
    return;
}

function Proc_AuthValidation()
{
    local ClanWnd script;

    script = ClanWnd(GetScript("ClanWnd"));
    // End:0xD0
    if(script.m_bNickName == 0)
    {
        // End:0x95
        if((script.G_IamHero == true) || script.G_IamNobless == true)
        {
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
        }        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
    }
    // End:0x158
    if(script.m_bGrade == 0)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
    }
    // End:0x218
    if(script.m_bManageMaster == 0)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");        
    }
    else
    {
        // End:0x297
        if(currentMasterName != "")
        {
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
            Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
        }
    }
    // End:0x352
    if(script.m_bOustMember == 0)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
    }
    return;
}

function HandleCrestChange(string param)
{
    local ClanWnd script;

    // End:0x7F
    if(m_State == "ClanEmblemManageWndState")
    {
        script = ClanWnd(GetScript("ClanWnd"));
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTextureWithClanCrest("ClanDrawerWnd.ClanCrestTextureCtrl", script.m_clanID);
    }
    return;
}

function HandleSkillList(string a_Param)
{
    local int Count, i, Id, Level;

    ParseInt(a_Param, "Count", Count);
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("ClanDrawerWnd.ClanSkillWnd");
    i = 0;

    while(i < Count)
    {
        ParseInt(a_Param, "SkillID" $ string(i), Id);
        ParseInt(a_Param, "SkillLevel" $ string(i), Level);
        AddSkill(Id, Level);
        ++i;
    }
    return;
}

function HandleSkillListAdd(string a_Param)
{
    local int Id, Level, i, Count;
    local ItemInfo Info;

    ParseInt(a_Param, "SkillID", Id);
    ParseInt(a_Param, "SkillLevel", Level);
    Count = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("ClanDrawerWnd.ClanSkillWnd");
    i = 0;

    while(i < Count)
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("ClanDrawerWnd.ClanSkillWnd", i, Info);
        // End:0xC8
        if(Info.ClassID == Id)
        {
            break;
        }
        ++i;
    }

    // End:0xF9
    if(i < Count)
    {
        ReplaceSkill(i, Id, Level);        
    }
    else
    {
        AddSkill(Id, Level);
    }
    return;
}

function HandleCancelWar1()
{
    local LVDataRecord Record;
    local int Index;

    Index = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedIndex("ClanDrawerWnd.Clan8_DeclaredListCtrl");
    // End:0xC6
    if(Index >= 0)
    {
        Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetRecord("ClanDrawerWnd.Clan8_DeclaredListCtrl", Index);
        RequestClanWithdrawWarWithClanName(Record.LVDataList[0].szData);
        RequestClanWarList(0, 0);
        SetStateAndShow("ClanWarManagementWndState");
    }
    return;
}

function HandleDeclareWar()
{
    local LVDataRecord Record;
    local int Index;

    Index = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedIndex("ClanDrawerWnd.Clan8_GotDeclaredListCtrl");
    // End:0xAF
    if(Index >= 0)
    {
        Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetRecord("ClanDrawerWnd.Clan8_GotDeclaredListCtrl", Index);
        RequestClanDeclareWarWidhClanName(Record.LVDataList[0].szData);
        RequestClanWarList(m_clanWarListPage, 1);
    }
    return;
}

function HandleCancelWar2()
{
    local LVDataRecord Record;
    local int Index;

    Index = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedIndex("ClanDrawerWnd.Clan8_GotDeclaredListCtrl");
    // End:0x111
    if(Index >= 0)
    {
        Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetRecord("ClanDrawerWnd.Clan8_GotDeclaredListCtrl", Index);
        RequestClanWithdrawWarWithClanName(Record.LVDataList[0].szData);
        RequestClanWarList(m_clanWarListPage, 1);
        Class'NWindow.UIAPI_TABCTRL'.static.SetTopOrder("ClanDrawerWnd.ClanWarTabCtrl", 1, true);
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ClanDrawerWnd.ClanWarManagementWnd");
    }
    return;
}

function HandleClanAuth(string a_Param)
{
    local int gradeID, Command;
    local array<int> powers;
    local int i, Index;

    ParseInt(a_Param, "GradeID", gradeID);
    ParseInt(a_Param, "Command", Command);
    powers.Length = 32;
    i = 0;

    while(i < 32)
    {
        ParseInt(a_Param, "PowerValue" $ string(i), powers[i]);
        ++i;
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan6_CurrentSelectedRankName", (GetStringByGradeID(gradeID)) $ GetSystemString(1376));
    Index = 1;
    i = 1;

    while(i <= 9)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check10" $ string(i), bool(powers[Index++]));
        ++i;
    }
    i = 1;

    while(i <= 5)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check20" $ string(i), bool(powers[Index++]));
        ++i;
    }
    i = 1;

    while(i <= 8)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check30" $ string(i), bool(powers[Index++]));
        ++i;
    }
    // End:0x244
    if((count_all_check("10", 9)) == true)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check100", true);        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check100", false);
    }
    // End:0x2B5
    if((count_all_check("20", 5)) == true)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check200", true);        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check200", false);
    }
    // End:0x326
    if((count_all_check("30", 8)) == true)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check300", true);        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan6_Check300", false);
    }
    // End:0x369
    if(gradeID == 9)
    {
        disableAcademyAuth();        
    }
    else
    {
        resetAcademyAuth();
    }
    return;
}

function HandleClanAuthMember(string a_Param)
{
    local ClanWnd script;
    local int gradeID;
    local string sName;
    local array<int> powers;
    local int i, Index;

    script = ClanWnd(GetScript("ClanWnd"));
    ParseInt(a_Param, "Grade", gradeID);
    ParseString(a_Param, "Name", sName);
    powers.Length = 32;
    i = 0;

    while(i < 32)
    {
        ParseInt(a_Param, "PowerValue" $ string(i), powers[i]);
        ++i;
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan2_CurrentSelectedMemberName", (sName @ "-") @ (GetStringByGradeID(gradeID)));
    Index = 1;
    i = 1;

    while(i <= 9)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check10" $ string(i), bool(powers[Index++]));
        ++i;
    }
    i = 1;

    while(i <= 5)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check20" $ string(i), bool(powers[Index++]));
        ++i;
    }
    i = 1;

    while(i <= 8)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check30" $ string(i), bool(powers[Index++]));
        ++i;
    }
    // End:0x25A
    if((count_all_check2("10", 9)) == true)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check100", true);        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check100", false);
    }
    // End:0x2CB
    if((count_all_check2("20", 5)) == true)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check200", true);        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check200", false);
    }
    // End:0x33C
    if((count_all_check2("30", 8)) == true)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check300", true);        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check300", false);
    }
    // End:0x493
    if(script.m_myName == sName)
    {
        // End:0x3C8
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ClanDrawerWnd.Clan2_Check101") == true)
        {
            script.m_bJoin = 1;            
        }
        else
        {
            script.m_bJoin = 0;
        }
        // End:0x41E
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ClanDrawerWnd.Clan2_Check107") == true)
        {
            script.m_bCrest = 1;            
        }
        else
        {
            script.m_bCrest = 0;
        }
        // End:0x474
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ClanDrawerWnd.Clan2_Check105") == true)
        {
            script.m_bWar = 1;            
        }
        else
        {
            script.m_bWar = 0;
        }
        script.resetBtnShowHide();
    }
    // End:0x5F9
    if(script.m_CurrentclanMasterReal == sName)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan2_CurrentSelectedMemberName", (sName @ "-") @ GetSystemString(342));
        i = 0;

        while(i <= 9)
        {
            Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check10" $ string(i), true);
            ++i;
        }
        i = 0;

        while(i <= 5)
        {
            Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check20" $ string(i), true);
            ++i;
        }
        i = 0;

        while(i <= 8)
        {
            Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("ClanDrawerWnd.Clan2_Check30" $ string(i), true);
            ++i;
        }
    }
    return;
}

function HandleClearWarList(string a_Param)
{
    local int Condition;

    // End:0x99
    if(ParseInt(a_Param, "Condition", Condition))
    {
        // End:0x61
        if(Condition == 0)
        {
            Class'NWindow.UIAPI_LISTCTRL'.static.DeleteAllItem("ClanDrawerWnd.Clan8_DeclaredListCtrl");            
        }
        else
        {
            Class'NWindow.UIAPI_LISTCTRL'.static.DeleteAllItem("ClanDrawerWnd.Clan8_GotDeclaredListCtrl");
        }
    }
    return;
}

function string GetStringByGradeID(int gradeID)
{
    local int stringIndex;

    stringIndex = -1;
    Debug("gradeID" @ string(gradeID));
    // End:0x3C
    if(gradeID == 1)
    {
        stringIndex = 1406;        
    }
    else
    {
        // End:0x56
        if(gradeID == 2)
        {
            stringIndex = 1407;            
        }
        else
        {
            // End:0x70
            if(gradeID == 3)
            {
                stringIndex = 1408;                
            }
            else
            {
                // End:0x8A
                if(gradeID == 4)
                {
                    stringIndex = 1409;                    
                }
                else
                {
                    // End:0xA4
                    if(gradeID == 5)
                    {
                        stringIndex = 1410;                        
                    }
                    else
                    {
                        // End:0xBE
                        if(gradeID == 6)
                        {
                            stringIndex = 1411;                            
                        }
                        else
                        {
                            // End:0xD8
                            if(gradeID == 7)
                            {
                                stringIndex = 1412;                                
                            }
                            else
                            {
                                // End:0xF2
                                if(gradeID == 8)
                                {
                                    stringIndex = 1413;                                    
                                }
                                else
                                {
                                    // End:0x109
                                    if(gradeID == 9)
                                    {
                                        stringIndex = 1414;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    // End:0x127
    if(stringIndex != -1)
    {
        return GetSystemString(stringIndex);        
    }
    else
    {
        return "";
    }
    return "";
}

function InitializeAcademyList()
{
    local ClanWnd script;
    local int i;
    local LVDataRecord Record;

    Record.LVDataList.Length = 3;
    script = ClanWnd(GetScript("ClanWnd"));
    InitializeClan1_AssignApprenticeList();
    i = 0;

    while(i < script.m_memberList[script.GetIndexFromType(-1)].m_array.Length)
    {
        // End:0x267
        if(script.m_memberList[script.GetIndexFromType(-1)].m_array[i].bHaveMaster == 0)
        {
            Record.LVDataList[0].szData = script.m_memberList[script.GetIndexFromType(-1)].m_array[i].sName;
            Record.LVDataList[1].szData = string(script.m_memberList[script.GetIndexFromType(-1)].m_array[i].Level);
            Record.nReserved1 = script.m_memberList[script.GetIndexFromType(-1)].m_array[i].clanType;
            Record.LVDataList[2].szData = string(script.m_memberList[script.GetIndexFromType(-1)].m_array[i].ClassID);
            Record.LVDataList[2].szTexture = script.GetClanClassIconCustom(script.m_memberList[script.GetIndexFromType(-1)].m_array[i].ClassID);
            Record.LVDataList[2].nTextureWidth = 16;
            Record.LVDataList[2].nTextureHeight = 16;
            Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord("ClanDrawerWnd.Clan1_AssignApprenticeList", Record);
        }
        ++i;
    }
    return;
}

function InitializeClan1_AssignApprenticeList()
{
    Class'NWindow.UIAPI_LISTCTRL'.static.DeleteAllItem("ClanDrawerWnd.Clan1_AssignApprenticeList");
    return;
}

function InitializeClanInfoWnd()
{
    local Color Blue, Red, DarkYellow;
    local ClanWnd script;
    local int i;
    local string ClanNameVal, ClanRankStr, ToolTip;
    local int clanType;

    Blue.R = 126;
    Blue.G = 158;
    Blue.B = 245;
    Red.R = 200;
    Red.G = 50;
    Red.B = 80;
    DarkYellow.R = 175;
    DarkYellow.G = 152;
    DarkYellow.B = 120;
    script = ClanWnd(GetScript("ClanWnd"));
    ClanNameVal = string(script.m_clanNameValue) @ GetSystemString(1442);
    reset_clan_org();
    // End:0xE0
    if(script.m_clanRank == 0)
    {
        ClanRankStr = GetSystemString(1374);        
    }
    else
    {
        // End:0x11B
        if(script.m_clanRank <= 100)
        {
            ClanRankStr = GetSystemString(1375) @ string(script.m_clanRank);            
        }
        else
        {
            ClanRankStr = GetSystemString(1374);
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan3_ClanName", script.m_clanName);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan3_ClanPoint", ClanNameVal);
    // End:0x1E4
    if(script.m_clanNameValue == 0)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("ClanDrawerWnd.Clan3_ClanPoint", DarkYellow);        
    }
    else
    {
        // End:0x22E
        if(script.m_clanNameValue < 0)
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("ClanDrawerWnd.Clan3_ClanPoint", Red);            
        }
        else
        {
            // End:0x275
            if(script.m_clanNameValue > 0)
            {
                Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("ClanDrawerWnd.Clan3_ClanPoint", Blue);
            }
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan3_ClanRanking", ClanRankStr);
    i = 0;

    while(i < 8)
    {
        // End:0x4DE
        if(script.m_memberList[i].m_sName != "")
        {
            clanType = script.GetClanTypeFromIndex(i);
            // End:0x356
            if(clanType == 0)
            {
                ToolTip = (((script.m_memberList[i].m_sName $ "\\n") $ GetSystemString(342)) $ " : ") $ script.m_memberList[i].m_sMasterName;
            }
            // End:0x384
            if(clanType == -1)
            {
                ToolTip = script.m_memberList[i].m_sName;
            }
            // End:0x3F2
            if((clanType == 100) || clanType == 200)
            {
                ToolTip = (((script.m_memberList[i].m_sName $ "\\n") $ GetSystemString(1438)) $ " : ") $ script.m_memberList[i].m_sMasterName;
            }
            // End:0x488
            if((((clanType == 1001) || clanType == 1002) || clanType == 2001) || clanType == 2002)
            {
                ToolTip = (((script.m_memberList[i].m_sName $ "\\n") $ GetSystemString(1433)) $ " : ") $ script.m_memberList[i].m_sMasterName;
            }
            // End:0x4DE
            if(ToolTip != "")
            {
                Clan3_OrgIcon[i].ShowWindow();
                Clan3_OrgIcon[i].EnableWindow();
                Clan3_OrgIcon[i].SetTooltipCustomType(SetTooltip(ToolTip));
            }
        }
        ++i;
    }
    return;
}

function InitializeGradeComboBox()
{
    local int i;

    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("ClanDrawerWnd.Clan1_MemberGradeList");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("ClanDrawerWnd.Clan1_MemberGradeList", GetSystemString(1451));
    i = 1;

    while(i < 6)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.AddString("ClanDrawerWnd.Clan1_MemberGradeList", GetStringByGradeID(i));
        ++i;
    }
    return;
}

function KnighthoodCombobox()
{
    local ClanWnd script;
    local int i;

    script = ClanWnd(GetScript("ClanWnd"));
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("ClanDrawerWnd.Clan1_targetknighthoodcombobox");
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("ClanDrawerWnd.Clan1_targetknighthoodmember");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodcombobox", GetSystemString(1465), 0);
    Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodmember", GetSystemString(1466), 0);
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_targetknighthoodmember");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodBtn");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodTXT1", MakeFullSystemMsg(GetSystemMessage(1906), m_currentName, ""));
    i = 0;

    while(i < script.m_memberList.Length)
    {
        // End:0x2A7
        if(script.m_memberList[i].m_sName != "")
        {
            // End:0x2A7
            if(script.GetClanTypeFromIndex(i) != -1)
            {
                Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodcombobox", script.m_memberList[i].m_sName, i);
            }
        }
        ++i;
    }
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("ClanDrawerWnd.Clan1_targetknighthoodcombobox", 0);
    return;
}

function swapTargetSelect(int clanNo)
{
    local ClanWnd script;
    local int i;

    script = ClanWnd(GetScript("ClanWnd"));
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("ClanDrawerWnd.Clan1_targetknighthoodmember");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodmember", GetSystemString(1466), 0);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodTXT1", MakeFullSystemMsg(GetSystemMessage(1907), m_currentName, ""));
    i = 0;

    while(i <= script.m_memberList[clanNo].m_array.Length)
    {
        // End:0x1D8
        if(script.m_memberList[clanNo].m_array[i].sName != script.m_CurrentclanMasterReal)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodmember", script.m_memberList[clanNo].m_array[i].sName, script.m_memberList[clanNo].m_array[i].clanType);
        }
        ++i;
    }
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("ClanDrawerWnd.Clan1_targetknighthoodmember", 0);
    return;
}

function proc_swapmember()
{
    local int currentindexnew1, currentindexnew2;
    local string currentstring1, currentstring2;
    local int Type, clantype1;
    local ClanWnd script;

    script = ClanWnd(GetScript("ClanWnd"));
    currentindexnew1 = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("ClanDrawerWnd.Clan1_targetknighthoodcombobox");
    currentstring1 = Class'NWindow.UIAPI_COMBOBOX'.static.GetString("ClanDrawerWnd.Clan1_targetknighthoodcombobox", currentindexnew1);
    clantype1 = script.GetClanTypeFromIndex(Class'NWindow.UIAPI_COMBOBOX'.static.GetReserved("ClanDrawerWnd.Clan1_targetknighthoodcombobox", currentindexnew1));
    currentindexnew2 = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("ClanDrawerWnd.Clan1_targetknighthoodmember");
    currentstring2 = Class'NWindow.UIAPI_COMBOBOX'.static.GetString("ClanDrawerWnd.Clan1_targetknighthoodmember", currentindexnew2);
    // End:0x198
    if(currentindexnew2 == 0)
    {
        Type = 0;        
    }
    else
    {
        Type = 1;
    }
    // End:0x1C3
    if(Type == 1)
    {
        RequestClanReorganizeMember(1, m_currentName, clantype1, currentstring2);        
    }
    else
    {
        // End:0x1E1
        if(Type == 0)
        {
            RequestClanReorganizeMember(0, m_currentName, clantype1, "");
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberOrderName", ((getClanOrderString(clantype1)) @ "-") @ currentstring1);
    return;
}

function OnComboBoxItemSelected(string strID, int Index)
{
    local int selectval;

    // End:0xF6
    if(strID == "Clan1_targetknighthoodcombobox")
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_targetknighthoodmember");
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodBtn");
        selectval = Class'NWindow.UIAPI_COMBOBOX'.static.GetReserved("ClanDrawerWnd.Clan1_targetknighthoodcombobox", Index);
        swapTargetSelect(selectval);
    }
    return;
}

function HideWindow()
{
    local ClanWnd script;

    script = ClanWnd(GetScript("ClanWnd"));
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
    script.ResetOpeningVariables();
    return;
}

function ApplyEditGrade()
{
    local array<int> powers;
    local int i, Index;

    powers.Length = 32;
    powers[0] = 0;
    Index = 1;
    i = 1;

    while(i <= 9)
    {
        // End:0x71
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ClanDrawerWnd.Clan6_Check10" $ string(i)))
        {
            powers[Index] = 1;
        }
        ++Index;
        ++i;
    }
    i = 1;

    while(i <= 5)
    {
        // End:0xDA
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ClanDrawerWnd.Clan6_Check20" $ string(i)))
        {
            powers[Index] = 1;
        }
        ++Index;
        ++i;
    }
    i = 1;

    while(i <= 8)
    {
        // End:0x143
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ClanDrawerWnd.Clan6_Check30" $ string(i)))
        {
            powers[Index] = 1;
        }
        ++Index;
        ++i;
    }
    RequestEditClanAuth(m_currentEditGradeID, powers);
    return;
}

function EditAuthGrade()
{
    local int Index;
    local LVDataRecord Record;

    Index = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedIndex("ClanDrawerWnd.Clan5_AuthListCtrl");
    // End:0xBD
    if(Index >= 0)
    {
        Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetRecord("ClanDrawerWnd.Clan5_AuthListCtrl", Index);
        RequestClanAuth(Record.nReserved1);
        m_currentEditGradeID = Record.nReserved1;
        SetStateAndShow("ClanAuthEditWndState");        
    }
    else
    {
        SetStateAndShow("ClanAuthManageWndState");
    }
    return;
}

function EditAuthGrade2()
{
    local int Index;
    local LVDataRecord Record;

    Index = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedIndex("ClanDrawerWnd.Clan5_AuthListCtrl2");
    // End:0xBF
    if(Index >= 0)
    {
        Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetRecord("ClanDrawerWnd.Clan5_AuthListCtrl2", Index);
        RequestClanAuth(Record.nReserved1);
        m_currentEditGradeID = Record.nReserved1;
        SetStateAndShow("ClanAuthEditWndState");        
    }
    else
    {
        SetStateAndShow("ClanAuthManageWndState");
    }
    return;
}

function string GetWarStateString(int State)
{
    // End:0x1A
    if(State == 0)
    {
        return GetSystemString(1429);        
    }
    else
    {
        // End:0x34
        if(State == 1)
        {
            return GetSystemString(1430);            
        }
        else
        {
            // End:0x4C
            if(State == 2)
            {
                return GetSystemString(1367);
            }
        }
    }
    return "Error";
}

function AddSkill(int Id, int Level)
{
    local ItemInfo Info;

    Info.ClassID = Id;
    Info.Level = Level;
    Info.Name = Class'NWindow.UIDATA_SKILL'.static.GetName(Info.ClassID, Info.Level);
    Info.IconName = Class'NWindow.UIDATA_SKILL'.static.GetIconName(Info.ClassID, Info.Level);
    Info.Description = Class'NWindow.UIDATA_SKILL'.static.GetDescription(Info.ClassID, Info.Level);
    Info.AdditionalName = Class'NWindow.UIDATA_SKILL'.static.GetEnchantName(Info.ClassID, Info.Level);
    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("ClanDrawerWnd.ClanSkillWnd", Info);
    return;
}

function ReplaceSkill(int Index, int Id, int Level)
{
    local ItemInfo Info;

    Info.ClassID = Id;
    Info.Level = Level;
    Info.Name = Class'NWindow.UIDATA_SKILL'.static.GetName(Info.ClassID, Info.Level);
    Info.IconName = Class'NWindow.UIDATA_SKILL'.static.GetIconName(Info.ClassID, Info.Level);
    Info.Description = Class'NWindow.UIDATA_SKILL'.static.GetDescription(Info.ClassID, Info.Level);
    Info.AdditionalName = Class'NWindow.UIDATA_SKILL'.static.GetEnchantName(Info.ClassID, Info.Level);
    Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("ClanDrawerWnd.ClanSkillWnd", Index, Info);
    return;
}

function string getClanOrderString(int gradeID)
{
    local int stringIndex;

    stringIndex = -1;
    // End:0x24
    if(gradeID == 0)
    {
        stringIndex = 1399;        
    }
    else
    {
        // End:0x3E
        if(gradeID == 100)
        {
            stringIndex = 1400;            
        }
        else
        {
            // End:0x58
            if(gradeID == 200)
            {
                stringIndex = 1401;                
            }
            else
            {
                // End:0x75
                if(gradeID == 1001)
                {
                    stringIndex = 1402;                    
                }
                else
                {
                    // End:0x92
                    if(gradeID == 1002)
                    {
                        stringIndex = 1403;                        
                    }
                    else
                    {
                        // End:0xAF
                        if(gradeID == 2001)
                        {
                            stringIndex = 1404;                            
                        }
                        else
                        {
                            // End:0xCC
                            if(gradeID == 2002)
                            {
                                stringIndex = 1405;                                
                            }
                            else
                            {
                                // End:0xE6
                                if(gradeID == -1)
                                {
                                    stringIndex = 1419;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    // End:0x104
    if(stringIndex != -1)
    {
        return GetSystemString(stringIndex);        
    }
    else
    {
        return "";
    }
    return "";
}

function reset_clan_org()
{
    local int i;

    i = 0;

    while(i < 8)
    {
        Clan3_OrgIcon[i].HideWindow();
        Clan3_OrgIcon[i].DisableWindow();
        Clan3_OrgIcon[i].SetTooltipCustomType(SetTooltip(""));
        ++i;
    }
    return;
}

function disableAcademyAuth()
{
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check100", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check101", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check102", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check106", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check104", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check105", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check107", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check108", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check109", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check110", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check200", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check203", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check204", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check205", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check300", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check303", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check302", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check305", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check306", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check307", true);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check308", true);
    return;
}

function resetAcademyAuth()
{
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check100", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check101", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check102", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check106", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check104", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check105", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check107", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check108", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check109", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check109", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check200", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check203", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check204", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check205", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check300", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check303", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check302", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check305", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check306", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check307", false);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetDisable("ClanDrawerWnd.Clan6_Check308", false);
    return;
}

function int getCurrentGradebyClanType()
{
    local int GradeNum;

    switch(m_clanType)
    {
        // End:0x16
        case 0:
            GradeNum = 6;
            // End:0x98
            break;
        // End:0x26
        case 100:
            GradeNum = 7;
            // End:0x98
            break;
        // End:0x36
        case 200:
            GradeNum = 7;
            // End:0x98
            break;
        // End:0x49
        case 1001:
            GradeNum = 8;
            // End:0x98
            break;
        // End:0x5C
        case 1002:
            GradeNum = 8;
            // End:0x98
            break;
        // End:0x6F
        case 2001:
            GradeNum = 8;
            // End:0x98
            break;
        // End:0x82
        case 2002:
            GradeNum = 8;
            // End:0x98
            break;
        // End:0x95
        case -1:
            GradeNum = 9;
            // End:0x98
            break;
        // End:0xFFFF
        default:
            break;
    }
    return GradeNum;
}

function CustomTooltip SetTooltip(string Text)
{
    local CustomTooltip ToolTip;
    local DrawItemInfo Info;

    ToolTip.MinimumWidth = 144;
    ToolTip.DrawList.Length = 1;
    Info.eType = DIT_TEXT;
    Info.t_color.R = 178;
    Info.t_color.G = 190;
    Info.t_color.B = 207;
    Info.t_color.A = byte(255);
    Info.t_strText = Text;
    ToolTip.DrawList[0] = Info;
    return ToolTip;
}
