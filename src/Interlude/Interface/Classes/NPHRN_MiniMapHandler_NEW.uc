class NPHRN_MiniMapHandler_NEW extends UICommonAPI;

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
    if(IsShowWindow("NPHRN_MinimapWnd_NEW.Curtain"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MinimapWnd_NEW.Curtain");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("NPHRN_MinimapWnd_NEW.Curtain");
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("NPHRN_MinimapWnd_NEW.Curtain");
    }
    return;
}
