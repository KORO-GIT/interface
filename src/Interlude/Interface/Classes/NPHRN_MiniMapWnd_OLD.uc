class NPHRN_MiniMapWnd_OLD extends UICommonAPI;

var WindowHandle unkWndHandle1;
var WindowHandle unkWndHandle2;
var int unkInt2;
var int unkInt1;
var ButtonHandle ButtonHandle;
var ButtonHandle BtnResize;
var bool unkBool;
var bool Large;

function OnLoad()
{
    BtnResize.SetTooltipCustomType(MakeTooltipSimpleText("Resize"));
    RegisterEvent(2900);
    RegisterEvent(110);
    RegisterEvent(2420);
    RegisterEvent(520);
    RegisterEvent(1790);
    RegisterEvent(1800);
    RegisterEvent(1810);
    RegisterEvent(1820);
    RegisterEvent(1830);
    RegisterEvent(11223344);
    unkWndHandle1 = GetHandle("NPHRN_MiniMapWnd_OLD");
    unkWndHandle2 = GetHandle("NPHRN_MiniMapHandler_OLD");
    ButtonHandle = ButtonHandle(GetHandle("NPHRN_MiniMapWnd_OLD.Curtain.BtnFixLoc"));
    BtnResize = ButtonHandle(GetHandle("NPHRN_MiniMapWnd_OLD.Curtain.BtnResize"));
    unkBool = true;
    unkFunc2();
    return;
}

function OnShow()
{
    AdjustMapToPlayerPosition(true);
    unkWndHandle1.SetTimer(1, 1000);
    unkFunc1();
    unkFunc2();
    return;
}

function OnTimer(int Id)
{
    unkWndHandle1.KillTimer(Id);
    unkFunc1();
    return;
}

function OnTick()
{
    // End:0x10
    if(unkBool)
    {
        AdjustMapToPlayerPosition(true);
    }
    return;
}

function OnClickButton(string param)
{
    switch(param)
    {
        // End:0x1E
        case "BtnFixLoc":
            unkFunc3();
            // End:0x9D
            break;
        // End:0x34
        case "BtnTrans":
            HandleRadarButtonClick();
            // End:0x9D
            break;
        // End:0x4E
        case "BtnTargetLoc":
            unkFunc4();
            // End:0x9D
            break;
        // End:0x67
        case "BtnPartyLoc":
            unkFunc5();
            // End:0x9D
            break;
        // End:0x9A
        case "BtnResize":
            // End:0x89
            if(Large)
            {
                Large = false;                
            }
            else
            {
                Large = true;
            }
            ResizeWnd();
            // End:0x9D
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnEvent(int Index, string param)
{
    local int idx;

    switch(Index)
    {
        // End:0x4C
        case 2900:
            unkWndHandle2.SetAnchor("", "TopRight", "TopRight", -1, 1);
            unkWndHandle2.ClearAnchor();
            // End:0x18A
            break;
        // End:0x79
        case 110:
            ParseInt(param, "ZoneCode", idx);
            unkFunc6(idx);
            // End:0x18A
            break;
        // End:0x8A
        case 2420:
            unkFunc1();
            // End:0x18A
            break;
        // End:0xA0
        case 520:
            unkFunc7(param);
            // End:0x18A
            break;
        // End:0xB6
        case 1790:
            unkFunc8(param);
            // End:0x18A
            break;
        // End:0xCC
        case 1800:
            unkFunc9(param);
            // End:0x18A
            break;
        // End:0x104
        case 1810:
            Class'NWindow.UIAPI_MINIMAPCTRL'.static.DeleteAllTarget("NPHRN_MiniMapWnd_OLD.Minimap");
            // End:0x18A
            break;
        // End:0x13D
        case 1820:
            Class'NWindow.UIAPI_MINIMAPCTRL'.static.SetShowQuest("NPHRN_MiniMapWnd_OLD.Minimap", true);
            // End:0x18A
            break;
        // End:0x176
        case 1830:
            Class'NWindow.UIAPI_MINIMAPCTRL'.static.SetShowQuest("NPHRN_MiniMapWnd_OLD.Minimap", false);
            // End:0x18A
            break;
        // End:0x187
        case 11223344:
            HandleRadarShowHide();
            // End:0x18A
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
        // End:0x79
        case 0:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapWnd_OLD");
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapHandler_OLD");
            // End:0x17D
            break;
        // End:0xCE
        case 1:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapWnd_OLD");
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapHandler_OLD");
            // End:0x17D
            break;
        // End:0x124
        case 2:
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("NPHRN_MiniMapWnd_OLD");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("NPHRN_MiniMapHandler_OLD");
            // End:0x17D
            break;
        // End:0x17A
        case 3:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapWnd_OLD");
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapHandler_OLD");
            // End:0x17D
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function unkFunc6(int idx)
{
    switch(idx)
    {
        // End:0x53
        case 15:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("NPHRN_MiniMapWnd_OLD.TexZone", "Was.NPHRN_Radar_ZGray");
            // End:0x21F
            break;
        // End:0x9F
        case 12:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("NPHRN_MiniMapWnd_OLD.TexZone", "Was.NPHRN_Radar_ZBlue");
            // End:0x21F
            break;
        // End:0xED
        case 11:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("NPHRN_MiniMapWnd_OLD.TexZone", "Was.NPHRN_Radar_ZOrange");
            // End:0x21F
            break;
        // End:0x138
        case 9:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("NPHRN_MiniMapWnd_OLD.TexZone", "Was.NPHRN_Radar_ZRed");
            // End:0x21F
            break;
        // End:0x183
        case 8:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("NPHRN_MiniMapWnd_OLD.TexZone", "Was.NPHRN_Radar_ZRed");
            // End:0x21F
            break;
        // End:0x1CF
        case 13:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("NPHRN_MiniMapWnd_OLD.TexZone", "Was.NPHRN_Radar_ZGray");
            // End:0x21F
            break;
        // End:0x21C
        case 14:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("NPHRN_MiniMapWnd_OLD.TexZone", "Was.NPHRN_Radar_ZGreen");
            // End:0x21F
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function AdjustMapToPlayerPosition(bool a_ZoomToTownMap)
{
    local Vector unkVar;

    unkVar = GetPlayerPosition();
    Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MiniMapWnd_OLD.Minimap", unkVar, a_ZoomToTownMap);
    return;
}

function unkFunc1()
{
    local string unkVar;

    unkVar = GetCurrentZoneName();
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("NPHRN_MiniMapWnd_OLD.HeadZone", unkVar);
    return;
}

function unkFunc7(string param)
{
    ParseInt(param, "PartyMemberCount", unkInt2);
    return;
}

function unkFunc8(string param)
{
    local Vector unkVar;

    // End:0xBD
    if(((ParseFloat(param, "X", unkVar.X) && ParseFloat(param, "Y", unkVar.Y)) && ParseFloat(param, "Z", unkVar.Z)))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AddTarget("NPHRN_MiniMapWnd_OLD.Minimap", unkVar);
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MiniMapWnd_OLD.Minimap", unkVar, false, false);
    }
    return;
}

function unkFunc9(string param)
{
    local Vector unkVar;
    local int LocX, LocY, LocZ;

    // End:0xB0
    if(((ParseInt(param, "X", LocX) && ParseInt(param, "Y", LocY)) && ParseInt(param, "Z", LocZ)))
    {
        unkVar.X = float(LocX);
        unkVar.Y = float(LocY);
        unkVar.Z = float(LocZ);
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.DeleteTarget("NPHRN_MiniMapWnd_OLD.Minimap", unkVar);
    }
    return;
}

function unkFunc4()
{
    local Vector QuestLocation;

    // End:0x46
    if(GetQuestLocation(QuestLocation))
    {
        unkFunc10();
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MiniMapWnd_OLD.Minimap", QuestLocation);
    }
    return;
}

function unkFunc5()
{
    local Vector PartyMemberLocation;

    unkInt2 = GetPartyMemberCount();
    // End:0x1D
    if((0 == unkInt2))
    {
        return;
    }
    unkFunc10();
    unkInt1 = int(float((unkInt1 + 1)) % float(unkInt2));
    // End:0x86
    if(GetPartyMemberLocation(unkInt1, PartyMemberLocation))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MiniMapWnd_OLD.Minimap", PartyMemberLocation, false);
    }
    return;
}

function HandleRadarButtonClick()
{
    SetOptionBool("Custom", "RadarTransparency", !GetOptionBool("Custom", "RadarTransparency"));
    unkFunc2();
    return;
}

function unkFunc2()
{
    local ButtonHandle btnHandle;

    btnHandle = ButtonHandle(GetHandle("NPHRN_MiniMapWnd_OLD.BtnTrans"));
    // End:0x127
    if(!GetOptionBool("Custom", "RadarTransparency"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("NPHRN_MiniMapWnd_OLD.Minimap", 255, 0.5000000);
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("NPHRN_MiniMapWnd_OLD.Circle", 255, 0.5000000);
        btnHandle.SetTexture("Was.NPHRN_Radar_BtnTrans", "Was.NPHRN_Radar_BtnTrans_Down", "Was.NPHRN_Radar_BtnTrans_Over");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("NPHRN_MiniMapWnd_OLD.Minimap", 130, 0.5000000);
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("NPHRN_MiniMapWnd_OLD.Circle", 130, 0.5000000);
        btnHandle.SetTexture("Was.NPHRN_Radar_BtnSolid", "Was.NPHRN_Radar_BtnSolid_Down", "Was.NPHRN_Radar_BtnSolid_Over");
    }
    return;
}

function unkFunc3()
{
    // End:0x12
    if(unkBool)
    {
        unkFunc10();        
    }
    else
    {
        unkFunc11();
    }
    return;
}

function unkFunc11()
{
    ButtonHandle.SetTexture("Was.NPHRN_Radar_Fix_Enabled", "Was.NPHRN_Radar_Fix_Down", "Was.NPHRN_Radar_Fix_Over");
    unkBool = true;
    return;
}

function unkFunc10()
{
    ButtonHandle.SetTexture("Was.NPHRN_Radar_Fix", "Was.NPHRN_Radar_Fix_Down", "Was.NPHRN_Radar_Fix_Over");
    unkBool = false;
    return;
}

function ResizeWnd()
{
    local TextureHandle Tex, Circle, TexZone, CurtainBg;
    local WindowHandle Minimap, Curtain;

    Tex = TextureHandle(GetHandle("NPHRN_MiniMapWnd_OLD.Tex"));
    Circle = TextureHandle(GetHandle("NPHRN_MiniMapWnd_OLD.Circle"));
    TexZone = TextureHandle(GetHandle("NPHRN_MiniMapWnd_OLD.TexZone"));
    CurtainBg = TextureHandle(GetHandle("NPHRN_MiniMapWnd_OLD.Curtain.Curtain_BG"));
    Curtain = GetHandle("NPHRN_MiniMapWnd_OLD.Curtain");
    Minimap = GetHandle("NPHRN_MiniMapWnd_OLD.Minimap");
    // End:0x238
    if((!Large))
    {
        unkWndHandle1.SetWindowSize(209, 207);
        Tex.SetWindowSize(209, 207);
        Tex.SetTexture("Was.NPHRN_Radar_CaseSolid");
        Circle.SetTexture("Was.NPHRN_Radar_Circle");
        CurtainBg.SetTexture("Was.NPHRN_Radar_Curtain");
        CurtainBg.SetWindowSize(40, 175);
        TexZone.SetWindowSize(202, 24);
        unkWndHandle2.SetWindowSize(202, 24);
        Curtain.SetWindowSize(40, 175);
        Minimap.SetWindowSize(197, 175);
        unkWndHandle2.Move(97, 0);        
    }
    else
    {
        unkWndHandle1.SetWindowSize(312, 309);
        Tex.SetWindowSize(312, 309);
        Tex.SetTexture("Was.NPHRN_Radar_CaseSolid_Big");
        Circle.SetTexture("Was.Null");
        CurtainBg.SetTexture("Was.NPHRN_Radar_Curtain_Big");
        CurtainBg.SetWindowSize(40, 277);
        TexZone.SetWindowSize(300, 24);
        unkWndHandle2.SetWindowSize(300, 24);
        Curtain.SetWindowSize(40, 277);
        Minimap.SetWindowSize(298, 276);
        unkWndHandle2.Move(-97, 0);
    }
    return;
}
