class OlympiadBuffWnd extends UIScript;

const NSTATUSICON_FRAMESIZE = 12;
const NSTATUSICON_MAXCOL = 12;

var int m_PlayerNum;
var int m_PlayerID;
var string m_WindowName;

function SetPlayerNum(int PlayerNum)
{
    m_PlayerNum = PlayerNum;
    m_WindowName = ("OlympiadBuff" $ string(PlayerNum)) $ "Wnd";
    return;
}

function OnLoad()
{
    RegisterEvent(930);
    RegisterEvent(940);
    RegisterEvent(910);
    return;
}

function OnEnterState(name a_PreStateName)
{
    Clear();
    m_PlayerID = 0;
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x1D
    if(Event_ID == 930)
    {
        HandleBuffShow(param);        
    }
    else
    {
        // End:0x3A
        if(Event_ID == 940)
        {
            HandleBuffInfo(param);            
        }
        else
        {
            // End:0x56
            if(Event_ID == 910)
            {
                Clear();
                m_PlayerID = 0;
            }
        }
    }
    return;
}

function Clear()
{
    Class'NWindow.UIAPI_STATUSICONCTRL'.static.Clear(m_WindowName $ ".StatusIcon");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow(m_WindowName);
    return;
}

function HandleBuffShow(string param)
{
    local int PlayerNum;

    ParseInt(param, "PlayerNum", PlayerNum);
    // End:0x39
    if((m_PlayerNum != PlayerNum) || PlayerNum < 1)
    {
        return;
    }
    ParseInt(param, "PlayerID", m_PlayerID);
    return;
}

function HandleBuffInfo(string param)
{
    local int PlayerID, i, Max, CurRow;
    local StatusIconInfo Info;
    local Rect rectWnd;

    ParseInt(param, "PlayerID", PlayerID);
    // End:0x38
    if((m_PlayerID != PlayerID) || PlayerID < 1)
    {
        return;
    }
    Clear();
    CurRow = -1;
    ParseInt(param, "Max", Max);
    i = 0;
    while(i < Max)
    {
        // End:0xB3
        if((float(i) % float(12)) == float(0))
        {
            Class'NWindow.UIAPI_STATUSICONCTRL'.static.AddRow(m_WindowName $ ".StatusIcon");
            CurRow++;
        }
        ParseInt(param, "SkillID_" $ string(i), Info.ClassID);
        ParseInt(param, "SkillLevel_" $ string(i), Info.Level);
        ParseInt(param, "RemainTime_" $ string(i), Info.RemainTime);
        ParseString(param, "Name_" $ string(i), Info.Name);
        ParseString(param, "IconName_" $ string(i), Info.IconName);
        ParseString(param, "Description_" $ string(i), Info.Description);
        Info.Size = 24;
        Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
        Info.bShow = true;
        Class'NWindow.UIAPI_STATUSICONCTRL'.static.AddCol(m_WindowName $ ".StatusIcon", CurRow, Info);
        i++;
    }
    // End:0x2B9
    if(Max > 0)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(m_WindowName);
        rectWnd = Class'NWindow.UIAPI_WINDOW'.static.GetRect(m_WindowName $ ".StatusIcon");
        Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize(m_WindowName, rectWnd.nWidth + 12, rectWnd.nHeight);
        Class'NWindow.UIAPI_WINDOW'.static.SetFrameSize(m_WindowName, 12, rectWnd.nHeight);
    }
    return;
}
