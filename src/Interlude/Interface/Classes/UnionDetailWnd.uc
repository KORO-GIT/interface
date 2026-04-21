class UnionDetailWnd extends UICommonAPI;

var int m_MasterID;
var WindowHandle Me;
var TextBoxHandle txtMasterName;
var ListCtrlHandle lstPartyMember;

function OnLoad()
{
    RegisterEvent(1420);
    Me = GetHandle("UnionDetailWnd");
    txtMasterName = TextBoxHandle(GetHandle("UnionDetailWnd.txtMasterName"));
    lstPartyMember = ListCtrlHandle(GetHandle("UnionDetailWnd.lstPartyMember"));
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x1A
    if(Event_ID == 1420)
    {
        HandleCommandChannelPartyMember(param);
    }
    return;
}

function SetMasterInfo(string MasterName, int MasterID)
{
    txtMasterName.SetText(MasterName);
    m_MasterID = MasterID;
    return;
}

function int GetMasterID()
{
    return m_MasterID;
}

function Clear()
{
    lstPartyMember.DeleteAllItem();
    txtMasterName.SetText("");
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1D
        case "btnClose":
            OnCloseClick();
            // End:0x20
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnCloseClick()
{
    Me.HideWindow();
    return;
}

function OnDBClickListCtrlRecord(string strID)
{
    local UserInfo UserInfo;
    local LVDataRecord Record;
    local int ServerID;

    // End:0x8E
    if(strID == "lstPartyMember")
    {
        Record = lstPartyMember.GetSelectedRecord();
        ServerID = Record.nReserved1;
        // End:0x8E
        if(ServerID > 0)
        {
            // End:0x8E
            if(GetPlayerInfo(UserInfo))
            {
                // End:0x79
                if(IsPKMode())
                {
                    RequestAttack(ServerID, UserInfo.Loc);                    
                }
                else
                {
                    RequestAction(ServerID, UserInfo.Loc);
                }
            }
        }
    }
    return;
}

function HandleCommandChannelPartyMember(string param)
{
    local LVDataRecord Record;
    local int idx, MemberCount;
    local string Name;
    local int ClassID, ServerID;
    local UnionWnd script;

    lstPartyMember.DeleteAllItem();
    ParseInt(param, "MemberCount", MemberCount);
    idx = 0;
    J0x33:

    // End:0x167 [Loop If]
    if(idx < MemberCount)
    {
        ParseString(param, "Name_" $ string(idx), Name);
        ParseInt(param, "ClassID_" $ string(idx), ClassID);
        ParseInt(param, "ServerID_" $ string(idx), ServerID);
        // End:0x15D
        if(Len(Name) > 0)
        {
            Record.LVDataList.Length = 2;
            Record.nReserved1 = ServerID;
            Record.LVDataList[0].szData = Name;
            Record.LVDataList[1].nTextureWidth = 11;
            Record.LVDataList[1].nTextureHeight = 11;
            Record.LVDataList[1].szData = string(ClassID);
            Record.LVDataList[1].szTexture = GetClassIconName(ClassID);
            lstPartyMember.InsertRecord(Record);
        }
        idx++;
        // [Loop Continue]
        goto J0x33;
    }
    script = UnionWnd(GetScript("UnionWnd"));
    script.UpdatePartyMemberCount(m_MasterID, MemberCount);
    return;
}
