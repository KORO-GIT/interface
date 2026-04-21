class SummonedWnd extends UIScript;

const NPET_SMALLBARSIZE = 125;
const NPET_BARHEIGHT = 12;

var int m_PetID;

function OnLoad()
{
    RegisterEvent(250);
    RegisterEvent(1090);
    RegisterEvent(1130);
    RegisterEvent(1340);
    RegisterEvent(1350);
    RegisterEvent(1900);
    HideScrollBar();
    return;
}

function OnShow()
{
    Class'NWindow.ActionAPI'.static.RequestSummonedActionList();
    return;
}

function HandleLanguageChanged()
{
    Class'NWindow.ActionAPI'.static.RequestSummonedActionList();
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x15
    if(Event_ID == 250)
    {
        HandlePetInfoUpdate();        
    }
    else
    {
        // End:0x2D
        if(Event_ID == 1130)
        {
            HandlePetSummonedStatusClose();            
        }
        else
        {
            // End:0x45
            if(Event_ID == 1090)
            {
                HandlePetShow();                
            }
            else
            {
                // End:0x5D
                if(Event_ID == 1340)
                {
                    HandleActionSummonedListStart();                    
                }
                else
                {
                    // End:0x7A
                    if(Event_ID == 1350)
                    {
                        HandleActionSummonedList(param);                        
                    }
                    else
                    {
                        // End:0x8F
                        if(Event_ID == 1900)
                        {
                            HandleLanguageChanged();
                        }
                    }
                }
            }
        }
    }
    return;
}

function OnClickItem(string strID, int Index)
{
    local ItemInfo infItem;

    // End:0x8C
    if((strID == "SummonedActionWnd") && Index > -1)
    {
        // End:0x8C
        if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("SummonedWnd.SummonedWnd_Action.SummonedActionWnd", Index, infItem))
        {
            DoAction(infItem.ClassID);
        }
    }
    return;
}

function HideScrollBar()
{
    Class'NWindow.UIAPI_ITEMWINDOW'.static.ShowScrollBar("SummonedWnd.SummonedWnd_Action.SummonedActionWnd", false);
    return;
}

function HandleActionSummonedListStart()
{
    ClearActionWnd();
    return;
}

function Clear()
{
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtLvName", "");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtHP", "0/0");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtMP", "0/0");
    UpdateHPBar(0, 0);
    UpdateMPBar(0, 0);
    return;
}

function ClearActionWnd()
{
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("SummonedWnd.SummonedWnd_Action.SummonedActionWnd");
    return;
}

function HandlePetSummonedStatusClose()
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("SummonedWnd");
    PlayConsoleSound(IFST_WINDOW_CLOSE);
    return;
}

function HandlePetInfoUpdate()
{
    local string Name;
    local int HP, MaxHP, MP, maxMP, Level, PhysicalAttack,
	    PhysicalDefense, HitRate, CriticalRate, PhysicalAttackSpeed, MagicalAttack,
	    MagicDefense, PhysicalAvoid, MovingSpeed, MagicCastingSpeed, SoulShotCosume,
	    SpiritShotConsume;

    local PetInfo Info;

    // End:0x13E
    if(GetPetInfo(Info))
    {
        m_PetID = Info.nID;
        Name = Info.Name;
        Level = Info.nLevel;
        HP = Info.nCurHP;
        MaxHP = Info.nMaxHP;
        MP = Info.nCurMP;
        maxMP = Info.nMaxMP;
        PhysicalAttack = Info.nPhysicalAttack;
        PhysicalDefense = Info.nPhysicalDefense;
        HitRate = Info.nHitRate;
        CriticalRate = Info.nCriticalRate;
        PhysicalAttackSpeed = Info.nPhysicalAttackSpeed;
        MagicalAttack = Info.nMagicalAttack;
        MagicDefense = Info.nMagicDefense;
        PhysicalAvoid = Info.nPhysicalAvoid;
        MovingSpeed = Info.nMovingSpeed;
        MagicCastingSpeed = Info.nMagicCastingSpeed;
        SoulShotCosume = Info.nSoulShotCosume;
        SpiritShotConsume = Info.nSpiritShotConsume;
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtLvName", (string(Level) $ " ") $ Name);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtHP", (string(HP) $ "/") $ string(MaxHP));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtMP", (string(MP) $ "/") $ string(maxMP));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtPhysicalAttack", string(PhysicalAttack));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtPhysicalDefense", string(PhysicalDefense));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtHitRate", string(HitRate));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtCriticalRate", string(CriticalRate));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtPhysicalAttackSpeed", string(PhysicalAttackSpeed));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtMagicalAttack", string(MagicalAttack));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtMagicDefense", string(MagicDefense));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtPhysicalAvoid", string(PhysicalAvoid));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtMovingSpeed", string(MovingSpeed));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtMagicCastingSpeed", string(MagicCastingSpeed));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtSoulShotCosume", string(SoulShotCosume));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("SummonedWnd.txtSpiritShotConsume", string(SpiritShotConsume));
    UpdateHPBar(HP, MaxHP);
    UpdateMPBar(MP, maxMP);
    return;
}

function HandlePetShow()
{
    Clear();
    HandlePetInfoUpdate();
    PlayConsoleSound(IFST_WINDOW_OPEN);
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("SummonedWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("SummonedWnd");
    return;
}

function UpdateHPBar(int Value, int MaxValue)
{
    local int Size;

    Size = 0;
    // End:0x3F
    if(MaxValue > 0)
    {
        Size = 125;
        // End:0x3F
        if(Value < MaxValue)
        {
            Size = (125 * Value) / MaxValue;
        }
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("SummonedWnd.texHP", Size, 12);
    return;
}

function UpdateMPBar(int Value, int MaxValue)
{
    local int Size;

    Size = 0;
    // End:0x3F
    if(MaxValue > 0)
    {
        Size = 125;
        // End:0x3F
        if(Value < MaxValue)
        {
            Size = (125 * Value) / MaxValue;
        }
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("SummonedWnd.texMP", Size, 12);
    return;
}

function HandleActionSummonedList(string param)
{
    local int tmp;
    local UIEventManager.EActionCategory Type;
    local int ActionID;
    local string strActionName, strIconName, strDescription, strCommand;
    local ItemInfo infItem;

    ParseInt(param, "Type", tmp);
    ParseInt(param, "ActionID", ActionID);
    ParseString(param, "Name", strActionName);
    ParseString(param, "IconName", strIconName);
    ParseString(param, "Description", strDescription);
    ParseString(param, "Command", strCommand);
    infItem.ClassID = ActionID;
    infItem.Name = strActionName;
    infItem.IconName = strIconName;
    infItem.Description = strDescription;
    infItem.ItemSubType = 3;
    infItem.MacroCommand = strCommand;
    Type = EActionCategory(tmp);
    // End:0x158
    if(Type == ACTION_SUMMON)
    {
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("SummonedWnd.SummonedWnd_Action.SummonedActionWnd", infItem);
    }
    return;
}
