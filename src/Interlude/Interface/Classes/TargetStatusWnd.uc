class TargetStatusWnd extends UICommonAPI;

var bool m_bExpand;
var WindowHandle m_wndTop;
var EditBoxHandle ChatEditBox;
var int m_TargetLevel;
var int m_targetID;
var string dlgText;
var PartyWnd PartyWnd;
var int idx_HoldTarget_1;
var int idx_HoldTarget_2;
var bool m_bShow;
var ButtonHandle b_Invite;
var ButtonHandle b_Trade;

function OnLoad()
{
    RegisterEvent(980);
    RegisterEvent(990);
    RegisterEvent(50);
    RegisterEvent(110);
    RegisterEvent(2960);
    RegisterEvent(290);
    RegisterEvent(230);
    RegisterEvent(240);
    RegisterEvent(190);
    RegisterEvent(210);
    RegisterEvent(200);
    RegisterEvent(220);
    RegisterEvent(300);
    SetExpandMode(false);
    m_wndTop = GetHandle("TargetStatusWnd");
    PartyWnd = PartyWnd(GetScript("PartyWnd"));
    ChatEditBox = EditBoxHandle(GetHandle("ChatWnd.ChatEditBox"));
    m_bShow = false;
    m_targetID = -1;
    return;
}

function OnShow()
{
    m_bShow = true;
    return;
}

function OnHide()
{
    m_bShow = false;
    return;
}

function OnEnterState(name a_PreStateName)
{
    SetExpandMode(m_bExpand);
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x37
    if(Event_ID == 980)
    {
        HandleTargetUpdate();
        // End:0x34
        if(!m_wndTop.IsShowWindow())
        {
            ExecuteEvent(2960);
        }        
    }
    else
    {
        // End:0x69
        if(Event_ID == 990)
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd");            
        }
        else
        {
            // End:0x86
            if(Event_ID == 300)
            {
                HandleReceiveTargetLevelDiff(param);                
            }
            else
            {
                // End:0xA0
                if(Event_ID == 190)
                {
                    HandleUpdateHPMP(param);                    
                }
                else
                {
                    // End:0xBA
                    if(Event_ID == 210)
                    {
                        HandleUpdateHPMP(param);                        
                    }
                    else
                    {
                        // End:0xD4
                        if(Event_ID == 200)
                        {
                            HandleUpdateHPMP(param);                            
                        }
                        else
                        {
                            // End:0xEE
                            if(Event_ID == 220)
                            {
                                HandleUpdateHPMP(param);                                
                            }
                            else
                            {
                                // End:0x128
                                if(Event_ID == 290)
                                {
                                    // End:0x125
                                    if(GetOptionBool("Custom", "IgnoreAggr"))
                                    {
                                        IgnoreAggrFunc(param);
                                    }                                    
                                }
                                else
                                {
                                    // End:0x150
                                    if((Event_ID == 50) || Event_ID == 110)
                                    {
                                        idx_HoldTarget_1 = -1;                                        
                                    }
                                    else
                                    {
                                        // End:0x165
                                        if(Event_ID == 2960)
                                        {
                                            holdTargetFunc();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function holdTargetFunc()
{
    // End:0x3E
    if(UnknownFunction242(GetOptionBool("Custom", "HoldTarget"), true))
    {
        // End:0x3E
        if(idx_HoldTarget_1 != idx_HoldTarget_2)
        {
            RequestTargetUser(idx_HoldTarget_1);
        }
    }
    return;
}

function IgnoreAggrFunc(string param)
{
    local int idx, AttackerID;

    ParseInt(param, "SkillID", idx);
    // End:0x62
    if(isAggroCast(idx))
    {
        ParseInt(param, "AttackerID", AttackerID);
        // End:0x62
        if(UnknownFunction129(isPartyMember(AttackerID)))
        {
            idx_HoldTarget_2 = AttackerID;
        }
    }
    return;
}

function bool isPartyMember(int m_targetID)
{
    local int j;
    local bool ResultBool;

    j = 0;
    J0x07:

    // End:0x43 [Loop If]
    if(j < 8)
    {
        // End:0x39
        if(m_targetID == PartyWnd.m_arrID[j])
        {
            ResultBool = true;
        }
        j++;
        // [Loop Continue]
        goto J0x07;
    }
    return ResultBool;
}

function bool isAggroCast(int idx)
{
    local bool ResultBool;

    switch(idx)
    {
        // End:0x0C
        case 18:
        // End:0x11
        case 28:
        // End:0x24
        case 286:
            ResultBool = true;
            // End:0x27
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1D
        case "btnClose":
            OnCloseButton();
            // End:0x55
            break;
        // End:0x38
        case "FastInviteBtn":
            OnFastInviteButton();
            // End:0x55
            break;
        // End:0x52
        case "FastTradeBtn":
            OnFastTradeBtn();
            // End:0x55
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnFastInviteButton()
{
    local UserInfo UserInfo;

    GetTargetInfo(UserInfo);
    RequestInviteParty(UserInfo.Name);
    return;
}

function OnFastTradeBtn()
{
    local UserInfo UserInfo;

    GetTargetInfo(UserInfo);
    ExecuteCommand("/trade " @ UserInfo.Name);
    return;
}

function OnCloseButton()
{
    RequestTargetCancel();
    PlayConsoleSound(IFST_WINDOW_CLOSE);
    return;
}

function HandleUpdateHPMP(string param)
{
    local int ServerID;

    // End:0x38
    if(m_bShow)
    {
        ParseInt(param, "ServerID", ServerID);
        // End:0x38
        if(m_targetID == ServerID)
        {
            HandleTargetUpdate();
        }
    }
    return;
}

function HandleReceiveTargetLevelDiff(string param)
{
    ParseInt(param, "LevelDiff", m_TargetLevel);
    return;
}

function HandleTargetUpdate()
{
    local Rect rectWnd;
    local string strTmp;
    local int targetID, PlayerID, PetID, clanType, clanNameValue, Level;

    local bool bIsServerObject, bIsHPShowableNPC;
    local string Name, RankName;
    local Color TargetNameColor;
    local int ServerObjectNameID;
    local UIEventManager.EServerObjectType ServerObjectType;
    local bool bShowHPBar, bShowMPBar, bShowHPBar1, bShowHPBar2, bShowCPBar, bShowMPBar1,
	    bShowPledgeInfo, bShowPledgeTex, bShowPledgeAllianceTex;

    local string PledgeName, PledgeAllianceName;
    local Texture PledgeCrestTexture, PledgeAllianceCrestTexture;
    local Color PledgeNameColor, PledgeAllianceNameColor;
    local bool bShowNpcInfo;
    local array<int> arrNpcInfo;
    local bool IsTargetChanged;
    local UserInfo Info;
    local Color WhiteColor;

    WhiteColor.R = 0;
    WhiteColor.G = 0;
    WhiteColor.B = 0;
    targetID = Class'NWindow.UIDATA_TARGET'.static.GetTargetID();
    // End:0x94
    if(UnknownFunction242(GetOptionBool("Custom", "IgnoreAggr"), true))
    {
        // End:0x94
        if(UnknownFunction154(targetID, idx_HoldTarget_2))
        {
            RequestTargetUser(idx_HoldTarget_1);
            idx_HoldTarget_2 = -1;
            targetID = -1;
        }
    }
    // End:0xC1
    if(targetID < 1)
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd");
        return;
    }
    // End:0x139
    if(m_targetID != targetID)
    {
        IsTargetChanged = true;
        idx_HoldTarget_1 = targetID;
        Class'NWindow.UIAPI_WINDOW'.static.KillUITimer("NPHRN_EventWnd", 11);
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.ReceiveMagicSkillUse");
    }
    m_targetID = targetID;
    GetTargetInfo(Info);
    rectWnd = Class'NWindow.UIAPI_WINDOW'.static.GetRect("TargetStatusWnd");
    PledgeName = GetSystemString(431);
    PledgeAllianceName = GetSystemString(591);
    PledgeNameColor.R = 128;
    PledgeNameColor.G = 128;
    PledgeNameColor.B = 128;
    PledgeAllianceNameColor.R = 128;
    PledgeAllianceNameColor.G = 128;
    PledgeAllianceNameColor.B = 128;
    TargetNameColor = Class'NWindow.UIDATA_TARGET'.static.GetTargetNameColor(m_TargetLevel);
    bIsServerObject = Class'NWindow.UIDATA_TARGET'.static.IsServerObject();
    // End:0x343
    if(bIsServerObject)
    {
        ServerObjectNameID = Class'NWindow.UIDATA_STATICOBJECT'.static.GetServerObjectNameID(m_targetID);
        // End:0x265
        if(ServerObjectNameID > 0)
        {
            Name = Class'NWindow.UIDATA_STATICOBJECT'.static.GetStaticObjectName(ServerObjectNameID);
            RankName = "";
        }
        Class'NWindow.UIAPI_NAMECTRL'.static.SetName("TargetStatusWnd.UserName", Name, NCT_Normal, TA_Center);
        Class'NWindow.UIAPI_NAMECTRL'.static.SetName("TargetStatusWnd.RankName", RankName, NCT_Normal, TA_Center);
        ServerObjectType = Class'NWindow.UIDATA_STATICOBJECT'.static.GetServerObjectType(m_targetID);
        // End:0x340
        if(int(ServerObjectType) == 2)
        {
            // End:0x340
            if(Class'NWindow.UIDATA_STATICOBJECT'.static.GetStaticObjectShowHP(m_targetID))
            {
                bShowHPBar = true;
                UpdateHPBar(Class'NWindow.UIDATA_STATICOBJECT'.static.GetServerObjectHP(m_targetID), Class'NWindow.UIDATA_STATICOBJECT'.static.GetServerObjectMaxHP(m_targetID));
            }
        }        
    }
    else
    {
        // End:0x42B
        if(Len(Info.Name) < 1)
        {
            Name = Class'NWindow.UIDATA_PARTY'.static.GetMemberName(m_targetID);
            RankName = "";
            Debug((((("m_TargetID" $ string(m_targetID)) $ ", info.Name : ") $ Info.Name) $ ", Name : ") $ Name);
            Class'NWindow.UIAPI_NAMECTRL'.static.SetName("TargetStatusWnd.UserName", Name, NCT_Normal, TA_Center);
            Class'NWindow.UIAPI_NAMECTRL'.static.SetName("TargetStatusWnd.RankName", RankName, NCT_Normal, TA_Center);            
        }
        else
        {
            PlayerID = Class'NWindow.UIDATA_PLAYER'.static.GetPlayerID();
            PetID = Class'NWindow.UIDATA_PET'.static.GetPetID();
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP", "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP1", "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP2", "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP3", "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP4", "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP5", "");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP6", "");
            bIsHPShowableNPC = Class'NWindow.UIDATA_TARGET'.static.IsHPShowableNPC();
            // End:0xA29
            if(((((Info.bNpc && !Info.bPet) && Info.bCanBeAttacked) || (PlayerID > 0) && m_targetID == PlayerID) || (Info.bNpc && Info.bPet) && m_targetID == PetID) || Info.bNpc && bIsHPShowableNPC)
            {
                // End:0x6EC
                if(IsAllWhiteID(Info.nClassID))
                {
                    Name = Info.Name;
                    RankName = "";
                    Class'NWindow.UIAPI_NAMECTRL'.static.SetName("TargetStatusWnd.UserName", Name, NCT_Normal, TA_Center);
                    Class'NWindow.UIAPI_NAMECTRL'.static.SetName("TargetStatusWnd.RankName", RankName, NCT_Normal, TA_Center);
                    // End:0x6E9
                    if(!IsNoBarID(Info.nClassID))
                    {
                        bShowHPBar = true;
                        UpdateHPBar(Info.nCurHP, Info.nMaxHP);
                    }                    
                }
                else
                {
                    Name = Info.Name;
                    RankName = "";
                    Class'NWindow.UIAPI_NAMECTRL'.static.SetNameWithColor("TargetStatusWnd.UserName", Name, NCT_Normal, TA_Center, TargetNameColor);
                    Class'NWindow.UIAPI_NAMECTRL'.static.SetName("TargetStatusWnd.RankName", RankName, NCT_Normal, TA_Center);
                    // End:0x7AF
                    if(!Info.bPet && Info.bCanBeAttacked)
                    {
                        bShowHPBar = true;
                        UpdateHPBar(Info.nCurHP, Info.nMaxHP);
                    }
                    // End:0x8D7
                    if(!Info.bPet && Info.bCanBeAttacked)
                    {
                        bShowHPBar1 = true;
                        UpdateHPBar1(Info.nCurHP, Info.nMaxHP);
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP1", (string(Info.nCurHP) $ " / ") $ string(Info.nMaxHP));
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP2", "HP");
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP3", (string(Info.nCurHP) $ " / ") $ string(Info.nMaxHP));
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP4", "HP");
                    }
                    // End:0x98E
                    if(!Info.bNpc && !Info.bPet)
                    {
                        bShowCPBar = true;
                        UpdateCPBar(Info.nCurCP, Info.nMaxCP);
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP5", (string(Info.nCurCP) $ " / ") $ string(Info.nMaxCP));
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP6", "CP");
                    }
                    // End:0x9E2
                    if(!(Info.bNpc && !Info.bPet) && Info.bCanBeAttacked)
                    {
                        bShowMPBar = true;
                        UpdateMPBar(Info.nCurMP, Info.nMaxMP);
                    }
                    // End:0xA26
                    if(!Info.bNpc && !Info.bPet)
                    {
                        bShowMPBar1 = true;
                        UpdateMPBar1(Info.nCurMP, Info.nMaxMP);
                    }
                }                
            }
            else
            {
                Name = Info.Name;
                Level = Info.nLevel;
                // End:0xA62
                if(Info.bNpc)
                {
                    RankName = "";                    
                }
                else
                {
                    RankName = GetClassType(Info.nUserRank);
                    // End:0xBB2
                    if(!(Info.bNpc && !Info.bPet) && Info.bCanBeAttacked)
                    {
                        bShowHPBar1 = true;
                        UpdateHPBar1(Info.nCurHP, Info.nMaxHP);
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP1", (string(Info.nCurHP) $ " / ") $ string(Info.nMaxHP));
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP2", "HP");
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP3", (string(Info.nCurHP) $ " / ") $ string(Info.nMaxHP));
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP4", "HP");
                    }
                    // End:0xC79
                    if(!(Info.bNpc && !Info.bPet) && Info.bCanBeAttacked)
                    {
                        bShowCPBar = true;
                        UpdateCPBar(Info.nCurCP, Info.nMaxCP);
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP5", (string(Info.nCurCP) $ " / ") $ string(Info.nMaxCP));
                        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.valHP6", "CP");
                    }
                    // End:0xCCD
                    if(!(Info.bNpc && !Info.bPet) && Info.bCanBeAttacked)
                    {
                        bShowMPBar1 = true;
                        UpdateMPBar1(Info.nCurMP, Info.nMaxMP);
                    }
                }
                Class'NWindow.UIAPI_NAMECTRL'.static.SetName("TargetStatusWnd.UserName", Name, NCT_Normal, TA_Center);
                Class'NWindow.UIAPI_NAMECTRL'.static.SetName("TargetStatusWnd.RankName", RankName, NCT_Normal, TA_Center);
            }
            // End:0x100D
            if(m_bExpand)
            {
                // End:0xD88
                if(Info.bNpc)
                {
                    // End:0xD85
                    if(Class'NWindow.UIDATA_NPC'.static.GetNpcProperty(Info.nClassID, arrNpcInfo))
                    {
                        bShowNpcInfo = true;
                        // End:0xD85
                        if(IsTargetChanged)
                        {
                            UpdateNpcInfoTree(arrNpcInfo);
                        }
                    }                    
                }
                else
                {
                    bShowPledgeInfo = true;
                    // End:0x100D
                    if(Info.nClanID > 0)
                    {
                        PledgeName = Class'NWindow.UIDATA_CLAN'.static.GetName(Info.nClanID);
                        PledgeNameColor.R = 176;
                        PledgeNameColor.G = 152;
                        PledgeNameColor.B = 121;
                        // End:0xED7
                        if(((PledgeName != "") && Class'NWindow.UIDATA_USER'.static.GetClanType(m_targetID, clanType)) && Class'NWindow.UIDATA_CLAN'.static.GetNameValue(Info.nClanID, clanNameValue))
                        {
                            // End:0xE6C
                            if(clanType == -1)
                            {
                                PledgeNameColor.R = 209;
                                PledgeNameColor.G = 167;
                                PledgeNameColor.B = 2;                                
                            }
                            else
                            {
                                // End:0xEA3
                                if(clanNameValue > 0)
                                {
                                    PledgeNameColor.R = 0;
                                    PledgeNameColor.G = 130;
                                    PledgeNameColor.B = byte(255);                                    
                                }
                                else
                                {
                                    // End:0xED7
                                    if(clanNameValue < 0)
                                    {
                                        PledgeNameColor.R = byte(255);
                                        PledgeNameColor.G = 0;
                                        PledgeNameColor.B = 0;
                                    }
                                }
                            }
                        }
                        // End:0xF37
                        if(Class'NWindow.UIDATA_CLAN'.static.GetCrestTexture(Info.nClanID, PledgeCrestTexture))
                        {
                            bShowPledgeTex = true;
                            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTextureWithObject("TargetStatusWnd.texPledgeCrest", PledgeCrestTexture);                            
                        }
                        else
                        {
                            bShowPledgeTex = false;
                        }
                        strTmp = Class'NWindow.UIDATA_CLAN'.static.GetAllianceName(Info.nClanID);
                        // End:0x100D
                        if(Len(strTmp) > 0)
                        {
                            PledgeAllianceName = strTmp;
                            PledgeAllianceNameColor.R = 176;
                            PledgeAllianceNameColor.G = 155;
                            PledgeAllianceNameColor.B = 121;
                            // End:0x1005
                            if(Class'NWindow.UIDATA_CLAN'.static.GetAllianceCrestTexture(Info.nClanID, PledgeAllianceCrestTexture))
                            {
                                bShowPledgeAllianceTex = true;
                                Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTextureWithObject("TargetStatusWnd.texPledgeAllianceCrest", PledgeAllianceCrestTexture);                                
                            }
                            else
                            {
                                bShowPledgeAllianceTex = false;
                            }
                        }
                    }
                }
            }
        }
    }
    // End:0x105E
    if(!Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("TargetStatusWnd"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd");
        SetExpandMode(m_bExpand);
    }
    // End:0x1090
    if(bShowHPBar)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.barHP");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.barHP");
    }
    // End:0x10E8
    if(bShowMPBar)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.barMP");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.barMP");
    }
    // End:0x1141
    if(bShowHPBar1)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.barHP1");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.barHP1");
    }
    // End:0x119B
    if(bShowHPBar2)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.barHP2");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.barHP2");
    }
    // End:0x11F4
    if(bShowCPBar)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.barCP");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.barCP");
    }
    // End:0x124D
    if(bShowMPBar1)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.barMP1");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.barMP1");
    }
    // End:0x1409
    if((((!Info.bNpc && !Info.bPet) && !bShowMPBar) && !bShowHPBar) && !bIsServerObject)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.FastInviteBtn");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.SmbInvite");
        b_Invite = ButtonHandle(GetHandle("TargetStatusWnd.FastInviteBtn"));
        b_Invite.SetTooltipCustomType(SetTooltip("Invite"));
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.FastTradeBtn");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.SmbExchange");
        b_Trade = ButtonHandle(GetHandle("TargetStatusWnd.FastTradeBtn"));
        b_Trade.SetTooltipCustomType(SetTooltip("Trade"));        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.FastInviteBtn");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.FastTradeBtn");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.SmbExchange");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.SmbInvite");
    }
    // End:0x1878
    if(bShowPledgeInfo)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.txtPledge");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.txtAlliance");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.txtPledgeName");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.txtPledgeAllianceName");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.txtPledgeName", PledgeName);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("TargetStatusWnd.txtPledgeAllianceName", PledgeAllianceName);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("TargetStatusWnd.txtPledgeName", PledgeNameColor);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("TargetStatusWnd.txtPledgeAllianceName", PledgeAllianceNameColor);
        // End:0x16DE
        if(bShowPledgeTex)
        {
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.texPledgeCrest");
            Class'NWindow.UIAPI_WINDOW'.static.MoveTo("TargetStatusWnd.txtPledgeName", rectWnd.nX + 63, rectWnd.nY + 43);            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.texPledgeCrest");
            Class'NWindow.UIAPI_WINDOW'.static.MoveTo("TargetStatusWnd.txtPledgeName", rectWnd.nX + 45, rectWnd.nY + 43);
        }
        // End:0x17EC
        if(bShowPledgeAllianceTex)
        {
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.texPledgeAllianceCrest");
            Class'NWindow.UIAPI_WINDOW'.static.MoveTo("TargetStatusWnd.txtPledgeAllianceName", rectWnd.nX + 63, rectWnd.nY + 59);            
        }
        else
        {
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.texPledgeAllianceCrest");
            Class'NWindow.UIAPI_WINDOW'.static.MoveTo("TargetStatusWnd.txtPledgeAllianceName", rectWnd.nX + 45, rectWnd.nY + 59);
        }        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.txtPledge");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.texPledgeCrest");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.txtPledgeName");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.txtAlliance");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.texPledgeAllianceCrest");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.txtPledgeAllianceName");
    }
    // End:0x19F5
    if(bShowNpcInfo)
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.NpcInfo");
        Class'NWindow.UIAPI_TREECTRL'.static.ShowScrollBar("TargetStatusWnd.NpcInfo", false);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.NpcInfo");
    }
    return;
}

function OnFrameExpandClick(bool bIsExpand)
{
    SetExpandMode(bIsExpand);
    return;
}

function SetExpandMode(bool bExpand)
{
    m_bExpand = bExpand;
    m_targetID = -1;
    HandleTargetUpdate();
    // End:0x13F
    if(bExpand)
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.BackTex");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.BackExpTex");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.valHP");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.valHP1");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.valHP2");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.valHP3");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.valHP4");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.BackTex");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.BackExpTex");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.valHP");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.valHP1");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("TargetStatusWnd.valHP2");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.valHP3");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.valHP4");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("TargetStatusWnd.valHP5");
    }
    return;
}

function UpdateHPBar(int HP, int MaxHP)
{
    Class'NWindow.UIAPI_BARCTRL'.static.SetValue("TargetStatusWnd.barHP", MaxHP, HP);
    return;
}

function UpdateMPBar(int MP, int maxMP)
{
    Class'NWindow.UIAPI_BARCTRL'.static.SetValue("TargetStatusWnd.barMP", maxMP, MP);
    return;
}

function UpdateHPBar1(int HP, int MaxHP)
{
    Class'NWindow.UIAPI_BARCTRL'.static.SetValue("TargetStatusWnd.barHP1", MaxHP, HP);
    return;
}

function UpdateHPBar2(int HP, int MaxHP)
{
    Class'NWindow.UIAPI_BARCTRL'.static.SetValue("TargetStatusWnd.barHP2", MaxHP, HP);
    return;
}

function UpdateCPBar(int CP, int maxCP)
{
    Class'NWindow.UIAPI_BARCTRL'.static.SetValue("TargetStatusWnd.barCP", maxCP, CP);
    return;
}

function UpdateMPBar1(int MP, int maxMP)
{
    Class'NWindow.UIAPI_BARCTRL'.static.SetValue("TargetStatusWnd.barMP1", maxMP, MP);
    return;
}

function UpdateNpcInfoTree(array<int> arrNpcInfo)
{
    local int i, SkillID, SkillLevel;
    local string strNodeName;
    local XMLTreeNodeInfo infNode;
    local XMLTreeNodeItemInfo infNodeItem;
    local XMLTreeNodeInfo infNodeClear;
    local XMLTreeNodeItemInfo infNodeItemClear;

    Class'NWindow.UIAPI_TREECTRL'.static.Clear("TargetStatusWnd.NpcInfo");
    infNode.strName = "root";
    strNodeName = Class'NWindow.UIAPI_TREECTRL'.static.InsertNode("TargetStatusWnd.NpcInfo", "", infNode);
    // End:0xB6
    if(Len(strNodeName) < 1)
    {
        Debug("ERROR: Can't insert root node. Name: " $ infNode.strName);
        return;
    }
    i = 0;
    J0xBD:

    // End:0x2FA [Loop If]
    if(i < arrNpcInfo.Length)
    {
        SkillID = arrNpcInfo[i];
        SkillLevel = arrNpcInfo[i + 1];
        infNode = infNodeClear;
        infNode.nOffSetX = int(float(i / 2) % float(8)) * 18;
        // End:0x162
        if((float(i / 2) % float(8)) == float(0))
        {
            // End:0x153
            if(i > 0)
            {
                infNode.nOffSetY = 3;                
            }
            else
            {
                infNode.nOffSetY = 0;
            }            
        }
        else
        {
            infNode.nOffSetY = -15;
        }
        infNode.strName = "" $ string(i / 2);
        infNode.bShowButton = 0;
        infNode.ToolTip = SetNpcInfoTooltip(SkillID, SkillLevel);
        strNodeName = Class'NWindow.UIAPI_TREECTRL'.static.InsertNode("TargetStatusWnd.NpcInfo", "root", infNode);
        // End:0x22B
        if(Len(strNodeName) < 1)
        {
            Log("ERROR: Can't insert node. Name: " $ infNode.strName);
            return;
        }
        infNode.ToolTip.DrawList.Remove(0, infNode.ToolTip.DrawList.Length);
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_TEXTURE;
        infNodeItem.u_nTextureWidth = 15;
        infNodeItem.u_nTextureHeight = 15;
        infNodeItem.u_nTextureUWidth = 32;
        infNodeItem.u_nTextureUHeight = 32;
        infNodeItem.u_strTexture = Class'NWindow.UIDATA_SKILL'.static.GetIconName(SkillID, SkillLevel);
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("TargetStatusWnd.NpcInfo", strNodeName, infNodeItem);
        i += 2;
        // [Loop Continue]
        goto J0xBD;
    }
    return;
}

function CustomTooltip SetNpcInfoTooltip(int Id, int Level)
{
    local CustomTooltip ToolTip;
    local DrawItemInfo Info, infoClear;
    local ItemInfo item;

    item.Name = Class'NWindow.UIDATA_SKILL'.static.GetName(Id, Level);
    item.Description = Class'NWindow.UIDATA_SKILL'.static.GetDescription(Id, Level);
    ToolTip.DrawList.Length = 1;
    Info = infoClear;
    Info.eType = DIT_TEXT;
    Info.t_bDrawOneLine = true;
    Info.t_strText = item.Name;
    ToolTip.DrawList[0] = Info;
    // End:0x171
    if(Len(item.Description) > 0)
    {
        ToolTip.MinimumWidth = 144;
        ToolTip.DrawList.Length = 2;
        Info = infoClear;
        Info.eType = DIT_TEXT;
        Info.nOffSetY = 6;
        Info.bLineBreak = true;
        Info.t_color.R = 178;
        Info.t_color.G = 190;
        Info.t_color.B = 207;
        Info.t_color.A = byte(255);
        Info.t_strText = item.Description;
        ToolTip.DrawList[1] = Info;
    }
    return ToolTip;
}

function bool IsAllWhiteID(int m_targetID)
{
    local bool bIsAllWhiteName;

    bIsAllWhiteName = false;
    switch(m_targetID)
    {
        // End:0x17
        case 12778:
        // End:0x1F
        case 13031:
        // End:0x27
        case 13032:
        // End:0x2F
        case 13033:
        // End:0x37
        case 13034:
        // End:0x3F
        case 13035:
        // End:0x52
        case 13036:
            bIsAllWhiteName = true;
            // End:0x55
            break;
        // End:0xFFFF
        default:
            break;
    }
    return bIsAllWhiteName;
}

function bool IsNoBarID(int m_targetID)
{
    local bool bIsNoBarName;

    bIsNoBarName = false;
    switch(m_targetID)
    {
        // End:0x22
        case 13036:
            bIsNoBarName = true;
            // End:0x25
            break;
        // End:0xFFFF
        default:
            break;
    }
    return bIsNoBarName;
}

function CustomTooltip SetTooltip(string Text)
{
    local CustomTooltip ToolTip;
    local DrawItemInfo Info;

    ToolTip.DrawList.Length = 1;
    Info.eType = DIT_TEXT;
    Info.t_strText = Text;
    ToolTip.DrawList[0] = Info;
    return ToolTip;
}

function OnRButtonUp(int X, int Y)
{
    local Rect rectWnd;
    local UserInfo UserInfo;

    dlgText = DialogGetString();
    rectWnd = m_wndTop.GetRect();
    // End:0x69
    if(X > rectWnd.nX)
    {
        GetTargetInfo(UserInfo);
        SetChatMessage(("\"" $ UserInfo.Name) $ " ");
        ChatEditBox.ReleaseFocus();
    }
    return;
}
