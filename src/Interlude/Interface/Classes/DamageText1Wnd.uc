class DamageText1Wnd extends SublimityItem;

const CONTAINER_COUNT = 30;
const TEX_COUNT = 10;
const MAX_DAMAGE_QUEUE = 2000000000;
const DIRECTION_UP = -1;
const DIRECTION_DOWN = 1;
const TYPE_DAMAGE = 1;
const TYPE_DAMAGE2 = 2;
const TYPE_CP = 3;
const TYPE_HEAL = 4;
const TYPE_MANA = 5;
const TYPE_EXP = 6;
const TYPE_MISS = 7;
const TYPE_MISS2 = 8;
const TYPE_BLOCK = 9;
const TYPE_BLOCK2 = 10;
const TYPE_RESIST = 11;
const TYPE_RESIST2 = 12;
const TYPE_CRITICAL = 13;
const TYPE_CRITICAL2 = 14;
const TYPE_OVERHIT = 15;

var ButtonHandle hEnableBtn;
var TextureHandle hDisableTex;
var bool bShowing;
var TextureHandle m_Digits[310];
var int m_TextWidth[20];
var int m_TextHeight[20];
var int m_TextOffset[20];
var int m_TextOffsetCorrection[20];
var int m_LastUsedContainer;
var int m_Direction[31];
var int m_ContainerType[31];
var int m_DamageQueue[30];
var int m_DamageQueueCount[30];
var int m_Type2Count;

function bool IsValidIndicatorType(int Type)
{
    return (Type >= TYPE_DAMAGE) && (Type <= TYPE_OVERHIT);
}

function bool IsValidContainer(int Container)
{
    return (Container >= 1) && (Container <= CONTAINER_COUNT);
}

function OnLoad()
{
    local int i, ii, C;

    RegisterEvent(580);
    RegisterEvent(40);
    m_TextWidth[0] = 18;
    m_TextWidth[1] = 11;
    m_TextWidth[2] = 17;
    m_TextWidth[3] = 17;
    m_TextWidth[4] = 17;
    m_TextWidth[5] = 17;
    m_TextWidth[6] = 16;
    m_TextWidth[7] = 17;
    m_TextWidth[8] = 18;
    m_TextWidth[9] = 16;
    m_TextWidth[10] = 10;
    m_TextWidth[11] = 10;
    m_TextWidth[12] = 0;
    m_TextWidth[13] = 60;
    m_TextWidth[14] = 81;
    m_TextWidth[15] = 85;
    m_TextWidth[16] = 200;
    m_TextWidth[17] = 200;
    m_TextWidth[18] = 200;
    m_TextOffset[0] = 53;
    m_TextOffset[1] = 77;
    m_TextOffset[2] = 96;
    m_TextOffset[3] = 118;
    m_TextOffset[4] = 142;
    m_TextOffset[5] = 165;
    m_TextOffset[6] = 188;
    m_TextOffset[7] = 211;
    m_TextOffset[8] = 232;
    m_TextOffset[9] = 257;
    m_TextOffset[10] = 17;
    m_TextOffset[11] = 35;
    m_TextOffset[12] = 288;
    m_TextOffset[13] = 17;
    m_TextOffset[14] = 96;
    m_TextOffset[15] = 196;
    m_TextOffset[16] = 320;
    m_TextOffset[17] = 320;
    m_TextOffset[18] = 50;
    m_TextOffsetCorrection[0] = -1;
    m_TextOffsetCorrection[1] = 0;
    m_TextOffsetCorrection[2] = 0;
    m_TextOffsetCorrection[3] = 0;
    m_TextOffsetCorrection[4] = 0;
    m_TextOffsetCorrection[5] = 0;
    m_TextOffsetCorrection[6] = 0;
    m_TextOffsetCorrection[7] = -2;
    m_TextOffsetCorrection[8] = 0;
    m_TextOffsetCorrection[9] = 0;
    m_TextOffsetCorrection[10] = 0;
    m_TextOffsetCorrection[11] = 0;
    m_TextOffsetCorrection[12] = 0;
    m_TextOffsetCorrection[13] = 0;
    m_TextOffsetCorrection[14] = 0;
    m_TextOffsetCorrection[15] = 0;
    i = 1;

    while(i <= 30)
    {
        C = i * 10;
        ii = 0;

        while(ii < 10)
        {
            m_Digits[C + ii] = TextureHandle(GetHandle(((("DamageText1Wnd.DamageText1" $ string(i)) $ "Wnd.Digit") $ string(i)) $ string(ii + 1)));
            ++ii;
        }
        ++i;
    }
    return;
}

function OnEvent(int Event_ID, string a_Param)
{
    switch(Event_ID)
    {
        // End:0x3B
        case 580:
            // End:0x38
            if(GetOptionBool("Options", "ShowDamage"))
            {
                HandleSystemMessage(a_Param);
            }
            // End:0x4C
            break;
        // End:0x49
        case 40:
            HandleRestart();
            // End:0x4C
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleRestart()
{
    local int i;

    i = 1;

    while(i <= 30)
    {
        HideWindow(("DamageText1Wnd.DamageText1" $ string(i)) $ "Wnd");
        ++i;
    }
    return;
}

function HandleSystemMessage(string a_Param)
{
    local string Index, Param1;

    ParseString(a_Param, "Index", Index);
    // End:0x78
    if((Index == "35") || Index == "1130")
    {
        ParseString(a_Param, "Param1", Param1);
        ShowIndicator(1, int(Param1), 80, false);
    }
    return;
}

function ShowIndicator(int Type, int Value, int nGroupThreshold, bool bGrouped)
{
    local int Container;

    if(!IsValidIndicatorType(Type))
    {
        return;
    }
    if(Value < 0)
    {
        Value = 0;
    }
    // End:0x89
    if(nGroupThreshold > 0)
    {
        if((Value > 0) && (m_DamageQueue[Type] > (MAX_DAMAGE_QUEUE - Value)))
        {
            m_DamageQueue[Type] = MAX_DAMAGE_QUEUE;
        }
        else
        {
            m_DamageQueue[Type] += Value;
        }
        m_DamageQueueCount[Type] += 1;
        Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("DamageText1Wnd", -1 * Type);
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("DamageText1Wnd", -1 * Type, nGroupThreshold);        
    }
    else
    {
        m_LastUsedContainer++;
        // End:0xA3
        if(m_LastUsedContainer > 30)
        {
            m_LastUsedContainer = 1;
        }
        Container = m_LastUsedContainer;
        ShowAndAnimate(Type, Container, Value, bGrouped);
    }
    return;
}

function ShowAndAnimate(int Type, int Container, int Value, bool bGrouped)
{
    local string WindowName;
    local int offsetX, offsetY;

    if(!IsValidIndicatorType(Type) || !IsValidContainer(Container))
    {
        return;
    }
    if(Value < 0)
    {
        Value = 0;
    }
    WindowName = ("DamageText1Wnd.DamageText1" $ string(Container)) $ "Wnd";
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("DamageText1Wnd", Container);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("DamageText1Wnd", -100 * Container);
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor(WindowName, "", "TopLeft", "TopLeft", 0, 0);
    Class'NWindow.UIAPI_WINDOW'.static.ClearAnchor(WindowName);
    Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WindowName, 255);
    SetValue(Type, Container, Value, bGrouped);
    ShowWindow(WindowName);
    // End:0x135
    if(Type == 1)
    {
        SetDirection(Container, -1);
        offsetX = 0 + (-10 - Rand(30));
        offsetY = -50;
    }
    // End:0x1A8
    if(((((Type == 7) || Type == 9) || Type == 11) || Type == 13) || Type == 14)
    {
        SetDirection(Container, -1);
        offsetX = -80 + (10 - Rand(30));
        offsetY = 0;        
    }
    else
    {
        // End:0x1E6
        if(Type == 2)
        {
            SetDirection(Container, 1);
            offsetX = -30 + (-30 + Rand(30));
            offsetY = -20;            
        }
        else
        {
            // End:0x239
            if(((Type == 8) || Type == 10) || Type == 12)
            {
                SetDirection(Container, 1);
                offsetX = 50 + (-20 + Rand(30));
                offsetY = 0;                
            }
            else
            {
                // End:0x270
                if(Type == 15)
                {
                    SetDirection(Container, 1);
                    offsetX = -100 + (10 + Rand(30));
                    offsetY = 0;                    
                }
                else
                {
                    // End:0x2CE
                    if(((Type == 3) || Type == 5) || Type == 4)
                    {
                        SetDirection(Container, -1);
                        offsetX = -100 + (20 - Rand(40));
                        offsetY = 50 + Rand(30);                        
                    }
                    else
                    {
                        // End:0x2FD
                        if(Type == 6)
                        {
                            SetDirection(Container, -1);
                            offsetX = -60;
                            offsetY = 100;
                        }
                    }
                }
            }
        }
    }
    // End:0x34C
    if(((((Type == 7) || Type == 9) || Type == 11) || Type == 13) || Type == 14)
    {
        offsetY = 40;        
    }
    else
    {
        // End:0x38D
        if((((Type == 8) || Type == 10) || Type == 12) || Type == 15)
        {
            offsetY = -40;
        }
    }
    // End:0x4ED
    if(Type == 2)
    {
        m_Type2Count++;
        // End:0x3B3
        if(m_Type2Count == 7)
        {
            m_Type2Count = 1;
        }
        offsetX = -30 + (-30 + Rand(30));
        // End:0x3E3
        if(m_Type2Count == 1)
        {
            offsetX = 0 + Rand(10);
        }
        // End:0x400
        if(m_Type2Count == 2)
        {
            offsetX = -10 + Rand(10);
        }
        // End:0x41A
        if(m_Type2Count == 3)
        {
            offsetX = 30 + Rand(10);
        }
        // End:0x437
        if(m_Type2Count == 4)
        {
            offsetX = -20 + Rand(10);
        }
        // End:0x451
        if(m_Type2Count == 5)
        {
            offsetX = 60 + Rand(10);
        }
        // End:0x46B
        if(m_Type2Count == 6)
        {
            offsetX = 90 + Rand(10);
        }
        offsetY = -20;
        // End:0x489
        if(m_Type2Count > 1)
        {
            offsetY = 10;
        }
        // End:0x49D
        if(m_Type2Count > 2)
        {
            offsetY = 40;
        }
        // End:0x4B1
        if(m_Type2Count > 3)
        {
            offsetY = 70;
        }
        // End:0x4C5
        if(m_Type2Count > 4)
        {
            offsetY = 100;
        }
        // End:0x4D9
        if(m_Type2Count > 5)
        {
            offsetY = 130;
        }
        // End:0x4ED
        if(m_Type2Count > 6)
        {
            offsetY = 160;
        }
    }
    Class'NWindow.UIAPI_WINDOW'.static.Move(WindowName, offsetX, offsetY);
    Class'NWindow.UIAPI_WINDOW'.static.Move(WindowName, 0, (GetDirection(Container)) * 48, 0.1000000);
    Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("DamageText1Wnd", Container, 100);
    return;
}

function SetDirection(int Container, int Direction)
{
    if(!IsValidContainer(Container))
    {
        return;
    }
    m_Direction[Container] = Direction;
    return;
}

function int GetDirection(int Container)
{
    if(!IsValidContainer(Container))
    {
        return DIRECTION_UP;
    }
    return m_Direction[Container];
}

function OnTimer(int Container)
{
    local string WindowName;
    local float FadeValue;
    local bool bGrouped;

    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("DamageText1Wnd", Container);
    FadeValue = 0.0000000;
    // End:0x107
    if(Container > 0)
    {
        if(!IsValidContainer(Container))
        {
            return;
        }
        WindowName = ("DamageText1Wnd.DamageText1" $ string(Container)) $ "Wnd";
        Class'NWindow.UIAPI_WINDOW'.static.Move(WindowName, 0, (GetDirection(Container)) * 100, 1.7000000);
        // End:0xD7
        if(m_ContainerType[Container] == 6)
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("DamageText1Wnd", -100 * Container, 100);            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("DamageText1Wnd", -100 * Container, 100);
        }        
    }
    else
    {
        // End:0x190
        if((Container < 0) && Container > -100)
        {
            Container = Container * -1;
            if(!IsValidIndicatorType(Container))
            {
                return;
            }
            bGrouped = false;
            // End:0x156
            if(m_DamageQueueCount[Container] > 1)
            {
                bGrouped = true;
            }
            ShowIndicator(Container, m_DamageQueue[Container], 0, bGrouped);
            m_DamageQueue[Container] = 0;
            m_DamageQueueCount[Container] = 0;            
        }
        else
        {
            Container = -1 * Container;
            // End:0x1C7
            if(Len(string(Container)) == 3)
            {
                Container = int(Left(string(Container), 1));                
            }
            else
            {
                Container = int(Left(string(Container), 2));
            }
            if(!IsValidContainer(Container))
            {
                return;
            }
            WindowName = ("DamageText1Wnd.DamageText1" $ string(Container)) $ "Wnd";
            HideWindow(WindowName);
        }
    }
    return;
}

function TimerFadeOut(int Container, int Duration, int Steps)
{
    local int i, C, D;

    if(!IsValidContainer(Container) || Steps <= 0)
    {
        return;
    }
    i = 1;
    C = 100 / Steps;
    D = Duration / Steps;

    while(i <= Steps)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("DamageText1Wnd", (-100 * Container) - (100 - (i * C)), i * D);
        i++;
    }
    return;
}

function SetValue(int Type, int Container, int Value, bool bGrouped)
{
    local int i;
    local string S, WindowName, wValue;
    local int C, nDigit, Length, PreviousDigit;

    if(!IsValidIndicatorType(Type) || !IsValidContainer(Container))
    {
        return;
    }
    if(Value < 0)
    {
        Value = 0;
    }
    m_ContainerType[Container] = Type;
    WindowName = ("DamageText1Wnd.DamageText1" $ string(Container)) $ "Wnd";
    C = Container * 10;
    i = 0;

    while(i < 10)
    {
        m_Digits[C + i].SetUV(0, 0);
        m_Digits[C + i].SetWindowSize(0, 0);
        ++i;
    }
    wValue = string(Value);
    // End:0x102
    if((((Type == 4) || Type == 3) || Type == 6) || Type == 5)
    {
        wValue = "#+" $ wValue;        
    }
    else
    {
        // End:0x128
        if((Type == 7) || Type == 8)
        {
            wValue = "M";            
        }
        else
        {
            // End:0x14E
            if((Type == 9) || Type == 10)
            {
                wValue = "B";                
            }
            else
            {
                // End:0x174
                if((Type == 11) || Type == 12)
                {
                    wValue = "R";                    
                }
                else
                {
                    // End:0x18C
                    if(Type == 13)
                    {
                        wValue = "C";                        
                    }
                    else
                    {
                        // End:0x1A4
                        if(Type == 14)
                        {
                            wValue = "H";                            
                        }
                        else
                        {
                            // End:0x1BC
                            if(Type == 15)
                            {
                                wValue = "O";                                
                            }
                            else
                            {
                                // End:0x1D5
                                if(bGrouped)
                                {
                                    wValue = "#" $ wValue;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Length = Len(wValue);
    if(Length > TEX_COUNT)
    {
        wValue = Right(wValue, TEX_COUNT);
        Length = TEX_COUNT;
    }
    i = 1;

    while(i <= Length)
    {
        S = Right(Left(wValue, i), 1);
        // End:0x225
        if(S == "+")
        {
            nDigit = 10;            
        }
        else
        {
            // End:0x23D
            if(S == "-")
            {
                nDigit = 11;                
            }
            else
            {
                // End:0x255
                if(S == "#")
                {
                    nDigit = 12;                    
                }
                else
                {
                    // End:0x26D
                    if(S == "M")
                    {
                        nDigit = 13;                        
                    }
                    else
                    {
                        // End:0x285
                        if(S == "B")
                        {
                            nDigit = 14;                            
                        }
                        else
                        {
                            // End:0x29D
                            if(S == "R")
                            {
                                nDigit = 15;                                
                            }
                            else
                            {
                                // End:0x2B5
                                if(S == "C")
                                {
                                    nDigit = 16;                                    
                                }
                                else
                                {
                                    // End:0x2CD
                                    if(S == "H")
                                    {
                                        nDigit = 17;                                        
                                    }
                                    else
                                    {
                                        // End:0x2E5
                                        if(S == "O")
                                        {
                                            nDigit = 18;                                            
                                        }
                                        else
                                        {
                                            nDigit = int(S);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        m_Digits[C + (i - 1)].SetUV(GetU(nDigit), GetV(Type));
        m_Digits[C + (i - 1)].SetWindowSize(GetWidth(nDigit, Type), GetHeight(nDigit));
        // End:0x3DF
        if(i > 1)
        {
            m_Digits[C + (i - 1)].SetAnchor(((WindowName $ ".Digit") $ string(Container)) $ string(i - 1), "TopLeft", "TopLeft", (GetWidth(PreviousDigit, Type)) + (GetOffsetCorrection(PreviousDigit)), 0);
        }
        PreviousDigit = nDigit;
        ++i;
    }
    return;
}

function int GetU(int nDigit)
{
    return m_TextOffset[nDigit];
}

function int GetV(int Type)
{
    // End:0x11
    if(Type == 1)
    {
        return 18;        
    }
    else
    {
        // End:0x23
        if(Type == 2)
        {
            return 68;            
        }
        else
        {
            // End:0x35
            if(Type == 3)
            {
                return 118;                
            }
            else
            {
                // End:0x47
                if(Type == 5)
                {
                    return 168;                    
                }
                else
                {
                    // End:0x59
                    if(Type == 4)
                    {
                        return 218;                        
                    }
                    else
                    {
                        // End:0x6E
                        if(Type == 6)
                        {
                            return 268;                            
                        }
                        else
                        {
                            // End:0x9F
                            if(((Type == 7) || Type == 9) || Type == 11)
                            {
                                return 399;                                
                            }
                            else
                            {
                                // End:0xD0
                                if(((Type == 8) || Type == 10) || Type == 12)
                                {
                                    return 449;                                    
                                }
                                else
                                {
                                    // End:0xE2
                                    if(Type == 13)
                                    {
                                        return 140;                                        
                                    }
                                    else
                                    {
                                        // End:0xF3
                                        if(Type == 14)
                                        {
                                            return 0;                                            
                                        }
                                        else
                                        {
                                            // End:0x105
                                            if(Type == 15)
                                            {
                                                return 300;
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
    }
    return 18;
}

function int GetWidth(int nDigit, int Type)
{
    // End:0x6A
    if(nDigit == 12)
    {
        // End:0x1E
        if(Type == 1)
        {
            return 31 + 2;
        }
        // End:0x31
        if(Type == 3)
        {
            return 20 + 2;
        }
        // End:0x44
        if(Type == 5)
        {
            return 24 + 2;
        }
        // End:0x57
        if(Type == 4)
        {
            return 22 + 2;
        }
        // End:0x6A
        if(Type == 6)
        {
            return 31 + 2;
        }
    }
    return m_TextWidth[nDigit];
}

function int GetHeight(int nDigit)
{
    // End:0x20
    if((nDigit == 16) || nDigit == 17)
    {
        return 70;        
    }
    else
    {
        // End:0x2F
        if(nDigit == 18)
        {
            return 80;
        }
    }
    return 27;
}

function int GetOffsetCorrection(int nDigit)
{
    return m_TextOffsetCorrection[nDigit];
}
