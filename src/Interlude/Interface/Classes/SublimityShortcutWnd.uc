class SublimityShortcutWnd extends SublimityItem;

const MAX_Panel = 4;
const MAX_Page = 10;
const MAX_ShortcutPerPage = 12;
const MAX_Shortcut = 120;

var bool m_IsInit;
var bool m_IsLocked;
var bool m_IsVertical;
var int m_ExpandCount;
var int m_ShortcutPage[4];
var int m_ShortcutState[120];

function OnLoad()
{
    RegisterEvent(650);
    RegisterEvent(631);
    RegisterEvent(630);
    RegisterEvent(640);
    RegisterEvent(90);
    HideWindow("ShortcutWnd.ShortcutWndVertical.JoypadBtn");
    HideWindow("ShortcutWnd.ShortcutWndHorizontal.JoypadBtn");
    return;
}

function OnShow()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F1Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F2Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F3Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F4Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F5Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F6Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F7Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F8Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F9Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F10Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F11Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd.F12Tex");
    return;
}

function OnDefaultPosition()
{
    local int i;

    SetExpand(0);
    SetLock(false);
    i = 0;

    while(i < 4)
    {
        SetPage(i, i);
        i++;
    }
    SetVertical(true);
    return;
}

function OnShortcutClear()
{
    local int i;

    Clear();
    LoadConfig();
    HandleLock();
    HandleExpand();
    i = 0;

    while(i < 4)
    {
        HandleSetPage(i);
        i++;
    }
    HandleVertical();
    return;
}

function OnShortcutDelete(int a_ShortcutID)
{
    SetShortcut(a_ShortcutID, true);
    return;
}

function OnShortcutUpdate(int a_ShortcutID)
{
    SetShortcut(a_ShortcutID, false);
    return;
}

function OnShortcutPageUpdate(int a_ShortcutPage)
{
    SetPage(0, a_ShortcutPage);
    return;
}

function OnClickButton(string a_ID)
{
    switch(a_ID)
    {
        // End:0x1D
        case "PrevBtn":
            PrevPage(0);
            // End:0x13B
            break;
        // End:0x33
        case "NextBtn":
            NextPage(0);
            // End:0x13B
            break;
        // End:0x4A
        case "PrevBtn2":
            PrevPage(1);
            // End:0x13B
            break;
        // End:0x61
        case "NextBtn2":
            NextPage(1);
            // End:0x13B
            break;
        // End:0x79
        case "PrevBtn3":
            PrevPage(2);
            // End:0x13B
            break;
        // End:0x91
        case "NextBtn3":
            NextPage(2);
            // End:0x13B
            break;
        // End:0xA9
        case "PrevBtn4":
            PrevPage(3);
            // End:0x13B
            break;
        // End:0xC1
        case "NextBtn4":
            NextPage(3);
            // End:0x13B
            break;
        // End:0xD8
        case "RotateBtn":
            ToggleRotate();
            // End:0x13B
            break;
        // End:0xF2
        case "ExpandButton":
            ToggleExpand();
            // End:0x13B
            break;
        // End:0x10C
        case "ReduceButton":
            ToggleExpand();
            // End:0x13B
            break;
        // End:0x121
        case "LockBtn":
            ToggleLock();
            // End:0x13B
            break;
        // End:0x138
        case "UnlockBtn":
            ToggleLock();
            // End:0x13B
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function NextPage(int a_PanelIndex)
{
    local int NewPage;

    NewPage = m_ShortcutPage[a_PanelIndex] + 1;
    // End:0x27
    if(NewPage >= 10)
    {
        NewPage = 0;
    }
    // End:0x49
    if(a_PanelIndex == 0)
    {
        Class'NWindow.ShortcutAPI'.static.SetShortcutPage(NewPage);        
    }
    else
    {
        SetPage(a_PanelIndex, NewPage);
    }
    return;
}

function PrevPage(int a_PanelIndex)
{
    local int NewPage;

    NewPage = m_ShortcutPage[a_PanelIndex] - 1;
    // End:0x2A
    if(NewPage < 0)
    {
        NewPage = 10 - 1;
    }
    // End:0x4C
    if(a_PanelIndex == 0)
    {
        Class'NWindow.ShortcutAPI'.static.SetShortcutPage(NewPage);        
    }
    else
    {
        SetPage(a_PanelIndex, NewPage);
    }
    return;
}

function ToggleLock()
{
    SetLock(!m_IsLocked);
    return;
}

function ToggleExpand()
{
    local int NewExpandCount;

    NewExpandCount = m_ExpandCount + 1;
    // End:0x21
    if(NewExpandCount >= 4)
    {
        NewExpandCount = 0;
    }
    SetExpand(NewExpandCount);
    return;
}

function ToggleRotate()
{
    SetVertical(!m_IsVertical);
    return;
}

function Clear()
{
    local int i, N;

    i = 0;

    while(i < 120)
    {
        SetActive(i, false);
        i++;
    }
    i = 0;

    while(i < 4)
    {
        N = 0;

        while(N < 12)
        {
            Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear(((GetPanelNameEx(i, false)) $ ".Shortcut") $ string(i + 1));
            Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear(((GetPanelNameEx(i, true)) $ ".Shortcut") $ string(i + 1));
            N++;
        }
        i++;
    }
    return;
}

function SetVertical(bool a_State)
{
    m_IsVertical = a_State;
    SetPcOptionBool("Game", "ShortcutIsVertical", a_State);
    HandleVertical();
    return;
}

function SetLock(bool a_State)
{
    m_IsLocked = a_State;
    SetOptionBool("Game", "IsLockShortcutWnd", a_State);
    HandleLock();
    return;
}

function SetShortcut(int a_ShortcutID, bool a_bDelete)
{
    local int i;

    i = 0;

    while(i < 4)
    {
        // End:0xB6
        if(IsShortcutIDInCurPage(m_ShortcutPage[i], a_ShortcutID))
        {
            Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut(((GetPanelNameEx(i, true)) $ ".Shortcut") $ string(int((float(a_ShortcutID) % float(12)) + float(1))), a_ShortcutID);
            Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut(((GetPanelNameEx(i, false)) $ ".Shortcut") $ string(int((float(a_ShortcutID) % float(12)) + float(1))), a_ShortcutID);
        }
        i++;
    }
    SetActive(a_ShortcutID, !a_bDelete);
    return;
}

function SetPage(int a_PanelIndex, int a_NumPage)
{
    // End:0x1B
    if((a_PanelIndex >= 4) || a_PanelIndex < 0)
    {
        return;
    }
    // End:0x36
    if((a_NumPage >= 10) || a_NumPage < 0)
    {
        return;
    }
    m_ShortcutPage[a_PanelIndex] = a_NumPage;
    SetPcOptionInt("Game", "ShortcutPage_" $ string(a_PanelIndex), a_NumPage);
    HandleSetPage(a_PanelIndex);
    return;
}

function SetActive(int a_ShortcutID, bool a_bActive)
{
    // End:0x24
    if(a_bActive)
    {
        ShowText(a_ShortcutID);
        m_ShortcutState[a_ShortcutID] = 1;        
    }
    else
    {
        HideText(a_ShortcutID);
        m_ShortcutState[a_ShortcutID] = 0;
    }
    return;
}

function SetExpand(int a_ExpandCount)
{
    // End:0x1B
    if((a_ExpandCount < 0) || a_ExpandCount >= 4)
    {
        return;
    }
    m_ExpandCount = a_ExpandCount;
    SetPcOptionInt("Game", "ShortcutExpandCount", a_ExpandCount);
    HandleExpand();
    return;
}

function HideText(int a_ShortcutID)
{
    local int i;

    i = 0;

    while(i < 4)
    {
        // End:0x9A
        if(IsShortcutIDInCurPage(m_ShortcutPage[i], a_ShortcutID))
        {
            HideWindow((((GetPanelNameEx(i, false)) $ ".F") $ string(int((float(a_ShortcutID) % float(12)) + float(1)))) $ "Tex");
            HideWindow((((GetPanelNameEx(i, true)) $ ".F") $ string(int((float(a_ShortcutID) % float(12)) + float(1)))) $ "Tex");
        }
        i++;
    }
    return;
}

function ShowText(int a_ShortcutID)
{
    local int i;

    i = 0;

    while(i < 4)
    {
        // End:0x9A
        if(IsShortcutIDInCurPage(m_ShortcutPage[i], a_ShortcutID))
        {
            ShowWindow((((GetPanelNameEx(i, false)) $ ".F") $ string(int((float(a_ShortcutID) % float(12)) + float(1)))) $ "Tex");
            ShowWindow((((GetPanelNameEx(i, true)) $ ".F") $ string(int((float(a_ShortcutID) % float(12)) + float(1)))) $ "Tex");
        }
        i++;
    }
    return;
}

function LoadConfig()
{
    local int i;

    InitConfig();
    m_ExpandCount = GetPcOptionInt("Game", "ShortcutExpandCount");
    m_IsVertical = GetPcOptionBool("Game", "ShortcutIsVertical");
    m_IsLocked = GetOptionBool("Game", "IsLockShortcutWnd");
    i = 0;

    while(i < 4)
    {
        m_ShortcutPage[i] = GetPcOptionInt("Game", "ShortcutPage_" $ string(i));
        i++;
    }
    return;
}

function InitConfig()
{
    local int i;

    // End:0x23
    if((GetPcOptionInt("Game", "ShortcutStub")) == 100)
    {
        return;
    }
    SetPcOptionInt("Game", "ShortcutStub", 100);
    SetPcOptionInt("Game", "ShortcutExpandCount", 0);
    SetPcOptionBool("Game", "ShortcutIsVertical", false);
    SetOptionBool("Game", "IsLockShortcutWnd", false);
    i = 0;

    while(i < 4)
    {
        SetPcOptionInt("Game", "ShortcutPage_" $ string(i), i);
        i++;
    }
    return;
}

function bool IsActive(int a_ShortcutID)
{
    return m_ShortcutState[a_ShortcutID] == 1;
}

function bool IsShortcutIDInCurPage(int PageNum, int a_nShortcutID)
{
    // End:0x15
    if((PageNum * 12) > a_nShortcutID)
    {
        return false;
    }
    // End:0x2D
    if(((PageNum + 1) * 12) <= a_nShortcutID)
    {
        return false;
    }
    return true;
}

function string GetPanelNameEx(int a_Index, bool a_IsVertical)
{
    local string Out;

    Out = "ShortcutWnd.";
    // End:0x42
    if(a_IsVertical)
    {
        Out = Out $ "ShortcutWndVertical";        
    }
    else
    {
        Out = Out $ "ShortcutWndHorizontal";
    }
    // End:0x8A
    if(a_Index > 0)
    {
        Out = (Out $ "_") $ string(a_Index);
    }
    return Out;
}

function string GetPanelName(int a_Index)
{
    return GetPanelNameEx(a_Index, m_IsVertical);
}

function HandleLock()
{
    // End:0x78
    if(m_IsLocked)
    {
        ShowWindow((GetPanelNameEx(0, false)) $ ".LockBtn");
        ShowWindow((GetPanelNameEx(0, true)) $ ".LockBtn");
        HideWindow((GetPanelNameEx(0, false)) $ ".UnlockBtn");
        HideWindow((GetPanelNameEx(0, true)) $ ".UnlockBtn");        
    }
    else
    {
        HideWindow((GetPanelNameEx(0, false)) $ ".LockBtn");
        HideWindow((GetPanelNameEx(0, true)) $ ".LockBtn");
        ShowWindow((GetPanelNameEx(0, false)) $ ".UnlockBtn");
        ShowWindow((GetPanelNameEx(0, true)) $ ".UnlockBtn");
    }
    return;
}

function HandleVertical()
{
    local Rect WindowRect;

    ShowWindow(GetPanelNameEx(0, m_IsVertical));
    HideWindow(GetPanelNameEx(0, !m_IsVertical));
    // End:0x81
    if(m_IsVertical)
    {
        WindowRect = Class'NWindow.UIAPI_WINDOW'.static.GetRect(GetPanelName(0));
        // End:0x7E
        if(WindowRect.nY < 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.MoveTo(GetPanelName(0), WindowRect.nX, 0);
        }        
    }
    else
    {
        WindowRect = Class'NWindow.UIAPI_WINDOW'.static.GetRect(GetPanelName(0));
        // End:0xCE
        if(WindowRect.nX < 0)
        {
            Class'NWindow.UIAPI_WINDOW'.static.MoveTo(GetPanelName(0), 0, WindowRect.nY);
        }
    }
    // End:0x1E8
    if(m_IsVertical)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("ShortcutWnd.ShortcutWndVertical", "ShortcutWnd.ShortcutWndHorizontal", "BottomRight", "BottomRight", 0, 0);
        Class'NWindow.UIAPI_WINDOW'.static.ClearAnchor("ShortcutWnd.ShortcutWndVertical");
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("ShortcutWnd.ShortcutWndHorizontal", "ShortcutWnd.ShortcutWndVertical", "BottomRight", "BottomRight", 0, 0);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("ShortcutWnd.ShortcutWndHorizontal", "ShortcutWnd.ShortcutWndVertical", "BottomRight", "BottomRight", 0, 0);
        Class'NWindow.UIAPI_WINDOW'.static.ClearAnchor("ShortcutWnd.ShortcutWndHorizontal");
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("ShortcutWnd.ShortcutWndVertical", "ShortcutWnd.ShortcutWndHorizontal", "BottomRight", "BottomRight", 0, 0);
    }
    return;
}

function HandleExpand()
{
    local int i, N;

    i = 0;

    while(i < m_ExpandCount)
    {
        ShowWindow(GetPanelNameEx(i + 1, false));
        ShowWindow(GetPanelNameEx(i + 1, true));
        i++;
    }
    N = i;

    while(N < (4 - 1))
    {
        HideWindow(GetPanelNameEx(N + 1, false));
        HideWindow(GetPanelNameEx(N + 1, true));
        N++;
    }
    // End:0x123
    if(m_ExpandCount == 3)
    {
        HideWindow((GetPanelNameEx(0, false)) $ ".ExpandButton");
        HideWindow((GetPanelNameEx(0, true)) $ ".ExpandButton");
        ShowWindow((GetPanelNameEx(0, false)) $ ".ReduceButton");
        ShowWindow((GetPanelNameEx(0, true)) $ ".ReduceButton");        
    }
    else
    {
        ShowWindow((GetPanelNameEx(0, false)) $ ".ExpandButton");
        ShowWindow((GetPanelNameEx(0, true)) $ ".ExpandButton");
        HideWindow((GetPanelNameEx(0, false)) $ ".ReduceButton");
        HideWindow((GetPanelNameEx(0, true)) $ ".ReduceButton");
    }
    return;
}

function HandleSetPage(int a_PanelIndex)
{
    local int i, nShortcutID;

    i = m_ShortcutPage[a_PanelIndex] + 1;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText((GetPanelNameEx(a_PanelIndex, false)) $ ".PageNumTextBox", string(i));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText((GetPanelNameEx(a_PanelIndex, true)) $ ".PageNumTextBox", string(i));
    nShortcutID = m_ShortcutPage[a_PanelIndex] * 12;
    i = 0;

    while(i < 12)
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut(((GetPanelNameEx(a_PanelIndex, false)) $ ".Shortcut") $ string(i + 1), nShortcutID);
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut(((GetPanelNameEx(a_PanelIndex, true)) $ ".Shortcut") $ string(i + 1), nShortcutID);
        // End:0x17F
        if(IsActive(nShortcutID))
        {
            ShowWindow((((GetPanelNameEx(a_PanelIndex, false)) $ ".F") $ string(i + 1)) $ "Tex");
            ShowWindow((((GetPanelNameEx(a_PanelIndex, true)) $ ".F") $ string(i + 1)) $ "Tex");            
        }
        else
        {
            HideWindow((((GetPanelNameEx(a_PanelIndex, false)) $ ".F") $ string(i + 1)) $ "Tex");
            HideWindow((((GetPanelNameEx(a_PanelIndex, true)) $ ".F") $ string(i + 1)) $ "Tex");
        }
        nShortcutID++;
        i++;
    }
    return;
}

function OnShortcutCommand(string a_Command)
{
    switch(a_Command)
    {
        // End:0x30
        case "MyShortcutItem11":
            UseShortcutItem(m_ShortcutPage[0] + 1, 1);
            // End:0x80A
            break;
        // End:0x5A
        case "MyShortcutItem12":
            UseShortcutItem(m_ShortcutPage[0] + 1, 2);
            // End:0x80A
            break;
        // End:0x84
        case "MyShortcutItem13":
            UseShortcutItem(m_ShortcutPage[0] + 1, 3);
            // End:0x80A
            break;
        // End:0xAE
        case "MyShortcutItem14":
            UseShortcutItem(m_ShortcutPage[0] + 1, 4);
            // End:0x80A
            break;
        // End:0xD8
        case "MyShortcutItem15":
            UseShortcutItem(m_ShortcutPage[0] + 1, 5);
            // End:0x80A
            break;
        // End:0x102
        case "MyShortcutItem16":
            UseShortcutItem(m_ShortcutPage[0] + 1, 6);
            // End:0x80A
            break;
        // End:0x12C
        case "MyShortcutItem17":
            UseShortcutItem(m_ShortcutPage[0] + 1, 7);
            // End:0x80A
            break;
        // End:0x156
        case "MyShortcutItem18":
            UseShortcutItem(m_ShortcutPage[0] + 1, 8);
            // End:0x80A
            break;
        // End:0x180
        case "MyShortcutItem19":
            UseShortcutItem(m_ShortcutPage[0] + 1, 9);
            // End:0x80A
            break;
        // End:0x1AB
        case "MyShortcutItem110":
            UseShortcutItem(m_ShortcutPage[0] + 1, 10);
            // End:0x80A
            break;
        // End:0x1D6
        case "MyShortcutItem111":
            UseShortcutItem(m_ShortcutPage[0] + 1, 11);
            // End:0x80A
            break;
        // End:0x201
        case "MyShortcutItem112":
            UseShortcutItem(m_ShortcutPage[0] + 1, 12);
            // End:0x80A
            break;
        // End:0x22A
        case "MyShortcutItem21":
            UseShortcutItem(m_ShortcutPage[1] + 1, 1);
            // End:0x80A
            break;
        // End:0x254
        case "MyShortcutItem22":
            UseShortcutItem(m_ShortcutPage[1] + 1, 2);
            // End:0x80A
            break;
        // End:0x27E
        case "MyShortcutItem23":
            UseShortcutItem(m_ShortcutPage[1] + 1, 3);
            // End:0x80A
            break;
        // End:0x2A8
        case "MyShortcutItem24":
            UseShortcutItem(m_ShortcutPage[1] + 1, 4);
            // End:0x80A
            break;
        // End:0x2D2
        case "MyShortcutItem25":
            UseShortcutItem(m_ShortcutPage[1] + 1, 5);
            // End:0x80A
            break;
        // End:0x2FC
        case "MyShortcutItem26":
            UseShortcutItem(m_ShortcutPage[1] + 1, 6);
            // End:0x80A
            break;
        // End:0x326
        case "MyShortcutItem27":
            UseShortcutItem(m_ShortcutPage[1] + 1, 7);
            // End:0x80A
            break;
        // End:0x350
        case "MyShortcutItem28":
            UseShortcutItem(m_ShortcutPage[1] + 1, 8);
            // End:0x80A
            break;
        // End:0x37A
        case "MyShortcutItem29":
            UseShortcutItem(m_ShortcutPage[1] + 1, 9);
            // End:0x80A
            break;
        // End:0x3A5
        case "MyShortcutItem210":
            UseShortcutItem(m_ShortcutPage[1] + 1, 10);
            // End:0x80A
            break;
        // End:0x3D0
        case "MyShortcutItem211":
            UseShortcutItem(m_ShortcutPage[1] + 1, 11);
            // End:0x80A
            break;
        // End:0x3FB
        case "MyShortcutItem212":
            UseShortcutItem(m_ShortcutPage[1] + 1, 12);
            // End:0x80A
            break;
        // End:0x425
        case "MyShortcutItem31":
            UseShortcutItem(m_ShortcutPage[2] + 1, 1);
            // End:0x80A
            break;
        // End:0x450
        case "MyShortcutItem32":
            UseShortcutItem(m_ShortcutPage[2] + 1, 2);
            // End:0x80A
            break;
        // End:0x47B
        case "MyShortcutItem33":
            UseShortcutItem(m_ShortcutPage[2] + 1, 3);
            // End:0x80A
            break;
        // End:0x4A6
        case "MyShortcutItem34":
            UseShortcutItem(m_ShortcutPage[2] + 1, 4);
            // End:0x80A
            break;
        // End:0x4D1
        case "MyShortcutItem35":
            UseShortcutItem(m_ShortcutPage[2] + 1, 5);
            // End:0x80A
            break;
        // End:0x4FC
        case "MyShortcutItem36":
            UseShortcutItem(m_ShortcutPage[2] + 1, 6);
            // End:0x80A
            break;
        // End:0x527
        case "MyShortcutItem37":
            UseShortcutItem(m_ShortcutPage[2] + 1, 7);
            // End:0x80A
            break;
        // End:0x552
        case "MyShortcutItem38":
            UseShortcutItem(m_ShortcutPage[2] + 1, 8);
            // End:0x80A
            break;
        // End:0x57D
        case "MyShortcutItem39":
            UseShortcutItem(m_ShortcutPage[2] + 1, 9);
            // End:0x80A
            break;
        // End:0x5A9
        case "MyShortcutItem310":
            UseShortcutItem(m_ShortcutPage[2] + 1, 10);
            // End:0x80A
            break;
        // End:0x5D5
        case "MyShortcutItem311":
            UseShortcutItem(m_ShortcutPage[2] + 1, 11);
            // End:0x80A
            break;
        // End:0x601
        case "MyShortcutItem312":
            UseShortcutItem(m_ShortcutPage[2] + 1, 12);
            // End:0x80A
            break;
        // End:0x62B
        case "MyShortcutItem41":
            UseShortcutItem(m_ShortcutPage[3] + 1, 1);
            // End:0x80A
            break;
        // End:0x656
        case "MyShortcutItem42":
            UseShortcutItem(m_ShortcutPage[3] + 1, 2);
            // End:0x80A
            break;
        // End:0x681
        case "MyShortcutItem43":
            UseShortcutItem(m_ShortcutPage[3] + 1, 3);
            // End:0x80A
            break;
        // End:0x6AC
        case "MyShortcutItem44":
            UseShortcutItem(m_ShortcutPage[3] + 1, 4);
            // End:0x80A
            break;
        // End:0x6D7
        case "MyShortcutItem45":
            UseShortcutItem(m_ShortcutPage[3] + 1, 5);
            // End:0x80A
            break;
        // End:0x702
        case "MyShortcutItem46":
            UseShortcutItem(m_ShortcutPage[3] + 1, 6);
            // End:0x80A
            break;
        // End:0x72D
        case "MyShortcutItem47":
            UseShortcutItem(m_ShortcutPage[3] + 1, 7);
            // End:0x80A
            break;
        // End:0x758
        case "MyShortcutItem48":
            UseShortcutItem(m_ShortcutPage[3] + 1, 8);
            // End:0x80A
            break;
        // End:0x783
        case "MyShortcutItem49":
            UseShortcutItem(m_ShortcutPage[3] + 1, 9);
            // End:0x80A
            break;
        // End:0x7AF
        case "MyShortcutItem410":
            UseShortcutItem(m_ShortcutPage[3] + 1, 10);
            // End:0x80A
            break;
        // End:0x7DB
        case "MyShortcutItem411":
            UseShortcutItem(m_ShortcutPage[3] + 1, 11);
            // End:0x80A
            break;
        // End:0x807
        case "MyShortcutItem412":
            UseShortcutItem(m_ShortcutPage[3] + 1, 12);
            // End:0x80A
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function UseShortcutItem(int page, int Num)
{
    ExecuteCommand((("/useshortcut " $ string(page)) $ " ") $ string(Num));
    return;
}
