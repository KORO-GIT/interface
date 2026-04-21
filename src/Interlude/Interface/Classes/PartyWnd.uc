class PartyWnd extends UICommonAPI;

const NSTATUSICON_MAXCOL = 18;
const NPARTYSTATUS_HEIGHT = 46;
const NPARTYSTATUS_MAXCOUNT = 8;

var bool m_bCompact;
var bool m_bBuff;
var int m_arrID[9];
var int m_CurCount;
var int m_CurBf;
var bool is_Nobless;
var WindowHandle m_wndTop;
var WindowHandle m_PartyStatus[9];
var WindowHandle m_PartyOption;
var NameCtrlHandle m_PlayerName[9];
var TextureHandle m_ClassIcon[9];
var TextureHandle m_ClassIconCustom[9];
var TextureHandle m_LeaderIcon[9];
var StatusIconHandle m_StatusIconBuff[9];
var StatusIconHandle m_StatusIconDeBuff[9];
var StatusIconHandle m_StatusNoblessBuff[9];
var BarHandle m_BarCP[9];
var BarHandle m_BarHP[9];
var BarHandle m_BarMP[9];
var ButtonHandle btnBuff;
var Color LeaderNameColor;
var Color AssistNameColor_1;
var Color AssistNameColor_2;
var int isLeader[10];
var string RoutingTypeString;
var bool b_AutoAssistEnabled;
var string s_AssistName_1;
var string s_AssistName_2;
var int i_AssistIndex_1;
var int i_AssistIndex_2;
var ComboBoxHandle m_cb1stAssist;
var ComboBoxHandle m_cb2ndAssist;
var ButtonHandle btnAssist;
var string ParamSpelledList[9];
var int checkPriorDebuffSameRow;
var bool checkPrior;
var array<int> a_UnkArrayInt1;
var int i_UnkInt_1;

function OnLoad()
{
    local int idx;

    RegisterEvent(950);
    RegisterEvent(1000);
    RegisterEvent(4445);
    RegisterEvent(1140);
    RegisterEvent(1150);
    RegisterEvent(1160);
    RegisterEvent(1170);
    RegisterEvent(1180);
    RegisterEvent(90);
    RegisterEvent(40);
    is_Nobless = false;
    m_bCompact = false;
    m_bBuff = false;
    m_CurBf = 0;
    m_wndTop = GetHandle("PartyWnd");
    m_PartyOption = GetHandle("PartyWndOption");
    idx = 0;
    J0xC0:

    // End:0x3E0 [Loop If]
    if(idx < 9)
    {
        m_PartyStatus[idx] = GetHandle("PartyWnd.PartyStatusWnd" $ string(idx));
        m_PlayerName[idx] = NameCtrlHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".PlayerName"));
        m_ClassIcon[idx] = TextureHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".ClassIcon"));
        m_ClassIconCustom[idx] = TextureHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".ClassIconCustom"));
        m_LeaderIcon[idx] = TextureHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".LeaderIcon"));
        m_StatusIconBuff[idx] = StatusIconHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".StatusIconBuff"));
        m_StatusIconDeBuff[idx] = StatusIconHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".StatusIconDebuff"));
        m_StatusNoblessBuff[idx] = StatusIconHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".StatusNoblessBuff"));
        m_BarCP[idx] = BarHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".barCP"));
        m_BarHP[idx] = BarHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".barHP"));
        m_BarMP[idx] = BarHandle(GetHandle(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".barMP"));
        idx++;
        // [Loop Continue]
        goto J0xC0;
    }
    btnBuff = ButtonHandle(GetHandle("PartyWnd.btnBuff"));
    idx = 0;
    J0x40A:

    // End:0x5C1 [Loop If]
    if(idx < 8)
    {
        m_StatusIconBuff[idx].SetAnchor("PartyWnd.PartyStatusWnd" $ string(idx), "TopRight", "TopLeft", -3, 1);
        m_StatusIconDeBuff[idx].SetAnchor("PartyWnd.PartyStatusWnd" $ string(idx), "TopRight", "TopLeft", -3, 3);
        m_StatusNoblessBuff[idx].SetAnchor("PartyWnd.PartyStatusWnd" $ string(idx), "TopRight", "TopRight", -11, 2);
        m_PlayerName[idx].SetAnchor(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".ClassIcon", "TopLeft", "TopLeft", 1, -16);
        m_ClassIconCustom[idx].SetAnchor("PartyWnd.PartyStatusWnd" $ string(idx), "TopRight", "TopRight", -11, 1);
        idx++;
        // [Loop Continue]
        goto J0x40A;
    }
    m_PartyOption.HideWindow();
    LeaderNameColor.R = byte(255);
    LeaderNameColor.G = byte(255);
    LeaderNameColor.B = 0;
    LeaderNameColor.A = byte(255);
    AssistNameColor_1.R = 148;
    AssistNameColor_1.G = 0;
    AssistNameColor_1.B = 211;
    AssistNameColor_1.A = byte(255);
    AssistNameColor_2.R = 70;
    AssistNameColor_2.G = 130;
    AssistNameColor_2.B = 180;
    AssistNameColor_2.A = byte(255);
    m_cb1stAssist = ComboBoxHandle(GetHandle("PartyWnd.AssistWnd.cb1stAssist"));
    m_cb2ndAssist = ComboBoxHandle(GetHandle("PartyWnd.AssistWnd.cb2ndAssist"));
    btnAssist = ButtonHandle(GetHandle("PartyWnd.AssistWnd.btnAssist"));
    s_AssistName_1 = "";
    s_AssistName_2 = "";
    DisableAutoAssist();
    btnAssist.SetTooltipCustomType(SetTooltip("Auto Assist: Press the button (SPACE) Enable/Disable"));
    checkPrior = GetOptionBool("Custom", "checkPrior");
    checkPriorDebuffSameRow = int(GetOptionBool("Custom", "checkPriorDebuffSameRow"));
    return;
}

function OnShow()
{
    ResizeWnd();
    UpdateAndSetAssistIndex();
    SetBuffButtonTooltip();
    // End:0x4C
    if(GetOptionBool("Custom", "HideAssist"))
    {
        HideWindow("PartyWnd.AssistWnd");        
    }
    else
    {
        ShowWindow("PartyWnd.AssistWnd");
    }
    return;
}

function OnHide()
{
    HideWindow("PartyWnd.AssistWnd");
    return;
}

function OnEnterState(name a_PreStateName)
{
    m_bCompact = false;
    m_bBuff = false;
    m_CurBf = 0;
    ResizeWnd();
    return;
}

function OnEvent(int Event_ID, string param)
{
    local int idx;

    // End:0x1D
    if(Event_ID == 950)
    {
        HandleAddNormalStatus(param);        
    }
    else
    {
        // End:0x3A
        if(Event_ID == 1140)
        {
            HandlePartyAddParty(param);            
        }
        else
        {
            // End:0x57
            if(Event_ID == 1150)
            {
                HandlePartyUpdateParty(param);                
            }
            else
            {
                // End:0x74
                if(Event_ID == 1160)
                {
                    HandlePartyDeleteParty(param);                    
                }
                else
                {
                    // End:0x8C
                    if(Event_ID == 1170)
                    {
                        HandlePartyDeleteAllParty();                        
                    }
                    else
                    {
                        // End:0xCF
                        if(Event_ID == 1180)
                        {
                            idx = HandlePartySpelledList(param);
                            // End:0xCC
                            if(idx > -1)
                            {
                                ParamSpelledList[idx] = param;
                            }                            
                        }
                        else
                        {
                            // End:0xEC
                            if(Event_ID == 1000)
                            {
                                HandleShowBuffIcon(param);                                
                            }
                            else
                            {
                                // End:0x107
                                if(Event_ID == 40)
                                {
                                    HandleRestart();
                                    DisableAutoAssist();                                    
                                }
                                else
                                {
                                    // End:0x121
                                    if(Event_ID == 90)
                                    {
                                        HandleShortcutCommand(param);                                        
                                    }
                                    else
                                    {
                                        // End:0x18C
                                        if(Event_ID == 4445)
                                        {
                                            checkPrior = GetOptionBool("Custom", "checkPrior");
                                            checkPriorDebuffSameRow = int(GetOptionBool("Custom", "checkPriorDebuffSameRow"));
                                            UpdateAndSetAssistIndex();
                                            ReHandlePartySpelledList();
                                        }
                                    }
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

function HandleAddNormalStatus(string param)
{
    local int i, Max;
    local StatusIconInfo Info;

    is_Nobless = false;
    ParseInt(param, "Max", Max);
    i = 0;
    J0x24:

    // End:0x84 [Loop If]
    if(i < Max)
    {
        ParseInt(param, "SkillID_" $ string(i), Info.ClassID);
        // End:0x7A
        if(Info.ClassID == 1323)
        {
            is_Nobless = true;
            // [Explicit Break]
            goto J0x84;
        }
        i++;
        // [Loop Continue]
        goto J0x24;
    }
    J0x84:

    return;
}

function OnTimer(int TimerID)
{
    local UserInfo StatusInfo;
    local bool inTimerBool;

    // End:0xEC
    if(TimerID == 0)
    {
        // End:0xEC
        if(b_AutoAssistEnabled)
        {
            SetAssistIndex();
            SetPartyMembersColors();
            // End:0x49
            if((i_AssistIndex_1 == -1) && i_AssistIndex_2 == -1)
            {
                DisableAutoAssist();                
            }
            else
            {
                inTimerBool = true;
                // End:0xB1
                if(i_AssistIndex_1 > -1)
                {
                    GetUserInfo(m_arrID[i_AssistIndex_1], StatusInfo);
                    // End:0xB1
                    if((isNotMemberDead(i_AssistIndex_1)) && InRange(StatusInfo.Loc, 2000))
                    {
                        RequestAssistFunction(i_AssistIndex_1);
                        inTimerBool = false;
                    }
                }
                // End:0xEC
                if(inTimerBool && i_AssistIndex_2 > -1)
                {
                    GetUserInfo(m_arrID[i_AssistIndex_2], StatusInfo);
                    RequestAssistFunction(i_AssistIndex_2);
                }
            }
        }
    }
    return;
}

function ReHandlePartySpelledList()
{
    local int A;

    A = 0;
    J0x07:

    // End:0x2E [Loop If]
    if(A < 8)
    {
        HandlePartySpelledList(ParamSpelledList[A]);
        A++;
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function HandleShortcutCommand(string param)
{
    local string Command;

    // End:0x46
    if(ParseString(param, "Command", Command))
    {
        switch(Command)
        {
            // End:0x43
            case "ChangeAssistStatus":
                HandleChangeAssistStatus();
                // End:0x46
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        return;
    }
}

function RequestAssistFunction(int Index)
{
    local UserInfo UserInfo;
    local bool if_Nobless;

    if_Nobless = GetOptionBool("Custom", "NoblesseAssist");
    GetPlayerInfo(UserInfo);
    // End:0x7E
    if(((is_Nobless && if_Nobless) || !if_Nobless) && UserInfo.nCurHP > 0)
    {
        RequestAssist(m_arrID[Index], UserInfo.Loc);
    }
    return;
}

function HandleUpdateComboBox()
{
    local int A;

    m_cb1stAssist.Clear();
    m_cb1stAssist.AddString("MA1");
    m_cb2ndAssist.Clear();
    m_cb2ndAssist.AddString("MA2");
    m_cb1stAssist.SetSelectedNum(0);
    m_cb2ndAssist.SetSelectedNum(0);
    A = 0;
    J0x6D:

    // End:0x10C [Loop If]
    if(A < m_CurCount)
    {
        m_cb1stAssist.AddString(GetMemberName(A));
        m_cb2ndAssist.AddString(GetMemberName(A));
        // End:0xD9
        if((GetMemberName(A)) == s_AssistName_1)
        {
            m_cb1stAssist.SetSelectedNum(A);
        }
        // End:0x102
        if((GetMemberName(A)) == s_AssistName_2)
        {
            m_cb2ndAssist.SetSelectedNum(A);
        }
        A++;
        // [Loop Continue]
        goto J0x6D;
    }
    return;
}

function OnComboBoxItemSelected(string strID, int Index)
{
    // End:0x27
    if(strID == "cb1stAssist")
    {
        s_AssistName_1 = GetMainAssistName(1);        
    }
    else
    {
        // End:0x4C
        if(strID == "cb2ndAssist")
        {
            s_AssistName_2 = GetMainAssistName(2);
        }
    }
    SetAssistIndex();
    SetPartyMembersColors();
    return;
}

function UpdateAndSetAssistIndex()
{
    HandleUpdateComboBox();
    SetAssistIndex();
    SetPartyMembersColors();
    return;
}

function string GetMainAssistName(int Index)
{
    switch(Index)
    {
        // End:0x25
        case 1:
            return m_cb1stAssist.GetString(GetSelectedNumAssist(1));
            // End:0x48
            break;
        // End:0x45
        case 2:
            return m_cb2ndAssist.GetString(GetSelectedNumAssist(2));
            // End:0x48
            break;
        // End:0xFFFF
        default:
            break;
    }
    return "";
}

function int GetSelectedNumAssist(int Index)
{
    // End:0x1E
    if(Index == 1)
    {
        return m_cb1stAssist.GetSelectedNum();        
    }
    else
    {
        // End:0x3D
        if(Index == 2)
        {
            return m_cb2ndAssist.GetSelectedNum();            
        }
        else
        {
            return 0;
        }
    }
    return 0;
}

function SetAssistIndex()
{
    local int A;

    i_AssistIndex_1 = -1;
    i_AssistIndex_2 = -1;
    // End:0x66
    if((GetSelectedNumAssist(1)) > 0)
    {
        A = 0;
        J0x2A:

        // End:0x66 [Loop If]
        if(A < m_CurCount)
        {
            // End:0x5C
            if((GetMemberName(A)) == s_AssistName_1)
            {
                i_AssistIndex_1 = A;
                // [Explicit Break]
                goto J0x66;
            }
            A++;
            // [Loop Continue]
            goto J0x2A;
        }
    }
    J0x66:

    // End:0xC2
    if((GetSelectedNumAssist(2)) > 0)
    {
        i_AssistIndex_2 = -1;
        A = 0;
        J0x86:

        // End:0xC2 [Loop If]
        if(A < m_CurCount)
        {
            // End:0xB8
            if((GetMemberName(A)) == s_AssistName_2)
            {
                i_AssistIndex_2 = A;
                // [Explicit Break]
                goto J0xC2;
            }
            A++;
            // [Loop Continue]
            goto J0x86;
        }
    }
    J0xC2:

    return;
}

function bool isNotMemberDead(int Index)
{
    local int MaxValue, CurValue;

    // End:0x0D
    if(Index < 0)
    {
        return false;
    }
    m_BarHP[Index].GetValue(MaxValue, CurValue);
    // End:0x3C
    if(CurValue > 0)
    {
        return true;        
    }
    else
    {
        return false;
    }
    return false;
}

function string GetMemberName(int Index)
{
    return m_PlayerName[Index].GetName();
}

function DisableAutoAssist()
{
    btnAssist.SetTexture("Was.Potions_Btn", "Was.Potions_Btn", "Was.Potions_Btn");
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("PartyWnd", 0);
    b_AutoAssistEnabled = false;
    i_AssistIndex_1 = -1;
    i_AssistIndex_2 = -1;
    return;
}

function EnableAutoAssist()
{
    btnAssist.SetTexture("Was.Potions_Btn_Down", "Was.Potions_Btn_Down", "Was.Potions_Btn_Down");
    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("PartyWnd", 0, 1000);
    b_AutoAssistEnabled = true;
    return;
}

function HandleRestart()
{
    Clear(true);
    return;
}

function Clear(bool b_Value)
{
    local int idx;

    idx = 0;
    J0x07:

    // End:0x2E [Loop If]
    if(idx < 9)
    {
        ClearStatus(idx, b_Value);
        idx++;
        // [Loop Continue]
        goto J0x07;
    }
    m_CurCount = 0;
    ResizeWnd();
    UpdateAndSetAssistIndex();
    return;
}

function ClearStatus(int idx, bool b_Value)
{
    m_StatusIconBuff[idx].Clear();
    m_StatusIconDeBuff[idx].Clear();
    m_StatusNoblessBuff[idx].Clear();
    m_PlayerName[idx].SetName("", NCT_Normal, TA_Left);
    isLeader[idx] = 0;
    m_LeaderIcon[idx].SetTexture("");
    m_PlayerName[idx].SetAnchor(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".ClassIcon", "TopLeft", "TopLeft", 1, -16);
    m_ClassIcon[idx].SetTexture("");
    m_ClassIconCustom[idx].SetTexture("");
    UpdateCPBar(idx, 0, 0);
    UpdateHPBar(idx, 0, 0);
    UpdateMPBar(idx, 0, 0);
    m_arrID[idx] = 0;
    // End:0x154
    if(b_Value)
    {
        ParamSpelledList[idx] = "";
    }
    return;
}

function f_UnkFunc_1(int DesIndex, int SrcIndex)
{
    local int MaxValue, CurValue;
    local CustomTooltip TooltipInfo;

    m_arrID[DesIndex] = m_arrID[SrcIndex];
    ParamSpelledList[DesIndex] = ParamSpelledList[SrcIndex];
    m_PlayerName[DesIndex].SetName(m_PlayerName[SrcIndex].GetName(), NCT_Normal, TA_Left);
    m_ClassIcon[DesIndex].SetTexture(m_ClassIcon[SrcIndex].GetTextureName());
    m_ClassIconCustom[DesIndex].SetTexture(m_ClassIconCustom[SrcIndex].GetTextureName());
    m_LeaderIcon[DesIndex].SetTexture(m_LeaderIcon[SrcIndex].GetTextureName());
    m_PlayerName[SrcIndex].SetAnchor(("PartyWnd.PartyStatusWnd" $ string(SrcIndex)) $ ".ClassIcon", "TopLeft", "TopLeft", 1, -16);
    m_PlayerName[DesIndex].SetAnchor(("PartyWnd.PartyStatusWnd" $ string(DesIndex)) $ ".ClassIcon", "TopLeft", "TopLeft", 1, -16);
    // End:0x250
    if(isLeader[SrcIndex] == 1)
    {
        m_PlayerName[DesIndex].SetNameWithColor(m_PlayerName[SrcIndex].GetName(), NCT_Normal, TA_Left, LeaderNameColor);
        m_PlayerName[DesIndex].SetAnchor(("PartyWnd.PartyStatusWnd" $ string(DesIndex)) $ ".ClassIcon", "TopLeft", "TopLeft", 20, -16);
        isLeader[DesIndex] = 1;
        isLeader[SrcIndex] = 0;
    }
    m_PartyStatus[SrcIndex].GetTooltipCustomType(TooltipInfo);
    m_PartyStatus[DesIndex].SetTooltipCustomType(TooltipInfo);
    m_ClassIconCustom[SrcIndex].GetTooltipCustomType(TooltipInfo);
    m_ClassIconCustom[DesIndex].SetTooltipCustomType(TooltipInfo);
    m_BarCP[SrcIndex].GetValue(MaxValue, CurValue);
    m_BarCP[DesIndex].SetValue(MaxValue, CurValue);
    m_BarHP[SrcIndex].GetValue(MaxValue, CurValue);
    m_BarHP[DesIndex].SetValue(MaxValue, CurValue);
    m_BarMP[SrcIndex].GetValue(MaxValue, CurValue);
    m_BarMP[DesIndex].SetValue(MaxValue, CurValue);
    return;
}

function ResizeWnd()
{
    local int idx;
    local Rect rectWnd;
    local bool bOption;

    bOption = GetOptionBool("Game", "SmallPartyWnd");
    // End:0x109
    if(m_CurCount > 0)
    {
        rectWnd = m_wndTop.GetRect();
        m_wndTop.SetWindowSize(rectWnd.nWidth, 46 * m_CurCount);
        m_wndTop.SetResizeFrameSize(10, 46 * m_CurCount);
        // End:0x9B
        if(!bOption)
        {
            m_wndTop.ShowWindow();            
        }
        else
        {
            m_wndTop.HideWindow();
        }
        idx = 0;
        J0xB1:

        // End:0x106 [Loop If]
        if(idx < 8)
        {
            // End:0xE7
            if(idx <= (m_CurCount - 1))
            {
                m_PartyStatus[idx].ShowWindow();
                // [Explicit Continue]
                goto J0xFC;
            }
            m_PartyStatus[idx].HideWindow();
            J0xFC:

            idx++;
            // [Loop Continue]
            goto J0xB1;
        }        
    }
    else
    {
        m_wndTop.HideWindow();
    }
    return;
}

function int GetMemberIndex(int Id)
{
    local int idx;

    idx = 0;
    J0x07:

    // End:0x38 [Loop If]
    if(idx < 8)
    {
        // End:0x2E
        if(m_arrID[idx] == Id)
        {
            return idx;
        }
        idx++;
        // [Loop Continue]
        goto J0x07;
    }
    return -1;
}

function HandlePartyAddParty(string param)
{
    local int Id;

    ParseInt(param, "ID", Id);
    // End:0x53
    if(Id > 0)
    {
        m_CurCount++;
        ResizeWnd();
        m_arrID[m_CurCount - 1] = Id;
        UpdateStatus(m_CurCount - 1, param);
    }
    UpdateAndSetAssistIndex();
    ReHandlePartySpelledList();
    return;
}

function HandlePartyUpdateParty(string param)
{
    local int Id, idx;

    ParseInt(param, "ID", Id);
    // End:0x40
    if(Id > 0)
    {
        idx = GetMemberIndex(Id);
        UpdateStatus(idx, param);
    }
    return;
}

function HandlePartyDeleteParty(string param)
{
    local int Id, idx, A;

    ParseInt(param, "ID", Id);
    // End:0x95
    if(Id > 0)
    {
        idx = GetMemberIndex(Id);
        // End:0x95
        if(idx > -1)
        {
            A = idx;
            J0x4A:

            // End:0x79 [Loop If]
            if(A < (m_CurCount - 1))
            {
                f_UnkFunc_1(A, A + 1);
                A++;
                // [Loop Continue]
                goto J0x4A;
            }
            ClearStatus(m_CurCount - 1, true);
            m_CurCount--;
            ResizeWnd();
        }
    }
    UpdateAndSetAssistIndex();
    ReHandlePartySpelledList();
    return;
}

function HandlePartyDeleteAllParty()
{
    Clear(false);
    UpdateAndSetAssistIndex();
    return;
}

function UpdateStatus(int idx, string param)
{
    local string Name;
    local int MasterID, RoutingType, Id, CP, maxCP, HP,
	    MaxHP, MP, maxMP, ClassID, Level;

    // End:0x1B
    if((idx < 0) || idx >= 8)
    {
        return;
    }
    ParseString(param, "Name", Name);
    ParseInt(param, "ID", Id);
    ParseInt(param, "CurCP", CP);
    ParseInt(param, "MaxCP", maxCP);
    ParseInt(param, "CurHP", HP);
    ParseInt(param, "MaxHP", MaxHP);
    ParseInt(param, "CurMP", MP);
    ParseInt(param, "MaxMP", maxMP);
    ParseInt(param, "ClassID", ClassID);
    ParseInt(param, "Level", Level);
    // End:0x29C
    if(ParseInt(param, "MasterID", MasterID))
    {
        // End:0x212
        if((MasterID > 0) && MasterID == Id)
        {
            ParseInt(param, "RoutingType", RoutingType);
            RoutingTypeString = GetRoutingString(RoutingType);
            m_PartyStatus[idx].SetTooltipCustomType(MakeTooltipSimpleText(((((("Lv" $ string(Level)) $ " - ") $ GetClassType(ClassID)) $ " [") $ RoutingTypeString) $ "]"));
            m_PlayerName[idx].SetNameWithColor(Name, NCT_Normal, TA_Left, LeaderNameColor);
            m_LeaderIcon[idx].SetTexture("Was.party_leadericon");
            isLeader[idx] = 1;            
        }
        else
        {
            m_PlayerName[idx].SetName(Name, NCT_Normal, TA_Left);
            m_PartyStatus[idx].SetTooltipCustomType(MakeTooltipSimpleText((("Lv" $ string(Level)) $ " - ") $ GetClassType(ClassID)));
            m_LeaderIcon[idx].SetTexture("");
            isLeader[idx] = 0;
        }
        UpdateAndSetAssistIndex();
        ReHandlePartySpelledList();
    }
    // End:0x35C
    if(isLeader[idx] == 1)
    {
        m_PartyStatus[idx].SetTooltipCustomType(MakeTooltipSimpleText(((((("Lv" $ string(Level)) $ " - ") $ GetClassType(ClassID)) $ " [") $ RoutingTypeString) $ "]"));
        m_PlayerName[idx].SetAnchor(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".ClassIcon", "TopLeft", "TopLeft", 20, -16);        
    }
    else
    {
        m_PartyStatus[idx].SetTooltipCustomType(MakeTooltipSimpleText((("Lv" $ string(Level)) $ " - ") $ GetClassType(ClassID)));
        m_PlayerName[idx].SetAnchor(("PartyWnd.PartyStatusWnd" $ string(idx)) $ ".ClassIcon", "TopLeft", "TopLeft", 1, -16);
    }
    m_ClassIcon[idx].SetTexture(GetClassIconCustom(ClassID));
    m_ClassIcon[idx].SetTextureSize(32, 32);
    m_ClassIcon[idx].SetWindowSize(24, 24);
    m_ClassIcon[idx].SetTextureCtrlType(TCT_Stretch);
    m_ClassIconCustom[idx].SetTexture(s_GetCustomClassIcon(ClassID, 1));
    m_ClassIconCustom[idx].SetTooltipCustomType(MakeTooltipSimpleText(s_GetCustomClassIconTooltipText(ClassID, 1)));
    UpdateCPBar(idx, CP, maxCP);
    UpdateHPBar(idx, HP, MaxHP);
    UpdateMPBar(idx, MP, maxMP);
    return;
}

function SetPartyMembersColors()
{
    local int idx;

    idx = 0;
    J0x07:

    // End:0x11F [Loop If]
    if(idx < m_CurCount)
    {
        // End:0x5D
        if(isLeader[idx] == 1)
        {
            m_PlayerName[idx].SetNameWithColor(m_PlayerName[idx].GetName(), NCT_Normal, TA_Left, LeaderNameColor);
            // [Explicit Continue]
            goto J0x115;
        }
        // End:0xA2
        if(idx == i_AssistIndex_1)
        {
            m_PlayerName[idx].SetNameWithColor(m_PlayerName[idx].GetName(), NCT_Normal, TA_Left, AssistNameColor_1);
            // [Explicit Continue]
            goto J0x115;
        }
        // End:0xE7
        if(idx == i_AssistIndex_2)
        {
            m_PlayerName[idx].SetNameWithColor(m_PlayerName[idx].GetName(), NCT_Normal, TA_Left, AssistNameColor_2);
            // [Explicit Continue]
            goto J0x115;
        }
        m_PlayerName[idx].SetName(m_PlayerName[idx].GetName(), NCT_Normal, TA_Left);
        J0x115:

        idx++;
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function int HandlePartySpelledList(string param)
{
    local int A, idx, Id, Max, BuffCnt, BuffCurRow;

    local StatusIconInfo StatusInfo;

    BuffCurRow = -1;
    ParseInt(param, "ID", Id);
    // End:0x30
    if(Id < 1)
    {
        return -1;
    }
    idx = GetMemberIndex(Id);
    // End:0x52
    if(idx < 0)
    {
        return -1;
    }
    m_StatusIconBuff[idx].Clear();
    m_StatusNoblessBuff[idx].Clear();
    m_StatusIconDeBuff[idx].Clear();
    A = 0;
    J0x98:

    // End:0xD8 [Loop If]
    if(A < 9)
    {
        m_StatusIconDeBuff[A].AddRow();
        m_StatusIconDeBuff[A].AddRow();
        A++;
        // [Loop Continue]
        goto J0x98;
    }
    StatusInfo.Size = 14;
    StatusInfo.bShow = true;
    ParseInt(param, "Max", Max);
    m_ClassIconCustom[idx].SetAnchor("PartyWnd.PartyStatusWnd" $ string(idx), "TopRight", "TopRight", -11, 1);
    A = 0;
    J0x15F:

    // End:0x367 [Loop If]
    if(A < Max)
    {
        ParseInt(param, "SkillID_" $ string(A), StatusInfo.ClassID);
        ParseInt(param, "Level_" $ string(A), StatusInfo.Level);
        // End:0x35D
        if(StatusInfo.ClassID > 0)
        {
            // End:0x231
            if(StatusInfo.ClassID == 1323)
            {
                m_ClassIconCustom[idx].SetAnchor("PartyWnd.PartyStatusWnd" $ string(idx), "TopRight", "TopRight", -28, 1);
            }
            StatusInfo.IconName = Class'NWindow.UIDATA_SKILL'.static.GetIconName(StatusInfo.ClassID, StatusInfo.Level);
            StatusInfo.BackTex = "";
            // End:0x2BD
            if(isDebuffCustom(StatusInfo.ClassID))
            {
                StatusInfo.BackTex = "L2UI_CH3.Debuff";
                m_StatusIconDeBuff[idx].AddCol(checkPriorDebuffSameRow, StatusInfo);                
            }
            else
            {
                // End:0x2EE
                if((float(BuffCnt) % float(18)) == float(0))
                {
                    BuffCurRow++;
                    m_StatusIconBuff[idx].AddRow();
                }
                m_StatusIconBuff[idx].AddCol(BuffCurRow, StatusInfo);
                BuffCnt++;
            }
            // End:0x34D
            if((f_UnkFunc1(StatusInfo.ClassID)) && checkPrior)
            {
                m_StatusIconDeBuff[idx].AddCol(0, StatusInfo);
            }
            HandleOnPartyBuff(idx, StatusInfo);
        }
        A++;
        // [Loop Continue]
        goto J0x15F;
    }
    UpdateBuff();
    return idx;
}

function bool f_UnkFunc1(int ClassID)
{
    local int j;

    j = 0;
    J0x07:

    // End:0x38 [Loop If]
    if(j < a_UnkArrayInt1.Length)
    {
        // End:0x2E
        if(a_UnkArrayInt1[j] == ClassID)
        {
            return true;
        }
        j++;
        // [Loop Continue]
        goto J0x07;
    }
    return false;
}

function HandleShowBuffIcon(string param)
{
    local int nShow;

    ParseInt(param, "Show", nShow);
    m_CurBf = m_CurBf + 1;
    // End:0x37
    if(m_CurBf > 2)
    {
        m_CurBf = 0;
    }
    SetBuffButtonTooltip();
    switch(m_CurBf)
    {
        // End:0x51
        case 1:
            UpdateBuff();
            // End:0x73
            break;
        // End:0x5F
        case 2:
            UpdateBuff();
            // End:0x73
            break;
        // End:0x70
        case 0:
            m_CurBf = 0;
            UpdateBuff();
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnClickButton(string strID)
{
    local PartyWndCompact script;

    script = PartyWndCompact(GetScript("PartyWndCompact"));
    switch(strID)
    {
        // End:0x4D
        case "btnBuff":
            OnBuffButton();
            script.OnBuffButton();
            // End:0x7F
            break;
        // End:0x65
        case "btnCompact":
            OnOpenPartyWndOption();
            // End:0x7F
            break;
        // End:0x7C
        case "btnAssist":
            HandleChangeAssistStatus();
            // End:0x7F
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleChangeAssistStatus()
{
    // End:0x12
    if(b_AutoAssistEnabled)
    {
        DisableAutoAssist();        
    }
    else
    {
        // End:0x35
        if(((GetSelectedNumAssist(1)) > 0) || (GetSelectedNumAssist(2)) > 0)
        {
            EnableAutoAssist();
        }
    }
    return;
}

function OnOpenPartyWndOption()
{
    local PartyWndOption script;

    script = PartyWndOption(GetScript("PartyWndOption"));
    script.ShowPartyWndOption();
    m_PartyOption.SetAnchor("PartyWnd.PartyStatusWnd0", "TopRight", "TopLeft", 5, 5);
    return;
}

function OnBuffButton()
{
    m_CurBf = m_CurBf + 1;
    // End:0x21
    if(m_CurBf > 2)
    {
        m_CurBf = 0;
    }
    SetBuffButtonTooltip();
    UpdateBuff();
    return;
}

function UpdateBuff()
{
    local int idx;

    // End:0x55
    if(m_CurBf == 1)
    {
        idx = 0;
        J0x12:

        // End:0x52 [Loop If]
        if(idx < 8)
        {
            m_StatusIconBuff[idx].ShowWindow();
            m_StatusIconDeBuff[idx].HideWindow();
            idx++;
            // [Loop Continue]
            goto J0x12;
        }        
    }
    else
    {
        // End:0xAB
        if(m_CurBf == 2)
        {
            idx = 0;
            J0x68:

            // End:0xA8 [Loop If]
            if(idx < 8)
            {
                m_StatusIconBuff[idx].HideWindow();
                m_StatusIconDeBuff[idx].ShowWindow();
                idx++;
                // [Loop Continue]
                goto J0x68;
            }            
        }
        else
        {
            idx = 0;
            J0xB2:

            // End:0xF2 [Loop If]
            if(idx < 8)
            {
                m_StatusIconBuff[idx].HideWindow();
                m_StatusIconDeBuff[idx].HideWindow();
                idx++;
                // [Loop Continue]
                goto J0xB2;
            }
        }
    }
    return;
}

function UpdateCPBar(int idx, int Value, int MaxValue)
{
    m_BarCP[idx].SetValue(MaxValue, Value);
    return;
}

function UpdateHPBar(int idx, int Value, int MaxValue)
{
    m_BarHP[idx].SetValue(MaxValue, Value);
    return;
}

function UpdateMPBar(int idx, int Value, int MaxValue)
{
    m_BarMP[idx].SetValue(MaxValue, Value);
    return;
}

function OnLButtonDown(WindowHandle a_WindowHandle, int X, int Y)
{
    local Rect rectWnd;
    local UserInfo StatusInfo;
    local int idx;

    rectWnd = m_wndTop.GetRect();
    // End:0xED
    if(((X > (rectWnd.nX + 13)) && X < ((rectWnd.nX + rectWnd.nWidth) - 10)) && Y > rectWnd.nY)
    {
        idx = (Y - rectWnd.nY) / 46;
        // End:0x9D
        if(IsKeyDown(IK_Alt))
        {
            i_UnkInt_1 = idx;            
        }
        else
        {
            // End:0xED
            if(GetPlayerInfo(StatusInfo))
            {
                // End:0xD2
                if(IsPKMode())
                {
                    RequestAttack(m_arrID[idx], StatusInfo.Loc);                    
                }
                else
                {
                    RequestAction(m_arrID[idx], StatusInfo.Loc);
                }
            }
        }
    }
    return;
}

function OnLButtonUp(WindowHandle a_WindowHandle, int X, int Y)
{
    local Rect rectWnd;
    local int idx;

    rectWnd = m_wndTop.GetRect();
    // End:0xBF
    if(((X > (rectWnd.nX + 13)) && X < ((rectWnd.nX + rectWnd.nWidth) - 10)) && Y > rectWnd.nY)
    {
        idx = (Y - rectWnd.nY) / 46;
        // End:0xBF
        if(IsKeyDown(IK_Alt))
        {
            // End:0xBF
            if((i_UnkInt_1 > -1) && i_UnkInt_1 != idx)
            {
                ProbablyMove(i_UnkInt_1, idx);
            }
        }
    }
    i_UnkInt_1 = -1;
    return;
}

function OnRButtonUp(int X, int Y)
{
    local Rect rectWnd;
    local UserInfo Info;
    local int idx;

    rectWnd = m_wndTop.GetRect();
    // End:0xAD
    if(((X > (rectWnd.nX + 13)) && X < ((rectWnd.nX + rectWnd.nWidth) - 10)) && Y > rectWnd.nY)
    {
        // End:0xAD
        if(GetPlayerInfo(Info))
        {
            idx = (Y - rectWnd.nY) / 46;
            RequestAssist(m_arrID[idx], Info.Loc);
        }
    }
    return;
}

function SetBuffButtonTooltip()
{
    local int idx;

    switch(m_CurBf)
    {
        // End:0x19
        case 0:
            idx = 1496;
            // End:0x41
            break;
        // End:0x2B
        case 1:
            idx = 1497;
            // End:0x41
            break;
        // End:0x3E
        case 2:
            idx = 1498;
            // End:0x41
            break;
        // End:0xFFFF
        default:
            break;
    }
    btnBuff.SetTooltipCustomType(MakeTooltipSimpleText(GetSystemString(idx)));
    return;
}

function HandleOnPartyBuff(int idx, StatusIconInfo StatusInfo)
{
    local StatusIconInfo Info;

    // End:0xBB
    if((((StatusInfo.ClassID == 1410) || StatusInfo.ClassID == 438) || StatusInfo.ClassID == 1418) || StatusInfo.ClassID == 1427)
    {
        m_StatusNoblessBuff[idx].DelItem(0, 0);
        // End:0x9D
        if(m_StatusNoblessBuff[idx].GetRowCount() < 1)
        {
            m_StatusNoblessBuff[idx].AddRow();
        }
        m_StatusNoblessBuff[idx].AddCol(0, StatusInfo);        
    }
    else
    {
        // End:0x18C
        if(StatusInfo.ClassID == 1323)
        {
            m_StatusNoblessBuff[idx].GetItem(0, 0, Info);
            // End:0x18C
            if((((Info.ClassID != 1410) && Info.ClassID != 438) && Info.ClassID != 1418) && Info.ClassID != 1427)
            {
                // End:0x171
                if(m_StatusNoblessBuff[idx].GetRowCount() < 1)
                {
                    m_StatusNoblessBuff[idx].AddRow();
                }
                m_StatusNoblessBuff[idx].AddCol(0, StatusInfo);
            }
        }
    }
    return;
}

function ProbablyMove(int UnkInt_ProbablyMemberPos, int idx)
{
    local int A;

    // End:0x28
    if((UnkInt_ProbablyMemberPos > (m_CurCount - 1)) || idx > (m_CurCount - 1))
    {
        return;
    }
    // End:0x39
    if(UnkInt_ProbablyMemberPos == idx)
    {
        return;
    }
    // End:0x5E
    if((UnkInt_ProbablyMemberPos == -1) || idx == -1)
    {
        return;        
    }
    else
    {
        // End:0xC7
        if(UnkInt_ProbablyMemberPos < idx)
        {
            f_UnkFunc_1(9 - 1, UnkInt_ProbablyMemberPos);
            A = UnkInt_ProbablyMemberPos;
            J0x88:

            // End:0xB4 [Loop If]
            if(A < idx)
            {
                f_UnkFunc_1(A, A + 1);
                A++;
                // [Loop Continue]
                goto J0x88;
            }
            f_UnkFunc_1(idx, 9 - 1);            
        }
        else
        {
            f_UnkFunc_1(9 - 1, UnkInt_ProbablyMemberPos);
            A = UnkInt_ProbablyMemberPos;
            J0xE2:

            // End:0x10E [Loop If]
            if(A > idx)
            {
                f_UnkFunc_1(A, A - 1);
                A--;
                // [Loop Continue]
                goto J0xE2;
            }
            f_UnkFunc_1(idx, 9 - 1);
        }
    }
    ClearStatus(9 - 1, true);
    ResizeWnd();
    UpdateAndSetAssistIndex();
    ReHandlePartySpelledList();
    return;
}

function CustomTooltip SetTooltip(string Text)
{
    local CustomTooltip ToolTip;
    local DrawItemInfo Info;

    ToolTip.DrawList.Length = 1;
    Info.eType = DIT_TEXT;
    Info.t_strText = Text;
    ToolTip.DrawList[0] = Info;
    return ToolTip;
}

function bool InRange(Vector v_Vector, int Range)
{
    local int X, Y, Z;
    local UserInfo Info;

    GetPlayerInfo(Info);
    X = int(v_Vector.X - Info.Loc.X);
    Y = int(v_Vector.Y - Info.Loc.Y);
    Z = int(v_Vector.Z - Info.Loc.Z);
    return (((X * X) + (Y * Y)) + (Z * Z)) < (Range * Range);
}
