class DetailStatusWnd extends UIScript;

const NSTATUS_SMALLBARSIZE = 85;
const NSTATUS_BARHEIGHT = 12;

var string m_WindowName;
var int m_UserID;
var bool m_bReceivedUserInfo;
var bool m_bShow;
var HennaInfo m_HennaInfo;

function OnLoad()
{
    RegisterEvent(180);
    RegisterEvent(260);
    RegisterEvent(190);
    RegisterEvent(200);
    RegisterEvent(210);
    RegisterEvent(220);
    RegisterEvent(230);
    RegisterEvent(240);
    m_bShow = false;
    return;
}

function OnEnterState(name a_PreStateName)
{
    m_bReceivedUserInfo = false;
    HandleUpdateUserInfo();
    return;
}

function OnShow()
{
    HandleUpdateUserInfo();
    m_bShow = true;
    return;
}

function OnHide()
{
    m_bShow = false;
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x15
    if(Event_ID == 180)
    {
        HandleUpdateUserInfo();        
    }
    else
    {
        // End:0x32
        if(Event_ID == 260)
        {
            HandleUpdateHennaInfo(param);            
        }
        else
        {
            // End:0x4C
            if(Event_ID == 200)
            {
                HandleUpdateStatusPacket(param);                
            }
            else
            {
                // End:0x66
                if(Event_ID == 210)
                {
                    HandleUpdateStatusPacket(param);                    
                }
                else
                {
                    // End:0x80
                    if(Event_ID == 220)
                    {
                        HandleUpdateStatusPacket(param);                        
                    }
                    else
                    {
                        // End:0x9A
                        if(Event_ID == 230)
                        {
                            HandleUpdateStatusPacket(param);                            
                        }
                        else
                        {
                            // End:0xB1
                            if(Event_ID == 240)
                            {
                                HandleUpdateStatusPacket(param);
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function HandleUpdateStatusPacket(string param)
{
    local int ServerID;

    ParseInt(param, "ServerID", ServerID);
    // End:0x3C
    if((m_UserID == ServerID) || !m_bReceivedUserInfo)
    {
        HandleUpdateUserInfo();
    }
    return;
}

function HandleUpdateHennaInfo(string param)
{
    ParseInt(param, "HennaID", m_HennaInfo.HennaID);
    ParseInt(param, "ClassID", m_HennaInfo.ClassID);
    ParseInt(param, "Num", m_HennaInfo.Num);
    ParseInt(param, "Fee", m_HennaInfo.Fee);
    ParseInt(param, "CanUse", m_HennaInfo.CanUse);
    ParseInt(param, "INTnow", m_HennaInfo.INTnow);
    ParseInt(param, "INTchange", m_HennaInfo.INTchange);
    ParseInt(param, "STRnow", m_HennaInfo.STRnow);
    ParseInt(param, "STRchange", m_HennaInfo.STRchange);
    ParseInt(param, "CONnow", m_HennaInfo.CONnow);
    ParseInt(param, "CONchange", m_HennaInfo.CONchange);
    ParseInt(param, "MENnow", m_HennaInfo.MENnow);
    ParseInt(param, "MENchange", m_HennaInfo.MENchange);
    ParseInt(param, "DEXnow", m_HennaInfo.DEXnow);
    ParseInt(param, "DEXchange", m_HennaInfo.DEXchange);
    ParseInt(param, "WITnow", m_HennaInfo.WITnow);
    ParseInt(param, "WITchange", m_HennaInfo.WITchange);
    return;
}

function bool GetMyUserInfo(out UserInfo a_MyUserInfo)
{
    return GetPlayerInfo(a_MyUserInfo);
}

function string GetMovingSpeed(UserInfo a_UserInfo)
{
    local int MovingSpeed;
    local UIEventManager.EMoveType MoveType;
    local UIEventManager.EEnvType EnvType;

    MoveType = Class'NWindow.UIDATA_PLAYER'.static.GetPlayerMoveType();
    EnvType = Class'NWindow.UIDATA_PLAYER'.static.GetPlayerEnvironment();
    // End:0xB7
    if(MoveType == MVT_FAST)
    {
        MovingSpeed = int(float(a_UserInfo.nGroundMaxSpeed) * a_UserInfo.fNonAttackSpeedModifier);
        switch(EnvType)
        {
            // End:0x89
            case ET_UNDERWATER:
                MovingSpeed = int(float(a_UserInfo.nWaterMaxSpeed) * a_UserInfo.fNonAttackSpeedModifier);
                // End:0xB4
                break;
            // End:0xB1
            case ET_AIR:
                MovingSpeed = int(float(a_UserInfo.nAirMaxSpeed) * a_UserInfo.fNonAttackSpeedModifier);
                // End:0xB4
                break;
            // End:0xFFFF
            default:
                break;
        }        
    }
    else
    {
        // End:0x141
        if(MoveType == MVT_SLOW)
        {
            MovingSpeed = int(float(a_UserInfo.nGroundMinSpeed) * a_UserInfo.fNonAttackSpeedModifier);
            switch(EnvType)
            {
                // End:0x116
                case ET_UNDERWATER:
                    MovingSpeed = int(float(a_UserInfo.nWaterMinSpeed) * a_UserInfo.fNonAttackSpeedModifier);
                    // End:0x141
                    break;
                // End:0x13E
                case ET_AIR:
                    MovingSpeed = int(float(a_UserInfo.nAirMinSpeed) * a_UserInfo.fNonAttackSpeedModifier);
                    // End:0x141
                    break;
                // End:0xFFFF
                default:
                    break;
            }
        }
        else
        {
        }
    }
    return string(MovingSpeed);
}

function float GetMyExpRate()
{
    return Class'NWindow.UIDATA_PLAYER'.static.GetPlayerEXPRate() * 100.0000000;
}

function HandleUpdateUserInfo()
{
    local Rect rectWnd;
    local int Width1, Height1, Width2, Height2;
    local string Name, nickname;
    local Color NameColor, NickNameColor;
    local int SubClassID;
    local string ClassName, UserRank;
    local int HP, MaxHP, MP, maxMP, CP, maxCP,
	    CarryWeight, CarringWeight, SP, Level;

    local float fExpRate, fTmp;
    local int PledgeID;
    local string PledgeName;
    local Texture PledgeCrestTexture;
    local bool bPledgeCrestTexture;
    local Color PledgeNameColor;
    local string HeroTexture;
    local bool bHero, bNobless;
    local int nStr, nDex, nCon, nInt, nWit, nMen;

    local string strTmp;
    local int PhysicalAttack, PhysicalDefense, HitRate, CriticalRate, PhysicalAttackSpeed, MagicalAttack,
	    MagicDefense, PhysicalAvoid;

    local string MovingSpeed;
    local int MagicCastingSpeed, CriminalRate, CrimRate;
    local string strCriminalRate;
    local int DualCount, PKCount, Sociality, RemainSulffrage;
    local UserInfo Info;

    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture(m_WindowName $ ".texPledgeCrest", "");
    rectWnd = Class'NWindow.UIAPI_WINDOW'.static.GetRect(m_WindowName);
    // End:0x31E
    if(GetMyUserInfo(Info))
    {
        m_UserID = Info.nID;
        Name = Info.Name;
        nickname = Info.strNickName;
        SubClassID = Info.nSubClass;
        ClassName = GetClassType(SubClassID);
        SP = Info.nSP;
        Level = Info.nLevel;
        UserRank = GetUserRankString(Info.nUserRank);
        HP = Info.nCurHP;
        MaxHP = Info.nMaxHP;
        MP = Info.nCurMP;
        maxMP = Info.nMaxMP;
        CarryWeight = Info.nCarryWeight;
        CarringWeight = Info.nCarringWeight;
        CP = Info.nCurCP;
        maxCP = Info.nMaxCP;
        fExpRate = GetMyExpRate();
        PledgeID = Info.nClanID;
        bHero = Info.bHero;
        bNobless = Info.bNobless;
        nStr = Info.nStr;
        nDex = Info.nDex;
        nCon = Info.nCon;
        nInt = Info.nInt;
        nWit = Info.nWit;
        nMen = Info.nMen;
        PhysicalAttack = Info.nPhysicalAttack;
        PhysicalDefense = Info.nPhysicalDefense;
        HitRate = Info.nHitRate;
        CriticalRate = Info.nCriticalRate;
        PhysicalAttackSpeed = Info.nPhysicalAttackSpeed;
        MagicalAttack = Info.nMagicalAttack;
        MagicDefense = Info.nMagicDefense;
        PhysicalAvoid = Info.nPhysicalAvoid;
        MagicCastingSpeed = Info.nMagicCastingSpeed;
        MovingSpeed = GetMovingSpeed(Info);
        CriminalRate = Info.nCriminalRate;
        DualCount = Info.nDualCount;
        PKCount = Info.nPKCount;
        Sociality = Info.nSociality;
        RemainSulffrage = Info.nRemainSulffrage;
        // End:0x30D
        if(CriminalRate >= 999999)
        {
            strCriminalRate = string(CriminalRate) $ "+";            
        }
        else
        {
            strCriminalRate = string(CriminalRate) $ "";
        }
    }
    CrimRate = CriminalRate;
    // End:0x33D
    if(CrimRate > 255)
    {
        CrimRate = 255;
    }
    // End:0x364
    if(CrimRate > 0)
    {
        CrimRate = Clamp(CrimRate, 100 + (CrimRate / 16), 255);
    }
    NameColor.R = byte(255);
    NameColor.G = byte(255 - CrimRate);
    NameColor.B = byte(255 - CrimRate);
    NameColor.A = byte(255);
    NickNameColor.R = 162;
    NickNameColor.G = 249;
    NickNameColor.B = 236;
    NickNameColor.A = byte(255);
    // End:0x571
    if(Len(nickname) > 0)
    {
        GetTextSize(Name, Width1, Height1);
        GetTextSize(nickname, Width2, Height2);
        // End:0x48E
        if((Width1 + Width2) > 220)
        {
            // End:0x45E
            if(Width1 > 109)
            {
                Name = Left(Name, 8);
                GetTextSize(Name, Width1, Height1);
            }
            // End:0x48E
            if(Width2 > 109)
            {
                nickname = Left(nickname, 8);
                GetTextSize(nickname, Width2, Height2);
            }
        }
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtName1", nickname);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(m_WindowName $ ".txtName1", NickNameColor);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtName2", Name);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(m_WindowName $ ".txtName2", NameColor);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo(m_WindowName $ ".txtName2", ((rectWnd.nX + 15) + Width2) + 6, rectWnd.nY + 9);        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtName1", Name);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(m_WindowName $ ".txtName1", NameColor);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtName2", "");
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtLvName", (string(Level) $ " ") $ ClassName);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtRank", UserRank);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtHP", (string(HP) $ "/") $ string(MaxHP));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtMP", (string(MP) $ "/") $ string(maxMP));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtExp", string(fExpRate) $ "%");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtCP", (string(CP) $ "/") $ string(maxCP));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtSP", string(SP));
    fTmp = (100.0000000 * float(CarringWeight)) / float(CarryWeight);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtWeight", string(fTmp) $ "%");
    // End:0x7EC
    if(PledgeID > 0)
    {
        bPledgeCrestTexture = Class'NWindow.UIDATA_CLAN'.static.GetCrestTexture(PledgeID, PledgeCrestTexture);
        PledgeName = Class'NWindow.UIDATA_CLAN'.static.GetName(PledgeID);
        PledgeNameColor.R = 176;
        PledgeNameColor.G = 155;
        PledgeNameColor.B = 121;
        PledgeNameColor.A = byte(255);        
    }
    else
    {
        PledgeName = GetSystemString(431);
        PledgeNameColor.R = byte(255);
        PledgeNameColor.G = byte(255);
        PledgeNameColor.B = byte(255);
        PledgeNameColor.A = byte(255);
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtPledge", PledgeName);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor(m_WindowName $ ".txtPledge", PledgeNameColor);
    // End:0x8FD
    if(bPledgeCrestTexture)
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTextureWithObject(m_WindowName $ ".texPledgeCrest", PledgeCrestTexture);
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo(m_WindowName $ ".txtPledge", rectWnd.nX + 88, rectWnd.nY + 25);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo(m_WindowName $ ".txtPledge", rectWnd.nX + 68, rectWnd.nY + 25);
    }
    // End:0x977
    if(bHero)
    {
        HeroTexture = "L2UI_CH3.PlayerStatusWnd.myinfo_heroicon";        
    }
    else
    {
        // End:0x9B1
        if(bNobless)
        {
            HeroTexture = "L2UI_CH3.PlayerStatusWnd.myinfo_nobleicon";
        }
    }
    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture(m_WindowName $ ".texHero", HeroTexture);
    // End:0xA0F
    if(m_HennaInfo.STRchange > 0)
    {
        strTmp = ((string(nStr) $ "(+") $ string(m_HennaInfo.STRchange)) $ ")";        
    }
    else
    {
        // End:0xA47
        if(m_HennaInfo.STRchange < 0)
        {
            strTmp = ((string(nStr) $ "(") $ string(m_HennaInfo.STRchange)) $ ")";            
        }
        else
        {
            strTmp = string(nStr);
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtSTR", strTmp);
    // End:0xAB1
    if(m_HennaInfo.DEXchange > 0)
    {
        strTmp = ((string(nDex) $ "(+") $ string(m_HennaInfo.DEXchange)) $ ")";        
    }
    else
    {
        // End:0xAE9
        if(m_HennaInfo.DEXchange < 0)
        {
            strTmp = ((string(nDex) $ "(") $ string(m_HennaInfo.DEXchange)) $ ")";            
        }
        else
        {
            strTmp = string(nDex);
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtDEX", strTmp);
    // End:0xB53
    if(m_HennaInfo.CONchange > 0)
    {
        strTmp = ((string(nCon) $ "(+") $ string(m_HennaInfo.CONchange)) $ ")";        
    }
    else
    {
        // End:0xB8B
        if(m_HennaInfo.CONchange < 0)
        {
            strTmp = ((string(nCon) $ "(") $ string(m_HennaInfo.CONchange)) $ ")";            
        }
        else
        {
            strTmp = string(nCon);
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtCON", strTmp);
    // End:0xBF5
    if(m_HennaInfo.INTchange > 0)
    {
        strTmp = ((string(nInt) $ "(+") $ string(m_HennaInfo.INTchange)) $ ")";        
    }
    else
    {
        // End:0xC2D
        if(m_HennaInfo.INTchange < 0)
        {
            strTmp = ((string(nInt) $ "(") $ string(m_HennaInfo.INTchange)) $ ")";            
        }
        else
        {
            strTmp = string(nInt);
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtINT", strTmp);
    // End:0xC97
    if(m_HennaInfo.WITchange > 0)
    {
        strTmp = ((string(nWit) $ "(+") $ string(m_HennaInfo.WITchange)) $ ")";        
    }
    else
    {
        // End:0xCCF
        if(m_HennaInfo.WITchange < 0)
        {
            strTmp = ((string(nWit) $ "(") $ string(m_HennaInfo.WITchange)) $ ")";            
        }
        else
        {
            strTmp = string(nWit);
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtWIT", strTmp);
    // End:0xD39
    if(m_HennaInfo.MENchange > 0)
    {
        strTmp = ((string(nMen) $ "(+") $ string(m_HennaInfo.MENchange)) $ ")";        
    }
    else
    {
        // End:0xD71
        if(m_HennaInfo.MENchange < 0)
        {
            strTmp = ((string(nMen) $ "(") $ string(m_HennaInfo.MENchange)) $ ")";            
        }
        else
        {
            strTmp = string(nMen);
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtMEN", strTmp);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtPhysicalAttack", string(PhysicalAttack));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtPhysicalDefense", string(PhysicalDefense));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtHitRate", string(HitRate));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtCriticalRate", string(CriticalRate));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtPhysicalAttackSpeed", string(PhysicalAttackSpeed));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtMagicalAttack", string(MagicalAttack));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtMagicDefense", string(MagicDefense));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtPhysicalAvoid", string(PhysicalAvoid));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtMovingSpeed", MovingSpeed);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtMagicCastingSpeed", string(MagicCastingSpeed));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtCriminalRate", strCriminalRate);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtPVP", (string(DualCount) $ " / ") $ string(PKCount));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtSociality", string(Sociality));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText(m_WindowName $ ".txtRemainSulffrage", string(RemainSulffrage));
    UpdateHPBar(HP, MaxHP);
    UpdateMPBar(MP, maxMP);
    UpdateCPBar(CP, maxCP);
    UpdateEXPBar(int(fExpRate), 100);
    UpdateWeightBar(CarringWeight, CarryWeight);
    return;
}

function UpdateHPBar(int Value, int MaxValue)
{
    local int Size;

    Size = 0;
    // End:0x3F
    if(MaxValue > 0)
    {
        Size = 85;
        // End:0x3F
        if(Value < MaxValue)
        {
            Size = (85 * Value) / MaxValue;
        }
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize(m_WindowName $ ".texHP", Size, 12);
    return;
}

function UpdateMPBar(int Value, int MaxValue)
{
    local int Size;

    Size = 0;
    // End:0x3F
    if(MaxValue > 0)
    {
        Size = 85;
        // End:0x3F
        if(Value < MaxValue)
        {
            Size = (85 * Value) / MaxValue;
        }
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize(m_WindowName $ ".texMP", Size, 12);
    return;
}

function UpdateEXPBar(int Value, int MaxValue)
{
    local int Size;

    Size = 0;
    // End:0x3F
    if(MaxValue > 0)
    {
        Size = 85;
        // End:0x3F
        if(Value < MaxValue)
        {
            Size = (85 * Value) / MaxValue;
        }
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize(m_WindowName $ ".texEXP", Size, 12);
    return;
}

function UpdateCPBar(int Value, int MaxValue)
{
    local int Size;

    Size = 0;
    // End:0x3F
    if(MaxValue > 0)
    {
        Size = 85;
        // End:0x3F
        if(Value < MaxValue)
        {
            Size = (85 * Value) / MaxValue;
        }
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize(m_WindowName $ ".texCP", Size, 12);
    return;
}

function UpdateWeightBar(int Value, int MaxValue)
{
    local int Size;
    local float fTmp;
    local string strName;

    Size = 0;
    // End:0x17B
    if(MaxValue > 0)
    {
        fTmp = (100.0000000 * float(Value)) / float(MaxValue);
        // End:0x6F
        if(fTmp <= 50.0000000)
        {
            strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar1";            
        }
        else
        {
            // End:0xC0
            if((fTmp > 50.0000000) && fTmp <= 66.6600000)
            {
                strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar2";                
            }
            else
            {
                // End:0x111
                if((fTmp > 66.6600000) && fTmp <= 80.0000000)
                {
                    strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar3";                    
                }
                else
                {
                    // End:0x14E
                    if(fTmp > 80.0000000)
                    {
                        strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar4";
                    }
                }
            }
        }
        Size = 85;
        // End:0x17B
        if(Value < MaxValue)
        {
            Size = (85 * Value) / MaxValue;
        }
    }
    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture(m_WindowName $ ".texWeight", strName);
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize(m_WindowName $ ".texWeight", Size, 12);
    return;
}

defaultproperties
{
    m_WindowName="DetailStatusWnd"
}
