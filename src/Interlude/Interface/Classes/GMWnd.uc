class GMWnd extends UICommonAPI;

const DIALOGID_Recall = 0;
const DIALOGID_SendHome = 1;
const DIALOGID_NPCList = 2;
const DIALOGID_ItemList = 3;
const DIALOGID_SkillList = 4;

var Color m_WhiteColor;
var EditBoxHandle m_hEditBox;
var WindowHandle m_hGMwnd;
var WindowHandle m_hGMDetailStatusWnd;
var WindowHandle m_hGMInventoryWnd;
var WindowHandle m_hGMMagicSkillWnd;
var WindowHandle m_hGMQuestWnd;
var WindowHandle m_hGMWarehouseWnd;
var WindowHandle m_hGMClanWnd;
var int m_targetID;

function OnLoad()
{
    RegisterEvent(2280);
    RegisterEvent(1710);
    RegisterEvent(1720);
    RegisterEvent(980);
    m_hGMwnd = GetHandle("GMWnd");
    m_hEditBox = EditBoxHandle(GetHandle("EditBox"));
    m_hGMDetailStatusWnd = GetHandle("GMDetailStatusWnd");
    m_hGMInventoryWnd = GetHandle("GMInventoryWnd");
    m_hGMMagicSkillWnd = GetHandle("GMMagicSkillWnd");
    m_hGMQuestWnd = GetHandle("GMQuestWnd");
    m_hGMWarehouseWnd = GetHandle("GMWarehouseWnd");
    m_hGMClanWnd = GetHandle("GMClanWnd");
    m_WhiteColor.R = 220;
    m_WhiteColor.G = 220;
    m_WhiteColor.B = 220;
    m_WhiteColor.A = byte(255);
    m_targetID = 0;
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x18
        case 2280:
            HandleShowGMWnd();
            // End:0x4E
            break;
        // End:0x29
        case 1710:
            HandleDialogOK();
            // End:0x4E
            break;
        // End:0x3A
        case 1720:
            HandleDialogCancel();
            // End:0x4E
            break;
        // End:0x4B
        case 980:
            HandleTargetUpdate();
            // End:0x4E
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleShowGMWnd()
{
    // End:0x24
    if(m_hOwnerWnd.IsShowWindow())
    {
        m_hOwnerWnd.HideWindow();        
    }
    else
    {
        m_hOwnerWnd.ShowWindow();
        m_hGMwnd.SetFocus();
    }
    return;
}

function HandleDialogOK()
{
    // End:0x0D
    if(!DialogIsMine())
    {
        return;
    }
    switch(DialogGetID())
    {
        // End:0x22
        case 0:
            Recall();
            // End:0x32
            break;
        // End:0x2F
        case 1:
            SendHome();
            // End:0x32
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleTargetUpdate()
{
    local int m_nowTargetID;
    local UserInfo Info;

    m_nowTargetID = Class'NWindow.UIDATA_TARGET'.static.GetTargetID();
    // End:0x26
    if(m_nowTargetID == m_targetID)
    {
        return;
    }
    // End:0x4B
    if(m_nowTargetID < 1)
    {
        m_targetID = 0;
        m_hEditBox.SetString("");
        return;
    }
    GetTargetInfo(Info);
    // End:0x8D
    if((m_nowTargetID > 0) && Info.bNpc == false)
    {
        m_hEditBox.SetString(Info.Name);
    }
    m_targetID = m_nowTargetID;
    return;
}

function HandleDialogCancel()
{
    // End:0x0D
    if(!DialogIsMine())
    {
        return;
    }
    return;
}

function OnClickButton(string a_ButtonID)
{
    switch(a_ButtonID)
    {
        // End:0x1F
        case "TeleButton":
            OnClickTeleButton();
            // End:0x1DE
            break;
        // End:0x37
        case "MoveButton":
            OnClickMoveButton();
            // End:0x1DE
            break;
        // End:0x51
        case "RecallButton":
            OnClickRecallButton();
            // End:0x1DE
            break;
        // End:0x71
        case "DetailStatusButton":
            OnClickDetailStatusButton();
            // End:0x1DE
            break;
        // End:0x8E
        case "InventoryButton":
            OnClickInventoryButton();
            // End:0x1DE
            break;
        // End:0xAC
        case "MagicSkillButton":
            OnClickMagicSkillButton();
            // End:0x1DE
            break;
        // End:0xC5
        case "QuestButton":
            OnClickQuestButton();
            // End:0x1DE
            break;
        // End:0xDD
        case "InfoButton":
            OnClickInfoButton();
            // End:0x1DE
            break;
        // End:0xF6
        case "StoreButton":
            OnClickStoreButton();
            // End:0x1DE
            break;
        // End:0x10E
        case "ClanButton":
            OnClickClanButton();
            // End:0x1DE
            break;
        // End:0x12A
        case "PetitionButton":
            OnClickPetitionButton();
            // End:0x1DE
            break;
        // End:0x146
        case "SendHomeButton":
            OnClickSendHomeButton();
            // End:0x1DE
            break;
        // End:0x161
        case "NPCListButton":
            OnClickNPCListButton();
            // End:0x1DE
            break;
        // End:0x17D
        case "ItemListButton":
            OnClickItemListButton();
            // End:0x1DE
            break;
        // End:0x19A
        case "SkillListButton":
            OnClickSkillListButton();
            // End:0x1DE
            break;
        // End:0x1BB
        case "ForcePetitionButton":
            OnClickForcePetitionButton();
            // End:0x1DE
            break;
        // End:0x1DB
        case "ChangeServerButton":
            OnClickChangeServerButton();
            // End:0x1DE
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnClickTeleButton()
{
    local string EditBoxString;

    EditBoxString = m_hEditBox.GetString();
    // End:0x3C
    if(EditBoxString != "")
    {
        ExecuteCommand("//teleportto" @ EditBoxString);
    }
    return;
}

function OnClickMoveButton()
{
    ExecuteCommand("//instant_move");
    return;
}

function OnClickRecallButton()
{
    DialogSetID(0);
    DialogShow(DIALOG_OKCancel, GetSystemMessage(1220));
    return;
}

function Recall()
{
    local string EditBoxString;

    EditBoxString = m_hEditBox.GetString();
    // End:0x38
    if(EditBoxString != "")
    {
        ExecuteCommand("//recall" @ EditBoxString);
    }
    return;
}

function OnClickDetailStatusButton()
{
    local string EditBoxString;
    local GMDetailStatusWnd GMDetailStatusWndScript;

    EditBoxString = m_hEditBox.GetString();
    // End:0x52
    if(EditBoxString != "")
    {
        GMDetailStatusWndScript = GMDetailStatusWnd(m_hGMDetailStatusWnd.GetScript());
        GMDetailStatusWndScript.ShowStatus(EditBoxString);        
    }
    else
    {
        AddSystemMessage(GetSystemMessage(364), m_WhiteColor);
    }
    return;
}

function OnClickInventoryButton()
{
    local string EditBoxString;
    local GMInventoryWnd GMInventoryWndScript;

    EditBoxString = m_hEditBox.GetString();
    // End:0x52
    if(EditBoxString != "")
    {
        GMInventoryWndScript = GMInventoryWnd(m_hGMInventoryWnd.GetScript());
        GMInventoryWndScript.ShowInventory(EditBoxString);        
    }
    else
    {
        AddSystemMessage(GetSystemMessage(364), m_WhiteColor);
    }
    return;
}

function OnClickMagicSkillButton()
{
    local string EditBoxString;
    local GMMagicSkillWnd GMMagicSkillWndScript;

    EditBoxString = m_hEditBox.GetString();
    // End:0x52
    if(EditBoxString != "")
    {
        GMMagicSkillWndScript = GMMagicSkillWnd(m_hGMMagicSkillWnd.GetScript());
        GMMagicSkillWndScript.ShowMagicSkill(EditBoxString);        
    }
    else
    {
        AddSystemMessage(GetSystemMessage(364), m_WhiteColor);
    }
    return;
}

function OnClickQuestButton()
{
    local string EditBoxString;
    local GMQuestWnd GMQuestWndScript;

    EditBoxString = m_hEditBox.GetString();
    // End:0x52
    if(EditBoxString != "")
    {
        GMQuestWndScript = GMQuestWnd(m_hGMQuestWnd.GetScript());
        GMQuestWndScript.ShowQuest(EditBoxString);        
    }
    else
    {
        AddSystemMessage(GetSystemMessage(364), m_WhiteColor);
    }
    return;
}

function OnClickInfoButton()
{
    local string EditBoxString;

    EditBoxString = m_hEditBox.GetString();
    // End:0x37
    if(EditBoxString != "")
    {
        ExecuteCommand("//debug" @ EditBoxString);
    }
    return;
}

function OnClickStoreButton()
{
    local string EditBoxString;
    local GMWarehouseWnd GMWarehouseWndScript;

    Debug("GMstore");
    EditBoxString = m_hEditBox.GetString();
    // End:0x61
    if(EditBoxString != "")
    {
        GMWarehouseWndScript = GMWarehouseWnd(m_hGMWarehouseWnd.GetScript());
        GMWarehouseWndScript.ShowWarehouse(EditBoxString);        
    }
    else
    {
        AddSystemMessage(GetSystemMessage(364), m_WhiteColor);
    }
    return;
}

function OnClickClanButton()
{
    local string EditBoxString;
    local GMClanWnd GMClanWndScript;

    EditBoxString = m_hEditBox.GetString();
    // End:0x52
    if(EditBoxString != "")
    {
        GMClanWndScript = GMClanWnd(m_hGMClanWnd.GetScript());
        GMClanWndScript.ShowClan(EditBoxString);        
    }
    else
    {
        AddSystemMessage(GetSystemMessage(364), m_WhiteColor);
    }
    return;
}

function OnClickPetitionButton()
{
    local string EditBoxString;

    EditBoxString = m_hEditBox.GetString();
    // End:0x3F
    if(EditBoxString != "")
    {
        ExecuteCommand("//add_peti_chat" @ EditBoxString);
    }
    return;
}

function OnClickSendHomeButton()
{
    DialogSetID(1);
    DialogShow(DIALOG_OKCancel, GetSystemMessage(1221));
    return;
}

function SendHome()
{
    local string EditBoxString;

    EditBoxString = m_hEditBox.GetString();
    // End:0x3A
    if(EditBoxString != "")
    {
        ExecuteCommand("//sendhome" @ EditBoxString);
    }
    return;
}

function OnClickNPCListButton()
{
    local int Id;
    local string EditBoxString;
    local WindowHandle m_dialogWnd;

    m_dialogWnd = GetHandle("DialogBox");
    EditBoxString = m_hEditBox.GetString();
    // End:0x3A
    if(EditBoxString == "")
    {
        return;
    }
    Id = Class'NWindow.UIDATA_NPC'.static.GetFirstID();
    J0x4F:

    // End:0x11C [Loop If]
    if(-1 != Id)
    {
        // End:0x104
        if(Class'NWindow.UIDATA_NPC'.static.IsValidData(Id) && Class'NWindow.UIDATA_NPC'.static.GetNPCName(Id) == EditBoxString)
        {
            // End:0xC7
            if((DialogIsMine()) && m_dialogWnd.IsShowWindow())
            {
                DialogHide();
                m_dialogWnd.HideWindow();
            }
            DialogSetID(2);
            DialogShow(DIALOG_OK, (("ClassID:" $ string(Id + 1000000)) @ "Name:") $ EditBoxString);
            // [Explicit Break]
            goto J0x11C;
        }
        Id = Class'NWindow.UIDATA_NPC'.static.GetNextID();
        // [Loop Continue]
        goto J0x4F;
    }
    J0x11C:

    return;
}

function OnClickItemListButton()
{
    local int Id;
    local string EditBoxString;
    local WindowHandle m_dialogWnd;

    m_dialogWnd = GetHandle("DialogBox");
    EditBoxString = m_hEditBox.GetString();
    // End:0x3A
    if(EditBoxString == "")
    {
        return;
    }
    Id = Class'NWindow.UIDATA_ITEM'.static.GetFirstID();
    J0x4F:

    // End:0xFC [Loop If]
    if(-1 != Id)
    {
        // End:0xE4
        if(Class'NWindow.UIDATA_ITEM'.static.GetItemName(Id) == EditBoxString)
        {
            // End:0xAE
            if((DialogIsMine()) && m_dialogWnd.IsShowWindow())
            {
                DialogHide();
                m_dialogWnd.HideWindow();
            }
            DialogSetID(3);
            DialogShow(DIALOG_OK, (("ClassID:" $ string(Id)) @ "Name:") $ EditBoxString);
            // [Explicit Break]
            goto J0xFC;
        }
        Id = Class'NWindow.UIDATA_ITEM'.static.GetNextID();
        // [Loop Continue]
        goto J0x4F;
    }
    J0xFC:

    return;
}

function OnClickSkillListButton()
{
    local int Id;
    local string EditBoxString;
    local WindowHandle m_dialogWnd;

    m_dialogWnd = GetHandle("DialogBox");
    EditBoxString = m_hEditBox.GetString();
    // End:0x3A
    if(EditBoxString == "")
    {
        return;
    }
    Id = Class'NWindow.UIDATA_SKILL'.static.GetFirstID();
    J0x4F:

    // End:0xFD [Loop If]
    if(-1 != Id)
    {
        // End:0xE5
        if(Class'NWindow.UIDATA_SKILL'.static.GetName(Id, 1) == EditBoxString)
        {
            // End:0xAF
            if((DialogIsMine()) && m_dialogWnd.IsShowWindow())
            {
                DialogHide();
                m_dialogWnd.HideWindow();
            }
            DialogSetID(4);
            DialogShow(DIALOG_OK, (("ClassID:" $ string(Id)) @ "Name:") $ EditBoxString);
            // [Explicit Break]
            goto J0xFD;
        }
        Id = Class'NWindow.UIDATA_SKILL'.static.GetNextID();
        // [Loop Continue]
        goto J0x4F;
    }
    J0xFD:

    return;
}

function OnClickForcePetitionButton()
{
    local string EditBoxString;

    EditBoxString = m_hEditBox.GetString();
    // End:0x49
    if(EditBoxString != "")
    {
        ExecuteCommand(("//force_peti" @ EditBoxString) @ GetSystemMessage(1528));
    }
    return;
}

function OnClickChangeServerButton()
{
    local string EditBoxString;
    local UserInfo PlayerInfo;

    EditBoxString = m_hEditBox.GetString();
    // End:0x23
    if(EditBoxString == "")
    {
        return;
    }
    // End:0x35
    if(!GetPlayerInfo(PlayerInfo))
    {
        return;
    }
    Class'NWindow.GMAPI'.static.BeginGMChangeServer(int(EditBoxString), PlayerInfo.Loc);
    return;
}
