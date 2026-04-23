class InviteClanPopWnd extends UIScript;

var string m_UserName;
var array<int> m_knighthoodIndex;

function OnLoad()
{
    m_knighthoodIndex.Length = 8;
    m_knighthoodIndex[0] = 0;
    m_knighthoodIndex[1] = 100;
    m_knighthoodIndex[2] = 200;
    m_knighthoodIndex[3] = 1001;
    m_knighthoodIndex[4] = 1002;
    m_knighthoodIndex[5] = 2001;
    m_knighthoodIndex[6] = 2002;
    m_knighthoodIndex[7] = -1;
    RegisterEvent(160);
    return;
}

function OnShow()
{
    InitializeComboBox();
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x30
        case 160:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InviteClanPopWnd");
            // End:0x36
            break;
        // End:0xFFFF
        default:
            // End:0x36
            break;
            break;
    }
    return;
}

function OnClickButton(string strID)
{
    // End:0x49
    if(strID == "InviteClandPopOkBtn")
    {
        AskJoin();
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InviteClanPopWnd");        
    }
    else
    {
        // End:0x8D
        if(strID == "InviteClandPopCancelBtn")
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InviteClanPopWnd");
        }
    }
    return;
}

function AskJoin()
{
    local UserInfo User;
    local int Index, knighthoodID;

    // End:0x115
    if(GetTargetInfo(User))
    {
        // End:0x115
        if(User.nID > 0)
        {
            Index = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("InviteClanPopWnd.ComboboxInviteClandPopWnd");
            // End:0x115
            if(Index >= 0)
            {
                knighthoodID = Class'NWindow.UIAPI_COMBOBOX'.static.GetReserved("InviteClanPopWnd.ComboboxInviteClandPopWnd", Index);
                Debug((((("AskJoin : id " $ string(User.nID)) $ " name ") $ User.Name) $ " clanType ") $ string(knighthoodID));
                RequestClanAskJoin(User.nID, knighthoodID);
            }
        }
    }
    return;
}

function InitializeComboBox()
{
    local int i;
    local ClanWnd script;
    local int addedCount;
    local string countnum, countnum2;
    local int cnt1, cnt2;

    script = ClanWnd(GetScript("ClanWnd"));
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("InviteClanPopWnd.ComboboxInviteClandPopWnd");
    countnum2 = "" $ string(script.m_myClanType);
    Debug(countnum2);
    cnt1 = Len(countnum2);
    i = 0;

    while(i < 8)
    {
        countnum = "" $ string(m_knighthoodIndex[i]);
        Debug(countnum);
        cnt2 = Len(countnum);
        // End:0x1DC
        if(script.m_memberList[i].m_sName != "")
        {
            // End:0x167
            if(m_knighthoodIndex[i] == -1)
            {
                Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved("InviteClanPopWnd.ComboboxInviteClandPopWnd", script.m_memberList[i].m_sName, m_knighthoodIndex[i]);
                ++addedCount;

                ++i;
                continue;
            }
            // End:0x1DC
            if(cnt1 <= cnt2)
            {
                Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved("InviteClanPopWnd.ComboboxInviteClandPopWnd", script.m_memberList[i].m_sName, m_knighthoodIndex[i]);
                ++addedCount;
            }
        }

        ++i;
    }
    // End:0x22D
    if(addedCount > 0)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("InviteClanPopWnd.ComboboxInviteClandPopWnd", 0);
    }
    return;
}
