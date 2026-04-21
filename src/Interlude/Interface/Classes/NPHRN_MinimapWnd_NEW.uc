class NPHRN_MinimapWnd_NEW extends UICommonAPI;

var WindowHandle Me;
var WindowHandle NPHRN_MiniMapHandler_NEW;
var int PartyMemberCount;
var int i_UnkInt_1;
var ButtonHandle BtnFixLoc;
var ButtonHandle BtnResize;
var bool FixedLocation;
var bool Large;
var TextureHandle Circle;
var TextureHandle TexZone;
var string Radar_Btn_;
var string ZoneName;
var int ZoneCode;

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
    Me = GetHandle("NPHRN_MinimapWnd_NEW");
    NPHRN_MiniMapHandler_NEW = GetHandle("NPHRN_MiniMapHandler_NEW");
    BtnFixLoc = ButtonHandle(GetHandle("NPHRN_MinimapWnd_NEW.BtnFixLoc"));
    BtnResize = ButtonHandle(GetHandle("NPHRN_MinimapWnd_NEW.BtnResize"));
    BtnResize.SetTooltipCustomType(MakeTooltipSimpleText("Resize"));
    FixedLocation = true;
    TexZone = TextureHandle(GetHandle("NPHRN_MinimapWnd_NEW.TexZone"));
    Circle = TextureHandle(GetHandle("NPHRN_MinimapWnd_NEW.Circle"));
    Radar_Btn_ = "Was.Radar_Btn_";
    HandleRadarTransparency();
    return;
}

function OnShow()
{
    HandleMinimap();
    AdjustMapToPlayerPosition(true);
    HandleRadarTransparency();
    return;
}

function OnTick()
{
    // End:0x10
    if(FixedLocation)
    {
        AdjustMapToPlayerPosition(true);
    }
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x4C
        case 2900:
            NPHRN_MiniMapHandler_NEW.SetAnchor("", "TopRight", "TopRight", -1, 1);
            NPHRN_MiniMapHandler_NEW.ClearAnchor();
            // End:0x1A9
            break;
        // End:0x79
        case 110:
            ParseInt(param, "ZoneCode", ZoneCode);
            HandleZoneShow(ZoneCode);
            // End:0x1A9
            break;
        // End:0xA9
        case 2420:
            ParseString(param, "ZoneName", ZoneName);
            HandleZoneShow(ZoneCode);
            // End:0x1A9
            break;
        // End:0xBF
        case 520:
            ParsePartyMemberCount(param);
            // End:0x1A9
            break;
        // End:0xD5
        case 1790:
            HandleMinimapAddTarget(param);
            // End:0x1A9
            break;
        // End:0xEB
        case 1800:
            HandleMinimapDeleteTarget(param);
            // End:0x1A9
            break;
        // End:0x123
        case 1810:
            Class'NWindow.UIAPI_MINIMAPCTRL'.static.DeleteAllTarget("NPHRN_MinimapWnd_NEW.Minimap");
            // End:0x1A9
            break;
        // End:0x15C
        case 1820:
            Class'NWindow.UIAPI_MINIMAPCTRL'.static.SetShowQuest("NPHRN_MinimapWnd_NEW.Minimap", true);
            // End:0x1A9
            break;
        // End:0x195
        case 1830:
            Class'NWindow.UIAPI_MINIMAPCTRL'.static.SetShowQuest("NPHRN_MinimapWnd_NEW.Minimap", false);
            // End:0x1A9
            break;
        // End:0x1A6
        case 11223344:
            HandleRadarShowHide();
            // End:0x1A9
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
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapWnd_NEW");
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapHandler_NEW");
            // End:0x17D
            break;
        // End:0xCE
        case 1:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapWnd_NEW");
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapHandler_NEW");
            // End:0x17D
            break;
        // End:0x124
        case 2:
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapWnd_NEW");
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MiniMapHandler_NEW");
            // End:0x17D
            break;
        // End:0x17A
        case 3:
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("NPHRN_MiniMapWnd_NEW");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("NPHRN_MiniMapHandler_NEW");
            // End:0x17D
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnClickButton(string param)
{
    switch(param)
    {
        // End:0x1E
        case "BtnFixLoc":
            HandleFixLoc();
            // End:0x9D
            break;
        // End:0x34
        case "BtnTrans":
            HandleRadarButtonClick();
            // End:0x9D
            break;
        // End:0x4E
        case "BtnTargetLoc":
            ShowTargetLocation();
            // End:0x9D
            break;
        // End:0x67
        case "BtnPartyLoc":
            ShowPartyMemberLocation();
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

function HandleZoneShow(int idx)
{
    local CustomTooltip param;
    local DrawItemInfo zoneDraw, ZoneState;
    local string Str;

    param.MinimumWidth = 144;
    param.DrawList[0] = zoneDraw;
    param.DrawList[1] = ZoneState;
    param.DrawList.Length = 2;
    zoneDraw.eType = DIT_TEXT;
    zoneDraw.nOffSetY = 6;
    zoneDraw.bLineBreak = true;
    zoneDraw.t_color.R = byte(255);
    zoneDraw.t_color.G = byte(255);
    zoneDraw.t_color.B = byte(255);
    zoneDraw.t_color.A = byte(255);
    zoneDraw.t_strText = ZoneName;
    param.DrawList[1] = zoneDraw;
    ZoneState.eType = DIT_TEXT;
    ZoneState.nOffSetY = 6;
    ZoneState.bLineBreak = true;
    switch(idx)
    {
        // End:0x19C
        case 15:
            TexZone.SetTexture(UnknownFunction112(UnknownFunction112("", Radar_Btn_), "Gray"));
            Str = "Ordinary Field";
            ZoneState.t_color.R = byte(255);
            ZoneState.t_color.G = byte(255);
            ZoneState.t_color.B = byte(255);
            ZoneState.t_color.A = byte(255);
            // End:0x4FF
            break;
        // End:0x22A
        case 12:
            TexZone.SetTexture(UnknownFunction112(UnknownFunction112("", Radar_Btn_), "Blue"));
            Str = "Peace Zone";
            ZoneState.t_color.R = 64;
            ZoneState.t_color.G = 140;
            ZoneState.t_color.B = byte(255);
            ZoneState.t_color.A = byte(255);
            // End:0x4FF
            break;
        // End:0x2C2
        case 11:
            TexZone.SetTexture(UnknownFunction112(UnknownFunction112("", Radar_Btn_), "Orange"));
            Str = "Siege Warfare Zone";
            ZoneState.t_color.R = byte(255);
            ZoneState.t_color.G = 114;
            ZoneState.t_color.B = 0;
            ZoneState.t_color.A = byte(255);
            // End:0x4FF
            break;
        // End:0x350
        case 9:
            TexZone.SetTexture(UnknownFunction112(UnknownFunction112("", Radar_Btn_), "Green"));
            Str = "Buff Zone";
            ZoneState.t_color.R = 119;
            ZoneState.t_color.G = byte(255);
            ZoneState.t_color.B = 153;
            ZoneState.t_color.A = byte(255);
            // End:0x4FF
            break;
        // End:0x3DC
        case 8:
            TexZone.SetTexture(UnknownFunction112(UnknownFunction112("", Radar_Btn_), "Red"));
            Str = "Danger Area";
            ZoneState.t_color.R = 178;
            ZoneState.t_color.G = 34;
            ZoneState.t_color.B = 34;
            ZoneState.t_color.A = byte(255);
            // End:0x4FF
            break;
        // End:0x46C
        case 13:
            TexZone.SetTexture(UnknownFunction112(UnknownFunction112("", Radar_Btn_), "Gray"));
            Str = "SSQ Zone";
            ZoneState.t_color.R = byte(255);
            ZoneState.t_color.G = byte(255);
            ZoneState.t_color.B = byte(255);
            ZoneState.t_color.A = byte(255);
            // End:0x4FF
            break;
        // End:0x4FC
        case 14:
            TexZone.SetTexture(UnknownFunction112(UnknownFunction112("", Radar_Btn_), "Green"));
            Str = "Combat Zone";
            ZoneState.t_color.R = 119;
            ZoneState.t_color.G = byte(255);
            ZoneState.t_color.B = 153;
            ZoneState.t_color.A = byte(255);
            // End:0x4FF
            break;
        // End:0xFFFF
        default:
            break;
    }
    ZoneState.t_strText = Str;
    param.DrawList[2] = ZoneState;
    TexZone.SetTooltipCustomType(param);
    // End:0x583
    if(UnknownFunction155(idx, 12))
    {
        Circle.SetWindowSize(32, 32);
        Circle.SetTexture("Was.Radar_Circle_Small");        
    }
    else
    {
        Circle.SetWindowSize(256, 256);
        Circle.SetTexture("Was.Radar_Circle_Large");
    }
    return;
}

function AdjustMapToPlayerPosition(bool a_ZoomToTownMap)
{
    local Vector param;

    param = GetPlayerPosition();
    Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MinimapWnd_NEW.Minimap", param, a_ZoomToTownMap);
    return;
}

function ParsePartyMemberCount(string param)
{
    ParseInt(param, "PartyMemberCount", PartyMemberCount);
    return;
}

function HandleMinimapAddTarget(string param)
{
    local Vector paramV;

    // End:0xBD
    if(UnknownFunction130(UnknownFunction130(ParseFloat(param, "X", paramV.X), ParseFloat(param, "Y", paramV.Y)), ParseFloat(param, "Z", paramV.Z)))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AddTarget("NPHRN_MinimapWnd_NEW.Minimap", paramV);
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MinimapWnd_NEW.Minimap", paramV, false, false);
    }
    return;
}

function HandleMinimapDeleteTarget(string param)
{
    local Vector paramV;
    local int LocX, LocY, LocZ;

    // End:0xB0
    if(UnknownFunction130(UnknownFunction130(ParseInt(param, "X", LocX), ParseInt(param, "Y", LocY)), ParseInt(param, "Z", LocZ)))
    {
        paramV.X = float(LocX);
        paramV.Y = float(LocY);
        paramV.Z = float(LocZ);
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.DeleteTarget("NPHRN_MinimapWnd_NEW.Minimap", paramV);
    }
    return;
}

function ShowTargetLocation()
{
    local Vector QuestLocation;

    // End:0x46
    if(GetQuestLocation(QuestLocation))
    {
        FixLocDisable();
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MinimapWnd_NEW.Minimap", QuestLocation);
    }
    return;
}

function ShowPartyMemberLocation()
{
    local Vector PartyMemberLocation;

    PartyMemberCount = GetPartyMemberCount();
    // End:0x1D
    if(UnknownFunction154(0, PartyMemberCount))
    {
        return;
    }
    FixLocDisable();
    i_UnkInt_1 = UnknownFunction173(UnknownFunction146(i_UnkInt_1, 1), PartyMemberCount);
    // End:0x86
    if(GetPartyMemberLocation(i_UnkInt_1, PartyMemberLocation))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("NPHRN_MinimapWnd_NEW.Minimap", PartyMemberLocation, false);
    }
    return;
}

function HandleRadarButtonClick()
{
    SetOptionBool("Custom", "RadarTransparency", !GetOptionBool("Custom", "RadarTransparency"));
    HandleRadarTransparency();
    return;
}

function HandleRadarTransparency()
{
    local ButtonHandle TransparentBtn;

    TransparentBtn = ButtonHandle(GetHandle("NPHRN_MinimapWnd_NEW.BtnTrans"));
    // End:0x118
    if(!GetOptionBool("Custom", "RadarTransparency"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("NPHRN_MinimapWnd_NEW.Minimap", 255, 0.5000000);
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("NPHRN_MinimapWnd_NEW.Circle", 255, 0.5000000);
        TransparentBtn.SetTexture("Was.Radar_Btn_Trans", "Was.Radar_Btn_Trans_Down", "Was.Radar_Btn_Trans_Over");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("NPHRN_MinimapWnd_NEW.Minimap", 130, 0.5000000);
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("NPHRN_MinimapWnd_NEW.Circle", 130, 0.5000000);
        TransparentBtn.SetTexture("Was.Radar_Btn_Solid", "Was.Radar_Btn_Solid_Down", "Was.Radar_Btn_Solid_Over");
    }
    return;
}

function HandleFixLoc()
{
    // End:0x12
    if(FixedLocation)
    {
        FixLocDisable();        
    }
    else
    {
        FixLocEnable();
    }
    return;
}

function FixLocEnable()
{
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("NPHRN_MinimapWnd_NEW.Circle");
    BtnFixLoc.SetTexture("Was.Radar_Btn_FixLoc_Enable", "Was.Radar_Btn_FixLoc_Down", "Was.Radar_Btn_FixLoc_Enable_Over");
    FixedLocation = true;
    return;
}

function FixLocDisable()
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MinimapWnd_NEW.Circle");
    BtnFixLoc.SetTexture("Was.Radar_Btn_FixLoc", "Was.Radar_Btn_FixLoc_Down", "Was.Radar_Btn_FixLoc_Over");
    FixedLocation = false;
    return;
}

function ResizeWnd()
{
    local TextureHandle Tex;
    local WindowHandle Minimap;

    Tex = TextureHandle(GetHandle("NPHRN_MinimapWnd_NEW.Tex"));
    Minimap = GetHandle("NPHRN_MinimapWnd_NEW.Minimap");
    // End:0xFA
    if(UnknownFunction129(Large))
    {
        Me.SetWindowSize(256, 256);
        Tex.SetWindowSize(256, 256);
        Tex.SetTexture("Was.Radar_Frame_Small");
        NPHRN_MiniMapHandler_NEW.SetWindowSize(224, 32);
        Minimap.SetWindowSize(252, 252);
        NPHRN_MiniMapHandler_NEW.Move(256, 0);        
    }
    else
    {
        Me.SetWindowSize(512, 512);
        Tex.SetWindowSize(512, 512);
        Tex.SetTexture("Was.Radar_Frame_Large");
        NPHRN_MiniMapHandler_NEW.SetWindowSize(480, 32);
        Minimap.SetWindowSize(508, 508);
        NPHRN_MiniMapHandler_NEW.Move(-256, 0);
    }
    return;
}

function OnLButtonDown(WindowHandle Handle, int X, int Y)
{
    switch(Handle)
    {
        // End:0xA6
        case TexZone:
            // End:0x7A
            if(UnknownFunction242(UnknownFunction129(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("NPHRN_MinimapWnd_NEW.Option")), true))
            {
                Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("NPHRN_MinimapWnd_NEW.Option");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.HideWindow("NPHRN_MinimapWnd_NEW.Option");
            }
        // End:0xFFFF
        default:
            return;
            break;
    }
}

function HandleMinimap()
{
    HandleZoneShow(ZoneCode);
    return;
}
