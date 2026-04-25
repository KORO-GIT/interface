class BuffOptionsWnd extends UICommonAPI;

var array<int> AbnormalPriorityArray;
var AbnormalDebuffsStatusWnd AbnormalDebuffsStatusWnd;
var array<int> PartyPriorityArray;
var PartyWnd PartyWnd;

function OnLoad()
{
    RegisterEvent(150);
    RegisterEvent(1900);
    AbnormalDebuffsStatusWnd = AbnormalDebuffsStatusWnd(GetScript("AbnormalDebuffsStatusWnd"));
    PartyWnd = PartyWnd(GetScript("PartyWnd"));
    InitInterfaceOption();
    HandleAbnormalPriorityBuffsWindows();
    HandleAbnormalPriorityBuffsList();
    HandlePartyPriorityBuffsWindows();
    HandlePartyPriorityBuffsList();
    ExecuteEvent(4444);
    ExecuteEvent(4445);
    return;
}

function OnEvent(int Index, string param)
{
    // End:0x17
    if(Index == 150)
    {
        ExecuteEvent(11223344);
    }
    if(Index == 1900)
    {
        InitInterfaceOption();
    }
    return;
}

function string GetLocalizedText(string EnglishText, string RussianText)
{
    if(GetOptionBool("Game", "IsNative"))
    {
        return RussianText;
    }
    return EnglishText;
}

function SetBuffOptionTitle(string ControlName, string EnglishText, string RussianText)
{
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("BuffOptionsWnd." $ ControlName, " " $ GetLocalizedText(EnglishText, RussianText));
    return;
}

function InitInterfaceOption()
{
    local bool bOption;

    bOption = GetOptionBool("Custom", "checkAbDebuff");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbDebuff", bOption);
    SetBuffOptionTitle("checkAbDebuff", "Show debuffs on separate row", "Показывать дебаффы отдельной строкой");
    bOption = GetOptionBool("Custom", "checkAbSongDance");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbSongDance", bOption);
    SetBuffOptionTitle("checkAbSongDance", "Show songs/dances on separate row", "Показывать песни/танцы отдельной строкой");
    bOption = GetOptionBool("Custom", "checkAbPrior");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPrior", bOption);
    SetBuffOptionTitle("checkAbPrior", "Show important buffs on separate row", "Показывать важные баффы отдельной строкой");
    bOption = GetOptionBool("Custom", "checkAbPriorNobless");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorNobless", bOption);
    SetBuffOptionTitle("checkAbPriorNobless", "Nobless/Salva/Phoenix", "Ноблесс/Салва/Феникс");
    bOption = GetOptionBool("Custom", "checkAbPriorAcumen");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorAcumen", bOption);
    SetBuffOptionTitle("checkAbPriorAcumen", "Acumen", "Акумен");
    bOption = GetOptionBool("Custom", "checkAbPriorEmpower");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorEmpower", bOption);
    SetBuffOptionTitle("checkAbPriorEmpower", "Empower", "Эмповер");
    bOption = GetOptionBool("Custom", "checkAbPriorWindWalk");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorWindWalk", bOption);
    SetBuffOptionTitle("checkAbPriorWindWalk", "Wind Walk", "Винд Волк");
    bOption = GetOptionBool("Custom", "checkAbPriorMight");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorMight", bOption);
    SetBuffOptionTitle("checkAbPriorMight", "Might", "Майт");
    bOption = GetOptionBool("Custom", "checkAbPriorHaste");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorHaste", bOption);
    SetBuffOptionTitle("checkAbPriorHaste", "Haste", "Хаст");
    bOption = GetOptionBool("Custom", "checkAbPriorPrayer");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorPrayer", bOption);
    SetBuffOptionTitle("checkAbPriorPrayer", "Prayer", "Праер");
    bOption = GetOptionBool("Custom", "checkAbPriorArcana");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorArcana", bOption);
    SetBuffOptionTitle("checkAbPriorArcana", "Arcane Skills", "Аркана скиллы");
    bOption = GetOptionBool("Custom", "checkAbPriorHotSpring");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorHotSpring", bOption);
    SetBuffOptionTitle("checkAbPriorHotSpring", "Hot Spring's Buffs", "Баффы Hot Springs");
    bOption = GetOptionBool("Custom", "checkAbPriorViciousStance");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorViciousStance", bOption);
    SetBuffOptionTitle("checkAbPriorViciousStance", "Vicious Stance", "Vicious Stance");
    bOption = GetOptionBool("Custom", "checkAbPriorHeroicValor");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorHeroicValor", bOption);
    SetBuffOptionTitle("checkAbPriorHeroicValor", "Hero Skills", "Геройские скиллы");
    bOption = GetOptionBool("Custom", "checkAbPriorSummoner");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorSummoner", bOption);
    SetBuffOptionTitle("checkAbPriorSummoner", "Summoner", "Саммонер");
    bOption = GetOptionBool("Custom", "checkAbPriorForce");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorForce", bOption);
    SetBuffOptionTitle("checkAbPriorForce", "Force", "Форс");
    bOption = GetOptionBool("Custom", "checkAbPriorTitan");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorTitan", bOption);
    SetBuffOptionTitle("checkAbPriorTitan", "Titan", "Титан");
    bOption = GetOptionBool("Custom", "checkAbPriorHawkeye");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorHawkeye", bOption);
    SetBuffOptionTitle("checkAbPriorHawkeye", "Hawkeye", "Хавк");
    bOption = GetOptionBool("Custom", "checkAbPriorRanger");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorRanger", bOption);
    SetBuffOptionTitle("checkAbPriorRanger", "Ranger", "Рейнджер");
    bOption = GetOptionBool("Custom", "checkAbPriorKnight");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorKnight", bOption);
    SetBuffOptionTitle("checkAbPriorKnight", "Knight", "Рыцарь");
    bOption = GetOptionBool("Custom", "checkAbPriorMystic");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorMystic", bOption);
    SetBuffOptionTitle("checkAbPriorMystic", "Mystic", "Мистик");
    bOption = GetOptionBool("Custom", "checkAbPriorMagePoV");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorMagePoV", bOption);
    SetBuffOptionTitle("checkAbPriorMagePoV", "Mage PoV", "Маг PoV");
    bOption = GetOptionBool("Custom", "checkAbPriorFighterPoV");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorFighterPoV", bOption);
    SetBuffOptionTitle("checkAbPriorFighterPoV", "Fighter PoV", "Воин PoV");
    bOption = GetOptionBool("Custom", "checkAbPriorTankPoV");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorTankPoV", bOption);
    SetBuffOptionTitle("checkAbPriorTankPoV", "Tank PoV", "Танк PoV");
    bOption = GetOptionBool("Custom", "checkAbPriorDebuffSameRow");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkAbPriorDebuffSameRow", bOption);
    SetBuffOptionTitle("checkAbPriorDebuffSameRow", "Show important buffs on debuff row", "Важные баффы в строке дебаффов");
    bOption = GetOptionBool("Custom", "checkPrior");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPrior", bOption);
    SetBuffOptionTitle("checkPrior", "Show important buffs on separate row", "Показывать важные баффы отдельной строкой");
    bOption = GetOptionBool("Custom", "checkPriorNobless");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorNobless", bOption);
    SetBuffOptionTitle("checkPriorNobless", "Nobless/Salva/Phoenix", "Ноблесс/Салва/Феникс");
    bOption = GetOptionBool("Custom", "checkPriorAcumen");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorAcumen", bOption);
    SetBuffOptionTitle("checkPriorAcumen", "Acumen", "Акумен");
    bOption = GetOptionBool("Custom", "checkPriorEmpower");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorEmpower", bOption);
    SetBuffOptionTitle("checkPriorEmpower", "Empower", "Эмповер");
    bOption = GetOptionBool("Custom", "checkPriorWindWalk");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorWindWalk", bOption);
    SetBuffOptionTitle("checkPriorWindWalk", "Wind Walk", "Винд Волк");
    bOption = GetOptionBool("Custom", "checkPriorMight");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorMight", bOption);
    SetBuffOptionTitle("checkPriorMight", "Might", "Майт");
    bOption = GetOptionBool("Custom", "checkPriorHaste");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorHaste", bOption);
    SetBuffOptionTitle("checkPriorHaste", "Haste", "Хаст");
    bOption = GetOptionBool("Custom", "checkPriorPrayer");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorPrayer", bOption);
    SetBuffOptionTitle("checkPriorPrayer", "Prayer", "Праер");
    bOption = GetOptionBool("Custom", "checkPriorArcana");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorArcana", bOption);
    SetBuffOptionTitle("checkPriorArcana", "Arcane Skills", "Аркана скиллы");
    bOption = GetOptionBool("Custom", "checkPriorHotSpring");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorHotSpring", bOption);
    SetBuffOptionTitle("checkPriorHotSpring", "Hot Spring's Buffs", "Баффы Hot Springs");
    bOption = GetOptionBool("Custom", "checkPriorViciousStance");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorViciousStance", bOption);
    SetBuffOptionTitle("checkPriorViciousStance", "Vicious Stance", "Vicious Stance");
    bOption = GetOptionBool("Custom", "checkPriorHeroicValor");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorHeroicValor", bOption);
    SetBuffOptionTitle("checkPriorHeroicValor", "Hero Skills", "Геройские скиллы");
    bOption = GetOptionBool("Custom", "checkPriorSummoner");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorSummoner", bOption);
    SetBuffOptionTitle("checkPriorSummoner", "Summoner", "Саммонер");
    bOption = GetOptionBool("Custom", "checkPriorForce");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorForce", bOption);
    SetBuffOptionTitle("checkPriorForce", "Force", "Форс");
    bOption = GetOptionBool("Custom", "checkPriorTitan");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorTitan", bOption);
    SetBuffOptionTitle("checkPriorTitan", "Titan", "Титан");
    bOption = GetOptionBool("Custom", "checkPriorHawkeye");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorHawkeye", bOption);
    SetBuffOptionTitle("checkPriorHawkeye", "Hawkeye", "Хавк");
    bOption = GetOptionBool("Custom", "checkPriorRanger");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorRanger", bOption);
    SetBuffOptionTitle("checkPriorRanger", "Ranger", "Рейнджер");
    bOption = GetOptionBool("Custom", "checkPriorKnight");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorKnight", bOption);
    SetBuffOptionTitle("checkPriorKnight", "Knight", "Рыцарь");
    bOption = GetOptionBool("Custom", "checkPriorMystic");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorMystic", bOption);
    SetBuffOptionTitle("checkPriorMystic", "Mystic", "Мистик");
    bOption = GetOptionBool("Custom", "checkPriorMagePoV");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorMagePoV", bOption);
    SetBuffOptionTitle("checkPriorMagePoV", "Mage PoV", "Маг PoV");
    bOption = GetOptionBool("Custom", "checkPriorFighterPoV");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorFighterPoV", bOption);
    SetBuffOptionTitle("checkPriorFighterPoV", "Fighter PoV", "Воин PoV");
    bOption = GetOptionBool("Custom", "checkPriorTankPoV");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorTankPoV", bOption);
    SetBuffOptionTitle("checkPriorTankPoV", "Tank PoV", "Танк PoV");
    bOption = GetOptionBool("Custom", "checkPriorDebuffSameRow");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("BuffOptionsWnd.checkPriorDebuffSameRow", bOption);
    SetBuffOptionTitle("checkPriorDebuffSameRow", "Show important buffs on separate row", "Показывать важные баффы отдельной строкой");
    return;
}

function OnClickCheckBox(string strID)
{
    switch(strID)
    {
        // End:0x83
        case "BuffPotions":
            // End:0x64
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("BuffOptionsWnd.BuffPotions"))
            {
                SetOptionBool("Custom", "BuffPotions", true);                
            }
            else
            {
                SetOptionBool("Custom", "BuffPotions", false);
            }
            // End:0x659
            break;
        // End:0x95
        case "checkAbDebuff":
        // End:0xAA
        case "checkAbSongDance":
        // End:0x110
        case "checkAbPriorDebuffSameRow":
            SetOptionBool("Custom", strID, Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("BuffOptionsWnd." $ strID));
            ExecuteEvent(4444);
            // End:0x659
            break;
        // End:0x16F
        case "checkAbPrior":
            SetOptionBool("Custom", strID, Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("BuffOptionsWnd." $ strID));
            HandleAbnormalPriorityBuffsWindows();
            ExecuteEvent(4444);
            // End:0x659
            break;
        // End:0x187
        case "checkAbPriorNobless":
        // End:0x19E
        case "checkAbPriorPrayer":
        // End:0x1B7
        case "checkAbPriorWindWalk":
        // End:0x1CE
        case "checkAbPriorArcana":
        // End:0x1E5
        case "checkAbPriorAcumen":
        // End:0x1FD
        case "checkAbPriorEmpower":
        // End:0x213
        case "checkAbPriorHaste":
        // End:0x229
        case "checkAbPriorMight":
        // End:0x243
        case "checkAbPriorHotSpring":
        // End:0x261
        case "checkAbPriorViciousStance":
        // End:0x27D
        case "checkAbPriorHeroicValor":
        // End:0x296
        case "checkAbPriorSummoner":
        // End:0x2AC
        case "checkAbPriorForce":
        // End:0x2C2
        case "checkAbPriorTitan":
        // End:0x2DA
        case "checkAbPriorHawkeye":
        // End:0x2F1
        case "checkAbPriorRanger":
        // End:0x308
        case "checkAbPriorKnight":
        // End:0x31F
        case "checkAbPriorMystic":
        // End:0x337
        case "checkAbPriorMagePoV":
        // End:0x352
        case "checkAbPriorFighterPoV":
        // End:0x3B8
        case "checkAbPriorTankPoV":
            SetOptionBool("Custom", strID, Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("BuffOptionsWnd." $ strID));
            HandleAbnormalPriorityBuffsList();
            ExecuteEvent(4444);
            // End:0x659
            break;
        // End:0x41B
        case "checkPrior":
            SetOptionBool("Custom", strID, Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("BuffOptionsWnd." $ strID));
            HandlePartyPriorityBuffsWindows();
            HandlePartyPriorityBuffsList();
            ExecuteEvent(4445);
            // End:0x659
            break;
        // End:0x431
        case "checkPriorNobless":
        // End:0x446
        case "checkPriorPrayer":
        // End:0x45D
        case "checkPriorWindWalk":
        // End:0x472
        case "checkPriorArcana":
        // End:0x487
        case "checkPriorAcumen":
        // End:0x49D
        case "checkPriorEmpower":
        // End:0x4B1
        case "checkPriorHaste":
        // End:0x4C5
        case "checkPriorMight":
        // End:0x4DD
        case "checkPriorHotSpring":
        // End:0x4F9
        case "checkPriorViciousStance":
        // End:0x513
        case "checkPriorHeroicValor":
        // End:0x52F
        case "checkPriorDebuffSameRow":
        // End:0x546
        case "checkPriorSummoner":
        // End:0x55A
        case "checkPriorForce":
        // End:0x56E
        case "checkPriorTitan":
        // End:0x584
        case "checkPriorHawkeye":
        // End:0x599
        case "checkPriorRanger":
        // End:0x5AE
        case "checkPriorKnight":
        // End:0x5C3
        case "checkPriorMystic":
        // End:0x5D9
        case "checkPriorMagePoV":
        // End:0x5F2
        case "checkPriorFighterPoV":
        // End:0x656
        case "checkPriorTankPoV":
            SetOptionBool("Custom", strID, Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("BuffOptionsWnd." $ strID));
            HandlePartyPriorityBuffsList();
            ExecuteEvent(4445);
            // End:0x659
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnShow()
{
    InitInterfaceOption();
    SetFocus();
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1A
        case "OtherTab2OKBtn":
        // End:0x4F
        case "OtherTab3OKBtn":
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd");
            // End:0x81
            break;
        // End:0x7E
        case "BtnClose":
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd");
            // End:0x81
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnComboBoxItemSelected(string sName, int Index)
{
    local int nSelectedNum;

    switch(sName)
    {
        // End:0x7F
        case "AbnormalSizeBox":
            nSelectedNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("BuffOptionsWnd.AbnormalSizeBox");
            SetOptionInt("Custom", "AbnormalSize", nSelectedNum);
            ExecuteEvent(4444);
            // End:0x82
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleAbnormalPriorityBuffsWindows()
{
    // End:0x48E
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPrior"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorNobless");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorAcumen");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorEmpower");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorMight");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorHaste");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorPrayer");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorArcana");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorWindWalk");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorHotSpring");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorDebuffSameRow");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorViciousStance");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorHeroicValor");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorSummoner");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorForce");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorTitan");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorHawkeye");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorRanger");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorKnight");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorMystic");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorMagePoV");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorFighterPoV");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkAbPriorTankPoV");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorNobless");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorAcumen");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorEmpower");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorMight");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorHaste");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorPrayer");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorArcana");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorWindWalk");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorHotSpring");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorDebuffSameRow");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorViciousStance");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorHeroicValor");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorSummoner");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorForce");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorTitan");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorHawkeye");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorRanger");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorKnight");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorMystic");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorMagePoV");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorFighterPoV");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkAbPriorTankPoV");
    }
    return;
}

function HandlePartyPriorityBuffsWindows()
{
    // End:0x497
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPrior"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorNobless");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorAcumen");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorEmpower");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorMight");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorHaste");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorPrayer");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorArcana");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorWindWalk");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorHotSpring");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorDebuffSameRow");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorViciousStance");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorHeroicValor");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorDebuffSameRow");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorSummoner");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorForce");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorTitan");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorHawkeye");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorRanger");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorKnight");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorMystic");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorMagePoV");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorFighterPoV");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("BuffOptionsWnd.checkPriorTankPoV");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorNobless");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorAcumen");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorEmpower");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorMight");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorHaste");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorPrayer");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorArcana");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorWindWalk");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorHotSpring");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorDebuffSameRow");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorViciousStance");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorHeroicValor");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorDebuffSameRow");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorSummoner");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorForce");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorTitan");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorHawkeye");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorRanger");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorKnight");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorMystic");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorMagePoV");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorFighterPoV");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("BuffOptionsWnd.checkPriorTankPoV");
    }
    return;
}

function AddAbnormalPriorityBuffs(int i_Param)
{
    AbnormalPriorityArray.Length = (AbnormalPriorityArray.Length + 1);
    AbnormalPriorityArray[(AbnormalPriorityArray.Length - 1)] = i_Param;
    return;
}

function HandleAbnormalPriorityBuffsList()
{
    AbnormalPriorityArray.Length = 0;
    // End:0x69B
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPrior"))
    {
        // End:0x7B
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorNobless"))
        {
            AddAbnormalPriorityBuffs(1323);
            AddAbnormalPriorityBuffs(1410);
            AddAbnormalPriorityBuffs(438);
            AddAbnormalPriorityBuffs(1418);
        }
        // End:0xAC
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorPrayer"))
        {
            AddAbnormalPriorityBuffs(1307);
        }
        // End:0xF5
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorWindWalk"))
        {
            AddAbnormalPriorityBuffs(1204);
            AddAbnormalPriorityBuffs(2034);
            AddAbnormalPriorityBuffs(1282);
        }
        // End:0x13C
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorArcana"))
        {
            AddAbnormalPriorityBuffs(336);
            AddAbnormalPriorityBuffs(337);
            AddAbnormalPriorityBuffs(338);
        }
        // End:0x18E
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorAcumen"))
        {
            AddAbnormalPriorityBuffs(1085);
            AddAbnormalPriorityBuffs(1004);
            AddAbnormalPriorityBuffs(1002);
            AddAbnormalPriorityBuffs(2169);
        }
        // End:0x1CB
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorEmpower"))
        {
            AddAbnormalPriorityBuffs(1059);
            AddAbnormalPriorityBuffs(1365);
        }
        // End:0x211
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorHaste"))
        {
            AddAbnormalPriorityBuffs(1086);
            AddAbnormalPriorityBuffs(1251);
            AddAbnormalPriorityBuffs(2035);
        }
        // End:0x2D0
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorMight"))
        {
            AddAbnormalPriorityBuffs(1388);
            AddAbnormalPriorityBuffs(3132);
            AddAbnormalPriorityBuffs(3134);
            AddAbnormalPriorityBuffs(3215);
            AddAbnormalPriorityBuffs(3217);
            AddAbnormalPriorityBuffs(3240);
            AddAbnormalPriorityBuffs(3243);
            AddAbnormalPriorityBuffs(4345);
            AddAbnormalPriorityBuffs(4393);
            AddAbnormalPriorityBuffs(5154);
            AddAbnormalPriorityBuffs(5157);
            AddAbnormalPriorityBuffs(1068);
            AddAbnormalPriorityBuffs(1003);
            AddAbnormalPriorityBuffs(1251);
        }
        // End:0x325
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorHotSpring"))
        {
            AddAbnormalPriorityBuffs(4554);
            AddAbnormalPriorityBuffs(4553);
            AddAbnormalPriorityBuffs(4552);
            AddAbnormalPriorityBuffs(4551);
        }
        // End:0x35D
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorViciousStance"))
        {
            AddAbnormalPriorityBuffs(312);
        }
        // End:0x3BF
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorHeroicValor"))
        {
            AddAbnormalPriorityBuffs(395);
            AddAbnormalPriorityBuffs(396);
            AddAbnormalPriorityBuffs(1374);
            AddAbnormalPriorityBuffs(1375);
            AddAbnormalPriorityBuffs(1376);
        }
        // End:0x41E
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorSummoner"))
        {
            AddAbnormalPriorityBuffs(1262);
            AddAbnormalPriorityBuffs(4702);
            AddAbnormalPriorityBuffs(4703);
            AddAbnormalPriorityBuffs(4699);
            AddAbnormalPriorityBuffs(4700);
        }
        // End:0x459
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorForce"))
        {
            AddAbnormalPriorityBuffs(5104);
            AddAbnormalPriorityBuffs(5105);
        }
        // End:0x499
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorTitan"))
        {
            AddAbnormalPriorityBuffs(176);
            AddAbnormalPriorityBuffs(420);
            AddAbnormalPriorityBuffs(94);
        }
        // End:0x4E3
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorHawkeye"))
        {
            AddAbnormalPriorityBuffs(131);
            AddAbnormalPriorityBuffs(313);
            AddAbnormalPriorityBuffs(4);
            AddAbnormalPriorityBuffs(111);
        }
        // End:0x532
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorRanger"))
        {
            AddAbnormalPriorityBuffs(414);
            AddAbnormalPriorityBuffs(413);
            AddAbnormalPriorityBuffs(369);
            AddAbnormalPriorityBuffs(111);
        }
        // End:0x579
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorKnight"))
        {
            AddAbnormalPriorityBuffs(406);
            AddAbnormalPriorityBuffs(341);
            AddAbnormalPriorityBuffs(342);
        }
        // End:0x5E1
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorMystic"))
        {
            AddAbnormalPriorityBuffs(1189);
            AddAbnormalPriorityBuffs(1191);
            AddAbnormalPriorityBuffs(1182);
            AddAbnormalPriorityBuffs(1287);
            AddAbnormalPriorityBuffs(1285);
            AddAbnormalPriorityBuffs(1286);
        }
        // End:0x61E
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorMagePoV"))
        {
            AddAbnormalPriorityBuffs(1413);
            AddAbnormalPriorityBuffs(1355);
        }
        // End:0x65E
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorFighterPoV"))
        {
            AddAbnormalPriorityBuffs(1356);
            AddAbnormalPriorityBuffs(1357);
        }
        // End:0x69B
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkAbPriorTankPoV"))
        {
            AddAbnormalPriorityBuffs(1363);
            AddAbnormalPriorityBuffs(1414);
        }
    }
    AbnormalDebuffsStatusWnd.a_UnkArrayInt1 = AbnormalPriorityArray;
    return;
}

function AddPartyPriorityBuffs(int i_Param)
{
    PartyPriorityArray.Length = (PartyPriorityArray.Length + 1);
    PartyPriorityArray[(PartyPriorityArray.Length - 1)] = i_Param;
    return;
}

function HandlePartyPriorityBuffsList()
{
    PartyPriorityArray.Length = 0;
    // End:0x66F
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPrior"))
    {
        // End:0x77
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorNobless"))
        {
            AddPartyPriorityBuffs(1323);
            AddPartyPriorityBuffs(1410);
            AddPartyPriorityBuffs(438);
            AddPartyPriorityBuffs(1418);
        }
        // End:0xA6
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorPrayer"))
        {
            AddPartyPriorityBuffs(1307);
        }
        // End:0xED
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorWindWalk"))
        {
            AddPartyPriorityBuffs(1204);
            AddPartyPriorityBuffs(2034);
            AddPartyPriorityBuffs(1282);
        }
        // End:0x132
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorArcana"))
        {
            AddPartyPriorityBuffs(336);
            AddPartyPriorityBuffs(337);
            AddPartyPriorityBuffs(338);
        }
        // End:0x182
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorAcumen"))
        {
            AddPartyPriorityBuffs(1085);
            AddPartyPriorityBuffs(1004);
            AddPartyPriorityBuffs(1002);
            AddPartyPriorityBuffs(2169);
        }
        // End:0x1BD
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorEmpower"))
        {
            AddPartyPriorityBuffs(1059);
            AddPartyPriorityBuffs(1365);
        }
        // End:0x201
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorHaste"))
        {
            AddPartyPriorityBuffs(1086);
            AddPartyPriorityBuffs(1251);
            AddPartyPriorityBuffs(2035);
        }
        // End:0x2BE
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorMight"))
        {
            AddPartyPriorityBuffs(1388);
            AddPartyPriorityBuffs(3132);
            AddPartyPriorityBuffs(3134);
            AddPartyPriorityBuffs(3215);
            AddPartyPriorityBuffs(3217);
            AddPartyPriorityBuffs(3240);
            AddPartyPriorityBuffs(3243);
            AddPartyPriorityBuffs(4345);
            AddPartyPriorityBuffs(4393);
            AddPartyPriorityBuffs(5154);
            AddPartyPriorityBuffs(5157);
            AddPartyPriorityBuffs(1068);
            AddPartyPriorityBuffs(1003);
            AddPartyPriorityBuffs(1251);
        }
        // End:0x311
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorHotSpring"))
        {
            AddPartyPriorityBuffs(4554);
            AddPartyPriorityBuffs(4553);
            AddPartyPriorityBuffs(4552);
            AddPartyPriorityBuffs(4551);
        }
        // End:0x347
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorViciousStance"))
        {
            AddPartyPriorityBuffs(312);
        }
        // End:0x3A7
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorHeroicValor"))
        {
            AddPartyPriorityBuffs(395);
            AddPartyPriorityBuffs(396);
            AddPartyPriorityBuffs(1374);
            AddPartyPriorityBuffs(1375);
            AddPartyPriorityBuffs(1376);
        }
        // End:0x404
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorSummoner"))
        {
            AddPartyPriorityBuffs(1262);
            AddPartyPriorityBuffs(4702);
            AddPartyPriorityBuffs(4703);
            AddPartyPriorityBuffs(4699);
            AddPartyPriorityBuffs(4700);
        }
        // End:0x43D
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorForce"))
        {
            AddPartyPriorityBuffs(5104);
            AddPartyPriorityBuffs(5105);
        }
        // End:0x47B
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorTitan"))
        {
            AddPartyPriorityBuffs(176);
            AddPartyPriorityBuffs(420);
            AddPartyPriorityBuffs(94);
        }
        // End:0x4C3
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorHawkeye"))
        {
            AddPartyPriorityBuffs(131);
            AddPartyPriorityBuffs(313);
            AddPartyPriorityBuffs(4);
            AddPartyPriorityBuffs(111);
        }
        // End:0x510
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorRanger"))
        {
            AddPartyPriorityBuffs(414);
            AddPartyPriorityBuffs(413);
            AddPartyPriorityBuffs(369);
            AddPartyPriorityBuffs(111);
        }
        // End:0x555
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorKnight"))
        {
            AddPartyPriorityBuffs(406);
            AddPartyPriorityBuffs(341);
            AddPartyPriorityBuffs(342);
        }
        // End:0x5BB
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorMystic"))
        {
            AddPartyPriorityBuffs(1189);
            AddPartyPriorityBuffs(1191);
            AddPartyPriorityBuffs(1182);
            AddPartyPriorityBuffs(1287);
            AddPartyPriorityBuffs(1285);
            AddPartyPriorityBuffs(1286);
        }
        // End:0x5F6
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorMagePoV"))
        {
            AddPartyPriorityBuffs(1413);
            AddPartyPriorityBuffs(1355);
        }
        // End:0x634
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorFighterPoV"))
        {
            AddPartyPriorityBuffs(1356);
            AddPartyPriorityBuffs(1357);
        }
        // End:0x66F
        if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("checkPriorTankPoV"))
        {
            AddPartyPriorityBuffs(1363);
            AddPartyPriorityBuffs(1414);
        }
    }
    PartyWnd.a_UnkArrayInt1 = PartyPriorityArray;
    return;
}

function SetFocus()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("BuffOptionsWnd.TabCtrl");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("BuffOptionsWnd.BtnClose");
    return;
}
