class AutoBuffWndStart extends UICommonAPI;

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x20
        case "btnAutoBuff":
            ToggleOpenAutoBuffWnd();
            // End:0x23
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function ToggleOpenAutoBuffWnd()
{
    // End:0x34
    if(IsShowWindow("AutoBuffWnd"))
    {
        HideWindow("AutoBuffWnd");
        PlayConsoleSound(IFST_WINDOW_CLOSE);        
    }
    else
    {
        ShowWindowWithFocus("AutoBuffWnd");
        PlayConsoleSound(IFST_WINDOW_OPEN);
    }
    return;
}
