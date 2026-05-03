class PartyWndCompact extends UICommonAPI;

const NSTATUSICON_MAXCOL = 12;
const NPARTYSTATUS_HEIGHT = 26;
const NPARTYSTATUS_MAXCOUNT = 8;
const PARTY_STATUS_MAX_SPELL_COUNT = 64;

var bool m_bCompact;
var bool m_bBuff;
var bool m_partyleader;
var int m_arrID[8];
var int m_CurCount;
var int m_CurBf;
var int m_MasterID;
var WindowHandle m_wndTop;
var WindowHandle m_PartyOption;
var WindowHandle m_PartyStatus[8];
var TextureHandle m_ClassIcon[8];
var StatusIconHandle m_StatusIconBuff[8];
var StatusIconHandle m_StatusIconDeBuff[8];
var BarHandle m_BarCP[8];
var BarHandle m_BarHP[8];
var BarHandle m_BarMP[8];
var ButtonHandle btnBuff;

function int ClampPartyStatusSpellCount(int Count)
{
    if(Count < 0)
    {
        return 0;
    }
    if(Count > PARTY_STATUS_MAX_SPELL_COUNT)
    {
        return PARTY_STATUS_MAX_SPELL_COUNT;
    }
    return Count;
}

function int ClampGaugeValue(int Value, int MaxValue)
{
    if(Value < 0)
    {
        return 0;
    }
    if(Value > MaxValue)
    {
        return MaxValue;
    }
    return Value;
}

function OnLoad()
{
    local int idx;

    RegisterEvent(1000);
    RegisterEvent(1140);
    RegisterEvent(1150);
    RegisterEvent(1160);
    RegisterEvent(1170);
    RegisterEvent(1180);
    RegisterEvent(40);
    m_bCompact = false;
    m_bBuff = false;
    m_CurBf = 0;
    m_MasterID = 0;
    m_wndTop = GetHandle("PartyWndCompact");
    m_PartyOption = GetHandle("PartyWndOption");
    idx = 0;

    while(idx < 8)
    {
        m_PartyStatus[idx] = GetHandle("PartyWndCompact.PartyStatusWnd" $ string(idx));
        m_ClassIcon[idx] = TextureHandle(GetHandle(("PartyWndCompact.PartyStatusWnd" $ string(idx)) $ ".ClassIcon"));
        m_StatusIconBuff[idx] = StatusIconHandle(GetHandle(("PartyWndCompact.PartyStatusWnd" $ string(idx)) $ ".StatusIconBuff"));
        m_StatusIconDeBuff[idx] = StatusIconHandle(GetHandle(("PartyWndCompact.PartyStatusWnd" $ string(idx)) $ ".StatusIconDebuff"));
        m_BarCP[idx] = BarHandle(GetHandle(("PartyWndCompact.PartyStatusWnd" $ string(idx)) $ ".barCP"));
        m_BarHP[idx] = BarHandle(GetHandle(("PartyWndCompact.PartyStatusWnd" $ string(idx)) $ ".barHP"));
        m_BarMP[idx] = BarHandle(GetHandle(("PartyWndCompact.PartyStatusWnd" $ string(idx)) $ ".barMP"));
        idx++;
    }
    btnBuff = ButtonHandle(GetHandle("PartyWndCompact.btnBuff"));
    idx = 0;

    while(idx < 8)
    {
        m_StatusIconBuff[idx].SetAnchor("PartyWndCompact.PartyStatusWnd" $ string(idx), "TopRight", "TopLeft", 1, 3);
        m_StatusIconDeBuff[idx].SetAnchor("PartyWndCompact.PartyStatusWnd" $ string(idx), "TopRight", "TopLeft", 1, 3);
        idx++;
    }
    m_ClassIcon[0].Move(0, 7);
    m_PartyOption.HideWindow();
    return;
}

function OnShow()
{
    SetBuffButtonTooltip();
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
    // End:0x1D
    if(Event_ID == 1140)
    {
        HandlePartyAddParty(param);        
    }
    else
    {
        // End:0x3A
        if(Event_ID == 1150)
        {
            HandlePartyUpdateParty(param);            
        }
        else
        {
            // End:0x57
            if(Event_ID == 1160)
            {
                HandlePartyDeleteParty(param);                
            }
            else
            {
                // End:0x6F
                if(Event_ID == 1170)
                {
                    HandlePartyDeleteAllParty();                    
                }
                else
                {
                    // End:0x8C
                    if(Event_ID == 1180)
                    {
                        HandlePartySpelledList(param);                        
                    }
                    else
                    {
                        // End:0xA9
                        if(Event_ID == 1000)
                        {
                            HandleShowBuffIcon(param);                            
                        }
                        else
                        {
                            // End:0xBB
                            if(Event_ID == 40)
                            {
                                HandleRestart();
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function HandleRestart()
{
    Clear();
    return;
}

function Clear()
{
    local int idx;

    idx = 0;

    while(idx < 8)
    {
        ClearStatus(idx);
        idx++;
    }
    m_CurCount = 0;
    ResizeWnd();
    return;
}

function ClearStatus(int idx)
{
    m_StatusIconBuff[idx].Clear();
    m_StatusIconDeBuff[idx].Clear();
    m_ClassIcon[idx].SetTexture("");
    UpdateCPBar(idx, 0, 0);
    UpdateHPBar(idx, 0, 0);
    UpdateMPBar(idx, 0, 0);
    m_arrID[idx] = 0;
    return;
}

function CopyStatus(int DesIndex, int SrcIndex)
{
    local int MaxValue, CurValue, row, col, MaxRow, MaxCol;

    local StatusIconInfo Info;
    local CustomTooltip TooltipInfo, TooltipInfo2;

    m_arrID[DesIndex] = m_arrID[SrcIndex];
    m_PartyStatus[SrcIndex].GetTooltipCustomType(TooltipInfo);
    m_PartyStatus[DesIndex].SetTooltipCustomType(TooltipInfo);
    m_ClassIcon[DesIndex].SetTexture(m_ClassIcon[SrcIndex].GetTextureName());
    m_ClassIcon[SrcIndex].GetTooltipCustomType(TooltipInfo2);
    m_ClassIcon[DesIndex].SetTooltipCustomType(TooltipInfo2);
    m_BarCP[SrcIndex].GetValue(MaxValue, CurValue);
    m_BarCP[DesIndex].SetValue(MaxValue, CurValue);
    m_BarHP[SrcIndex].GetValue(MaxValue, CurValue);
    m_BarHP[DesIndex].SetValue(MaxValue, CurValue);
    m_BarMP[SrcIndex].GetValue(MaxValue, CurValue);
    m_BarMP[DesIndex].SetValue(MaxValue, CurValue);
    m_StatusIconBuff[DesIndex].Clear();
    MaxRow = m_StatusIconBuff[SrcIndex].GetRowCount();
    row = 0;

    while(row < MaxRow)
    {
        m_StatusIconBuff[DesIndex].AddRow();
        MaxCol = m_StatusIconBuff[SrcIndex].GetColCount(row);
        col = 0;

        while(col < MaxCol)
        {
            m_StatusIconBuff[SrcIndex].GetItem(row, col, Info);
            m_StatusIconBuff[DesIndex].AddCol(row, Info);
            col++;
        }
        row++;
    }
    m_StatusIconDeBuff[DesIndex].Clear();
    MaxRow = m_StatusIconDeBuff[SrcIndex].GetRowCount();
    row = 0;

    while(row < MaxRow)
    {
        m_StatusIconDeBuff[DesIndex].AddRow();
        MaxCol = m_StatusIconDeBuff[SrcIndex].GetColCount(row);
        col = 0;

        while(col < MaxCol)
        {
            m_StatusIconDeBuff[SrcIndex].GetItem(row, col, Info);
            m_StatusIconDeBuff[DesIndex].AddCol(row, Info);
            col++;
        }
        row++;
    }
    return;
}

function ResizeWnd()
{
    local int idx;
    local Rect rectWnd;
    local bool bOption;

    bOption = GetOptionBool("Game", "SmallPartyWnd");
    // End:0x107
    if(m_CurCount > 0)
    {
        rectWnd = m_wndTop.GetRect();
        m_wndTop.SetWindowSize(rectWnd.nWidth, 26 * m_CurCount);
        m_wndTop.SetResizeFrameSize(10, 26 * m_CurCount);
        // End:0x99
        if(bOption)
        {
            m_wndTop.ShowWindow();            
        }
        else
        {
            m_wndTop.HideWindow();
        }
        idx = 0;

        while(idx < 8)
        {
            // End:0xE5
            if(idx <= (m_CurCount - 1))
            {
                m_PartyStatus[idx].ShowWindow();

                idx++;
                continue;
            }
            m_PartyStatus[idx].HideWindow();

            idx++;
        }        
    }
    else
    {
        m_wndTop.HideWindow();
    }
    return;
}

function int FindPartyID(int Id)
{
    local int idx;

    idx = 0;

    while(idx < 8)
    {
        // End:0x2E
        if(m_arrID[idx] == Id)
        {
            return idx;
        }
        idx++;
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
    return;
}

function HandlePartyUpdateParty(string param)
{
    local int Id, idx;

    ParseInt(param, "ID", Id);
    // End:0x40
    if(Id > 0)
    {
        idx = FindPartyID(Id);
        UpdateStatus(idx, param);
    }
    return;
}

function HandlePartyDeleteParty(string param)
{
    local int Id, idx, i;

    ParseInt(param, "ID", Id);
    // End:0x91
    if(Id > 0)
    {
        idx = FindPartyID(Id);
        // End:0x91
        if(idx > -1)
        {
            i = idx;

            while(i < (m_CurCount - 1))
            {
                CopyStatus(i, i + 1);
                i++;
            }
            ClearStatus(m_CurCount);
            m_CurCount--;
            ResizeWnd();
        }
    }
    return;
}

function HandlePartyDeleteAllParty()
{
    Clear();
    return;
}

function UpdateStatus(int idx, string param)
{
    local string Name;
    local int Id, CP, maxCP, HP, MaxHP, MP,
	    maxMP, ClassID, MasterID;

    local CustomTooltip TooltipInfo, TooltipInfo2;

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
    // End:0x110
    if(ParseInt(param, "MasterID", MasterID))
    {
        m_MasterID = MasterID;
    }
    TooltipInfo.DrawList.Length = 1;
    TooltipInfo.DrawList[0].eType = DIT_TEXT;
    TooltipInfo.DrawList[0].t_bDrawOneLine = true;
    // End:0x192
    if((m_MasterID > 0) && m_MasterID == Id)
    {
        TooltipInfo.DrawList[0].t_strText = ((Name $ "(") $ GetSystemString(408)) $ ")";        
    }
    else
    {
        TooltipInfo.DrawList[0].t_strText = Name;
    }
    m_PartyStatus[idx].SetTooltipCustomType(TooltipInfo);
    m_ClassIcon[idx].SetTexture(GetClassIconName(ClassID));
    TooltipInfo2.DrawList.Length = 2;
    TooltipInfo2.DrawList[0].eType = DIT_TEXT;
    TooltipInfo2.DrawList[0].t_bDrawOneLine = true;
    // End:0x266
    if((m_MasterID > 0) && m_MasterID == Id)
    {
        TooltipInfo2.DrawList[0].t_strText = ((Name $ "(") $ GetSystemString(408)) $ ")";        
    }
    else
    {
        TooltipInfo2.DrawList[0].t_strText = Name;
    }
    TooltipInfo2.DrawList[1].eType = DIT_TEXT;
    TooltipInfo2.DrawList[1].nOffSetY = 2;
    TooltipInfo2.DrawList[1].t_bDrawOneLine = true;
    TooltipInfo2.DrawList[1].bLineBreak = true;
    TooltipInfo2.DrawList[1].t_strText = (GetClassStr(ClassID) $ " - ") $ GetClassType(ClassID);
    TooltipInfo2.DrawList[1].t_color.R = 128;
    TooltipInfo2.DrawList[1].t_color.G = 128;
    TooltipInfo2.DrawList[1].t_color.B = 128;
    TooltipInfo2.DrawList[1].t_color.A = byte(255);
    m_ClassIcon[idx].SetTooltipCustomType(TooltipInfo2);
    UpdateCPBar(idx, CP, maxCP);
    UpdateHPBar(idx, HP, MaxHP);
    UpdateMPBar(idx, MP, maxMP);
    return;
}

function HandlePartySpelledList(string param)
{
    local int i, idx, Id, Max, BuffCnt, BuffCurRow,
	    DeBuffCnt, DeBuffCurRow;

    local StatusIconInfo Info;

    DeBuffCurRow = -1;
    BuffCurRow = -1;
    ParseInt(param, "ID", Id);
    // End:0x37
    if(Id < 1)
    {
        return;
    }
    idx = FindPartyID(Id);
    // End:0x55
    if(idx < 0)
    {
        return;
    }
    m_StatusIconBuff[idx].Clear();
    m_StatusIconDeBuff[idx].Clear();
    Info.Size = 10;
    Info.bShow = true;
    ParseInt(param, "Max", Max);
    Max = ClampPartyStatusSpellCount(Max);
    i = 0;

    while(i < Max)
    {
        ParseInt(param, "SkillID_" $ string(i), Info.ClassID);
        ParseInt(param, "Level_" $ string(i), Info.Level);
        // End:0x221
        if(Info.ClassID > 0)
        {
            Info.IconName = Class'NWindow.UIDATA_SKILL'.static.GetIconName(Info.ClassID, Info.Level);
            // End:0x1CA
            if(IsDebuff(Info.ClassID, Info.Level) == true)
            {
                // End:0x1A1
                if((float(DeBuffCnt) % float(12)) == float(0))
                {
                    DeBuffCurRow++;
                    m_StatusIconDeBuff[idx].AddRow();
                }
                m_StatusIconDeBuff[idx].AddCol(DeBuffCurRow, Info);
                DeBuffCnt++;

                i++;
                continue;
            }
            // End:0x1FB
            if((float(BuffCnt) % float(12)) == float(0))
            {
                BuffCurRow++;
                m_StatusIconBuff[idx].AddRow();
            }
            m_StatusIconBuff[idx].AddCol(BuffCurRow, Info);
            BuffCnt++;
        }

        i++;
    }
    UpdateBuff();
    return;
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
    local PartyWnd script;

    script = PartyWnd(GetScript("PartyWnd"));
    switch(strID)
    {
        // End:0x46
        case "btnBuff":
            OnBuffButton();
            script.OnBuffButton();
            // End:0x5D
            break;
        // End:0x5A
        case "btnOption":
            OnOpenPartyWndOption();
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnOpenPartyWndOption()
{
    local PartyWndOption script;

    script = PartyWndOption(GetScript("PartyWndOption"));
    script.ShowPartyWndOption();
    m_PartyOption.SetAnchor("PartyWndCompact.PartyStatusWnd0", "TopRight", "TopLeft", 5, 5);
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

        while(idx < 8)
        {
            m_StatusIconBuff[idx].ShowWindow();
            m_StatusIconDeBuff[idx].HideWindow();
            idx++;
        }        
    }
    else
    {
        // End:0xAB
        if(m_CurBf == 2)
        {
            idx = 0;

            while(idx < 8)
            {
                m_StatusIconBuff[idx].HideWindow();
                m_StatusIconDeBuff[idx].ShowWindow();
                idx++;
            }            
        }
        else
        {
            idx = 0;

            while(idx < 8)
            {
                m_StatusIconBuff[idx].HideWindow();
                m_StatusIconDeBuff[idx].HideWindow();
                idx++;
            }
        }
    }
    return;
}

function UpdateCPBar(int idx, int Value, int MaxValue)
{
    if((idx < 0) || idx >= 8)
    {
        return;
    }
    if(MaxValue < 0)
    {
        MaxValue = 0;
    }
    Value = ClampGaugeValue(Value, MaxValue);
    m_BarCP[idx].SetValue(MaxValue, Value);
    return;
}

function UpdateHPBar(int idx, int Value, int MaxValue)
{
    if((idx < 0) || idx >= 8)
    {
        return;
    }
    if(MaxValue < 0)
    {
        MaxValue = 0;
    }
    Value = ClampGaugeValue(Value, MaxValue);
    m_BarHP[idx].SetValue(MaxValue, Value);
    return;
}

function UpdateMPBar(int idx, int Value, int MaxValue)
{
    if((idx < 0) || idx >= 8)
    {
        return;
    }
    if(MaxValue < 0)
    {
        MaxValue = 0;
    }
    Value = ClampGaugeValue(Value, MaxValue);
    m_BarMP[idx].SetValue(MaxValue, Value);
    return;
}

function OnLButtonDown(WindowHandle a_WindowHandle, int X, int Y)
{
    local Rect rectWnd;
    local int idx;

    rectWnd = m_wndTop.GetRect();
    // End:0x59
    if(X > (rectWnd.nX + 30))
    {
        idx = (Y - rectWnd.nY) / 26;
        RequestTargetUser(m_arrID[idx]);
    }
    return;
}

function OnRButtonUp(int X, int Y)
{
    local Rect rectWnd;
    local UserInfo UserInfo;
    local int idx;

    rectWnd = m_wndTop.GetRect();
    // End:0x71
    if(X > (rectWnd.nX + 30))
    {
        // End:0x71
        if(GetPlayerInfo(UserInfo))
        {
            idx = (Y - rectWnd.nY) / 26;
            RequestAssist(m_arrID[idx], UserInfo.Loc);
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
