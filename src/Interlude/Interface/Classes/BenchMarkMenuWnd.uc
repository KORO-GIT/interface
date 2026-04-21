class BenchMarkMenuWnd extends UIScript;

function OnLoad()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("BenchMarkMenuWnd.BenchMarkFunctionWnd");
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1C
        case "btnPlay":
            BeginPlay();
            // End:0x65
            break;
        // End:0x36
        case "btnBenchMark":
            BeginBenchMark();
            // End:0x65
            break;
        // End:0x4D
        case "btnOption":
            ShowOptionWnd();
            // End:0x65
            break;
        // End:0x62
        case "btnExit":
            ExecQuit();
            // End:0x65
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function ShowOptionWnd()
{
    // End:0x42
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("OptionWnd"))
    {
        PlayConsoleSound(IFST_WINDOW_CLOSE);
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("OptionWnd");        
    }
    else
    {
        PlayConsoleSound(IFST_WINDOW_OPEN);
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("OptionWnd");
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("OptionWnd");
    }
    return;
}
