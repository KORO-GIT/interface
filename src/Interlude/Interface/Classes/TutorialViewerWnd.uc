class TutorialViewerWnd extends UICommonAPI;

function OnLoad()
{
    RegisterEvent(2430);
    RegisterEvent(2440);
    return;
}

function OnEvent(int Event_ID, string param)
{
    local string HtmlString;
    local Rect Rect;
    local int HtmlHeight;

    switch(Event_ID)
    {
        // End:0x278
        case 2430:
            ParseString(param, "HtmlString", HtmlString);
            Class'NWindow.UIAPI_HTMLCTRL'.static.LoadHtmlFromString("TutorialViewerWnd.HtmlTutorialViewer", HtmlString);
            Rect = Class'NWindow.UIAPI_WINDOW'.static.GetRect("TutorialViewerWnd");
            HtmlHeight = Class'NWindow.UIAPI_HTMLCTRL'.static.GetFrameMaxHeight("TutorialViewerWnd.HtmlTutorialViewer");
            // End:0xE5
            if(HtmlHeight < 256)
            {
                HtmlHeight = 256;                
            }
            else
            {
                // End:0x107
                if(HtmlHeight > (680 - 8))
                {
                    HtmlHeight = 680 - 8;
                }
            }
            Rect.nHeight = (HtmlHeight + 32) + 8;
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("TutorialViewerWnd", Rect.nWidth, Rect.nHeight);
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("TutorialViewerWnd.texTutorialViewerBack2", Rect.nWidth, (Rect.nHeight - 32) - 9);
            Class'NWindow.UIAPI_WINDOW'.static.MoveTo("TutorialViewerWnd.texTutorialViewerBack3", Rect.nX, (Rect.nY + Rect.nHeight) - 9);
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("TutorialViewerWnd.HtmlTutorialViewer", Rect.nWidth - 15, (Rect.nHeight - 32) - 9);
            ShowWindowWithFocus("TutorialViewerWnd");
            // End:0x29F
            break;
        // End:0x29C
        case 2440:
            HideWindow("TutorialViewerWnd");
            // End:0x29F
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}
