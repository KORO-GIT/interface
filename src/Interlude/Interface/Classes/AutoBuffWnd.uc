class AutoBuffWnd extends UICommonAPI;

const SPIRIT_ORE = 3031;
const NOBL_TIMER = 4452;
const SKILL_TIMER_DELAY = 500;
const SKILL_TIMER = 4448;

var string m_WindowName;
var WindowHandle Me;
var string BuffParam;
var array<BuffInfo> TopBuffSkills;
var array<BuffInfo> BottomBuffSkills;
var bool bHasNoblesseOrCelestialStatus;
var bool bAutoNoblesseEnabled;
var bool bInvincibleStatusActive;
var ItemWindowHandle BItemWnd;
var ItemWindowHandle TItemWnd;
var int targetID;
var int PlayerID;
var bool bWaitForSelfTargetRestore;

function OnLoad()
{
    RegisterEvent(1280);
    RegisterEvent(1290);
    RegisterEvent(950);
    RegisterEvent(980);
    RegisterEvent(90);
    RegisterEvent(190);
    RegisterEvent(40);
    Me = GetHandle("AutoBuffWnd");
    BItemWnd = ItemWindowHandle(GetHandle((m_WindowName $ ".BItemWnd")));
    TItemWnd = ItemWindowHandle(GetHandle((m_WindowName $ ".TItemWnd")));
    PlayerID = Class'NWindow.UIDATA_PLAYER'.static.GetPlayerID();
    Me.SetWindowTitle("Auto Buff");
    return;
}

function OnShow()
{
    RequestSkillList();
    SetFocus();
    return;
}

function HandleShortcutCommand(string param)
{
    local string Command;

    // End:0x49
    if(ParseString(param, "Command", Command))
    {
        switch(Command)
        {
            // End:0x46
            case "ToggleOpenAutoBuffWnd":
                ToggleOpenAutoBuffWnd();
                // End:0x49
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

function OnEvent(int Index, string param)
{
    switch(Index)
    {
        // End:0x18
        case 1280:
            HandleSkillListStart();
            // End:0xA5
            break;
        // End:0x2E
        case 1290:
            HandleSkillList(param);
            // End:0xA5
            break;
        // End:0x4F
        case 950:
            HandleAddNormalStatus(param);
            BuffParam = param;
            // End:0xA5
            break;
        // End:0x60
        case 980:
            TargetUpdate();
            // End:0xA5
            break;
        // End:0x73
        case 90:
            HandleShortcutCommand(param);
            // End:0xA5
            break;
        // End:0x86
        case 190:
            HandleUpdateHP(param);
            // End:0xA5
            break;
        // End:0xA2
        case 40:
            Me.KillTimer(4448);
            // End:0xA5
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function ToggleOpenAutoBuffWnd()
{
    // End:0x54
    if(IsShowWindow("AutoBuffWnd"))
    {
        HideWindow("AutoBuffWnd");
        PlaySound("InterfaceSound.charstat_close_01");
    }
    else
    {
        ShowWindowWithFocus("AutoBuffWnd");
        PlaySound("InterfaceSound.charstat_open_01");
    }
    return;
}

function OnClickButton(string strID)
{
    // End:0x2B
    if((strID == "BtnClose"))
    {
        HideWindow("AutoBuffWnd");
    }
    return;
}

function OnClickItem(string param, int Index)
{
    ToggleAutoBuffSkill(param, Index);
    return;
}

function OnRClickItem(string param, int Index)
{
    ToggleAutoBuffSkill(param, Index);
    return;
}

function ToggleAutoBuffSkill(string param, int Index)
{
    local ItemInfo Info;

    // End:0x265
    if((Index > -1))
    {
        // End:0xE4
        if((param == "TItemWnd"))
        {
            // End:0xE1
            if(TItemWnd.GetItem(Index, Info))
            {
                // End:0xAB
                if((Info.ForeTexture == ""))
                {
                    // End:0xA8
                    if(IsKnownSkill(Info.ClassID))
                    {
                        AddTopBuffSkill(Info);
                        Info.ForeTexture = "Was.Auto";
                        TItemWnd.SetItem(Index, Info);
                    }
                }
                else
                {
                    RemoveTopBuffSkill(Info.ClassID);
                    Info.ForeTexture = "";
                    TItemWnd.SetItem(Index, Info);
                }
            }
        }
        else
        {
            // End:0x1FE
            if((param == "BItemWnd"))
            {
                // End:0x1FE
                if(BItemWnd.GetItem(Index, Info))
                {
                    // End:0x1A5
                    if((Info.ForeTexture == ""))
                    {
                        // End:0x1A2
                        if(IsKnownSkill(Info.ClassID))
                        {
                            // End:0x169
                            if((Info.ClassID == 1323))
                            {
                                bAutoNoblesseEnabled = true;
                                TargetUpdate();
                            }
                            else
                            {
                                AddBottomBuffSkill(Info);
                            }
                            Info.ForeTexture = "Was.Auto";
                            BItemWnd.SetItem(Index, Info);
                        }
                    }
                    else
                    {
                        // End:0x1C8
                        if((Info.ClassID == 1323))
                        {
                            bAutoNoblesseEnabled = false;
                        }
                        else
                        {
                            RemoveBottomBuffSkill(Info.ClassID);
                        }
                        Info.ForeTexture = "";
                        BItemWnd.SetItem(Index, Info);
                    }
                }
            }
        }
        Me.KillTimer(4448);
        // End:0x265
        if((((TopBuffSkills.Length > 0) || (BottomBuffSkills.Length > 0)) || bAutoNoblesseEnabled))
        {
            HandleAddNormalStatus(BuffParam);
            Me.SetTimer(4448, 500);
        }
    }
    return;
}

function bool IsKnownSkill(int SkillID)
{
    return (Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("MagicSkillWnd.ASkill.SkillItem", SkillID) > -1);
}

function AddTopBuffSkill(ItemInfo Info)
{
    TopBuffSkills.Length = (TopBuffSkills.Length + 1);
    TopBuffSkills[(TopBuffSkills.Length - 1)].Id = Info.ClassID;
    TopBuffSkills[(TopBuffSkills.Length - 1)].BuffInfo_Bool = false;
    TopBuffSkills[(TopBuffSkills.Length - 1)].BuffInfo_Int = GetRequiredWeaponType(Info.ClassID);
    TopBuffSkills[(TopBuffSkills.Length - 1)].Name = Info.Name;
    return;
}

function RemoveTopBuffSkill(int Id)
{
    local int i;

    i = 0;

    while((i < TopBuffSkills.Length))
    {
        // End:0x6F
        if((TopBuffSkills[i].Id == Id))
        {
            TopBuffSkills[i] = TopBuffSkills[(TopBuffSkills.Length - 1)];
            TopBuffSkills.Length = (TopBuffSkills.Length - 1);
            break;
        }
        i++;
    }

    return;
}

function AddBottomBuffSkill(ItemInfo Info)
{
    BottomBuffSkills.Length = (BottomBuffSkills.Length + 1);
    BottomBuffSkills[(BottomBuffSkills.Length - 1)].Id = Info.ClassID;
    BottomBuffSkills[(BottomBuffSkills.Length - 1)].BuffInfo_Bool = false;
    BottomBuffSkills[(BottomBuffSkills.Length - 1)].BuffInfo_Int = GetRequiredWeaponType(Info.ClassID);
    BottomBuffSkills[(BottomBuffSkills.Length - 1)].Name = Info.Name;
    return;
}

function RemoveBottomBuffSkill(int Id)
{
    local int i;

    i = 0;

    while((i < BottomBuffSkills.Length))
    {
        // End:0x6F
        if((BottomBuffSkills[i].Id == Id))
        {
            BottomBuffSkills[i] = BottomBuffSkills[(BottomBuffSkills.Length - 1)];
            BottomBuffSkills.Length = (BottomBuffSkills.Length - 1);
            break;
        }
        i++;
    }

    return;
}

function OnTimer(int Index)
{
    local int i;

    // End:0x2AD
    if((Index == 4448))
    {
        // End:0x50
        if((bAutoNoblesseEnabled && (!bHasNoblesseOrCelestialStatus)))
        {
            // End:0x4A
            if((targetID == PlayerID))
            {
                TryUseNoblesse();
            }
            else
            {
                RequestSelfTarget();
            }
        }
        i = 0;

        while((i < TopBuffSkills.Length))
        {
            // End:0x18A
            if((!TopBuffSkills[i].BuffInfo_Bool))
            {
                // End:0x12C
                if((TopBuffSkills[i].BuffInfo_Int > -1))
                {
                    // End:0xDB
                    if((TopBuffSkills[i].BuffInfo_Int == GetEquippedWeaponType()))
                    {
                        TryUseSkill(TopBuffSkills[i].Id);
                    }
                    else
                    {
                        ChatSystemMsg((("Cannot use " $ TopBuffSkills[i].Name) $ ". Change Weapon!"), GetColor("Amber"));
                    }
                }
                else
                {
                    // End:0x174
                    if((TopBuffSkills[i].Id == 337))
                    {
                        // End:0x171
                        if((GetUserCurrentHP() > 150))
                        {
                            TryUseSkill(TopBuffSkills[i].Id);
                        }
                    }
                    else
                    {
                        TryUseSkill(TopBuffSkills[i].Id);
                    }
                }
            }
            i++;
        }
        i = 0;

        while((i < BottomBuffSkills.Length))
        {
            // End:0x29F
            if((!BottomBuffSkills[i].BuffInfo_Bool))
            {
                // End:0x29F
                if(CanUseBottomBuffSkills())
                {
                    // End:0x289
                    if((BottomBuffSkills[i].BuffInfo_Int > -1))
                    {
                        // End:0x22C
                        if((BottomBuffSkills[i].BuffInfo_Int == GetEquippedWeaponType()))
                        {
                            TryUseSkill(BottomBuffSkills[i].Id);
                        }
                        else
                        {
                            ChatSystemMsg((("[AI SKILLS] Cannot use " $ BottomBuffSkills[i].Name) $ ". Change Weapon!"), GetColor("Amber"));
                        }
                    }
                    else
                    {
                        TryUseSkill(BottomBuffSkills[i].Id);
                    }
                }
            }
            i++;
        }
    }
    return;
}

function HandleAddNormalStatus(string param)
{
    local int i, j, Max, ClassID;
    local bool localBool;

    bInvincibleStatusActive = false;
    ParseInt(param, "Max", Max);
    i = 0;

    while((i < Max))
    {
        bHasNoblesseOrCelestialStatus = false;
        ParseInt(param, ("SkillID_" $ string(i)), ClassID);
        // End:0x7F
        if(IsNoblesseOrCelestialStatus(ClassID))
        {
            bHasNoblesseOrCelestialStatus = true;
            break;
        }
        // End:0x95
        if(IsInvincibleStatus(ClassID))
        {
            bInvincibleStatusActive = true;
        }
        i++;
    }

    i = 0;

    while((i < TopBuffSkills.Length))
    {
        localBool = false;
        j = (Max - 1);

        while((j >= 0))
        {
            ParseInt(param, ("SkillID_" $ string(j)), ClassID);
            // End:0x14A
            if((TopBuffSkills[i].Id == ClassID))
            {
                TopBuffSkills[i].BuffInfo_Bool = true;
                localBool = true;
                break;
            }
            j--;
        }

        // End:0x17A
        if((!localBool))
        {
            TopBuffSkills[i].BuffInfo_Bool = false;
        }
        i++;
    }
    i = 0;

    while((i < BottomBuffSkills.Length))
    {
        localBool = false;
        j = 0;

        while((j < Max))
        {
            ParseInt(param, ("SkillID_" $ string(j)), ClassID);
            // End:0x228
            if((BottomBuffSkills[i].Id == ClassID))
            {
                BottomBuffSkills[i].BuffInfo_Bool = true;
                localBool = true;
                break;
            }
            j++;
        }

        // End:0x258
        if((!localBool))
        {
            BottomBuffSkills[i].BuffInfo_Bool = false;
        }
        i++;
    }
    return;
}

function TargetUpdate()
{
    // End:0x5B
    if(bAutoNoblesseEnabled)
    {
        PlayerID = Class'NWindow.UIDATA_PLAYER'.static.GetPlayerID();
        targetID = Class'NWindow.UIDATA_TARGET'.static.GetTargetID();
        // End:0x5B
        if((!bHasNoblesseOrCelestialStatus))
        {
            // End:0x5B
            if((PlayerID == targetID))
            {
                TryUseNoblesse();
            }
        }
    }
    return;
}

function TryUseNoblesse()
{
    // End:0x24
    if((CountInventoryItemByClassID(3031) >= 5))
    {
        TryUseSkill(1323);
    }
    else
    {
        ChatSystemMsg("[AI SKILLS] Cannot use Noblesse Blessing. Missing SPIRIT ORES", GetColor("Amber"));
    }
    return;
}

function HandleUpdateHP(string param)
{
    local int ServerID;

    // End:0x74
    if(bAutoNoblesseEnabled)
    {
        ParseInt(param, "ServerID", ServerID);
        // End:0x74
        if((ServerID == PlayerID))
        {
            // End:0x58
            if(bWaitForSelfTargetRestore && IsUserAlive())
            {
                RequestSelfTarget();
                bWaitForSelfTargetRestore = false;
            }
            // End:0x6C
            if(IsUserAlive())
            {
                bWaitForSelfTargetRestore = false;
            }
            else
            {
                bWaitForSelfTargetRestore = true;
            }
        }
    }
    return;
}

function HandleSkillListStart()
{
    Clear();
    return;
}

function Clear()
{
    BItemWnd.Clear();
    TItemWnd.Clear();
    return;
}

function HandleSkillList(string param)
{
    local int SkillID, SkillLevel, Lock;
    local string IconName, strSkillName, Description, strEnchantName, strCommand;

    local int i;
    local ItemInfo Info;

    ParseInt(param, "ClassID", SkillID);
    ParseInt(param, "Level", SkillLevel);
    ParseInt(param, "Lock", Lock);
    ParseString(param, "Name", strSkillName);
    ParseString(param, "IconName", IconName);
    ParseString(param, "Description", Description);
    ParseString(param, "EnchantName", strEnchantName);
    ParseString(param, "Command", strCommand);
    Info.ClassID = SkillID;
    Info.Level = SkillLevel;
    Info.Name = strSkillName;
    Info.AdditionalName = strEnchantName;
    Info.IconName = IconName;
    Info.Description = Description;
    Info.ItemSubType = 2;
    Info.MacroCommand = strCommand;
    // End:0x165
    if((Lock > 0))
    {
        Info.bIsLock = true;
    }
    else
    {
        Info.bIsLock = false;
    }
    Info.ForeTexture = "";
    // End:0x203
    if(IsTopBuffSkill(SkillID))
    {
        i = 0;

        while((i < TopBuffSkills.Length))
        {
            // End:0x1DE
            if((TopBuffSkills[i].Id == SkillID))
            {
                Info.ForeTexture = "Was.Auto";
                break;
            }
            i++;
        }

        TItemWnd.AddItem(Info);
    }
    else
    {
        // End:0x302
        if((IsBottomBuffSkill(SkillID) || IsSongDanceSkill(SkillID)))
        {
            // End:0x256
            if((SkillID == 1323))
            {
                // End:0x253
                if(bAutoNoblesseEnabled)
                {
                    Info.ForeTexture = "Was.Auto";
                }
            }
            else
            {
                i = 0;

                while((i < BottomBuffSkills.Length))
                {
                    // End:0x2A7
                    if((BottomBuffSkills[i].Id == SkillID))
                    {
                        Info.ForeTexture = "Was.Auto";
                        break;
                    }
                    i++;
                }
            }

            BItemWnd.AddItem(Info);
            // End:0x302
            if((SkillID == 1323))
            {
                BItemWnd.SwapItems(0, (BItemWnd.GetItemNum() - 1));
            }
        }
    }
    return;
}

function bool CanUseBottomBuffSkills()
{
    // End:0x11
    if((!bInvincibleStatusActive))
    {
        return true;
    }
    return false;
}

function bool IsSongDanceSkill(int ClassID)
{
    switch(ClassID)
    {
        // End:0x0F
        case 264:
        // End:0x17
        case 265:
        // End:0x1F
        case 266:
        // End:0x27
        case 267:
        // End:0x2F
        case 268:
        // End:0x37
        case 269:
        // End:0x3F
        case 270:
        // End:0x47
        case 271:
        // End:0x4F
        case 272:
        // End:0x57
        case 273:
        // End:0x5F
        case 274:
        // End:0x67
        case 275:
        // End:0x6F
        case 276:
        // End:0x77
        case 277:
        // End:0x7F
        case 304:
        // End:0x87
        case 305:
        // End:0x8F
        case 306:
        // End:0x97
        case 307:
        // End:0x9F
        case 308:
        // End:0xA7
        case 309:
        // End:0xAF
        case 310:
        // End:0xB7
        case 311:
        // End:0xBF
        case 349:
        // End:0xC7
        case 363:
        // End:0xCF
        case 364:
        // End:0xD7
        case 365:
        // End:0xE1
        case 366:
            return true;
        // End:0xFFFF
        default:
            return false;
            break;
    }
    return false;
}

function bool IsTopBuffSkill(int ClassID)
{
    switch(ClassID)
    {
        // End:0x0C
        case 196:
        // End:0x11
        case 197:
        // End:0x16
        case 221:
        // End:0x1B
        case 222:
        // End:0x23
        case 256:
        // End:0x2B
        case 288:
        // End:0x33
        case 312:
        // End:0x3B
        case 318:
        // End:0x43
        case 322:
        // End:0x4B
        case 334:
        // End:0x53
        case 335:
        // End:0x5B
        case 336:
        // End:0x63
        case 337:
        // End:0x6B
        case 338:
        // End:0x73
        case 339:
        // End:0x7B
        case 340:
        // End:0x83
        case 422:
        // End:0x8B
        case 424:
        // End:0x93
        case 1001:
        // End:0x9B
        case 1262:
        // End:0xA3
        case 1283:
        // End:0xB0
        case 4476:
            return true;
            // End:0xB8
            break;
        // End:0xFFFF
        default:
            return false;
            break;
    }
    return false;
}

function bool IsBottomBuffSkill(int ClassID)
{
    switch(ClassID)
    {
        // End:0x0F
        case 1323:
        // End:0x14
        case 78:
        // End:0x19
        case 82:
        // End:0x1E
        case 94:
        // End:0x23
        case 99:
        // End:0x28
        case 112:
        // End:0x2D
        case 130:
        // End:0x35
        case 297:
        // End:0x3D
        case 317:
        // End:0x45
        case 357:
        // End:0x4D
        case 356:
        // End:0x55
        case 355:
        // End:0x5D
        case 413:
        // End:0x65
        case 414:
        // End:0x6D
        case 410:
        // End:0x75
        case 415:
        // End:0x7D
        case 416:
        // End:0x85
        case 421:
        // End:0x8D
        case 423:
        // End:0x95
        case 1003:
        // End:0x9D
        case 1008:
        // End:0xA5
        case 1005:
        // End:0xAD
        case 1004:
        // End:0xB5
        case 1249:
        // End:0xBD
        case 1250:
        // End:0xC5
        case 1260:
        // End:0xCD
        case 1261:
        // End:0xD5
        case 1282:
        // End:0xDD
        case 1307:
        // End:0xE5
        case 1364:
        // End:0xF2
        case 1365:
            return true;
            // End:0xFA
            break;
        // End:0xFFFF
        default:
            return false;
            break;
    }
    return false;
}

function int GetRequiredWeaponType(int SkillID)
{
    switch(SkillID)
    {
        // End:0x0F
        case 357:
        // End:0x17
        case 356:
        // End:0x1F
        case 355:
        // End:0x2D
        case 410:
            return 3;
            // End:0xBA
            break;
        // End:0x35
        case 317:
        // End:0x43
        case 421:
            return 4;
            // End:0xBA
            break;
        // End:0x4B
        case 271:
        // End:0x53
        case 272:
        // End:0x5B
        case 273:
        // End:0x63
        case 274:
        // End:0x6B
        case 275:
        // End:0x73
        case 276:
        // End:0x7B
        case 277:
        // End:0x83
        case 309:
        // End:0x8B
        case 310:
        // End:0x93
        case 311:
        // End:0x9B
        case 307:
        // End:0xA9
        case 365:
            return 8;
            // End:0xBA
            break;
        // End:0xB1
        case 222:
            return 5;
        // End:0xFFFF
        default:
            return -1;
            break;
    }
    return 0;
}

function bool IsUserAlive()
{
    // End:0x15
    if((GetUserCurrentHP() > 0))
    {
        return true;
    }
    else
    {
        return false;
    }
    return false;
}

function int GetUserCurrentHP()
{
    local UserInfo Info;

    // End:0x19
    if(GetPlayerInfo(Info))
    {
        return Info.nCurHP;
    }
    return 0;
}

function int CountInventoryItemByClassID(int ItemID)
{
    local int i, idx, resultInt;
    local ItemInfo Info, info2;

    idx = Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItemNum("InventoryWnd.InventoryItem");
    i = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("InventoryWnd.InventoryItem", ItemID);
    // End:0x167
    if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.InventoryItem", i, Info))
    {
        // End:0x139
        if((Info.ItemNum == 1))
        {
            i = 0;

            while((i <= idx))
            {
                // End:0x128
                if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.InventoryItem", i, info2))
                {
                    // End:0x128
                    if((info2.ClassID == ItemID))
                    {
                        resultInt++;
                    }
                }
                ++i;
            }
        }
        else
        {
            // End:0x157
            if((Info.ItemNum == 0))
            {
                resultInt = 0;
            }
            else
            {
                resultInt = Info.ItemNum;
            }
        }
    }
    return resultInt;
}

function TryUseSkill(int SkillID)
{
    // End:0x14
    if(IsUserAlive())
    {
        UseSkill(SkillID);
    }
    return;
}

function ChatSystemMsg(string param, Color Color)
{
    // End:0x55
    if(GetOptionBool("Game", "SystemMsgWnd"))
    {
        Class'NWindow.UIAPI_TEXTLISTBOX'.static.AddString("SystemMsgWnd.SystemMsgList", param, Color);
    }
    else
    {
        Class'NWindow.UIAPI_TEXTLISTBOX'.static.AddString("ChatWnd.NormalChat", param, Color);
        Class'NWindow.UIAPI_TEXTLISTBOX'.static.AddString("ChatWnd.TradeChat", param, Color);
        Class'NWindow.UIAPI_TEXTLISTBOX'.static.AddString("ChatWnd.PartyChat", param, Color);
        Class'NWindow.UIAPI_TEXTLISTBOX'.static.AddString("ChatWnd.ClanChat", param, Color);
        Class'NWindow.UIAPI_TEXTLISTBOX'.static.AddString("ChatWnd.AllyChat", param, Color);
    }
    return;
}

function Color GetColor(string Colors)
{
    local Color RGB;

    RGB.A = byte(255);
    switch(Colors)
    {
        // End:0x4F
        case "Yellow":
            RGB.R = byte(255);
            RGB.G = byte(255);
            RGB.B = 0;
            // End:0x191
            break;
        // End:0x84
        case "System":
            RGB.R = 176;
            RGB.G = 155;
            RGB.B = 121;
            // End:0x191
            break;
        // End:0xB8
        case "Amber":
            RGB.R = 218;
            RGB.G = 165;
            RGB.B = 32;
            // End:0x191
            break;
        // End:0xF2
        case "White":
            RGB.R = byte(255);
            RGB.G = byte(255);
            RGB.B = byte(255);
            // End:0x191
            break;
        // End:0x124
        case "Dim":
            RGB.R = 177;
            RGB.G = 173;
            RGB.B = 172;
            // End:0x191
            break;
        // End:0x15E
        case "Magenta":
            RGB.R = byte(255);
            RGB.G = 0;
            RGB.B = byte(255);
            // End:0x191
            break;
        // End:0xFFFF
        default:
            RGB.R = byte(255);
            RGB.G = byte(255);
            RGB.B = byte(255);
            // End:0x191
            break;
            break;
    }
    return RGB;
}

function bool IsNoblesseOrCelestialStatus(int SkillID)
{
    switch(SkillID)
    {
        // End:0x0F
        case 1323:
        // End:0x17
        case 408:
        // End:0x21
        case 1418:
            return true;
        // End:0xFFFF
        default:
            return false;
            break;
    }
    return false;
}

function bool IsInvincibleStatus(int ClassID)
{
    switch(ClassID)
    {
        // End:0x0F
        case 1418:
        // End:0x1C
        case 1427:
            return true;
            // End:0x1F
            break;
        // End:0xFFFF
        default:
            break;
    }
    return false;
}

function ItemInfo GetWeapon()
{
    local ItemInfo Info;

    Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("InventoryWnd.EquipItem_RHand", 0, Info);
    return Info;
}

function int GetEquippedWeaponType()
{
    return GetWeapon().WeaponType;
}

function SetFocus()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.Container.Tex");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.TItemWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.BItemWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.TSlots");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.BSlots");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.txtToggle");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.txtBuffs");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.texAuto");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.txtAuto");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("AutoBuffWnd.BtnClose");
    return;
}

defaultproperties
{
    m_WindowName="AutoBuffWnd"
}
