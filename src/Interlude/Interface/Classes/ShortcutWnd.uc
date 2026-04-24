class ShortcutWnd extends UICommonAPI;

const MAX_Page = 10;
const MAX_ShortcutPerPage = 12;
const MAX_ShortcutPerPage2 = 24;
const MAX_ShortcutPerPage3 = 36;
const MAX_ShortcutPerPage4 = 48;

enum EJoyShortcut
{
    JOYSHORTCUT_Left,               // 0
    JOYSHORTCUT_Center,             // 1
    JOYSHORTCUT_Right               // 2
};

var int CurrentShortcutPage;
var int CurrentShortcutPage2;
var int CurrentShortcutPage3;
var int CurrentShortcutPage4;
var int CurrentShortcutPage5;
var int CurrentShortcutPage6;
var bool m_IsLocked;
var bool m_IsVertical;
var bool m_IsJoypad;
var bool m_IsJoypadExpand;
var bool m_IsJoypadOn;
var bool m_IsExpand1;
var bool m_IsExpand2;
var bool m_IsExpand3;
var bool m_IsExpand4;
var bool m_IsExpand5;
var bool m_IsShortcutExpand;
var string m_ShortcutWndName;
var WindowHandle Me_Horizontal;
var ButtonHandle btnMove_Horizontal;

function OnRegisterEvent()
{
    RegisterEvent(630);
    RegisterEvent(640);
    RegisterEvent(660);
    RegisterEvent(650);
    RegisterEvent(590);
    RegisterEvent(600);
    RegisterEvent(610);
    RegisterEvent(620);
    RegisterEvent(150);
    return;
}

function OnLoad()
{
    OnRegisterEvent();
    m_IsLocked = GetOptionBool("Game", "IsLockShortcutWnd");
    m_IsExpand1 = GetOptionBool("Game", "Is1ExpandShortcutWnd");
    m_IsExpand2 = GetOptionBool("Game", "Is2ExpandShortcutWnd");
    m_IsExpand3 = GetOptionBool("Game", "Is3ExpandShortcutWnd");
    m_IsExpand4 = GetOptionBool("Game", "Is4ExpandShortcutWnd");
    m_IsExpand5 = GetOptionBool("Game", "Is5ExpandShortcutWnd");
    m_IsVertical = GetOptionBool("Game", "IsShortcutWndVertical");
    InitShortPageNum();
    ShowWindow("ShortcutWnd.ShortcutWndHorizontal.TooltipMaxBtn");
    HideWindow("ShortcutWnd.ShortcutWndHorizontal.TooltipMinBtn");
    ShowWindow("ShortcutWnd.ShortcutWndVertical.TooltipMaxBtn");
    HideWindow("ShortcutWnd.ShortcutWndVertical.TooltipMinBtn");
    Me_Horizontal = GetHandle("ShortcutWnd.ShortcutWndHorizontal");
    btnMove_Horizontal = ButtonHandle(GetHandle("ShortcutWnd.ShortcutWndHorizontal.btnMove"));
    btnMove_Horizontal.SetTooltipCustomType(MakeTooltipSimpleText("Disable shortcut Move"));
    return;
}

function OnDefaultPosition()
{
    m_IsExpand1 = false;
    m_IsExpand2 = false;
    m_IsExpand3 = false;
    m_IsExpand4 = false;
    m_IsExpand5 = false;
    SetVertical(true);
    InitShortPageNum();
    ArrangeWnd();
    ExpandWnd();
    return;
}

function OnEnterState(name a_PreStateName)
{
    ArrangeWnd();
    ExpandWnd();
    AutoPotionsWndPosition();
    // End:0x27
    if(a_PreStateName == 'LoadingState')
    {
        InitShortPageNum();
    }
    // End:0xEC
    if(GetOptionBool("Custom", "ShortcutMovable"))
    {
        btnMove_Horizontal.SetTexture("Was.Savoshortcut_unlock_over", "Was.Savoshortcut_unlock", "Was.Savoshortcut_unlock_over");
        btnMove_Horizontal.SetTooltipCustomType(MakeTooltipSimpleText("Disable shortcut Move"));
        Me_Horizontal.SetDraggable(true);        
    }
    else
    {
        btnMove_Horizontal.SetTexture("Was.Savoshortcut_lock_over", "Was.Savoshortcut_lock", "Was.Savoshortcut_lock_over");
        btnMove_Horizontal.SetTooltipCustomType(MakeTooltipSimpleText("Enable shortcut Move"));
        Me_Horizontal.SetDraggable(false);
    }
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x0F
        case 150:
            // End:0xC9
            break;
        // End:0x25
        case 640:
            HandleShortcutPageUpdate(a_Param);
            // End:0xC9
            break;
        // End:0x3B
        case 660:
            HandleShortcutJoypad(a_Param);
            // End:0xC9
            break;
        // End:0x51
        case 590:
            HandleJoypadLButtonDown(a_Param);
            // End:0xC9
            break;
        // End:0x67
        case 600:
            HandleJoypadLButtonUp(a_Param);
            // End:0xC9
            break;
        // End:0x7D
        case 610:
            HandleJoypadRButtonDown(a_Param);
            // End:0xC9
            break;
        // End:0x93
        case 620:
            HandleJoypadRButtonUp(a_Param);
            // End:0xC9
            break;
        // End:0xA9
        case 630:
            HandleShortcutUpdate(a_Param);
            // End:0xC9
            break;
        // End:0xC6
        case 650:
            HandleShortcutClear();
            ArrangeWnd();
            ExpandWnd();
            // End:0xC9
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function InitShortPageNum()
{
    CurrentShortcutPage = 0;
    CurrentShortcutPage2 = 1;
    CurrentShortcutPage3 = 2;
    CurrentShortcutPage4 = 3;
    CurrentShortcutPage5 = 4;
    CurrentShortcutPage6 = 5;
    return;
}

function HandleShortcutPageUpdate(string param)
{
    local int i, nShortcutID, ShortcutPage;

    // End:0xFD
    if(ParseInt(param, "ShortcutPage", ShortcutPage))
    {
        // End:0x3C
        if((0 > ShortcutPage) || 10 <= ShortcutPage)
        {
            return;
        }
        CurrentShortcutPage = ShortcutPage;
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(("ShortcutWnd." $ m_ShortcutWndName) $ ".PageNumTextBox", string(CurrentShortcutPage + 1));
        nShortcutID = CurrentShortcutPage * 12;
        i = 0;

        while(i < 12)
        {
            Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut((("ShortcutWnd." $ m_ShortcutWndName) $ ".Shortcut") $ string(i + 1), nShortcutID);
            nShortcutID++;
            ++i;
        }
    }
    return;
}

function HandleShortcutUpdate(string param)
{
    local int nShortcutID, nShortcutNum;

    ParseInt(param, "ShortcutID", nShortcutID);
    nShortcutNum = int(float(nShortcutID) % float(12)) + 1;
    // End:0x86
    if(IsShortcutIDInCurPage(CurrentShortcutPage, nShortcutID))
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut((("ShortcutWnd." $ m_ShortcutWndName) $ ".Shortcut") $ string(nShortcutNum), nShortcutID);
    }
    // End:0xDA
    if(IsShortcutIDInCurPage(CurrentShortcutPage2, nShortcutID))
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut((("ShortcutWnd." $ m_ShortcutWndName) $ "_1.Shortcut") $ string(nShortcutNum), nShortcutID);
    }
    // End:0x12E
    if(IsShortcutIDInCurPage(CurrentShortcutPage3, nShortcutID))
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut((("ShortcutWnd." $ m_ShortcutWndName) $ "_2.Shortcut") $ string(nShortcutNum), nShortcutID);
    }
    // End:0x182
    if(IsShortcutIDInCurPage(CurrentShortcutPage4, nShortcutID))
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut((("ShortcutWnd." $ m_ShortcutWndName) $ "_3.Shortcut") $ string(nShortcutNum), nShortcutID);
    }
    // End:0x1D6
    if(IsShortcutIDInCurPage(CurrentShortcutPage5, nShortcutID))
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut((("ShortcutWnd." $ m_ShortcutWndName) $ "_4.Shortcut") $ string(nShortcutNum), nShortcutID);
    }
    // End:0x22A
    if(IsShortcutIDInCurPage(CurrentShortcutPage6, nShortcutID))
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut((("ShortcutWnd." $ m_ShortcutWndName) $ "_5.Shortcut") $ string(nShortcutNum), nShortcutID);
    }
    return;
}

function HandleShortcutClear()
{
    local int i;

    i = 0;

    while(i < 12)
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndVertical.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndVertical_1.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndVertical_2.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndVertical_3.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndVertical_4.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndVertical_5.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndHorizontal.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndHorizontal_1.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndHorizontal_2.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndHorizontal_3.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndHorizontal_4.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndHorizontal_5.Shortcut" $ string(i + 1));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndJoypadExpand.Shortcut" $ string(i + 1));
        ++i;
    }
    i = 0;

    while(i < 4)
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.Clear("ShortcutWnd.ShortcutWndJoypad.Shortcut" $ string(i + 1));
        ++i;
    }
    return;
}

function HandleShortcutJoypad(string a_Param)
{
    local int OnOff;

    // End:0x95
    if(ParseInt(a_Param, "OnOff", OnOff))
    {
        // End:0x59
        if(1 == OnOff)
        {
            m_IsJoypadOn = true;
            ShowWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".JoypadBtn");            
        }
        else
        {
            // End:0x95
            if(0 == OnOff)
            {
                m_IsJoypadOn = false;
                HideWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".JoypadBtn");
            }
        }
    }
    return;
}

function HandleJoypadLButtonUp(string a_Param)
{
    SetJoypadShortcut(JOYSHORTCUT_Center);
    return;
}

function HandleJoypadLButtonDown(string a_Param)
{
    SetJoypadShortcut(JOYSHORTCUT_Left);
    return;
}

function HandleJoypadRButtonUp(string a_Param)
{
    SetJoypadShortcut(JOYSHORTCUT_Center);
    return;
}

function HandleJoypadRButtonDown(string a_Param)
{
    SetJoypadShortcut(JOYSHORTCUT_Right);
    return;
}

function SetJoypadShortcut(ShortcutWnd.EJoyShortcut a_JoyShortcut)
{
    local int i, nShortcutID;

    switch(a_JoyShortcut)
    {
        // End:0x238
        case JOYSHORTCUT_Left:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex", "L2UI_CH3.ShortcutWnd.joypad2_back_over1");
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetAnchor("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex", "ShortcutWnd.ShortcutWndJoypadExpand", "TopLeft", "TopLeft", 28, 0);
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadLButtonTex", "L2UI_ch3.Joypad.joypad_L_HOLD");
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadRButtonTex", "L2UI_ch3.Joypad.joypad_R");
            nShortcutID = (CurrentShortcutPage * 12) + 4;
            i = 0;

            while(i < 4)
            {
                Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut("ShortcutWnd.ShortcutWndJoypad.Shortcut" $ string(i + 1), nShortcutID);
                nShortcutID++;
                ++i;
            }
            // End:0x697
            break;
        // End:0x460
        case JOYSHORTCUT_Center:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex", "L2UI_CH3.ShortcutWnd.joypad2_back_over2");
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetAnchor("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex", "ShortcutWnd.ShortcutWndJoypadExpand", "TopLeft", "TopLeft", 158, 0);
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadLButtonTex", "L2UI_ch3.Joypad.joypad_L");
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadRButtonTex", "L2UI_ch3.Joypad.joypad_R");
            nShortcutID = CurrentShortcutPage * 12;
            i = 0;

            while(i < 4)
            {
                Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut("ShortcutWnd.ShortcutWndJoypad.Shortcut" $ string(i + 1), nShortcutID);
                nShortcutID++;
                ++i;
            }
            // End:0x697
            break;
        // End:0x694
        case JOYSHORTCUT_Right:
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex", "L2UI_CH3.ShortcutWnd.joypad2_back_over3");
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetAnchor("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex", "ShortcutWnd.ShortcutWndJoypadExpand", "TopLeft", "TopLeft", 288, 0);
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadLButtonTex", "L2UI_ch3.Joypad.joypad_L");
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadRButtonTex", "L2UI_ch3.Joypad.joypad_R_HOLD");
            nShortcutID = (CurrentShortcutPage * 12) + 8;
            i = 0;

            while(i < 4)
            {
                Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut("ShortcutWnd.ShortcutWndJoypad.Shortcut" $ string(i + 1), nShortcutID);
                nShortcutID++;
                ++i;
            }
            // End:0x697
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnClickButton(string a_strID)
{
    switch(a_strID)
    {
        // End:0x1C
        case "PrevBtn":
            OnPrevBtn();
            // End:0x3BE
            break;
        // End:0x31
        case "NextBtn":
            OnNextBtn();
            // End:0x3BE
            break;
        // End:0x47
        case "PrevBtn2":
            OnPrevBtn2();
            // End:0x3BE
            break;
        // End:0x5D
        case "NextBtn2":
            OnNextBtn2();
            // End:0x3BE
            break;
        // End:0x73
        case "PrevBtn3":
            OnPrevBtn3();
            // End:0x3BE
            break;
        // End:0x89
        case "PrevBtn4":
            OnPrevBtn4();
            // End:0x3BE
            break;
        // End:0x9F
        case "PrevBtn5":
            OnPrevBtn5();
            // End:0x3BE
            break;
        // End:0xB5
        case "NextBtn3":
            OnNextBtn3();
            // End:0x3BE
            break;
        // End:0xCB
        case "NextBtn4":
            OnNextBtn4();
            // End:0x3BE
            break;
        // End:0xE1
        case "NextBtn5":
            OnNextBtn5();
            // End:0x3BE
            break;
        // End:0xF7
        case "PrevBtn6":
            OnPrevBtn6();
            // End:0x3BE
            break;
        // End:0x10E
        case "NextBtn6":
            OnNextBtn6();
            // End:0x3BE
            break;
        // End:0xF6
        case "LockBtn":
            OnClickLockBtn();
            // End:0x3BE
            break;
        // End:0x10D
        case "UnlockBtn":
            OnClickUnlockBtn();
            // End:0x3BE
            break;
        // End:0x124
        case "RotateBtn":
            OnRotateBtn();
            // End:0x3BE
            break;
        // End:0x13B
        case "JoypadBtn":
            OnJoypadBtn();
            // End:0x3BE
            break;
        // End:0x152
        case "ExpandBtn":
            OnExpandBtn();
            // End:0x3BE
            break;
        // End:0x16C
        case "ExpandButton":
            OnClickExpandShortcutButton();
            // End:0x3BE
            break;
        // End:0x186
        case "ReduceButton":
            OnClickExpandShortcutButton();
            // End:0x3BE
            break;
        // End:0x21E
        case "btnKeyOption":
            // End:0x1F1
            if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("InterfaceAI_KeySettingWnd"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.HideWindow("InterfaceAI_KeySettingWnd");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("InterfaceAI_KeySettingWnd");
            }
            // End:0x3BE
            break;
        // End:0x3BB
        case "btnMove":
            Me_Horizontal.SetDraggable(!Me_Horizontal.IsDraggable());
            // End:0x30F
            if(Me_Horizontal.IsDraggable())
            {
                btnMove_Horizontal.SetTexture("Was.Savoshortcut_unlock_over", "Was.Savoshortcut_unlock", "Was.Savoshortcut_unlock_over");
                btnMove_Horizontal.SetTooltipCustomType(MakeTooltipSimpleText("Disable shortcut Move"));
                SetOptionBool("Custom", "ShortcutMovable", true);                
            }
            else
            {
                btnMove_Horizontal.SetTexture("Was.Savoshortcut_lock_over", "Was.Savoshortcut_lock", "Was.Savoshortcut_lock_over");
                btnMove_Horizontal.SetTooltipCustomType(MakeTooltipSimpleText("Enable shortcut Move"));
                SetOptionBool("Custom", "ShortcutMovable", false);
            }
            // End:0x3BE
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnPrevBtn()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage - 1;
    // End:0x24
    if(0 > nNewPage)
    {
        nNewPage = 10 - 1;
    }
    SetCurPage(nNewPage);
    return;
}

function OnPrevBtn2()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage2 - 1;
    // End:0x24
    if(0 > nNewPage)
    {
        nNewPage = 10 - 1;
    }
    SetCurPage2(nNewPage);
    return;
}

function OnPrevBtn3()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage3 - 1;
    // End:0x24
    if(0 > nNewPage)
    {
        nNewPage = 10 - 1;
    }
    SetCurPage3(nNewPage);
    return;
}

function OnNextBtn()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage + 1;
    // End:0x21
    if(10 <= nNewPage)
    {
        nNewPage = 0;
    }
    SetCurPage(nNewPage);
    return;
}

function OnNextBtn2()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage2 + 1;
    // End:0x21
    if(10 <= nNewPage)
    {
        nNewPage = 0;
    }
    SetCurPage2(nNewPage);
    return;
}

function OnNextBtn3()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage3 + 1;
    // End:0x21
    if(10 <= nNewPage)
    {
        nNewPage = 0;
    }
    SetCurPage3(nNewPage);
    return;
}

function OnPrevBtn4()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage4 - 1;
    // End:0x24
    if(0 > nNewPage)
    {
        nNewPage = 10 - 1;
    }
    SetCurPage4(nNewPage);
    return;
}

function OnNextBtn4()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage4 + 1;
    // End:0x21
    if(10 <= nNewPage)
    {
        nNewPage = 0;
    }
    SetCurPage4(nNewPage);
    return;
}

function OnPrevBtn5()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage5 - 1;
    // End:0x24
    if(0 > nNewPage)
    {
        nNewPage = 10 - 1;
    }
    SetCurPage5(nNewPage);
    return;
}

function OnNextBtn5()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage5 + 1;
    // End:0x21
    if(10 <= nNewPage)
    {
        nNewPage = 0;
    }
    SetCurPage5(nNewPage);
    return;
}

function OnPrevBtn6()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage6 - 1;
    // End:0x24
    if(0 > nNewPage)
    {
        nNewPage = 10 - 1;
    }
    SetCurPage6(nNewPage);
    return;
}

function OnNextBtn6()
{
    local int nNewPage;

    nNewPage = CurrentShortcutPage6 + 1;
    // End:0x21
    if(10 <= nNewPage)
    {
        nNewPage = 0;
    }
    SetCurPage6(nNewPage);
    return;
}

function OnClickLockBtn()
{
    UnLock();
    return;
}

function OnClickUnlockBtn()
{
    Lock();
    return;
}

function OnRotateBtn()
{
    SetVertical(!m_IsVertical);
    // End:0x128
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
    // End:0x256
    if(m_IsExpand5 == true)
    {
        Expand1();
        Expand2();
        Expand3();
        Expand4();
        Expand5();
    }
    // End:0x26E
    if(m_IsExpand4 == true)
    {
        Expand1();
        Expand2();
        Expand3();
        Expand4();
    }
    // End:0x280
    if(m_IsExpand3 == true)
    {
        Expand1();
        Expand2();
        Expand3();
    }
    // End:0x26E
    if(m_IsExpand2 == true)
    {
        Expand1();
        Expand2();
    }
    // End:0x280
    if(m_IsExpand1 == true)
    {
        Expand1();
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd." $ m_ShortcutWndName);
    ReflowExpandedShortcutWnds();
    AutoPotionsWndPosition();
    return;
}

function OnJoypadBtn()
{
    SetJoypad(!m_IsJoypad);
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd." $ m_ShortcutWndName);
    return;
}

function OnExpandBtn()
{
    SetJoypadExpand(!m_IsJoypadExpand);
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("ShortcutWnd." $ m_ShortcutWndName);
    return;
}

function SetCurPage(int a_nCurPage)
{
    // End:0x1B
    if((0 > a_nCurPage) || 10 <= a_nCurPage)
    {
        return;
    }
    Class'NWindow.ShortcutAPI'.static.SetShortcutPage(a_nCurPage);
    return;
}

function SetCurPage2(int a_nCurPage)
{
    local int i, nShortcutID;

    // End:0x1B
    if((0 > a_nCurPage) || 10 <= a_nCurPage)
    {
        return;
    }
    CurrentShortcutPage2 = a_nCurPage;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1") $ ".PageNumTextBox", string(CurrentShortcutPage2 + 1));
    nShortcutID = CurrentShortcutPage2 * 12;
    i = 0;

    while(i < 12)
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut(((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1") $ ".Shortcut") $ string(i + 1), nShortcutID);
        nShortcutID++;
        ++i;
    }
    return;
}

function SetCurPage3(int a_nCurPage)
{
    local int i, nShortcutID;

    // End:0x1B
    if((0 > a_nCurPage) || 10 <= a_nCurPage)
    {
        return;
    }
    CurrentShortcutPage3 = a_nCurPage;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_2") $ ".PageNumTextBox", string(CurrentShortcutPage3 + 1));
    nShortcutID = CurrentShortcutPage3 * 12;
    i = 0;

    while(i < 12)
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut(((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_2") $ ".Shortcut") $ string(i + 1), nShortcutID);
        nShortcutID++;
        ++i;
    }
    return;
}

function SetCurPage4(int a_nCurPage)
{
    local int i, nShortcutID;

    // End:0x1B
    if((0 > a_nCurPage) || 10 <= a_nCurPage)
    {
        return;
    }
    CurrentShortcutPage4 = a_nCurPage;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_3") $ ".PageNumTextBox", string(CurrentShortcutPage4 + 1));
    nShortcutID = CurrentShortcutPage4 * 12;
    i = 0;

    while(i < 12)
    {
        Debug((((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_3") $ ".Shortcut") $ string(i + 1)) @ string(nShortcutID));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut(((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_3") $ ".Shortcut") $ string(i + 1), nShortcutID);
        nShortcutID++;
        ++i;
    }
    return;
}

function SetCurPage5(int a_nCurPage)
{
    local int i, nShortcutID;

    // End:0x1B
    if((0 > a_nCurPage) || 10 <= a_nCurPage)
    {
        return;
    }
    CurrentShortcutPage5 = a_nCurPage;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_4") $ ".PageNumTextBox", string(CurrentShortcutPage5 + 1));
    nShortcutID = CurrentShortcutPage5 * 12;
    i = 0;

    while(i < 12)
    {
        Debug((((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_4") $ ".Shortcut") $ string(i + 1)) @ string(nShortcutID));
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut(((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_4") $ ".Shortcut") $ string(i + 1), nShortcutID);
        nShortcutID++;
        ++i;
    }
    return;
}

function SetCurPage6(int a_nCurPage)
{
    local int i, nShortcutID;

    // End:0x1B
    if((0 > a_nCurPage) || 10 <= a_nCurPage)
    {
        return;
    }
    CurrentShortcutPage6 = a_nCurPage;
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_5") $ ".PageNumTextBox", string(CurrentShortcutPage6 + 1));
    nShortcutID = CurrentShortcutPage6 * 12;
    i = 0;

    while(i < 12)
    {
        Class'NWindow.UIAPI_SHORTCUTITEMWINDOW'.static.UpdateShortcut(((((((("ShortcutWnd." $ m_ShortcutWndName) $ ".") $ m_ShortcutWndName) $ "_1.") $ m_ShortcutWndName) $ "_5") $ ".Shortcut") $ string(i + 1), nShortcutID);
        nShortcutID++;
        ++i;
    }
    return;
}

function int GetPhysicalPanelPage(int a_nPanel)
{
    switch(a_nPanel)
    {
        case 1:
            return CurrentShortcutPage + 1;
        case 2:
            return CurrentShortcutPage2 + 1;
        case 3:
            return CurrentShortcutPage3 + 1;
        case 4:
            return CurrentShortcutPage4 + 1;
        case 5:
            return CurrentShortcutPage5 + 1;
        case 6:
            return CurrentShortcutPage6 + 1;
        default:
            break;
    }
    return CurrentShortcutPage + 1;
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

function Lock()
{
    m_IsLocked = true;
    SetOptionBool("Game", "IsLockShortcutWnd", true);
    ShowWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".LockBtn");
    HideWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".UnlockBtn");
    return;
}

function UnLock()
{
    m_IsLocked = false;
    SetOptionBool("Game", "IsLockShortcutWnd", false);
    ShowWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".UnlockBtn");
    HideWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".LockBtn");
    return;
}

function SetVertical(bool a_IsVertical)
{
    m_IsVertical = a_IsVertical;
    SetOptionBool("Game", "IsShortcutWndVertical", m_IsVertical);
    ArrangeWnd();
    ExpandWnd();
    return;
}

function SetJoypad(bool a_IsJoypad)
{
    m_IsJoypad = a_IsJoypad;
    ArrangeWnd();
    return;
}

function SetJoypadExpand(bool a_IsJoypadExpand)
{
    m_IsJoypadExpand = a_IsJoypadExpand;
    // End:0xB4
    if(m_IsJoypadExpand)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("ShortcutWnd.ShortcutWndJoypadExpand", "ShortcutWnd.ShortcutWndJoypad", "TopLeft", "TopLeft", 0, 0);
        Class'NWindow.UIAPI_WINDOW'.static.ClearAnchor("ShortcutWnd.ShortcutWndJoypadExpand");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("ShortcutWnd.ShortcutWndJoypad", "ShortcutWnd.ShortcutWndJoypadExpand", "TopLeft", "TopLeft", 0, 0);
        Class'NWindow.UIAPI_WINDOW'.static.ClearAnchor("ShortcutWnd.ShortcutWndJoypad");
    }
    ArrangeWnd();
    return;
}

function ArrangeWnd()
{
    local Rect WindowRect;

    // End:0x140
    if(m_IsJoypad)
    {
        HideWindow("ShortcutWnd.ShortcutWndVertical");
        HideWindow("ShortcutWnd.ShortcutWndHorizontal");
        // End:0xD4
        if(m_IsJoypadExpand)
        {
            HideWindow("ShortcutWnd.ShortcutWndJoypad");
            ShowWindow("ShortcutWnd.ShortcutWndJoypadExpand");
            m_ShortcutWndName = "ShortcutWndJoypadExpand";            
        }
        else
        {
            HideWindow("ShortcutWnd.ShortcutWndJoypadExpand");
            ShowWindow("ShortcutWnd.ShortcutWndJoypad");
            m_ShortcutWndName = "ShortcutWndJoypad";
        }        
    }
    else
    {
        HideWindow("ShortcutWnd.ShortcutWndJoypadExpand");
        HideWindow("ShortcutWnd.ShortcutWndJoypad");
        // End:0x288
        if(m_IsVertical)
        {
            m_ShortcutWndName = "ShortcutWndVertical";
            WindowRect = Class'NWindow.UIAPI_WINDOW'.static.GetRect("ShortcutWnd.ShortcutWndVertical");
            // End:0x235
            if(WindowRect.nY < 0)
            {
                Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndVertical", WindowRect.nX, 0);
            }
            HideWindow("ShortcutWnd.ShortcutWndHorizontal");
            ShowWindow("ShortcutWnd.ShortcutWndVertical");            
        }
        else
        {
            m_ShortcutWndName = "ShortcutWndHorizontal";
            WindowRect = Class'NWindow.UIAPI_WINDOW'.static.GetRect("ShortcutWnd.ShortcutWndHorizontal");
            // End:0x32A
            if(WindowRect.nX < 0)
            {
                Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndHorizontal", 0, WindowRect.nY);
            }
            HideWindow("ShortcutWnd.ShortcutWndVertical");
            ShowWindow("ShortcutWnd.ShortcutWndHorizontal");
        }
        // End:0x3AF
        if(m_IsJoypadOn)
        {
            ShowWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".JoypadBtn");            
        }
        else
        {
            HideWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".JoypadBtn");
        }
    }
    // End:0x3EA
    if(m_IsLocked)
    {
        Lock();        
    }
    else
    {
        UnLock();
    }
    SetCurPage(CurrentShortcutPage);
    SetCurPage2(CurrentShortcutPage2);
    SetCurPage3(CurrentShortcutPage3);
    SetCurPage4(CurrentShortcutPage4);
    SetCurPage5(CurrentShortcutPage5);
    SetCurPage6(CurrentShortcutPage6);
    m_IsShortcutExpand = !m_IsExpand5;
    HandleExpandButton();
    return;
}

function ExpandWnd()
{
    local int ExpandLevel;

    if(m_IsExpand5 == true)
    {
        ExpandLevel = 5;
    }
    else
    {
        if(m_IsExpand4 == true)
        {
            ExpandLevel = 4;
        }
        else
        {
            if(m_IsExpand3 == true)
            {
                ExpandLevel = 3;
            }
            else
            {
                if(m_IsExpand2 == true)
                {
                    ExpandLevel = 2;
                }
                else
                {
                    if(m_IsExpand1 == true)
                    {
                        ExpandLevel = 1;
                    }
                }
            }
        }
    }
    // End:0x9D
    if(ExpandLevel > 0)
    {
        if(ExpandLevel >= 1)
        {
            Expand1();
        }
        if(ExpandLevel >= 2)
        {
            Expand2();
        }
        if(ExpandLevel >= 3)
        {
            Expand3();
        }
        if(ExpandLevel >= 4)
        {
            Expand4();
        }
        if(ExpandLevel >= 5)
        {
            Expand5();
        }
        ReflowExpandedShortcutWnds();
        m_IsShortcutExpand = ExpandLevel < 5;
        HandleExpandButton();
    }
    else
    {
        m_IsShortcutExpand = true;
        Reduce();
    }
    return;
}

function Expand1()
{
    m_IsShortcutExpand = true;
    m_IsExpand1 = true;
    SetOptionBool("Game", "Is1ExpandShortcutWnd", m_IsExpand1);
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndVertical_1");
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndHorizontal_1");
    HandleExpandButton();
    return;
}

function Expand2()
{
    m_IsShortcutExpand = true;
    m_IsExpand2 = true;
    SetOptionBool("Game", "Is2ExpandShortcutWnd", m_IsExpand2);
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndVertical_2");
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndHorizontal_2");
    HandleExpandButton();
    return;
}

function Expand3()
{
    m_IsShortcutExpand = true;
    m_IsExpand3 = true;
    SetOptionBool("Game", "Is3ExpandShortcutWnd", m_IsExpand3);
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndVertical_3");
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndHorizontal_3");
    HandleExpandButton();
    return;
}

function Expand4()
{
    m_IsShortcutExpand = true;
    m_IsExpand4 = true;
    SetOptionBool("Game", "Is4ExpandShortcutWnd", m_IsExpand4);
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndVertical_4");
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndHorizontal_4");
    HandleExpandButton();
    return;
}

function Expand5()
{
    m_IsShortcutExpand = false;
    m_IsExpand5 = true;
    SetOptionBool("Game", "Is5ExpandShortcutWnd", m_IsExpand5);
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndVertical_5");
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("ShortcutWnd.ShortcutWndHorizontal_5");
    HandleExpandButton();
    return;
}

function ReflowExpandedShortcutWnds()
{
    local Rect BaseRect;

    if(m_IsJoypad)
    {
        return;
    }
    BaseRect = Class'NWindow.UIAPI_WINDOW'.static.GetRect("ShortcutWnd." $ m_ShortcutWndName);
    if(m_IsVertical)
    {
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndVertical_1", BaseRect.nX - 46, BaseRect.nY);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndVertical_2", BaseRect.nX - 92, BaseRect.nY);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndVertical_3", BaseRect.nX - 138, BaseRect.nY);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndVertical_4", BaseRect.nX - 184, BaseRect.nY);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndVertical_5", BaseRect.nX - 230, BaseRect.nY);
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndHorizontal_1", BaseRect.nX, BaseRect.nY - 46);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndHorizontal_2", BaseRect.nX, BaseRect.nY - 92);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndHorizontal_3", BaseRect.nX, BaseRect.nY - 138);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndHorizontal_4", BaseRect.nX, BaseRect.nY - 184);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("ShortcutWnd.ShortcutWndHorizontal_5", BaseRect.nX, BaseRect.nY - 230);
    }
    return;
}

function Reduce()
{
    m_IsShortcutExpand = true;
    m_IsExpand1 = false;
    m_IsExpand2 = false;
    m_IsExpand3 = false;
    m_IsExpand4 = false;
    m_IsExpand5 = false;
    SetOptionBool("Game", "Is1ExpandShortcutWnd", m_IsExpand1);
    SetOptionBool("Game", "Is2ExpandShortcutWnd", m_IsExpand2);
    SetOptionBool("Game", "Is3ExpandShortcutWnd", m_IsExpand3);
    SetOptionBool("Game", "Is4ExpandShortcutWnd", m_IsExpand4);
    SetOptionBool("Game", "Is5ExpandShortcutWnd", m_IsExpand5);
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndVertical_1");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndVertical_2");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndVertical_3");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndVertical_4");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndVertical_5");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndHorizontal_1");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndHorizontal_2");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndHorizontal_3");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndHorizontal_4");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("ShortcutWnd.ShortcutWndHorizontal_5");
    HandleExpandButton();
    return;
}

function OnClickExpandShortcutButton()
{
    // End:0x12
    if(m_IsExpand5)
    {
        Reduce();        
    }
    else
    {
        // End:0x24
        if(m_IsExpand4)
        {
            Expand5();            
        }
        else
        {
            if(m_IsExpand3)
            {
                Expand4();            
            }
            else
            {
                // End:0x36
                if(m_IsExpand2)
                {
                    Expand3();                
                }
                else
                {
                    if(m_IsExpand1)
                    {
                        Expand2();                
                    }
                    else
                    {
                        Expand1();
                    }
                }
            }
        }
    }
    AutoPotionsWndPosition();
    ReflowExpandedShortcutWnds();
    return;
}

function HandleExpandButton()
{
    // End:0x64
    if(m_IsShortcutExpand)
    {
        ShowWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".ExpandButton");
        HideWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".ReduceButton");        
    }
    else
    {
        HideWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".ExpandButton");
        ShowWindow(("ShortcutWnd." $ m_ShortcutWndName) $ ".ReduceButton");
    }
    return;
}

function AutoPotionsWndPosition()
{
    // End:0x821
    if(!m_IsVertical)
    {
        // End:0x13A
        if(IsShowWindow("ShortcutWndHorizontal_5"))
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoPotionsWnd", "ShortcutWnd.ShortcutWndHorizontal_5", "TopRight", "TopRight", -1, -29);
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillWnd", "ShortcutWnd.ShortcutWndHorizontal_5", "TopLeft", "TopLeft", 101, -29);
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoShotItemWnd", "ShortcutWnd.ShortcutWndHorizontal_5", "TopLeft", "TopLeft", 16, -29);
            if(GetOptionBool("Custom", "HideAutoBuff"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "ShortcutWnd.ShortcutWndHorizontal_5", "TopLeft", "TopLeft", 101, -29);                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "AutoSkillWnd", "TopLeft", "TopLeft", 0, -30);
            }
        }
        else
        {
            if(IsShowWindow("ShortcutWndHorizontal_4"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoPotionsWnd", "ShortcutWnd.ShortcutWndHorizontal_4", "TopRight", "TopRight", -1, -29);
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillWnd", "ShortcutWnd.ShortcutWndHorizontal_4", "TopLeft", "TopLeft", 101, -29);
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoShotItemWnd", "ShortcutWnd.ShortcutWndHorizontal_4", "TopLeft", "TopLeft", 16, -29);
                if(GetOptionBool("Custom", "HideAutoBuff"))
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "ShortcutWnd.ShortcutWndHorizontal_4", "TopLeft", "TopLeft", 101, -29);                    
                }
                else
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "AutoSkillWnd", "TopLeft", "TopLeft", 0, -30);
                }
            }
            else
            {
        // End:0x213
        if(IsShowWindow("ShortcutWndHorizontal_3"))
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoPotionsWnd", "ShortcutWnd.ShortcutWndHorizontal_3", "TopRight", "TopRight", -1, -29);
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillWnd", "ShortcutWnd.ShortcutWndHorizontal_3", "TopLeft", "TopLeft", 101, -29);
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoShotItemWnd", "ShortcutWnd.ShortcutWndHorizontal_3", "TopLeft", "TopLeft", 16, -29);
            // End:0x1C9
            if(GetOptionBool("Custom", "HideAutoBuff"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "ShortcutWnd.ShortcutWndHorizontal_3", "TopLeft", "TopLeft", 101, -29);                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "AutoSkillWnd", "TopLeft", "TopLeft", 0, -30);
            }            
        }
        else
        {
            // End:0x41B
            if(IsShowWindow("ShortcutWndHorizontal_2"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoPotionsWnd", "ShortcutWnd.ShortcutWndHorizontal_2", "TopRight", "TopRight", -1, -29);
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillWnd", "ShortcutWnd.ShortcutWndHorizontal_2", "TopLeft", "TopLeft", 101, -29);
                Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoShotItemWnd", "ShortcutWnd.ShortcutWndHorizontal_2", "TopLeft", "TopLeft", 16, -29);
                // End:0x3D1
                if(GetOptionBool("Custom", "HideAutoBuff"))
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "ShortcutWnd.ShortcutWndHorizontal_2", "TopLeft", "TopLeft", 101, -29);                    
                }
                else
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "AutoSkillWnd", "TopLeft", "TopLeft", 0, -30);
                }                
            }
            else
            {
                // End:0x623
                if(IsShowWindow("ShortcutWndHorizontal_1"))
                {
                    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoPotionsWnd", "ShortcutWnd.ShortcutWndHorizontal_1", "TopRight", "TopRight", -1, -29);
                    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillWnd", "ShortcutWnd.ShortcutWndHorizontal_1", "TopLeft", "TopLeft", 101, -29);
                    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoShotItemWnd", "ShortcutWnd.ShortcutWndHorizontal_1", "TopLeft", "TopLeft", 16, -29);
                    // End:0x5D9
                    if(GetOptionBool("Custom", "HideAutoBuff"))
                    {
                        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "ShortcutWnd.ShortcutWndHorizontal_1", "TopLeft", "TopLeft", 101, -29);                        
                    }
                    else
                    {
                        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "AutoSkillWnd", "TopLeft", "TopLeft", 0, -30);
                    }                    
                }
                else
                {
                    // End:0x81E
                    if(IsShowWindow("ShortcutWndHorizontal"))
                    {
                        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoPotionsWnd", "ShortcutWnd.ShortcutWndHorizontal", "TopRight", "TopRight", -1, -29);
                        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillWnd", "ShortcutWnd.ShortcutWndHorizontal", "TopLeft", "TopLeft", 101, -29);
                        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoShotItemWnd", "ShortcutWnd.ShortcutWndHorizontal", "TopLeft", "TopLeft", 16, -29);
                        // End:0x7D7
                        if(GetOptionBool("Custom", "HideAutoBuff"))
                        {
                            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "ShortcutWnd.ShortcutWndHorizontal", "TopLeft", "TopLeft", 101, -29);                            
                        }
                        else
                        {
                            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "AutoSkillWnd", "TopLeft", "TopLeft", 0, -30);
                        }
                    }
                }
            }
        }        
            }
        }
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoPotionsWnd", "Menu", "TopRight", "TopRight", -180, -55);
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillWnd", "Menu", "TopRight", "TopRight", -230, -25);
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoShotItemWnd", "Menu", "TopRight", "TopRight", -402, -86);
        // End:0x950
        if(GetOptionBool("Custom", "HideAutoBuff"))
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "Menu", "TopRight", "TopRight", -230, -25);            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoSkillSpamWnd", "AutoSkillWnd", "TopLeft", "TopLeft", 0, -30);
        }
    }
    return;
}

function OnDropItemSource(string strTarget, ItemInfo infItem)
{
    return;
}

function DebugMessage(string Message)
{
    local ChatWindowHandle NormalChat;
    local Color Color;

    NormalChat = ChatWindowHandle(GetHandle("ChatWnd.NormalChat"));
    Color.R = byte(255);
    Color.G = 0;
    Color.B = 0;
    Color.A = byte(255);
    NormalChat.AddString(Message, Color);
    return;
}

function HandleShortcutCommand(string a_Param)
{
    local string Command;

    // End:0x7AE
    if(ParseString(a_Param, "Command", Command))
    {
        switch(Command)
        {
            // End:0x4A
            case "MyShortcutItem11":
                UseShortcutItem(CurrentShortcutPage + 1, 1);
                // End:0x7AE
                break;
            // End:0x72
            case "MyShortcutItem12":
                UseShortcutItem(CurrentShortcutPage + 1, 2);
                // End:0x7AE
                break;
            // End:0x9A
            case "MyShortcutItem13":
                UseShortcutItem(CurrentShortcutPage + 1, 3);
                // End:0x7AE
                break;
            // End:0xC2
            case "MyShortcutItem14":
                UseShortcutItem(CurrentShortcutPage + 1, 4);
                // End:0x7AE
                break;
            // End:0xEA
            case "MyShortcutItem15":
                UseShortcutItem(CurrentShortcutPage + 1, 5);
                // End:0x7AE
                break;
            // End:0x112
            case "MyShortcutItem16":
                UseShortcutItem(CurrentShortcutPage + 1, 6);
                // End:0x7AE
                break;
            // End:0x13A
            case "MyShortcutItem17":
                UseShortcutItem(CurrentShortcutPage + 1, 7);
                // End:0x7AE
                break;
            // End:0x162
            case "MyShortcutItem18":
                UseShortcutItem(CurrentShortcutPage + 1, 8);
                // End:0x7AE
                break;
            // End:0x18A
            case "MyShortcutItem19":
                UseShortcutItem(CurrentShortcutPage + 1, 9);
                // End:0x7AE
                break;
            // End:0x1B3
            case "MyShortcutItem110":
                UseShortcutItem(CurrentShortcutPage + 1, 10);
                // End:0x7AE
                break;
            // End:0x1DC
            case "MyShortcutItem111":
                UseShortcutItem(CurrentShortcutPage + 1, 11);
                // End:0x7AE
                break;
            // End:0x205
            case "MyShortcutItem112":
                UseShortcutItem(CurrentShortcutPage + 1, 12);
                // End:0x7AE
                break;
            // End:0x22C
            case "MyShortcutItem21":
                UseShortcutItem(CurrentShortcutPage2 + 1, 1);
                // End:0x7AE
                break;
            // End:0x254
            case "MyShortcutItem22":
                UseShortcutItem(CurrentShortcutPage2 + 1, 2);
                // End:0x7AE
                break;
            // End:0x27C
            case "MyShortcutItem23":
                UseShortcutItem(CurrentShortcutPage2 + 1, 3);
                // End:0x7AE
                break;
            // End:0x2A4
            case "MyShortcutItem24":
                UseShortcutItem(CurrentShortcutPage2 + 1, 4);
                // End:0x7AE
                break;
            // End:0x2CC
            case "MyShortcutItem25":
                UseShortcutItem(CurrentShortcutPage2 + 1, 5);
                // End:0x7AE
                break;
            // End:0x2F4
            case "MyShortcutItem26":
                UseShortcutItem(CurrentShortcutPage2 + 1, 6);
                // End:0x7AE
                break;
            // End:0x31C
            case "MyShortcutItem27":
                UseShortcutItem(CurrentShortcutPage2 + 1, 7);
                // End:0x7AE
                break;
            // End:0x344
            case "MyShortcutItem28":
                UseShortcutItem(CurrentShortcutPage2 + 1, 8);
                // End:0x7AE
                break;
            // End:0x36C
            case "MyShortcutItem29":
                UseShortcutItem(CurrentShortcutPage2 + 1, 9);
                // End:0x7AE
                break;
            // End:0x395
            case "MyShortcutItem210":
                UseShortcutItem(CurrentShortcutPage2 + 1, 10);
                // End:0x7AE
                break;
            // End:0x3BE
            case "MyShortcutItem211":
                UseShortcutItem(CurrentShortcutPage2 + 1, 11);
                // End:0x7AE
                break;
            // End:0x3E7
            case "MyShortcutItem212":
                UseShortcutItem(CurrentShortcutPage2 + 1, 12);
                // End:0x7AE
                break;
            // End:0x40E
            case "MyShortcutItem31":
                UseShortcutItem(CurrentShortcutPage3 + 1, 1);
                // End:0x7AE
                break;
            // End:0x436
            case "MyShortcutItem32":
                UseShortcutItem(CurrentShortcutPage3 + 1, 2);
                // End:0x7AE
                break;
            // End:0x45E
            case "MyShortcutItem33":
                UseShortcutItem(CurrentShortcutPage3 + 1, 3);
                // End:0x7AE
                break;
            // End:0x486
            case "MyShortcutItem34":
                UseShortcutItem(CurrentShortcutPage3 + 1, 4);
                // End:0x7AE
                break;
            // End:0x4AE
            case "MyShortcutItem35":
                UseShortcutItem(CurrentShortcutPage3 + 1, 5);
                // End:0x7AE
                break;
            // End:0x4D6
            case "MyShortcutItem36":
                UseShortcutItem(CurrentShortcutPage3 + 1, 6);
                // End:0x7AE
                break;
            // End:0x4FE
            case "MyShortcutItem37":
                UseShortcutItem(CurrentShortcutPage3 + 1, 7);
                // End:0x7AE
                break;
            // End:0x526
            case "MyShortcutItem38":
                UseShortcutItem(CurrentShortcutPage3 + 1, 8);
                // End:0x7AE
                break;
            // End:0x54E
            case "MyShortcutItem39":
                UseShortcutItem(CurrentShortcutPage3 + 1, 9);
                // End:0x7AE
                break;
            // End:0x577
            case "MyShortcutItem310":
                UseShortcutItem(CurrentShortcutPage3 + 1, 10);
                // End:0x7AE
                break;
            // End:0x5A0
            case "MyShortcutItem311":
                UseShortcutItem(CurrentShortcutPage3 + 1, 11);
                // End:0x7AE
                break;
            // End:0x5C9
            case "MyShortcutItem312":
                UseShortcutItem(CurrentShortcutPage3 + 1, 12);
                // End:0x7AE
                break;
            // End:0x5F0
            case "MyShortcutItem41":
                UseShortcutItem(CurrentShortcutPage4 + 1, 1);
                // End:0x7AE
                break;
            // End:0x618
            case "MyShortcutItem42":
                UseShortcutItem(CurrentShortcutPage4 + 1, 2);
                // End:0x7AE
                break;
            // End:0x640
            case "MyShortcutItem43":
                UseShortcutItem(CurrentShortcutPage4 + 1, 3);
                // End:0x7AE
                break;
            // End:0x668
            case "MyShortcutItem44":
                UseShortcutItem(CurrentShortcutPage4 + 1, 4);
                // End:0x7AE
                break;
            // End:0x690
            case "MyShortcutItem45":
                UseShortcutItem(CurrentShortcutPage4 + 1, 5);
                // End:0x7AE
                break;
            // End:0x6B8
            case "MyShortcutItem46":
                UseShortcutItem(CurrentShortcutPage4 + 1, 6);
                // End:0x7AE
                break;
            // End:0x6E0
            case "MyShortcutItem47":
                UseShortcutItem(CurrentShortcutPage4 + 1, 7);
                // End:0x7AE
                break;
            // End:0x708
            case "MyShortcutItem48":
                UseShortcutItem(CurrentShortcutPage4 + 1, 8);
                // End:0x7AE
                break;
            // End:0x730
            case "MyShortcutItem49":
                UseShortcutItem(CurrentShortcutPage4 + 1, 9);
                // End:0x7AE
                break;
            // End:0x759
            case "MyShortcutItem410":
                UseShortcutItem(CurrentShortcutPage4 + 1, 10);
                // End:0x7AE
                break;
            // End:0x782
            case "MyShortcutItem411":
                UseShortcutItem(CurrentShortcutPage4 + 1, 11);
                // End:0x7AE
                break;
            // End:0x7AB
            case "MyShortcutItem412":
                UseShortcutItem(CurrentShortcutPage4 + 1, 12);
                // End:0x7AE
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        return;
    }
}

function UseShortcutItem(int page, int Num)
{
    ExecuteCommand((("/useshortcut " $ string(page)) $ " ") $ string(Num));
    return;
}
