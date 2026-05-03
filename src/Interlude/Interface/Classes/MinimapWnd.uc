class MinimapWnd extends UICommonAPI;

var int m_PartyMemberCount;
var int m_PartyLocIndex;
var int b_IsShowGuideWnd;
var bool m_AdjustCursedLoc;
var int m_SSQStatus;
var bool m_bShowSSQType;
var bool m_bShowCurrentLocation;
var bool m_bShowGameTime;
var WindowHandle m_hExpandWnd;
var WindowHandle m_hGuideWnd;
var bool m_bExpandState;

function OnLoad()
{
    m_PartyLocIndex = -1;
    m_PartyMemberCount = GetPartyMemberCount();
    RegisterEvent(1780);
    RegisterEvent(520);
    RegisterEvent(1790);
    RegisterEvent(1800);
    RegisterEvent(1810);
    RegisterEvent(1820);
    RegisterEvent(1830);
    RegisterEvent(1840);
    RegisterEvent(1850);
    RegisterEvent(1860);
    RegisterEvent(2420);
    RegisterEvent(1870);
    RegisterEvent(1880);
    RegisterEvent(1890);
    m_AdjustCursedLoc = false;
    m_bShowSSQType = true;
    m_bShowCurrentLocation = true;
    m_bShowGameTime = true;
    m_bExpandState = false;
    m_hExpandWnd = GetHandle("MinimapWnd_Expand");
    m_hGuideWnd = GetHandle("GuideWnd");
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x1D
        case 1780:
            HandleShowMinimap(a_Param);
            // End:0x151
            break;
        // End:0x33
        case 520:
            HandlePartyMemberChanged(a_Param);
            // End:0x151
            break;
        // End:0x49
        case 1790:
            HandleMinimapAddTarget(a_Param);
            // End:0x151
            break;
        // End:0x5F
        case 1800:
            HandleMinimapDeleteTarget(a_Param);
            // End:0x151
            break;
        // End:0x70
        case 1810:
            HandleMinimapDeleteAllTarget();
            // End:0x151
            break;
        // End:0x81
        case 1820:
            HandleMinimapShowQuest();
            // End:0x151
            break;
        // End:0x92
        case 1830:
            HandleMinimapHideQuest();
            // End:0x151
            break;
        // End:0xA4
        case 1840:
            AdjustMapToPlayerPosition(true);
            // End:0x151
            break;
        // End:0xBA
        case 1850:
            HandleCursedWeaponList(a_Param);
            // End:0x151
            break;
        // End:0xD0
        case 1860:
            HandleCursedWeaponLoctaion(a_Param);
            // End:0x151
            break;
        // End:0xE1
        case 2420:
            SetCurrentLocation();
            // End:0x151
            break;
        // End:0x108
        case 1870:
            ShowWindow("MinimapWnd.btnReduce");
            // End:0x151
            break;
        // End:0x12F
        case 1880:
            HideWindow("MinimapWnd.btnReduce");
            // End:0x151
            break;
        // End:0x14E
        case 1890:
            // End:0x14B
            if(m_bShowGameTime)
            {
                HandleUpdateGameTime(a_Param);
            }
            // End:0x151
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnShow()
{
    Debug("MinimapWnd - OnShow");
    AdjustMapToPlayerPosition(true);
    Class'NWindow.AudioAPI'.static.PlaySound("interfacesound.Interface.map_open_01");
    // End:0x71
    if(b_IsShowGuideWnd == 1)
    {
        m_hGuideWnd.ShowWindow();
    }
    b_IsShowGuideWnd = 0;
    SetSSQTypeText();
    SetCurrentLocation();
    return;
}

function SetSSQTypeText()
{
    local string SSQText;

    switch(m_SSQStatus)
    {
        // End:0x1F
        case 0:
            SSQText = GetSystemString(973);
            // End:0x6C
            break;
        // End:0x37
        case 1:
            SSQText = GetSystemString(974);
            // End:0x6C
            break;
        // End:0x50
        case 2:
            SSQText = GetSystemString(975);
            // End:0x6C
            break;
        // End:0x69
        case 3:
            SSQText = GetSystemString(976);
            // End:0x6C
            break;
        // End:0xFFFF
        default:
            break;
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("Minimapwnd.txtVarSSQType", SSQText);
    return;
}

function SetCurrentLocation()
{
    local string ZoneName;

    ZoneName = GetCurrentZoneName();
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("Minimapwnd.txtVarCurLoc", ZoneName);
    return;
}

function OnHide()
{
    // End:0x19
    if(m_hGuideWnd.IsShowWindow())
    {
        b_IsShowGuideWnd = 1;
    }
    Class'NWindow.AudioAPI'.static.PlaySound("interfacesound.Interface.map_close_01");
    return;
}

function HandlePartyMemberChanged(string a_Param)
{
    ParseInt(a_Param, "PartyMemberCount", m_PartyMemberCount);
    return;
}

function SetExpandState(bool bExpandState)
{
    m_bExpandState = bExpandState;
    return;
}

function bool IsExpandState()
{
    return m_bExpandState;
}

function HandleShowMinimap(string a_Param)
{
    local int SSQStatus;

    Debug("HandleShowMiniap");
    // End:0x69
    if(ParseInt(a_Param, "SSQStatus", SSQStatus))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.SetSSQStatus("MinimapWnd.Minimap", SSQStatus);
        m_SSQStatus = SSQStatus;
    }
    // End:0xD8
    if(IsExpandState())
    {
        // End:0xAA
        if(IsShowWindow("MinimapWnd_Expand"))
        {
            HideWindow("MinimapWnd_Expand");            
        }
        else
        {
            HideWindow("MinimapWnd");
            ShowWindowWithFocus("MinimapWnd_Expand");
        }        
    }
    else
    {
        // End:0x102
        if(IsShowWindow("MinimapWnd"))
        {
            HideWindow("MinimapWnd");            
        }
        else
        {
            HideWindow("MinimapWnd_Expand");
            ShowWindowWithFocus("MinimapWnd");
        }
    }
    // End:0x17E
    if((IsShowWindow("MinimapWnd")) || IsShowWindow("MinimapWnd_Expand"))
    {
        Class'NWindow.MiniMapAPI'.static.RequestCursedWeaponList();
        Class'NWindow.MiniMapAPI'.static.RequestCursedWeaponLocation();
    }
    return;
}

function HandleMinimapAddTarget(string a_Param)
{
    local Vector Loc;

    Debug("~~~MinimapWnd - HandleMiniampAddTarget~~~~~~" $ a_Param);
    // End:0xE2
    if(((ParseFloat(a_Param, "X", Loc.X)) && ParseFloat(a_Param, "Y", Loc.Y)) && ParseFloat(a_Param, "Z", Loc.Z))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AddTarget("MinimapWnd.Minimap", Loc);
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("MinimapWnd.Minimap", Loc, false, false);
    }
    return;
}

function HandleMinimapDeleteTarget(string a_Param)
{
    local Vector Loc;
    local int LocX, LocY, LocZ;

    // End:0xA4
    if(((ParseInt(a_Param, "X", LocX)) && ParseInt(a_Param, "Y", LocY)) && ParseInt(a_Param, "Z", LocZ))
    {
        Loc.X = float(LocX);
        Loc.Y = float(LocY);
        Loc.Z = float(LocZ);
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.DeleteTarget("MinimapWnd.Minimap", Loc);
    }
    return;
}

function HandleMinimapDeleteAllTarget()
{
    Class'NWindow.UIAPI_MINIMAPCTRL'.static.DeleteAllTarget("MinimapWnd.Minimap");
    return;
}

function HandleMinimapShowQuest()
{
    Debug("MinimapWnd.HandleMinimapShowQuest");
    Class'NWindow.UIAPI_MINIMAPCTRL'.static.SetShowQuest("MinimapWnd.Minimap", true);
    return;
}

function HandleMinimapHideQuest()
{
    Debug("MinimapWnd.HandleMinimapHideQuest");
    Class'NWindow.UIAPI_MINIMAPCTRL'.static.SetShowQuest("MinimapWnd.Minimap", false);
    return;
}

function OnComboBoxItemSelected(string sName, int Index)
{
    local int CursedweaponComboBoxCurrentReservedData;

    // End:0x4F
    if(sName == "CursedComboBox")
    {
        CursedweaponComboBoxCurrentReservedData = Class'NWindow.UIAPI_COMBOBOX'.static.GetReserved("MinimapWnd.CursedComboBox", Index);
    }
    return;
}

function OnClickButton(string a_ButtonID)
{
    Debug(a_ButtonID);
    switch(a_ButtonID)
    {
        // End:0x2C
        case "TargetButton":
            OnClickTargetButton();
            // End:0x167
            break;
        // End:0x45
        case "MyLocButton":
            OnClickMyLocButton();
            // End:0x167
            break;
        // End:0x61
        case "PartyLocButton":
            OnClickPartyLocButton();
            // End:0x167
            break;
        // End:0xA8
        case "OpenGuideWnd":
            // End:0x96
            if(m_hGuideWnd.IsShowWindow())
            {
                m_hGuideWnd.HideWindow();                
            }
            else
            {
                m_hGuideWnd.ShowWindow();
            }
            // End:0x167
            break;
        // End:0xCE
        case "Pursuit":
            m_AdjustCursedLoc = true;
            Class'NWindow.MiniMapAPI'.static.RequestCursedWeaponLocation();
            // End:0x167
            break;
        // End:0x114
        case "ExpandButton":
            SetExpandState(true);
            ShowWindowWithFocus("MinimapWnd_Expand");
            HideWindow("MinimapWnd");
            // End:0x167
            break;
        // End:0x164
        case "btnReduce":
            Class'NWindow.UIAPI_MINIMAPCTRL'.static.RequestReduceBtn("MinimapWnd.Minimap");
            HideWindow("MinimapWnd.btnReduce");
            // End:0x167
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnClickTargetButton()
{
    local Vector QuestLocation;

    // End:0x36
    if(GetQuestLocation(QuestLocation))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("MinimapWnd.Minimap", QuestLocation);
    }
    return;
}

function OnClickMyLocButton()
{
    AdjustMapToPlayerPosition(true);
    return;
}

function AdjustMapToPlayerPosition(bool a_ZoomToTownMap)
{
    local Vector PlayerPosition;

    PlayerPosition = GetPlayerPosition();
    Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("MinimapWnd.Minimap", PlayerPosition, a_ZoomToTownMap);
    return;
}

function OnClickPartyLocButton()
{
    local Vector PartyMemberLocation;

    m_PartyMemberCount = GetPartyMemberCount();
    // End:0x19
    if(0 == m_PartyMemberCount)
    {
        return;
    }
    m_PartyLocIndex = int(float(m_PartyLocIndex + 1) % float(m_PartyMemberCount));
    // End:0x70
    if(GetPartyMemberLocation(m_PartyLocIndex, PartyMemberLocation))
    {
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("MinimapWnd.Minimap", PartyMemberLocation, false);
    }
    return;
}

function HandleCursedWeaponList(string param)
{
    local int Num, ItemID, i;
    local string cursedName;

    ParseInt(param, "NUM", Num);
    if(Num < 0)
    {
        Num = 0;
    }
    if(Num > 2)
    {
        Num = 2;
    }
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("MinimapWnd.CursedComboBox");
    i = 0;

    while(i < (Num + 1))
    {
        // End:0x9C
        if(i == 0)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved("MinimapWnd.CursedComboBox", GetSystemString(1463), 0);

            ++i;
            continue;
        }
        ParseInt(param, "ID" $ string(i - 1), ItemID);
        ParseString(param, "NAME" $ string(i - 1), cursedName);
        Class'NWindow.UIAPI_COMBOBOX'.static.AddStringWithReserved("MinimapWnd.CursedComboBox", cursedName, ItemID);
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("MinimapWnd.CursedComboBox", 0);

        ++i;
    }
    Class'NWindow.UIAPI_MINIMAPCTRL'.static.DeleteAllTarget("MinimapWnd.Minimap");
    return;
}

function HandleCursedWeaponLoctaion(string param)
{
    local int Num, ItemID, itemID1, itemID2, isowndedo, isownded1,
	    isownded2, X, Y, Z, i;

    local Vector CursedWeaponLoc1, CursedWeaponLoc2;
    local int CursedWeaponComboCurrentData;
    local string combocursedName, cursedName, cursedName1, cursedName2;
    local Vector cursedWeaponLocation;
    local bool combined;

    ParseInt(param, "NUM", Num);
    if(Num < 0)
    {
        Num = 0;
    }
    if(Num > 2)
    {
        Num = 2;
    }
    // End:0x7A
    if(Num == 0)
    {
        // End:0x52
        if(m_AdjustCursedLoc)
        {
            Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("MinimapWnd.Minimap", GetPlayerPosition());
        }
        Class'NWindow.UIAPI_MINIMAPCTRL'.static.DeleteAllCursedWeaponIcon("MinimapWnd.Minimap");
        return;        
    }
    else
    {
        i = 0;

        while(i < Num)
        {
            ParseInt(param, "ID" $ string(i), ItemID);
            ParseString(param, "NAME" $ string(i), cursedName);
            ParseInt(param, "ISOWNED" $ string(i), isowndedo);
            ParseInt(param, "X" $ string(i), X);
            ParseInt(param, "Y" $ string(i), Y);
            ParseInt(param, "Z" $ string(i), Z);
            cursedWeaponLocation.X = float(X);
            cursedWeaponLocation.Y = float(Y);
            cursedWeaponLocation.Z = float(Z);
            Normal(cursedWeaponLocation);
            switch(i)
            {
                // End:0x21D
                case 0:
                    itemID1 = ItemID;
                    cursedName1 = cursedName;
                    isownded1 = isowndedo;
                    CursedWeaponLoc1.X = cursedWeaponLocation.X;
                    CursedWeaponLoc1.Y = cursedWeaponLocation.Y;
                    CursedWeaponLoc1.Z = cursedWeaponLocation.Z;
                    Normal(CursedWeaponLoc1);
                    Debug((("무기1:" $ cursedName1) $ ", 위치:") @ string(CursedWeaponLoc1));
                    // End:0x2B7
                    break;
                // End:0x2B4
                case 1:
                    itemID2 = ItemID;
                    cursedName2 = cursedName;
                    isownded2 = isowndedo;
                    CursedWeaponLoc2.X = cursedWeaponLocation.X;
                    CursedWeaponLoc2.Y = cursedWeaponLocation.Y;
                    CursedWeaponLoc2.Z = cursedWeaponLocation.Z;
                    Normal(CursedWeaponLoc2);
                    Debug((("무기2:" $ cursedName2) $ ", 위치:") @ string(CursedWeaponLoc2));
                    // End:0x2B7
                    break;
                // End:0xFFFF
                default:
                    break;
            }
            ++i;
        }
    }
    // End:0x3B7
    if(m_AdjustCursedLoc)
    {
        m_AdjustCursedLoc = false;
        CursedWeaponComboCurrentData = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("MinimapWnd.CursedComboBox");
        combocursedName = Class'NWindow.UIAPI_COMBOBOX'.static.GetString("MinimapWnd.CursedComboBox", CursedWeaponComboCurrentData);
        // End:0x372
        if(combocursedName == cursedName1)
        {
            Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("MinimapWnd.Minimap", CursedWeaponLoc1, false);            
        }
        else
        {
            // End:0x3AD
            if(combocursedName == cursedName2)
            {
                Class'NWindow.UIAPI_MINIMAPCTRL'.static.AdjustMapView("MinimapWnd.Minimap", CursedWeaponLoc2, false);                
            }
            else
            {
                AdjustMapToPlayerPosition(true);
            }
        }        
    }
    else
    {
        // End:0x3F7
        if(Num == 1)
        {
            DrawCursedWeapon("MinimapWnd.Minimap", itemID1, cursedName1, CursedWeaponLoc1, isownded1 == 0, true);            
        }
        else
        {
            // End:0x58B
            if(Num == 2)
            {
                combined = Class'NWindow.UIAPI_MINIMAPCTRL'.static.IsOverlapped("MinimapWnd.Minimap", int(CursedWeaponLoc1.X), int(CursedWeaponLoc1.Y), int(CursedWeaponLoc2.X), int(CursedWeaponLoc2.Y));
                Debug("컴바인" @ string(combined));
                // End:0x506
                if(combined)
                {
                    Class'NWindow.UIAPI_MINIMAPCTRL'.static.DrawGridIcon("MinimapWnd.Minimap", "L2UI_CH3.MiniMap.cursedmapicon00", "L2UI_CH3.MiniMap.cursedmapicon00", CursedWeaponLoc1, true, 0, -12, (cursedName1 $ "\\n") $ cursedName2);                    
                }
                else
                {
                    Debug(("ownded:" @ string(isownded1)) @ string(isownded2));
                    DrawCursedWeapon("MinimapWnd.Minimap", itemID1, cursedName1, CursedWeaponLoc1, isownded1 == 0, true);
                    DrawCursedWeapon("MinimapWnd.Minimap", itemID2, cursedName2, CursedWeaponLoc2, isownded2 == 0, false);
                }
            }
        }
    }
    return;
}

function DrawCursedWeapon(string WindowName, int ItemID, string cursedName, Vector vecLoc, bool bDropped, bool bRefresh)
{
    local string itemIconName;

    // End:0x3A
    if(ItemID == 8190)
    {
        itemIconName = "L2UI_CH3.MiniMap.cursedmapicon01";        
    }
    else
    {
        // End:0x71
        if(ItemID == 8689)
        {
            itemIconName = "L2UI_CH3.MiniMap.cursedmapicon02";
        }
    }
    // End:0x8E
    if(bDropped)
    {
        itemIconName = itemIconName $ "_drop";
    }
    Class'NWindow.UIAPI_MINIMAPCTRL'.static.DrawGridIcon(WindowName, itemIconName, "L2UI_CH3.MiniMap.cursedmapicon00", vecLoc, bRefresh, 0, -12, cursedName);
    return;
}

function HandleUpdateGameTime(string a_Param)
{
    local int GameHour, GameMinute;
    local string GameTimeString;

    ParseInt(a_Param, "GameHour", GameHour);
    ParseInt(a_Param, "GameMinute", GameMinute);
    SelectSunOrMoon(GameHour);
    // End:0x64
    if(GameHour >= 12)
    {
        GameTimeString = "PM ";
        GameHour -= 12;        
    }
    else
    {
        GameTimeString = "AM ";
    }
    // End:0x82
    if(GameHour == 0)
    {
        GameHour = 12;
    }
    // End:0xB1
    if(GameHour < 10)
    {
        GameTimeString = ((GameTimeString $ "0") $ string(GameHour)) $ " : ";        
    }
    else
    {
        GameTimeString = (GameTimeString $ string(GameHour)) $ " : ";
    }
    // End:0xF4
    if(GameMinute < 10)
    {
        GameTimeString = (GameTimeString $ "0") $ string(GameMinute);        
    }
    else
    {
        GameTimeString = GameTimeString $ string(GameMinute);
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("MinimapWnd.txtGameTime", GameTimeString);
    return;
}

function SelectSunOrMoon(int GameHour)
{
    // End:0x50
    if((GameHour >= 6) && GameHour <= 24)
    {
        ShowWindow("MinimapWnd.texSun");
        HideWindow("MinimapWnd.texMoon");        
    }
    else
    {
        ShowWindow("MinimapWnd.texMoon");
        HideWindow("MinimapWnd.texSun");
    }
    return;
}
