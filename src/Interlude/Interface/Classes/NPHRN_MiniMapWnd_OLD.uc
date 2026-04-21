class NPHRN_MiniMapWnd_OLD extends UICommonAPI;

var WindowHandle MinimapWnd;
var WindowHandle MinimapHandlerWnd;
var int PartyMemberCount;
var int CurrentPartyMemberIndex;
var ButtonHandle BtnFixLoc;
var ButtonHandle BtnResize;
var bool bFollowPlayer;
var bool Large;

function OnLoad()
{
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
    MinimapWnd = GetHandle("NPHRN_MiniMapWnd_OLD");
    MinimapHandlerWnd = GetHandle("NPHRN_MiniMapHandler_OLD");
    BtnFixLoc = ButtonHandle(GetHandle("NPHRN_MiniMapWnd_OLD.Curtain.BtnFixLoc"));
    BtnResize = ButtonHandle(GetHandle("NPHRN_MiniMapWnd_OLD.Curtain.BtnResize"));
    BtnResize.SetTooltipCustomType(MakeTooltipSimpleText("Resize"));
    bFollowPlayer = true;
    UpdateTransparencyState();
    return;
}

function OnShow()
{
    AdjustMapToPlayerPosition(true);
    MinimapWnd.SetTimer(1, 1000);
    UpdateZoneName();
    UpdateTransparencyState();
    return;
}

function OnTimer(int Id)
{
    MinimapWnd.KillTimer(Id);
    UpdateZoneName();
    return;
}

function OnTick()
{
    // End:0x10
    if(bFollowPlayer)
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
            ToggleFollowPlayer();
            // End:0x9D
            break;
        // End:0x34
        case "BtnTrans":
            HandleRadarButtonClick();
            // End:0x9D
            break;
        // End:0x4E
        case "BtnTargetLoc":
            ShowQuestLocation();
            // End:0x9D
            break;
        // End:0x67
        case "BtnPartyLoc":
            ShowNextPartyMemberLocation();
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
            MinimapHandlerWnd.SetAnchor("", "TopRight", "TopRight", -1, 1);
            MinimapHandlerWnd.ClearAnchor();
            // End:0x18A
            break;
        // End:0x79
        case 110:
            ParseInt(param, "ZoneCode", idx);
            UpdateZoneTexture(idx);
            // End:0x18A
            break;
        // End:0x8A
        case 2420:
            UpdateZoneName();
            // End:0x18A
            break;
        // End:0xA0
        case 520:
            HandlePartyMemberCount(param);
            // End:0x18A
            break;
        // End:0xB6
        case 1790:
            HandleAddTarget(param);
            // End:0x18A
            break;
        // End:0xCC
        case 1800:
            HandleDeleteTarget(param);
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

function UpdateZoneTexture(int idx)
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
    local Vector PlayerLocation;

    PlayerLocation = GetPlayerPosition();
    Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MiniMapWnd_OLD.Minimap", PlayerLocation, a_ZoomToTownMap);
    return;
}

function UpdateZoneName()
{
    local string ZoneName;

    ZoneName = GetCurrentZoneName();
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("NPHRN_MiniMapWnd_OLD.HeadZone", ZoneName);
    return;
}

function HandlePartyMemberCount(string param)
{
    ParseInt(param, "PartyMemberCount", PartyMemberCount);
    return;
}

function HandleAddTarget(string param)
{
    local Vector TargetLocation;

    // End:0xBD
    if(((ParseFloat(param, "X", TargetLocation.X) && ParseFloat(param, "Y", TargetLocation.Y)) && ParseFloat(param, "Z", TargetLocation.Z)))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AddTarget("NPHRN_MiniMapWnd_OLD.Minimap", TargetLocation);
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MiniMapWnd_OLD.Minimap", TargetLocation, false, false);
    }
    return;
}

function HandleDeleteTarget(string param)
{
    local Vector TargetLocation;
    local int LocX, LocY, LocZ;

    // End:0xB0
    if(((ParseInt(param, "X", LocX) && ParseInt(param, "Y", LocY)) && ParseInt(param, "Z", LocZ)))
    {
        TargetLocation.X = float(LocX);
        TargetLocation.Y = float(LocY);
        TargetLocation.Z = float(LocZ);
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.DeleteTarget("NPHRN_MiniMapWnd_OLD.Minimap", TargetLocation);
    }
    return;
}

function ShowQuestLocation()
{
    local Vector QuestLocation;

    // End:0x46
    if(GetQuestLocation(QuestLocation))
    {
        DisableFollowPlayer();
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MiniMapWnd_OLD.Minimap", QuestLocation);
    }
    return;
}

function ShowNextPartyMemberLocation()
{
    local Vector PartyMemberLocation;

    PartyMemberCount = GetPartyMemberCount();
    // End:0x1D
    if((0 == PartyMemberCount))
    {
        return;
    }
    DisableFollowPlayer();
    CurrentPartyMemberIndex = int(float((CurrentPartyMemberIndex + 1)) % float(PartyMemberCount));
    // End:0x86
    if(GetPartyMemberLocation(CurrentPartyMemberIndex, PartyMemberLocation))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MiniMapWnd_OLD.Minimap", PartyMemberLocation, false);
    }
    return;
}

function HandleRadarButtonClick()
{
    SetOptionBool("Custom", "RadarTransparency", !GetOptionBool("Custom", "RadarTransparency"));
    UpdateTransparencyState();
    return;
}

function UpdateTransparencyState()
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

function ToggleFollowPlayer()
{
    // End:0x12
    if(bFollowPlayer)
    {
        DisableFollowPlayer();
    }
    else
    {
        EnableFollowPlayer();
    }
    return;
}

function EnableFollowPlayer()
{
    BtnFixLoc.SetTexture("Was.NPHRN_Radar_Fix_Enabled", "Was.NPHRN_Radar_Fix_Down", "Was.NPHRN_Radar_Fix_Over");
    bFollowPlayer = true;
    return;
}

function DisableFollowPlayer()
{
    BtnFixLoc.SetTexture("Was.NPHRN_Radar_Fix", "Was.NPHRN_Radar_Fix_Down", "Was.NPHRN_Radar_Fix_Over");
    bFollowPlayer = false;
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
        MinimapWnd.SetWindowSize(209, 207);
        Tex.SetWindowSize(209, 207);
        Tex.SetTexture("Was.NPHRN_Radar_CaseSolid");
        Circle.SetTexture("Was.NPHRN_Radar_Circle");
        CurtainBg.SetTexture("Was.NPHRN_Radar_Curtain");
        CurtainBg.SetWindowSize(40, 175);
        TexZone.SetWindowSize(202, 24);
        MinimapHandlerWnd.SetWindowSize(202, 24);
        Curtain.SetWindowSize(40, 175);
        Minimap.SetWindowSize(197, 175);
        MinimapHandlerWnd.Move(97, 0);
    }
    else
    {
        MinimapWnd.SetWindowSize(312, 309);
        Tex.SetWindowSize(312, 309);
        Tex.SetTexture("Was.NPHRN_Radar_CaseSolid_Big");
        Circle.SetTexture("Was.Null");
        CurtainBg.SetTexture("Was.NPHRN_Radar_Curtain_Big");
        CurtainBg.SetWindowSize(40, 277);
        TexZone.SetWindowSize(300, 24);
        MinimapHandlerWnd.SetWindowSize(300, 24);
        Curtain.SetWindowSize(40, 277);
        Minimap.SetWindowSize(298, 276);
        MinimapHandlerWnd.Move(-97, 0);
    }
    return;
}
