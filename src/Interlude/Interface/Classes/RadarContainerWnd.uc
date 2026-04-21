class RadarContainerWnd extends UICommonAPI;

function OnLoad()
{
    RegisterEvent(1730);
    RegisterEvent(1740);
    RegisterEvent(1750);
    RegisterEvent(11223344);
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x1D
        case 1730:
            HandleRadarAddTarget(a_Param);
            // End:0x58
            break;
        // End:0x33
        case 1740:
            HandleRadarDeleteTarget(a_Param);
            // End:0x58
            break;
        // End:0x44
        case 1750:
            HandleRadarDeleteAllTarget();
            // End:0x58
            break;
        // End:0x55
        case 11223344:
            HandleRadarShowHide();
            // End:0x58
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleRadarShowHide()
{
    local int idx;

    idx = GetOptionInt("Custom", "Minimap");
    switch(idx)
    {
        // End:0x53
        case 0:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("RadarContainerWnd.Radar");
            // End:0xE5
            break;
        // End:0x82
        case 1:
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("RadarContainerWnd.Radar");
            // End:0xE5
            break;
        // End:0xB2
        case 2:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("RadarContainerWnd.Radar");
            // End:0xE5
            break;
        // End:0xE2
        case 3:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("RadarContainerWnd.Radar");
            // End:0xE5
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleRadarAddTarget(string a_Param)
{
    local int X, Y, Z;

    // End:0x7E
    if(((ParseInt(a_Param, "X", X)) && ParseInt(a_Param, "Y", Y)) && ParseInt(a_Param, "Z", Z))
    {
        Class'NWindow.UIAPI_RADAR'.static.AddTarget("RadarContainterWnd.Radar", X, Y, Z);
    }
    return;
}

function HandleRadarDeleteTarget(string a_Param)
{
    local int X, Y, Z;

    // End:0x7E
    if(((ParseInt(a_Param, "X", X)) && ParseInt(a_Param, "Y", Y)) && ParseInt(a_Param, "Z", Z))
    {
        Class'NWindow.UIAPI_RADAR'.static.DeleteTarget("RadarContainterWnd.Radar", X, Y, Z);
    }
    return;
}

function HandleRadarDeleteAllTarget()
{
    Class'NWindow.UIAPI_RADAR'.static.DeleteAllTarget("RadarContainterWnd.Radar");
    return;
}

function OnClickButton(string a_strID)
{
    switch(a_strID)
    {
        // End:0x68
        case "RadarBtn":
            // End:0x4C
            if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("RadarWnd"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.HideWindow("RadarWnd");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("RadarWnd");
            }
            // End:0x6B
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}
