class GMSnoopWnd extends UICommonAPI;

const MAX_GMSnoop = 4;

var int m_SnoopIDList[4];
var WindowHandle m_hSnoopWndList[4];
var TextListBoxHandle m_hSnoopChatWndList[4];
var ButtonHandle m_hCancelButtonList[4];
var CheckBoxHandle m_hCheckBox[28];

function OnLoad()
{
    local int i, j;

    i = 0;
    J0x07:

    // End:0x124 [Loop If]
    if(i < 4)
    {
        m_hSnoopWndList[i] = GetHandle("SnoopWnd" $ string(i + 1));
        m_hSnoopChatWndList[i] = TextListBoxHandle(GetHandle(("SnoopWnd" $ string(i + 1)) $ ".Chat"));
        m_hCancelButtonList[i] = ButtonHandle(GetHandle(("SnoopWnd" $ string(i + 1)) $ ".CancelButton"));
        j = 0;
        J0xB6:

        // End:0x11A [Loop If]
        if(j < 7)
        {
            m_hCheckBox[(i * 7) + j] = CheckBoxHandle(GetHandle((("SnoopWnd" $ string(i + 1)) $ ".CheckBox") $ string(j)));
            ++j;
            // [Loop Continue]
            goto J0xB6;
        }
        ++i;
        // [Loop Continue]
        goto J0x07;
    }
    RegisterEvent(2410);
    ClearAllSnoop();
    return;
}

function OnShow()
{
    local int i;

    i = 0;
    J0x07:

    // End:0x32 [Loop If]
    if(i < 4)
    {
        m_hSnoopWndList[i].HideWindow();
        ++i;
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function OnHide()
{
    return;
}

function OnClickButtonWithHandle(ButtonHandle a_ButtonHandle)
{
    local int i;

    i = 0;
    J0x07:

    // End:0x57 [Loop If]
    if(i < 4)
    {
        // End:0x4D
        if(a_ButtonHandle == m_hCancelButtonList[i])
        {
            Class'NWindow.GMAPI'.static.RequestSnoopEnd(m_SnoopIDList[i]);
            ClearSnoop(i);
        }
        ++i;
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x1D
        case 2410:
            HandleGMSnoop(a_Param);
            // End:0x20
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleGMSnoop(string a_Param)
{
    local int SnoopID;
    local string SnoopName;
    local int CreatureID, Type, SnoopIndex;
    local string CharacterName, chatMessage;
    local WindowHandle hSnoopWnd;
    local TextListBoxHandle hSnoopChatWnd;

    ParseInt(a_Param, "SnoopID", SnoopID);
    ParseString(a_Param, "CharacterName", CharacterName);
    // End:0x71
    if(!GetSnoopWnd(SnoopID, hSnoopWnd, hSnoopChatWnd, SnoopIndex, CharacterName))
    {
        DialogShow(DIALOG_OK, GetSystemMessage(802));
        return;
    }
    ParseString(a_Param, "SnoopName", SnoopName);
    ParseInt(a_Param, "CreatureID", CreatureID);
    ParseInt(a_Param, "Type", Type);
    ParseString(a_Param, "ChatMessage", chatMessage);
    // End:0xFE
    if(!m_hOwnerWnd.IsShowWindow())
    {
        m_hOwnerWnd.ShowWindow();
    }
    hSnoopWnd.ShowWindow();
    // End:0x152
    if(!IsFiltered(EChatType(Type), SnoopIndex))
    {
        hSnoopChatWnd.AddString((CharacterName $ ": ") $ chatMessage, GetColorByType(EChatType(Type)));
    }
    return;
}

function ClearAllSnoop()
{
    local int i;

    i = 0;
    J0x07:

    // End:0x28 [Loop If]
    if(i < 4)
    {
        ClearSnoop(i);
        ++i;
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function ClearSnoop(int a_SnoopIndex)
{
    local int i;
    local bool AllHidden;

    // End:0x0D
    if(0 > a_SnoopIndex)
    {
        return;
    }
    // End:0x1B
    if(4 <= a_SnoopIndex)
    {
        return;
    }
    m_SnoopIDList[a_SnoopIndex] = -1;
    m_hSnoopWndList[a_SnoopIndex].HideWindow();
    m_hSnoopChatWndList[a_SnoopIndex].HideWindow();
    AllHidden = true;
    i = 0;
    J0x65:

    // End:0x9B [Loop If]
    if(i < 4)
    {
        // End:0x91
        if(-1 != m_SnoopIDList[a_SnoopIndex])
        {
            AllHidden = false;
            // [Explicit Break]
            goto J0x9B;
        }
        ++i;
        // [Loop Continue]
        goto J0x65;
    }
    J0x9B:

    // End:0xB3
    if(AllHidden)
    {
        m_hOwnerWnd.HideWindow();
    }
    return;
}

function bool GetSnoopWnd(int a_SnoopID, out WindowHandle a_hSnoopWnd, out TextListBoxHandle a_hSnoopChatWnd, out int a_SnoopIndex, string a_CharacterName)
{
    local int SnoopIndex;

    SnoopIndex = GetSnoopIndexByID(a_SnoopID);
    // End:0x4F
    if(-1 != SnoopIndex)
    {
        a_hSnoopWnd = m_hSnoopWndList[SnoopIndex];
        a_hSnoopChatWnd = m_hSnoopChatWndList[SnoopIndex];
        a_SnoopIndex = SnoopIndex;
        return true;
    }
    SnoopIndex = GetSnoopIndexByID(-1);
    // End:0xD7
    if(-1 != SnoopIndex)
    {
        m_SnoopIDList[SnoopIndex] = a_SnoopID;
        a_hSnoopWnd = m_hSnoopWndList[SnoopIndex];
        a_hSnoopChatWnd = m_hSnoopChatWndList[SnoopIndex];
        a_SnoopIndex = SnoopIndex;
        a_hSnoopWnd.SetWindowTitle((GetSystemString(693) $ " - ") $ a_CharacterName);
        return true;
    }
    return false;
}

function int GetSnoopIndexByID(int a_SnoopID)
{
    local int i;

    i = 0;
    J0x07:

    // End:0x38 [Loop If]
    if(i < 4)
    {
        // End:0x2E
        if(a_SnoopID == m_SnoopIDList[i])
        {
            return i;
        }
        ++i;
        // [Loop Continue]
        goto J0x07;
    }
    return -1;
}

function Color GetColorByType(UIEventManager.EChatType a_Type)
{
    local Color ResultColor;

    ResultColor.A = byte(255);
    switch(a_Type)
    {
        // End:0x47
        case CHAT_SHOUT:
            ResultColor.R = byte(255);
            ResultColor.G = 114;
            ResultColor.B = 0;
            // End:0x16E
            break;
        // End:0x78
        case CHAT_PARTY:
            ResultColor.R = 0;
            ResultColor.G = byte(255);
            ResultColor.B = 0;
            // End:0x16E
            break;
        // End:0xA9
        case CHAT_CLAN:
            ResultColor.R = 125;
            ResultColor.G = 119;
            ResultColor.B = byte(255);
            // End:0x16E
            break;
        // End:0xDC
        case CHAT_TELL:
            ResultColor.R = byte(255);
            ResultColor.G = 0;
            ResultColor.B = byte(255);
            // End:0x16E
            break;
        // End:0x10B
        case CHAT_MARKET:
            ResultColor.R = 234;
            ResultColor.G = 165;
            ResultColor.B = 245;
            // End:0x16E
            break;
        // End:0x13C
        case CHAT_ALLIANCE:
            ResultColor.R = 119;
            ResultColor.G = byte(255);
            ResultColor.B = 153;
            // End:0x16E
            break;
        // End:0x16B
        case CHAT_NORMAL:
            ResultColor.R = 220;
            ResultColor.G = 220;
            ResultColor.B = 220;
            // End:0x16E
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultColor;
}

function bool IsFiltered(UIEventManager.EChatType a_Type, int a_SnoopIndex)
{
    switch(a_Type)
    {
        // End:0x2D
        case CHAT_MARKET:
            // End:0x2A
            if(m_hCheckBox[a_SnoopIndex * 7].IsChecked())
            {
                return false;
            }
            // End:0x12B
            break;
        // End:0x56
        case CHAT_CLAN:
            // End:0x53
            if(m_hCheckBox[(a_SnoopIndex * 7) + 1].IsChecked())
            {
                return false;
            }
            // End:0x12B
            break;
        // End:0x80
        case CHAT_PARTY:
            // End:0x7D
            if(m_hCheckBox[(a_SnoopIndex * 7) + 2].IsChecked())
            {
                return false;
            }
            // End:0x12B
            break;
        // End:0xAA
        case CHAT_SHOUT:
            // End:0xA7
            if(m_hCheckBox[(a_SnoopIndex * 7) + 3].IsChecked())
            {
                return false;
            }
            // End:0x12B
            break;
        // End:0xD4
        case CHAT_TELL:
            // End:0xD1
            if(m_hCheckBox[(a_SnoopIndex * 7) + 4].IsChecked())
            {
                return false;
            }
            // End:0x12B
            break;
        // End:0xFE
        case CHAT_NORMAL:
            // End:0xFB
            if(m_hCheckBox[(a_SnoopIndex * 7) + 5].IsChecked())
            {
                return false;
            }
            // End:0x12B
            break;
        // End:0x128
        case CHAT_ALLIANCE:
            // End:0x125
            if(m_hCheckBox[(a_SnoopIndex * 7) + 6].IsChecked())
            {
                return false;
            }
            // End:0x12B
            break;
        // End:0xFFFF
        default:
            break;
    }
    return true;
}
