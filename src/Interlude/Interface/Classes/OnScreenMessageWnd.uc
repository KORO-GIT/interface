class OnScreenMessageWnd extends UIScript;

const ONSCREEN_MESSAGE_MAX_WND = 8;
const ONSCREEN_MESSAGE_TIMER_BASE = 8100;

var string currentwnd1;
var bool onshowstat1;
var bool onshowstat2;
var int timerset1;
var int globalAlphavalue1;
var int globalAlphavalue2;
var int globalDuration;
var int droprate;
var int moveval;
var int moveval2;
var string MovedWndName;
var int m_TimerCount;
var bool linedivided;
var int m_FadeInByWindow[9];
var int m_FadeOutByWindow[9];
var int m_AlphaInByWindow[9];
var int m_AlphaOutByWindow[9];
var int m_DropRateByWindow[9];
var int m_DurationByWindow[9];

function OnLoad()
{
    RegisterEvent(140);
    RegisterEvent(580);
    ResetAllMessage();
    timerset1 = 0;
    moveval = 0;
    moveval2 = 0;
    globalAlphavalue1 = 0;
    globalAlphavalue2 = 255;
    m_TimerCount = 0;
    return;
}

function OnTick()
{
    local int i;

    i = 1;

    while(i <= ONSCREEN_MESSAGE_MAX_WND)
    {
        if(m_FadeInByWindow[i] != 0)
        {
            FadeInWindow(i);
        }
        if(m_FadeOutByWindow[i] != 0)
        {
            FadeOutWindow(i);
        }
        ++i;
    }
    return;
}

function OnTimer(int TimerID)
{
    local int WndNum;

    if((TimerID > ONSCREEN_MESSAGE_TIMER_BASE) && (TimerID <= (ONSCREEN_MESSAGE_TIMER_BASE + ONSCREEN_MESSAGE_MAX_WND)))
    {
        Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("OnScreenMessageWnd1", TimerID);
        WndNum = TimerID - ONSCREEN_MESSAGE_TIMER_BASE;
        m_FadeOutByWindow[WndNum] = 1;
    }
    return;
}

function OnHide()
{
    return;
}

function ResetAllMessage()
{
    local int i;

    globalAlphavalue1 = 0;
    globalAlphavalue2 = 255;
    currentwnd1 = "";
    onshowstat1 = false;
    onshowstat2 = false;
    i = 1;

    while(i <= ONSCREEN_MESSAGE_MAX_WND)
    {
        ResetMessage(i);
        ++i;
    }
    return;
}

function ResetMessage(int WndNum)
{
    local Color DefaultColor;
    local string WndName;

    if((WndNum < 1) || (WndNum > ONSCREEN_MESSAGE_MAX_WND))
    {
        return;
    }

    DefaultColor.R = byte(255);
    DefaultColor.G = byte(255);
    DefaultColor.B = byte(255);
    WndName = "OnScreenMessageWnd" $ string(WndNum);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("OnScreenMessageWnd1", ONSCREEN_MESSAGE_TIMER_BASE + WndNum);
    m_FadeInByWindow[WndNum] = 0;
    m_FadeOutByWindow[WndNum] = 0;
    m_AlphaInByWindow[WndNum] = 0;
    m_AlphaOutByWindow[WndNum] = 255;
    m_DropRateByWindow[WndNum] = 255;
    m_DurationByWindow[WndNum] = 0;
    Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, 0);
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow(WndName);
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow(WndName $ ".texturetype1");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor((WndName $ ".TextBox") $ string(WndNum), DefaultColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(((WndName $ ".TextBox") $ string(WndNum)) $ "-1", DefaultColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor((WndName $ ".TextBoxsm") $ string(WndNum), DefaultColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(((WndName $ ".TextBoxsm") $ string(WndNum)) $ "-1", DefaultColor);
    return;
}

function bool IsMessageWindowActive(int WndNum)
{
    local string WndName;

    if((WndNum < 1) || (WndNum > ONSCREEN_MESSAGE_MAX_WND))
    {
        return false;
    }

    WndName = "OnScreenMessageWnd" $ string(WndNum);
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow(WndName))
    {
        return true;
    }

    if((m_FadeInByWindow[WndNum] != 0) || (m_FadeOutByWindow[WndNum] != 0))
    {
        return true;
    }

    return false;
}

function PrepareMessageWindow(int WndNum, bool bRefresh)
{
    local string WndName;

    if((WndNum < 1) || (WndNum > ONSCREEN_MESSAGE_MAX_WND))
    {
        return;
    }

    if(!bRefresh)
    {
        ResetMessage(WndNum);
        return;
    }

    WndName = "OnScreenMessageWnd" $ string(WndNum);
    Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("OnScreenMessageWnd1", ONSCREEN_MESSAGE_TIMER_BASE + WndNum);
    m_FadeInByWindow[WndNum] = 0;
    m_FadeOutByWindow[WndNum] = 0;
    m_AlphaInByWindow[WndNum] = 0;
    m_AlphaOutByWindow[WndNum] = 255;
    Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, 255);
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(WndName);
    return;
}

function int NormalizeMessageWndNum(int WndNum)
{
    if(WndNum < 1)
    {
        return 1;
    }

    if(WndNum > ONSCREEN_MESSAGE_MAX_WND)
    {
        return ONSCREEN_MESSAGE_MAX_WND;
    }

    return WndNum;
}

function ShowMsg(int WndNum, string TextValue, int Duration, int Animation, int FontType, int BackgroundType, int ColorR, int ColorG, int ColorB)
{
    local string WndName, TextBoxName, ShadowBoxName, TextBoxName2, ShadowBoxName2, TextValue1,
	    TextValue2, CurText, SmallBoxName1, SmallBoxName2;

    local Color FontColor;
    local int i, j, LengthTotal, TotalLength, TextOffsetTotal1;
    local bool bRefresh;

    WndNum = NormalizeMessageWndNum(WndNum);
    bRefresh = IsMessageWindowActive(WndNum);
    PrepareMessageWindow(WndNum, bRefresh);

    if(Duration < 0)
    {
        Duration = 0;
    }
    if((Duration > 0) && (Duration < 1500))
    {
        Duration = 1500;
    }
    if(Len(TextValue) > 512)
    {
        TextValue = Left(TextValue, 512);
    }
    j = 1;
    TotalLength = Len(TextValue);
    TextValue1 = "";
    TextValue2 = "";
    linedivided = false;
    FontColor.R = byte(ColorR);
    FontColor.G = byte(ColorG);
    FontColor.B = byte(ColorB);
    i = 1;

    while(i <= TotalLength)
    {
        LengthTotal = Len(TextValue) - 1;
        CurText = Left(TextValue, 1);
        TextValue = Right(TextValue, LengthTotal);
        // End:0xD4
        if(CurText == "`")
        {
            CurText = "";
        }
        // End:0xF9
        if(CurText == "#")
        {
            CurText = "";
            j = 2;
            linedivided = true;
        }
        // End:0x119
        if(j == 1)
        {
            TextValue1 = TextValue1 $ CurText;

            ++i;
            continue;
        }
        TextValue2 = TextValue2 $ CurText;

        ++i;
    }
    WndName = "OnScreenMessageWnd" $ string(WndNum);
    TextBoxName = (WndName $ ".TextBox") $ string(WndNum);
    ShadowBoxName = ((WndName $ ".TextBox") $ string(WndNum)) $ "-0";
    TextBoxName2 = ((WndName $ ".TextBox") $ string(WndNum)) $ "-1";
    ShadowBoxName2 = ((WndName $ ".TextBox") $ string(WndNum)) $ "-1-0";
    SmallBoxName1 = (WndName $ ".TextBoxsm") $ string(WndNum);
    SmallBoxName2 = ((WndName $ ".TextBoxsm") $ string(WndNum)) $ "-1";
    currentwnd1 = WndName;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(TextBoxName, FontColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(TextBoxName2, FontColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(SmallBoxName1, FontColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(SmallBoxName2, FontColor);
    // End:0x36D
    if(FontType == 0)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(currentwnd1);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(ShadowBoxName, TextValue1);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(TextBoxName, TextValue1);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(ShadowBoxName2, TextValue2);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(TextBoxName2, TextValue2);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(SmallBoxName1, "");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(SmallBoxName2, "");        
    }
    else
    {
        // End:0x416
        if(FontType == 1)
        {
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(currentwnd1);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(ShadowBoxName, "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(TextBoxName, "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(ShadowBoxName2, "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(TextBoxName2, "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(SmallBoxName1, TextValue1);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText(SmallBoxName2, TextValue2);
        }
    }
    // End:0x4A6
    if(WndNum == 2)
    {
        // End:0x42D
        if(moveval != 0)
        {
        }
        MovedWndName = WndName;
        moveval2 = (TextOffsetTotal1 / 2) * 29;
        // End:0x47E
        if(BackgroundType == 1)
        {
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow(MovedWndName $ ".texturetype1");            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow(MovedWndName $ ".texturetype1");
        }        
    }
    else
    {
        // End:0x4CB
        if(WndNum == 5)
        {
            // End:0x4BD
            if(moveval != 0)
            {
            }
            MovedWndName = WndName;            
        }
        else
        {
            // End:0x4F0
            if(WndNum == 7)
            {
                // End:0x4E2
                if(moveval != 0)
                {
                }
                MovedWndName = WndName;                
            }
            else
            {
                moveval = 0;
            }
        }
    }
    onshowstat1 = true;
    onshowstat2 = false;
    globalDuration = Duration;
    m_DurationByWindow[WndNum] = Duration;
    droprate = 255;
    switch(Animation)
    {
        // End:0x528
        case 0:
            droprate = 255;
            // End:0x56A
            break;
        // End:0x537
        case 1:
            droprate = 25;
            // End:0x56A
            break;
        // End:0x547
        case 11:
            droprate = 15;
            // End:0x56A
            break;
        // End:0x557
        case 12:
            droprate = 25;
            // End:0x56A
            break;
        // End:0x567
        case 13:
            droprate = 35;
            // End:0x56A
            break;
        // End:0xFFFF
        default:
            droprate = 255;
            break;
    }
    m_DropRateByWindow[WndNum] = droprate;
    m_AlphaInByWindow[WndNum] = 0;
    m_AlphaOutByWindow[WndNum] = 255;
    m_FadeOutByWindow[WndNum] = 0;
    if(bRefresh)
    {
        m_FadeInByWindow[WndNum] = 0;
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, 255);
        if(m_DurationByWindow[WndNum] > 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("OnScreenMessageWnd1", ONSCREEN_MESSAGE_TIMER_BASE + WndNum, m_DurationByWindow[WndNum]);
        }
    }
    else
    {
        m_FadeInByWindow[WndNum] = 1;
    }
    return;
}

function FadeInWindow(int WndNum)
{
    local string WndName;

    if((WndNum < 1) || (WndNum > ONSCREEN_MESSAGE_MAX_WND))
    {
        return;
    }

    WndName = "OnScreenMessageWnd" $ string(WndNum);
    m_AlphaInByWindow[WndNum] = m_AlphaInByWindow[WndNum] + m_DropRateByWindow[WndNum];
    if(m_AlphaInByWindow[WndNum] < 255)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, m_AlphaInByWindow[WndNum]);
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, 255);
        m_AlphaInByWindow[WndNum] = 0;
        m_FadeInByWindow[WndNum] = 0;
        if(m_DurationByWindow[WndNum] > 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("OnScreenMessageWnd1", ONSCREEN_MESSAGE_TIMER_BASE + WndNum, m_DurationByWindow[WndNum]);
        }
    }
    return;
}

function FadeOutWindow(int WndNum)
{
    local string WndName;

    if((WndNum < 1) || (WndNum > ONSCREEN_MESSAGE_MAX_WND))
    {
        return;
    }

    WndName = "OnScreenMessageWnd" $ string(WndNum);
    m_AlphaOutByWindow[WndNum] = m_AlphaOutByWindow[WndNum] - m_DropRateByWindow[WndNum];
    if(m_AlphaOutByWindow[WndNum] > 1)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, m_AlphaOutByWindow[WndNum]);
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, 0);
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow(WndName);
        m_AlphaOutByWindow[WndNum] = 255;
        m_FadeOutByWindow[WndNum] = 0;
        m_DurationByWindow[WndNum] = 0;
        if((WndNum == 2) || (WndNum == 5) || (WndNum == 7))
        {
            moveval2 = 0;
            moveval = 0;
        }
    }
    return;
}

function FadeIn(string WndName)
{
    globalAlphavalue1 = globalAlphavalue1 + droprate;
    // End:0x3A
    if(globalAlphavalue1 < 255)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, globalAlphavalue1);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, 255);
        globalAlphavalue1 = 0;
        onshowstat1 = false;
        m_TimerCount++;
        Class'NWindow.UIAPI_WINDOW'.static.SetUITimer("OnScreenMessageWnd1", m_TimerCount, globalDuration);
    }
    return;
}

function FadeOut(string WndName)
{
    globalAlphavalue2 = globalAlphavalue2 - droprate;
    // End:0x39
    if(globalAlphavalue2 > 1)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, globalAlphavalue2);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha(WndName, 0);
        globalAlphavalue2 = 255;
        onshowstat2 = false;
        ResetAllMessage();
        moveval2 = 0;
        moveval = 0;
    }
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    local int MsgType, MsgNo, WindowType, FontSize, FontType, MsgColor,
	    msgcolorR, msgcolorG, msgcolorB, shadowtype, BackgroundType,
	    LifeTime, AnimationType, SystemMsgIndex;

    local string MsgText;

    // End:0x23D
    if(a_EventID == 140)
    {
        ParseInt(a_Param, "MsgType", MsgType);
        ParseInt(a_Param, "MsgNo", MsgNo);
        ParseInt(a_Param, "WindowType", WindowType);
        ParseInt(a_Param, "FontSize", FontSize);
        ParseInt(a_Param, "FontType", FontType);
        ParseInt(a_Param, "MsgColor", MsgColor);
        // End:0xCE
        if(!ParseInt(a_Param, "MsgColorR", msgcolorR))
        {
            msgcolorR = 255;
        }
        // End:0xF6
        if(!ParseInt(a_Param, "MsgColorG", msgcolorG))
        {
            msgcolorG = 255;
        }
        // End:0x11E
        if(!ParseInt(a_Param, "MsgColorB", msgcolorB))
        {
            msgcolorB = 255;
        }
        ParseInt(a_Param, "ShadowType", shadowtype);
        ParseInt(a_Param, "BackgroundType", BackgroundType);
        ParseInt(a_Param, "LifeTime", LifeTime);
        ParseInt(a_Param, "AnimationType", AnimationType);
        ParseString(a_Param, "Msg", MsgText);
        ResetAllMessage();
        switch(MsgType)
        {
            // End:0x1EF
            case 1:
                ShowMsg(WindowType, MsgText, LifeTime, AnimationType, FontType, BackgroundType, msgcolorR, msgcolorG, msgcolorB);
                // End:0x23D
                break;
            // End:0x23A
            case 0:
                MsgText = GetSystemMessage(MsgNo);
                ShowMsg(WindowType, MsgText, LifeTime, AnimationType, FontType, BackgroundType, msgcolorR, msgcolorG, msgcolorB);
                // End:0x23D
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        // End:0x2A8
        if(a_EventID == 580)
        {
            ParseInt(a_Param, "Index", SystemMsgIndex);
            ValidateSystemMsg(SystemMsgIndex, a_Param);
        }
        return;
    }
}

function ValidateSystemMsg(int Index, string Param)
{
    local SystemMsgData SystemMsgCurrent;
    local int WindowType, FontType, BackgroundType, LifeTime, AnimationType;

    local string MsgText, StringTxt1, StringTxt2;
    local Color TextColor;

    GetSystemMsgInfo(Index, SystemMsgCurrent);
    // End:0x1CE
    if(SystemMsgCurrent.WindowType != 0)
    {
        WindowType = SystemMsgCurrent.WindowType;
        MsgText = SystemMsgCurrent.OnScrMsg;
        ParseString(Param, "Param1", StringTxt1);
        ParseString(Param, "Param2", StringTxt2);
        MsgText = MakeFullSystemMsg(MsgText, StringTxt1, StringTxt2);
        LifeTime = SystemMsgCurrent.LifeTime * 1000;
        AnimationType = SystemMsgCurrent.AnimationType;
        FontType = SystemMsgCurrent.FontType;
        BackgroundType = SystemMsgCurrent.BackgroundType;
        TextColor = SystemMsgCurrent.Color;
        // End:0x11C
        if(((int(TextColor.R) == 0) && int(TextColor.G) == 0) && int(TextColor.B) == 0)
        {
            TextColor.R = byte(255);
            TextColor.G = byte(255);
            TextColor.B = byte(255);            
        }
        else
        {
            // End:0x186
            if(((int(TextColor.R) == 176) && int(TextColor.G) == 155) && int(TextColor.B) == 121)
            {
                TextColor.R = byte(255);
                TextColor.G = byte(255);
                TextColor.B = byte(255);
            }
        }
        ShowMsg(WindowType, MsgText, LifeTime, AnimationType, FontType, BackgroundType, int(TextColor.R), int(TextColor.G), int(TextColor.B));
    }
    return;
}
