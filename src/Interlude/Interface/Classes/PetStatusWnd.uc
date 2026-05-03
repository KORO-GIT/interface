class PetStatusWnd extends UIScript;

const NSTATUSICON_MAXCOL = 10;
const STATUS_MAX_SPELL_COUNT = 64;

var bool m_bBuff;
var bool m_bShow;
var int m_PetID;

function int ClampStatusSpellCount(int Count)
{
    if(Count < 0)
    {
        return 0;
    }
    if(Count > STATUS_MAX_SPELL_COUNT)
    {
        return STATUS_MAX_SPELL_COUNT;
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
    RegisterEvent(250);
    RegisterEvent(1000);
    RegisterEvent(1040);
    RegisterEvent(1050);
    RegisterEvent(1130);
    m_bShow = false;
    m_bBuff = false;
    return;
}

function OnShow()
{
    local int PetID, IsPetOrSummoned;

    PetID = Class'NWindow.UIDATA_PET'.static.GetPetID();
    IsPetOrSummoned = Class'NWindow.UIDATA_PET'.static.GetIsPetOrSummoned();
    // End:0x63
    if((PetID < 0) || IsPetOrSummoned != 2)
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("PetStatusWnd");        
    }
    else
    {
        m_bShow = true;
    }
    return;
}

function OnHide()
{
    m_bShow = false;
    return;
}

function OnEnterState(name a_PreStateName)
{
    m_bBuff = false;
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x15
    if(Event_ID == 250)
    {
        HandlePetInfoUpdate();        
    }
    else
    {
        // End:0x2D
        if(Event_ID == 1130)
        {
            HandlePetStatusClose();            
        }
        else
        {
            // End:0x45
            if(Event_ID == 1040)
            {
                HandlePetStatusShow();                
            }
            else
            {
                // End:0x62
                if(Event_ID == 1000)
                {
                    HandleShowBuffIcon(param);                    
                }
                else
                {
                    // End:0x7C
                    if(Event_ID == 1050)
                    {
                        HandlePetStatusSpelledList(param);
                    }
                }
            }
        }
    }
    return;
}

function Clear()
{
    Class'NWindow.UIAPI_STATUSICONCTRL'.static.Clear("PetStatusWnd.StatusIcon");
    Class'NWindow.UIAPI_NAMECTRL'.static.SetName("PetStatusWnd.PetName", "", NCT_Normal, TA_Center);
    UpdateHPBar(0, 0);
    UpdateMPBar(0, 0);
    UpdateFatigueBar(0, 0);
    return;
}

function HandlePetStatusClose()
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("PetStatusWnd");
    PlayConsoleSound(IFST_WINDOW_CLOSE);
    return;
}

function HandlePetInfoUpdate()
{
    local string Name;
    local int HP, MaxHP, MP, maxMP, Fatigue, MaxFatigue;

    local PetInfo Info;

    m_PetID = 0;
    // End:0x95
    if(GetPetInfo(Info))
    {
        m_PetID = Info.nID;
        Name = Info.Name;
        HP = Info.nCurHP;
        MP = Info.nCurMP;
        Fatigue = Info.nFatigue;
        MaxHP = Info.nMaxHP;
        maxMP = Info.nMaxMP;
        MaxFatigue = Info.nMaxFatigue;
    }
    Class'NWindow.UIAPI_NAMECTRL'.static.SetName("PetStatusWnd.PetName", Name, NCT_Normal, TA_Center);
    UpdateHPBar(HP, MaxHP);
    UpdateMPBar(MP, maxMP);
    UpdateFatigueBar(Fatigue, MaxFatigue);
    return;
}

function HandlePetStatusShow()
{
    Clear();
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("PetStatusWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("PetStatusWnd");
    return;
}

function HandlePetStatusSpelledList(string param)
{
    local int i, Max, BuffCnt, CurRow;
    local StatusIconInfo Info;

    CurRow = -1;
    Class'NWindow.UIAPI_STATUSICONCTRL'.static.Clear("PetStatusWnd.StatusIcon");
    Info.Size = 16;
    Info.bShow = true;
    ParseInt(param, "Max", Max);
    Max = ClampStatusSpellCount(Max);
    i = 0;

    while(i < Max)
    {
        ParseInt(param, "SkillID_" $ string(i), Info.ClassID);
        // End:0x152
        if(Info.ClassID > 0)
        {
            Info.IconName = Class'NWindow.UIDATA_SKILL'.static.GetIconName(Info.ClassID, 1);
            // End:0x119
            if((float(BuffCnt) % float(10)) == float(0))
            {
                CurRow++;
                Class'NWindow.UIAPI_STATUSICONCTRL'.static.AddRow("PetStatusWnd.StatusIcon");
            }
            Class'NWindow.UIAPI_STATUSICONCTRL'.static.AddCol("PetStatusWnd.StatusIcon", CurRow, Info);
            BuffCnt++;
        }
        i++;
    }
    UpdateBuff(m_bBuff);
    return;
}

function HandleShowBuffIcon(string param)
{
    local int nShow;

    ParseInt(param, "Show", nShow);
    // End:0x2B
    if(nShow == 1)
    {
        UpdateBuff(true);        
    }
    else
    {
        UpdateBuff(false);
    }
    return;
}

function OnLButtonDown(WindowHandle a_WindowHandle, int X, int Y)
{
    local Rect rectWnd;
    local UserInfo UserInfo;

    rectWnd = Class'NWindow.UIAPI_WINDOW'.static.GetRect("PetStatusWnd");
    // End:0x84
    if((X > (rectWnd.nX + 13)) && X < ((rectWnd.nX + rectWnd.nWidth) - 10))
    {
        // End:0x84
        if(GetPlayerInfo(UserInfo))
        {
            RequestAction(m_PetID, UserInfo.Loc);
        }
    }
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1C
        case "btnBuff":
            OnBuffButton();
            // End:0x1F
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnBuffButton()
{
    UpdateBuff(!m_bBuff);
    return;
}

function UpdateBuff(bool bShow)
{
    // End:0x34
    if(bShow)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("PetStatusWnd.StatusIcon");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("PetStatusWnd.StatusIcon");
    }
    m_bBuff = bShow;
    return;
}

function UpdateHPBar(int Value, int MaxValue)
{
    if(MaxValue < 0)
    {
        MaxValue = 0;
    }
    Value = ClampGaugeValue(Value, MaxValue);
    Class'NWindow.UIAPI_BARCTRL'.static.SetValue("PetStatusWnd.barHP", MaxValue, Value);
    return;
}

function UpdateMPBar(int Value, int MaxValue)
{
    if(MaxValue < 0)
    {
        MaxValue = 0;
    }
    Value = ClampGaugeValue(Value, MaxValue);
    Class'NWindow.UIAPI_BARCTRL'.static.SetValue("PetStatusWnd.barMP", MaxValue, Value);
    return;
}

function UpdateFatigueBar(int Value, int MaxValue)
{
    if(MaxValue < 0)
    {
        MaxValue = 0;
    }
    Value = ClampGaugeValue(Value, MaxValue);
    Class'NWindow.UIAPI_BARCTRL'.static.SetValue("PetStatusWnd.barFatigue", MaxValue, Value);
    return;
}
