class ReportWnd extends UICommonAPI;

var WindowHandle Me;
var int int_1;
var int int_2;
var int int_3;
var TextBoxHandle text_1;
var TextBoxHandle text_2;
var TextBoxHandle text_3;
var TextBoxHandle text_4;
var ButtonHandle button_1;
var TextureHandle texture_1;
var InventoryWnd InventoryWnd;
var int Sec;
var int int_4;
var int Hrs;
var int Day;
var string uMin;
var string uHrs;
var string uDay;
var string uAdena;

function function1()
{
    InventoryWnd = InventoryWnd(GetScript("InventoryWnd"));
    Me = GetHandle("ReportWnd");
    button_1 = ButtonHandle(GetHandle("ReportWnd.BtnExecute"));
    text_1 = TextBoxHandle(GetHandle("ReportWnd.ExpValue"));
    text_2 = TextBoxHandle(GetHandle("ReportWnd.AdenaValue"));
    text_3 = TextBoxHandle(GetHandle("ReportWnd.Title"));
    text_4 = TextBoxHandle(GetHandle("ReportWnd.TitleExecute"));
    texture_1 = TextureHandle(GetHandle("ReportWnd.TexExecute"));
    return;
}

function OnLoad()
{
    // End:0x3F
    if(UnknownFunction242(GetOptionBool("Unload", "ReportWnd"), true))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ReportWnd");
        return;
    }
    RegisterEvent(2930);
    RegisterEvent(2940);
    RegisterEvent(580);
    RegisterEvent(3030);
    function1();
    function2();
    return;
}

function OnShow()
{
    Me.SetFocus();
    return;
}

function OnEnterState(name a_PreStateName)
{
    Reset();
    HandleOnlineTime();
    return;
}

function OnExitState(name a_PreStateName)
{
    Reset();
    Me.KillTimer(0);
    return;
}

function OnEvent(int int_5, string string_1)
{
    switch(int_5)
    {
        // End:0x1D
        case 580:
            function3(string_1);
            // End:0x69
            break;
        // End:0x25
        case 2930:
        // End:0x55
        case 2940:
            int_1 = int_5;
            function4(int_5);
            Me.ShowWindow();
            // End:0x69
            break;
        // End:0x66
        case 3030:
            function2();
            // End:0x69
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function Reset()
{
    int_2 = 0;
    int_3 = 0;
    text_1.SetText(UnknownFunction112(MakeCostString(string(int_2)), " Exp"));
    text_2.SetText(UnknownFunction112(UnknownFunction112(MakeCostString(string(int_3)), " "), uAdena));
    Sec = 0;
    int_4 = 0;
    Hrs = 0;
    Day = 0;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ReportWnd.TimeValue", UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("", string(Day)), " "), uDay), " "), string(Hrs)), " "), uHrs), " "), string(int_4)), " "), uMin));
    return;
}

function function4(int int_5)
{
    // End:0x69
    if(UnknownFunction154(int_5, 2930))
    {
        text_3.SetText("Restart");
        text_4.SetText("Restart");
        texture_1.SetTexture("Was.Symbol_Restart");        
    }
    else
    {
        // End:0xD0
        if(UnknownFunction154(int_5, 2940))
        {
            text_3.SetText("Exit Game");
            text_4.SetText("Exit Game");
            texture_1.SetTexture("Was.Symbol_Exit");
        }
    }
    return;
}

function function6()
{
    // End:0x1C
    if(UnknownFunction154(int_1, 2930))
    {
        ExecRestart();        
    }
    else
    {
        // End:0x35
        if(UnknownFunction154(int_1, 2940))
        {
            ExecQuit();
        }
    }
    return;
}

function OnClickButton(string Name)
{
    switch(Name)
    {
        // End:0x14
        case "BtnClose":
        // End:0x34
        case "BtnCancel":
            Me.HideWindow();
            // End:0x64
            break;
        // End:0x4C
        case "BtnExecute":
            function6();
            // End:0x64
            break;
        // End:0x61
        case "BtnInit":
            Reset();
            // End:0x64
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function function3(string string_1)
{
    local int int_6, int_7;

    ParseInt(string_1, "Index", int_6);
    switch(int_6)
    {
        // End:0x23
        case 45:
        // End:0x7D
        case 95:
            ParseInt(string_1, "Param1", int_7);
            int_2 = int_2 + int_7;
            text_1.SetText(UnknownFunction112(MakeCostString(string(int_2)), " Exp"));
            // End:0x14E
            break;
        // End:0x82
        case 28:
        // End:0xE4
        case 52:
            ParseInt(string_1, "Param1", int_7);
            int_3 = int_3 + int_7;
            text_2.SetText(UnknownFunction112(UnknownFunction112(MakeCostString(string(int_3)), " "), uAdena));
            // End:0x14E
            break;
        // End:0xE9
        case 29:
        // End:0xEE
        case 30:
        // End:0xF3
        case 53:
        // End:0x122
        case 54:
            // End:0x11F
            if(InventoryWnd.bool_1)
            {
                Me.SetTimer(1, 1000);
            }
            // End:0x14E
            break;
        // End:0x14B
        case 98:
            // End:0x148
            if(InventoryWnd.bool_1)
            {
                InventoryWnd.function47();
            }
            // End:0x14E
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnTimer(int TimerID)
{
    Me.KillTimer(TimerID);
    switch(TimerID)
    {
        // End:0x28
        case 0:
            HandleOnlineTime();
            // End:0x41
            break;
        // End:0x3E
        case 1:
            InventoryWnd.function46();
            // End:0x41
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function function2()
{
    uMin = "Min.";
    uHrs = "Hr.";
    uDay = "Day.";
    uAdena = "Adena";
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ReportWnd.TitleCancel", "Cancel");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ReportWnd.HeadPlayReport", "Play Report");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ReportWnd.ExpHead", "EXP Acquired");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ReportWnd.AdenaHead", "Adena Acquired");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ReportWnd.TitleInit", "Reset");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ReportWnd.TimeHead", "Online Time");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ReportWnd.TimeValue", UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("", string(Day)), " "), uDay), " "), string(Hrs)), " "), uHrs), " "), string(int_4)), " "), uMin));
    text_2.SetText(UnknownFunction112(UnknownFunction112(MakeCostString(string(int_3)), " "), uAdena));
    return;
}

function HandleOnlineTime()
{
    UnknownFunction165(Sec);
    // End:0x2D
    if(UnknownFunction154(Sec, 60))
    {
        Sec = 0;
        UnknownFunction165(int_4);
    }
    // End:0x4F
    if(UnknownFunction154(int_4, 60))
    {
        int_4 = 0;
        UnknownFunction165(Hrs);
    }
    // End:0x71
    if(UnknownFunction154(Hrs, 24))
    {
        Hrs = 0;
        UnknownFunction165(Day);
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("ReportWnd.TimeValue", UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("", string(Day)), " "), uDay), " "), string(Hrs)), " "), uHrs), " "), string(int_4)), " "), uMin));
    Me.SetTimer(0, 1000);
    return;
}
