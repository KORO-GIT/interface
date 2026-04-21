class NPHRN_MiniMapHandler_OLD extends UICommonAPI;

function OnClickButton(string param)
{
    switch(param)
    {
        // End:0x1B
        case "BtnOpt":
            ToggleOpenCurtain();
            // End:0x1E
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function ToggleOpenCurtain()
{
    // End:0x57
    if(IsShowWindow("NPHRN_MiniMapWnd_OLD.Curtain"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapWnd_OLD.Curtain");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("NPHRN_MiniMapWnd_OLD.Curtain");
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("NPHRN_MiniMapWnd_OLD.Curtain");
    }
    return;
}
