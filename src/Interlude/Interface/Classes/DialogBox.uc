class DialogBox extends UICommonAPI;

var string m_strTargetScript;
var string m_strEditMessage;
var UICommonAPI.EDialogType m_Type;
var int m_ID;
var bool m_bInUse;
var int m_paramInt;
var int m_reservedInt;
var int m_reservedInt2;
var int m_reservedInt3;
var int m_dialogEditMaxLength;
var int m_dialogEditMaxLength_prev;
var UICommonAPI.DialogDefaultAction m_defaultAction;
var TextBoxHandle DialogReadingText;
var EditBoxHandle m_dialogEdit;

function ShowDialog(UICommonAPI.EDialogType Style, string Message, string Target)
{
    // End:0x2B
    if(m_bInUse)
    {
        Debug("Error!! DialogBox in Use");
        return;
    }
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox");
    SetWindowStyle(Style);
    SetMessage(Message);
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("DialogBox");
    // End:0xCE
    if(m_dialogEdit.IsShowWindow())
    {
        m_dialogEdit.SetFocus();
        // End:0xCE
        if(m_dialogEditMaxLength != -1)
        {
            m_dialogEditMaxLength_prev = m_dialogEdit.GetMaxLength();
            m_dialogEdit.SetMaxLength(m_dialogEditMaxLength);
        }
    }
    m_strTargetScript = Target;
    m_bInUse = true;
    return;
}

function HideDialog()
{
    HideWindow("DialogBox");
    Initialize();
    return;
}

function OnKeyUp(Interactions.EInputKey nKey)
{
    // End:0x16
    if(int(nKey) == 13)
    {
        DoDefaultAction();
    }
    return;
}

function SetDefaultAction(UICommonAPI.DialogDefaultAction defaultAction)
{
    Debug("DialogBox SetDefaultAction " $ string(defaultAction));
    m_defaultAction = defaultAction;
    return;
}

function string GetTarget()
{
    return m_strTargetScript;
}

function string GetEditMessage()
{
    return m_strEditMessage;
}

function SetEditMessage(string strMsg)
{
    m_dialogEdit.SetString(strMsg);
    return;
}

function int GetID()
{
    return m_ID;
}

function SetID(int Id)
{
    m_ID = Id;
    return;
}

function SetEditType(string strType)
{
    m_dialogEdit.SetEditType(strType);
    return;
}

function SetParamInt(int param)
{
    m_paramInt = param;
    return;
}

function SetReservedInt(int Value)
{
    m_reservedInt = Value;
    return;
}

function SetReservedInt2(int Value)
{
    m_reservedInt2 = Value;
    return;
}

function SetReservedInt3(int Value)
{
    m_reservedInt3 = Value;
    return;
}

function int GetReservedInt()
{
    return m_reservedInt;
}

function int GetReservedInt2()
{
    return m_reservedInt2;
}

function int GetReservedInt3()
{
    return m_reservedInt3;
}

function SetEditBoxMaxLength(int maxLength)
{
    // End:0x16
    if(maxLength >= 0)
    {
        m_dialogEditMaxLength = maxLength;
    }
    return;
}

function OnLoad()
{
    DialogReadingText = TextBoxHandle(GetHandle("DialogBox.DialogReadingText"));
    m_dialogEdit = EditBoxHandle(GetHandle("DialogBox.DialogBoxEdit"));
    Initialize();
    SetButtonName(1337, 1342);
    SetMessage("Message uninitialized");
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x14
        case "OKButton":
        // End:0x30
        case "CenterOKButton":
            HandleOK();
            // End:0xD6
            break;
        // End:0x4A
        case "CancelButton":
            HandleCancel();
            // End:0xD6
            break;
        // End:0x53
        case "num0":
        // End:0x5C
        case "num1":
        // End:0x65
        case "num2":
        // End:0x6E
        case "num3":
        // End:0x77
        case "num4":
        // End:0x80
        case "num5":
        // End:0x89
        case "num6":
        // End:0x92
        case "num7":
        // End:0x9B
        case "num8":
        // End:0xA4
        case "num9":
        // End:0xAF
        case "numAll":
        // End:0xB9
        case "numBS":
        // End:0xD0
        case "numC":
            HandleNumberClick(strID);
            // End:0xD6
            break;
        // End:0xFFFF
        default:
            // End:0xD6
            break;
            break;
    }
    return;
}

function OnHide()
{
    // End:0x39
    if(int(m_Type) == 7)
    {
        Class'NWindow.UIAPI_PROGRESSCTRL'.static.Stop("DialogBox.DialogProgress");
    }
    SetEditType("normal");
    SetEditMessage("");
    // End:0x7D
    if(m_dialogEditMaxLength != -1)
    {
        m_dialogEditMaxLength = -1;
        m_dialogEdit.SetMaxLength(m_dialogEditMaxLength_prev);
    }
    m_dialogEdit.Clear();
    return;
}

function OnChangeEditBox(string strID)
{
    local string strInput;

    // End:0x76
    if(strID == "DialogBoxEdit")
    {
        // End:0x76
        if(int(m_Type) == 6)
        {
            DialogReadingText.SetText("");
            strInput = m_dialogEdit.GetString();
            // End:0x76
            if(Len(strInput) > 0)
            {
                DialogReadingText.SetText(ConvertNumToTextNoAdena(strInput));
            }
        }
    }
    return;
}

function Initialize()
{
    m_strTargetScript = "";
    m_bInUse = false;
    SetEditType("normal");
    m_paramInt = 0;
    m_reservedInt = 0;
    m_reservedInt2 = 0;
    m_dialogEditMaxLength = -1;
    SetDefaultAction(EDefaultNone);
    return;
}

function HideAll()
{
    m_dialogEdit.HideWindow();
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("DialogBox.OKButton");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("DialogBox.CancelButton");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("DialogBox.CenterOKButton");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("DialogBox.NumberPad");
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("DialogBox.DialogProgress");
    return;
}

function SetWindowStyle(UICommonAPI.EDialogType Style)
{
    local Rect bodyRect, numpadRect;

    HideAll();
    bodyRect = Class'NWindow.UIAPI_WINDOW'.static.GetRect("DialogBox.DialogBody");
    numpadRect = Class'NWindow.UIAPI_WINDOW'.static.GetRect("DialogBox.NumberPad");
    m_Type = Style;
    switch(Style)
    {
        // End:0xED
        case DIALOG_OKCancel:
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.OKButton");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.CancelButton");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("DialogBox", bodyRect.nWidth, bodyRect.nHeight);
            // End:0x607
            break;
        // End:0x14C
        case DIALOG_OK:
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.CenterOKButton");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("DialogBox", bodyRect.nWidth, bodyRect.nHeight);
            // End:0x607
            break;
        // End:0x21E
        case DIALOG_OKCancelInput:
            m_dialogEdit.ShowWindow();
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("DialogBox.DialogReadingText", "");
            Debug("what the hell");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.OKButton");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.CancelButton");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("DialogBox", bodyRect.nWidth, bodyRect.nHeight);
            // End:0x607
            break;
        // End:0x2BA
        case DIALOG_OKInput:
            m_dialogEdit.ShowWindow();
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("DialogBox.DialogReadingText", "");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.CenterOKButton");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("DialogBox", bodyRect.nWidth, bodyRect.nHeight);
            // End:0x607
            break;
        // End:0x33A
        case DIALOG_Warning:
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.OKButton");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.CancelButton");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("DialogBox", bodyRect.nWidth, bodyRect.nHeight);
            // End:0x607
            break;
        // End:0x399
        case DIALOG_Notice:
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.CenterOKButton");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("DialogBox", bodyRect.nWidth, bodyRect.nHeight);
            // End:0x607
            break;
        // End:0x494
        case DIALOG_NumberPad:
            m_dialogEdit.ShowWindow();
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("DialogBox.DialogReadingText", "");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.OKButton");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.CancelButton");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.NumberPad");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("DialogBox", bodyRect.nWidth + numpadRect.nWidth, bodyRect.nHeight);
            SetEditType("number");
            // End:0x607
            break;
        // End:0x604
        case DIALOG_Progress:
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.OKButton");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.CancelButton");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("DialogBox.DialogProgress");
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("DialogBox", bodyRect.nWidth, bodyRect.nHeight);
            // End:0x581
            if(m_paramInt == 0)
            {
                Debug("DialogBox Error!! DIALOG_Progress needs parameter");                
            }
            else
            {
                Class'NWindow.UIAPI_PROGRESSCTRL'.static.SetProgressTime("DialogBox.DialogProgress", m_paramInt);
                Class'NWindow.UIAPI_PROGRESSCTRL'.static.Reset("DialogBox.DialogProgress");
                Class'NWindow.UIAPI_PROGRESSCTRL'.static.Start("DialogBox.DialogProgress");
            }
            // End:0x607
            break;
        // End:0xFFFF
        default:
            break;
    }
    // End:0x654
    if(int(Style) == 7)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("DialogBox", "", "BottomCenter", "BottomCenter", 0, 0);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("DialogBox", "", "CenterCenter", "CenterCenter", 0, 0);
    }
    return;
}

function SetMessage(string strMessage)
{
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("DialogBox.DialogText", strMessage);
    return;
}

function SetButtonName(int indexOK, int indexCancel)
{
    Class'NWindow.UIAPI_BUTTON'.static.SetButtonName("DialogBox.OKButton", indexOK);
    Class'NWindow.UIAPI_BUTTON'.static.SetButtonName("DialogBox.CenterOKButton", indexOK);
    Class'NWindow.UIAPI_BUTTON'.static.SetButtonName("DialogBox.CancelButton", indexCancel);
    return;
}

function HandleOK()
{
    // End:0x2A
    if(m_dialogEdit.IsShowWindow())
    {
        m_strEditMessage = m_dialogEdit.GetString();        
    }
    else
    {
        m_strEditMessage = "";
    }
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("DialogBox");
    m_bInUse = false;
    ExecuteEvent(1710);
    return;
}

function HandleCancel()
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("DialogBox");
    m_bInUse = false;
    ExecuteEvent(1720);
    return;
}

function HandleNumberClick(string strID)
{
    switch(strID)
    {
        // End:0x25
        case "num0":
            m_dialogEdit.AddString("0");
            // End:0x1A2
            break;
        // End:0x43
        case "num1":
            m_dialogEdit.AddString("1");
            // End:0x1A2
            break;
        // End:0x61
        case "num2":
            m_dialogEdit.AddString("2");
            // End:0x1A2
            break;
        // End:0x7F
        case "num3":
            m_dialogEdit.AddString("3");
            // End:0x1A2
            break;
        // End:0x9D
        case "num4":
            m_dialogEdit.AddString("4");
            // End:0x1A2
            break;
        // End:0xBB
        case "num5":
            m_dialogEdit.AddString("5");
            // End:0x1A2
            break;
        // End:0xD9
        case "num6":
            m_dialogEdit.AddString("6");
            // End:0x1A2
            break;
        // End:0xF7
        case "num7":
            m_dialogEdit.AddString("7");
            // End:0x1A2
            break;
        // End:0x115
        case "num8":
            m_dialogEdit.AddString("8");
            // End:0x1A2
            break;
        // End:0x133
        case "num9":
            m_dialogEdit.AddString("9");
            // End:0x1A2
            break;
        // End:0x162
        case "numAll":
            // End:0x15F
            if(m_paramInt >= 0)
            {
                m_dialogEdit.SetString(string(m_paramInt));
            }
            // End:0x1A2
            break;
        // End:0x17E
        case "numBS":
            m_dialogEdit.SimulateBackspace();
            // End:0x1A2
            break;
        // End:0x19C
        case "numC":
            m_dialogEdit.SetString("0");
            // End:0x1A2
            break;
        // End:0xFFFF
        default:
            // End:0x1A2
            break;
            break;
    }
    return;
}

function OnProgressTimeUp(string strID)
{
    Debug("OnProgressTimeUp");
    // End:0x38
    if(strID == "DialogProgress")
    {
        HandleCancel();
    }
    return;
}

function DoDefaultAction()
{
    Debug("DialogBox DoDefaultAction");
    switch(m_defaultAction)
    {
        // End:0x36
        case EDefaultOK:
            HandleOK();
            // End:0x58
            break;
        // End:0x44
        case EDefaultCancel:
            HandleCancel();
            // End:0x58
            break;
        // End:0x52
        case EDefaultNone:
            HandleCancel();
            // End:0x58
            break;
        // End:0xFFFF
        default:
            // End:0x58
            break;
            break;
    }
    SetDefaultAction(EDefaultNone);
    return;
}
