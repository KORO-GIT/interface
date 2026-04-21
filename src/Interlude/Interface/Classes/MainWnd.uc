class MainWnd extends UIScript;

var ClanWnd ClanWndScript;

function OnLoad()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 433);
    ClanWndScript = ClanWnd(GetScript("ClanWnd"));
    return;
}

function OnHide()
{
    return;
}

function OnMinimize()
{
    local int Index;

    Index = Class'NWindow.UIAPI_TABCTRL'.static.GetTopIndex("MainWnd.MainTabCtrl");
    // End:0x76
    if(Index == 0)
    {
        Class'NWindow.UIAPI_WINDOW'.static.Iconize("MainWnd", "L2UI_CH3.TABBUTTON.MainWndTabIcon1", 194);        
    }
    else
    {
        // End:0xC2
        if(Index == 1)
        {
            Class'NWindow.UIAPI_WINDOW'.static.Iconize("MainWnd", "L2UI_CH3.TABBUTTON.MainWndTabIcon2", 196);            
        }
        else
        {
            // End:0x10F
            if(Index == 2)
            {
                Class'NWindow.UIAPI_WINDOW'.static.Iconize("MainWnd", "L2UI_CH3.TABBUTTON.MainWndTabIcon3", 197);                
            }
            else
            {
                // End:0x15F
                if(Index == 3)
                {
                    Class'NWindow.UIAPI_WINDOW'.static.Iconize("MainWnd", "L2UI_CH3.TABBUTTON.MainWndTabIcon4", 895);                    
                }
                else
                {
                    // End:0x1A9
                    if(Index == 4)
                    {
                        Class'NWindow.UIAPI_WINDOW'.static.Iconize("MainWnd", "L2UI_CH3.TABBUTTON.MainWndTabIcon5", 198);
                    }
                }
            }
        }
    }
    ClanWndScript.ResetOpeningVariables();
    return;
}

function OnClickButton(string strID)
{
    // End:0x65
    if(strID == "MainTabCtrl0")
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 433);
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
        ClanWndScript.ResetOpeningVariables();        
    }
    else
    {
        // End:0xC7
        if(strID == "MainTabCtrl1")
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 119);
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
            ClanWndScript.ResetOpeningVariables();            
        }
        else
        {
            // End:0x129
            if(strID == "MainTabCtrl2")
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 127);
                Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
                ClanWndScript.ResetOpeningVariables();                
            }
            else
            {
                // End:0x18E
                if(strID == "MainTabCtrl3")
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 439);
                    ClanWndScript.getmyClanInfo();
                    ClanWndScript.NoblessMenuValidate();
                    ClanWndScript.ResetOpeningVariables();                    
                }
                else
                {
                    // End:0x1ED
                    if(strID == "MainTabCtrl4")
                    {
                        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
                        Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 118);
                        ClanWndScript.ResetOpeningVariables();
                    }
                }
            }
        }
    }
    return;
}
