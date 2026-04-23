class ReplayListWnd extends UIScript;

const REPLAY_DIR = "..\\REPLAY";
const REPLAY_EXTENSION = ".L2R";

var array<string> m_StrFileList;

function OnLoad()
{
    return;
}

function OnShow()
{
    InitReplayList();
    return;
}

function InitReplayList()
{
    local array<string> strReplayFileList;
    local int i, iLength;
    local string strFileName;

    Class'NWindow.UIAPI_LISTCTRL'.static.DeleteAllItem("ReplayListWnd.ReplayListCtrl");
    GetFileList(strReplayFileList, "..\\REPLAY", ".L2R");
    i = 0;

    while(i < strReplayFileList.Length)
    {
        iLength = Len(strReplayFileList[i]) - Len(".L2R");
        strFileName = Left(strReplayFileList[i], iLength);
        AddItem(i, strFileName);
        ++i;
    }
    return;
}

function OnEvent(int Event_ID, string param)
{
    return;
}

function AddItem(int iNum, string strFileName)
{
    local LVDataRecord Record;
    local LVData Data;

    Data.szData = string(iNum);
    Record.LVDataList[0] = Data;
    Data.szData = strFileName;
    Record.LVDataList[1] = Data;
    Class'NWindow.UIAPI_LISTCTRL'.static.InsertRecord("ReplayListWnd.ReplayListCtrl", Record);
    return;
}

function string GetSelectedFileName()
{
    local int Index;
    local LVDataRecord Record;
    local string strFileName;

    Index = Class'NWindow.UIAPI_LISTCTRL'.static.GetSelectedIndex("ReplayListWnd.ReplayListCtrl");
    // End:0x8D
    if(Index >= 0)
    {
        Record = Class'NWindow.UIAPI_LISTCTRL'.static.GetRecord("ReplayListWnd.ReplayListCtrl", Index);
        strFileName = Record.LVDataList[1].szData;
    }
    return strFileName;
}

function OnDBClickListCtrlRecord(string ListCtrlID)
{
    OnOk();
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1A
        case "btnOK":
            OnOk();
            // End:0x5A
            break;
        // End:0x34
        case "btnDel":
            OnDelete();
            InitReplayList();
            // End:0x5A
            break;
        // End:0x57
        case "btnCancel":
            SetUIState("LoginState");
            // End:0x5A
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnOk()
{
    local string strFileName;
    local bool bLoadCameraInst, bLoadChatData;

    strFileName = GetSelectedFileName();
    // End:0x1A
    if(strFileName == "")
    {
        return;
    }
    bLoadCameraInst = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ReplayListWnd.chkLoadCamInst");
    bLoadChatData = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("ReplayListWnd.chkLoadChatData");
    BeginReplay(strFileName, bLoadCameraInst, bLoadChatData);
    return;
}

function OnDelete()
{
    local string strFileName;

    strFileName = GetSelectedFileName();
    // End:0x1A
    if(strFileName == "")
    {
        return;
    }
    EraseReplayFile(((("..\\REPLAY" $ "\\") $ strFileName) $ "") $ ".L2R");
    return;
}
