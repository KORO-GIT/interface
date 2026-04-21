class AutoPotionsWnd extends UICommonAPI;

const TIMER_CP_ELIXIR = 10198;
const TIMER_HP_ELIXIR = 10199;
const TIMER_CP_POTION = 10200;
const TIMER_HP_POTION = 10201;
const TIMER_MP_POTION = 10202;
const TIMER_INSERT_ON_START = 10210;
const POTION_BUFF_TIMER = 4443;
const POTION_BUFF_DELAY = 1500;

var WindowHandle m_hOptWnd;
var WindowHandle AutoPotionsWnd;
var ItemWindowHandle InventoryItem;
var ItemWindowHandle ElixirBoxCP;
var ItemWindowHandle ElixirBoxHP;
var ItemWindowHandle BoxCP;
var ItemWindowHandle BoxHP;
var ItemWindowHandle BoxMP;
var ItemInfo Elixir_CP_Item;
var ItemInfo Elixir_HP_Item;
var ItemInfo CP_Item;
var ItemInfo HP_Item;
var ItemInfo MP_Item;
var bool ElixirUseCPPot;
var bool ElixirUseHPPot;
var bool UseCPPot;
var bool UseHPPot;
var bool UseMPPot;
var TextureHandle ElixirToggleCP;
var TextureHandle ElixirToggleHP;
var TextureHandle ToggleCP;
var TextureHandle ToggleHP;
var TextureHandle ToggleMP;
var TextBoxHandle ElixirCountCP;
var TextBoxHandle ElixirCountHP;
var TextBoxHandle CountCP;
var TextBoxHandle CountHP;
var TextBoxHandle CountMP;
var bool UseAutoElixirPotionCP;
var bool UseAutoElixirPotionHP;
var bool UseAutoPotionCP;
var bool UseAutoPotionHP;
var bool UseAutoPotionMP;
var bool PotionsEnabled;
var bool hasAcumen;
var bool hasHaste;
var bool hasWW;
var bool hasBlockBuffEffect;
var ItemInfo AcumenPot;
var ItemInfo HastePot;
var ItemInfo WindWalkPot;

function OnLoad()
{
    OnRegisterEvent();
    Init();
    ElixirToggleCP.HideWindow();
    ElixirToggleHP.HideWindow();
    ToggleCP.HideWindow();
    ToggleHP.HideWindow();
    ToggleMP.HideWindow();
    ElixirCountCP.HideWindow();
    ElixirCountHP.HideWindow();
    CountCP.HideWindow();
    CountHP.HideWindow();
    CountMP.HideWindow();
    return;
}

function OnDefaultPosition()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoPotionsWnd", "Menu", "TopRight", "TopRight", -180, -55);
    return;
}

function OnRegisterEvent()
{
    RegisterEvent(150);
    RegisterEvent(230);
    RegisterEvent(190);
    RegisterEvent(210);
    RegisterEvent(950);
    return;
}

function Init()
{
    AutoPotionsWnd = GetHandle("AutoPotionsWnd");
    InventoryItem = ItemWindowHandle(GetHandle("InventoryWnd.InventoryItem"));
    ElixirBoxCP = ItemWindowHandle(GetHandle("AutoPotionsWnd.ElixirBoxCP"));
    ElixirBoxHP = ItemWindowHandle(GetHandle("AutoPotionsWnd.ElixirBoxHP"));
    BoxCP = ItemWindowHandle(GetHandle("AutoPotionsWnd.BoxCP"));
    BoxHP = ItemWindowHandle(GetHandle("AutoPotionsWnd.BoxHP"));
    BoxMP = ItemWindowHandle(GetHandle("AutoPotionsWnd.BoxMP"));
    ElixirToggleCP = TextureHandle(GetHandle("AutoPotionsWnd.ElixirToggleCP"));
    ElixirToggleHP = TextureHandle(GetHandle("AutoPotionsWnd.ElixirToggleHP"));
    ToggleCP = TextureHandle(GetHandle("AutoPotionsWnd.ToggleCP"));
    ToggleHP = TextureHandle(GetHandle("AutoPotionsWnd.ToggleHP"));
    ToggleMP = TextureHandle(GetHandle("AutoPotionsWnd.ToggleMP"));
    ElixirCountCP = TextBoxHandle(GetHandle("AutoPotionsWnd.ElixirCountCP"));
    ElixirCountHP = TextBoxHandle(GetHandle("AutoPotionsWnd.ElixirCountHP"));
    CountCP = TextBoxHandle(GetHandle("AutoPotionsWnd.CountCP"));
    CountHP = TextBoxHandle(GetHandle("AutoPotionsWnd.CountHP"));
    CountMP = TextBoxHandle(GetHandle("AutoPotionsWnd.CountMP"));
    return;
}

function InsertPotionsOnStart()
{
    GetItemInfo(8639, Elixir_CP_Item);
    // End:0x2B
    if(Elixir_CP_Item.ItemNum >= 1)
    {
        InsertElixirCPPotion(Elixir_CP_Item);
    }
    GetItemInfo(8627, Elixir_HP_Item);
    // End:0x56
    if(Elixir_HP_Item.ItemNum >= 1)
    {
        InsertElixirHPPotion(Elixir_HP_Item);
    }
    GetItemInfo(5592, CP_Item);
    // End:0x84
    if(CP_Item.ItemNum >= 1)
    {
        InsertCPPotion(CP_Item);        
    }
    else
    {
        GetItemInfo(6540, CP_Item);
        // End:0xAF
        if(CP_Item.ItemNum >= 1)
        {
            InsertCPPotion(CP_Item);
        }
    }
    GetItemInfo(1539, HP_Item);
    // End:0xDA
    if(HP_Item.ItemNum >= 1)
    {
        InsertHPPotion(HP_Item);
    }
    GetItemInfo(728, MP_Item);
    // End:0x108
    if(MP_Item.ItemNum >= 1)
    {
        InsertMPPotion(MP_Item);        
    }
    else
    {
        GetItemInfo(6539, MP_Item);
        // End:0x133
        if(MP_Item.ItemNum >= 1)
        {
            InsertMPPotion(MP_Item);
        }
    }
    return;
}

function GetItemInfo(int Id, out ItemInfo Info)
{
    local int Index;
    local ItemInfo item;

    Index = InventoryItem.FindItemWithClassID(Id);
    InventoryItem.GetItem(Index, item);
    // End:0x50
    if(Index > -1)
    {
        Info = item;        
    }
    else
    {
        Info.ItemNum = 0;
    }
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x172
        case "BtnSetting":
            // End:0xCA
            if(PotionsEnabled)
            {
                // End:0x3F
                if(ElixirBoxCP.GetItemNum() > 0)
                {
                    DisablePotions(ElixirBoxCP);
                }
                // End:0x5F
                if(ElixirBoxHP.GetItemNum() > 0)
                {
                    DisablePotions(ElixirBoxHP);
                }
                // End:0x7F
                if(BoxCP.GetItemNum() > 0)
                {
                    DisablePotions(BoxCP);
                }
                // End:0x9F
                if(BoxHP.GetItemNum() > 0)
                {
                    DisablePotions(BoxHP);
                }
                // End:0xBF
                if(BoxMP.GetItemNum() > 0)
                {
                    DisablePotions(BoxMP);
                }
                PotionsEnabled = false;                
            }
            else
            {
                // End:0xEA
                if(ElixirBoxCP.GetItemNum() > 0)
                {
                    EnablePotions(ElixirBoxCP);
                }
                // End:0x10A
                if(ElixirBoxHP.GetItemNum() > 0)
                {
                    EnablePotions(ElixirBoxHP);
                }
                // End:0x12A
                if(BoxCP.GetItemNum() > 0)
                {
                    EnablePotions(BoxCP);
                }
                // End:0x14A
                if(BoxHP.GetItemNum() > 0)
                {
                    EnablePotions(BoxHP);
                }
                // End:0x16A
                if(BoxMP.GetItemNum() > 0)
                {
                    EnablePotions(BoxMP);
                }
                PotionsEnabled = true;
            }
        // End:0xFFFF
        default:
            return;
            break;
    }
}

function OnTimer(int TimerID)
{
    // End:0x4C
    if(TimerID == 10198)
    {
        AutoPotionsWnd.KillTimer(10198);
        SetPotionsCount(ElixirCountCP, ElixirBoxCP, Elixir_CP_Item.ClassID);
        Handle_CP_HP_MP_Update(230 + 55667788);
    }
    // End:0x98
    if(TimerID == 10199)
    {
        AutoPotionsWnd.KillTimer(10199);
        SetPotionsCount(ElixirCountHP, ElixirBoxHP, Elixir_HP_Item.ClassID);
        Handle_CP_HP_MP_Update(190 + 11223344);
    }
    // End:0xDD
    if(TimerID == 10200)
    {
        AutoPotionsWnd.KillTimer(10200);
        SetPotionsCount(CountCP, BoxCP, CP_Item.ClassID);
        Handle_CP_HP_MP_Update(230);
    }
    // End:0x122
    if(TimerID == 10201)
    {
        AutoPotionsWnd.KillTimer(10201);
        SetPotionsCount(CountHP, BoxHP, HP_Item.ClassID);
        Handle_CP_HP_MP_Update(190);
    }
    // End:0x167
    if(TimerID == 10202)
    {
        AutoPotionsWnd.KillTimer(10202);
        SetPotionsCount(CountMP, BoxMP, MP_Item.ClassID);
        Handle_CP_HP_MP_Update(210);
    }
    // End:0x190
    if(TimerID == 10210)
    {
        AutoPotionsWnd.KillTimer(10210);
        InsertPotionsOnStart();
    }
    // End:0x1A5
    if(TimerID == 4443)
    {
        TryUsePotions();
    }
    return;
}

function Reset()
{
    AutoPotionsWnd.KillTimer(10198);
    AutoPotionsWnd.KillTimer(10199);
    AutoPotionsWnd.KillTimer(10200);
    AutoPotionsWnd.KillTimer(10201);
    AutoPotionsWnd.KillTimer(10202);
    UseAutoElixirPotionCP = false;
    UseAutoElixirPotionHP = false;
    UseAutoPotionCP = false;
    UseAutoPotionHP = false;
    UseAutoPotionMP = false;
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x15
        case 150:
            HandleGamingStateEnter();
            // End:0xF7
            break;
        // End:0x23
        case 50:
            Reset();
            // End:0xF7
            break;
        // End:0x6D
        case 230:
            // End:0x47
            if(UseCPPot)
            {
                // End:0x47
                if(!UseAutoPotionCP)
                {
                    Handle_CP_HP_MP_Update(a_EventID);
                }
            }
            // End:0x6A
            if(ElixirUseCPPot)
            {
                // End:0x6A
                if(!UseAutoElixirPotionCP)
                {
                    Handle_CP_HP_MP_Update(230 + 55667788);
                }
            }
            // End:0xF7
            break;
        // End:0xB7
        case 190:
            // End:0x91
            if(UseHPPot)
            {
                // End:0x91
                if(!UseAutoPotionHP)
                {
                    Handle_CP_HP_MP_Update(a_EventID);
                }
            }
            // End:0xB4
            if(ElixirUseHPPot)
            {
                // End:0xB4
                if(!UseAutoElixirPotionHP)
                {
                    Handle_CP_HP_MP_Update(190 + 11223344);
                }
            }
            // End:0xF7
            break;
        // End:0xDE
        case 210:
            // End:0xDB
            if(UseMPPot)
            {
                // End:0xDB
                if(!UseAutoPotionMP)
                {
                    Handle_CP_HP_MP_Update(a_EventID);
                }
            }
            // End:0xF7
            break;
        // End:0xF4
        case 950:
            HandleBuffs(a_Param);
            // End:0xF7
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleGamingStateEnter()
{
    Reset();
    AutoPotionsWnd.SetTimer(10210, 2000);
    return;
}

function OnDropItem(string a_WindowID, ItemInfo a_ItemInfo, int X, int Y)
{
    switch(a_WindowID)
    {
        // End:0x25
        case "ElixirBoxCP":
            InsertElixirCPPotion(a_ItemInfo);
            // End:0x8E
            break;
        // End:0x43
        case "ElixirBoxHP":
            InsertElixirHPPotion(a_ItemInfo);
            // End:0x8E
            break;
        // End:0x5B
        case "BoxCP":
            InsertCPPotion(a_ItemInfo);
            // End:0x8E
            break;
        // End:0x73
        case "BoxHP":
            InsertHPPotion(a_ItemInfo);
            // End:0x8E
            break;
        // End:0x8B
        case "BoxMP":
            InsertMPPotion(a_ItemInfo);
            // End:0x8E
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function InsertElixirCPPotion(ItemInfo a_ItemInfo)
{
    // End:0x3D
    if(a_ItemInfo.ClassID != 8639)
    {
        AddSystemMessage(SetText("Remain", Elixir_CP_Item), SetColor("System"));
        return;
    }
    UseAutoElixirPotionCP = false;
    ElixirBoxCP.Clear();
    Elixir_CP_Item = a_ItemInfo;
    ElixirBoxCP.AddItem(a_ItemInfo);
    ElixirCountCP.ShowWindow();
    SetPotionsCount(ElixirCountCP, ElixirBoxCP, 8639);
    return;
}

function InsertElixirHPPotion(ItemInfo a_ItemInfo)
{
    // End:0x3D
    if(a_ItemInfo.ClassID != 8627)
    {
        AddSystemMessage(SetText("Remain", Elixir_HP_Item), SetColor("System"));
        return;
    }
    UseAutoElixirPotionHP = false;
    ElixirBoxHP.Clear();
    Elixir_HP_Item = a_ItemInfo;
    ElixirBoxHP.AddItem(a_ItemInfo);
    ElixirCountHP.ShowWindow();
    SetPotionsCount(ElixirCountHP, ElixirBoxHP, 8627);
    return;
}

function InsertCPPotion(ItemInfo a_ItemInfo)
{
    // End:0x53
    if((a_ItemInfo.ClassID != 5592) && a_ItemInfo.ClassID != 6540)
    {
        AddSystemMessage(SetText("Remain", CP_Item), SetColor("System"));
        return;
    }
    UseAutoPotionCP = false;
    BoxCP.Clear();
    CP_Item = a_ItemInfo;
    BoxCP.AddItem(a_ItemInfo);
    CountCP.ShowWindow();
    SetPotionsCount(CountCP, BoxCP, a_ItemInfo.ClassID);
    return;
}

function InsertHPPotion(ItemInfo a_ItemInfo)
{
    // End:0x3D
    if(a_ItemInfo.ClassID != 1539)
    {
        AddSystemMessage(SetText("Remain", HP_Item), SetColor("System"));
        return;
    }
    UseAutoPotionHP = false;
    BoxHP.Clear();
    HP_Item = a_ItemInfo;
    BoxHP.AddItem(a_ItemInfo);
    CountHP.ShowWindow();
    SetOptionInt("Potions", "Type_HP", HP_Item.ClassID);
    SetPotionsCount(CountHP, BoxHP, HP_Item.ClassID);
    return;
}

function InsertMPPotion(ItemInfo a_ItemInfo)
{
    // End:0x53
    if((a_ItemInfo.ClassID != 728) && a_ItemInfo.ClassID != 6539)
    {
        AddSystemMessage(SetText("Remain", MP_Item), SetColor("System"));
        return;
    }
    UseAutoPotionMP = false;
    BoxMP.Clear();
    MP_Item = a_ItemInfo;
    BoxMP.AddItem(a_ItemInfo);
    CountMP.ShowWindow();
    SetPotionsCount(CountMP, BoxMP, a_ItemInfo.ClassID);
    return;
}

function SetPotionsCount(TextBoxHandle Text, ItemWindowHandle item, int Id)
{
    local int Index;
    local ItemInfo a_ItemInfo;

    Index = InventoryItem.FindItemWithClassID(Id);
    InventoryItem.GetItem(Index, a_ItemInfo);
    // End:0x88
    if(Index > -1)
    {
        // End:0x6A
        if(a_ItemInfo.ItemNum > 99)
        {
            Text.SetText("99+");            
        }
        else
        {
            Text.SetText(string(a_ItemInfo.ItemNum));
        }        
    }
    else
    {
        Text.SetText("");
        item.Clear();
        DisablePotions(item);
    }
    return;
}

function OnClickItem(string strID, int Index)
{
    // End:0x4C
    if((strID == "ElixirBoxCP") && Index > -1)
    {
        // End:0x41
        if(!ElixirUseCPPot)
        {
            EnablePotions(ElixirBoxCP);            
        }
        else
        {
            DisablePotions(ElixirBoxCP);
        }
    }
    // End:0x98
    if((strID == "ElixirBoxHP") && Index > -1)
    {
        // End:0x8D
        if(!ElixirUseHPPot)
        {
            EnablePotions(ElixirBoxHP);            
        }
        else
        {
            DisablePotions(ElixirBoxHP);
        }
    }
    // End:0xDE
    if((strID == "BoxCP") && Index > -1)
    {
        // End:0xD3
        if(!UseCPPot)
        {
            EnablePotions(BoxCP);            
        }
        else
        {
            DisablePotions(BoxCP);
        }
    }
    // End:0x124
    if((strID == "BoxHP") && Index > -1)
    {
        // End:0x119
        if(!UseHPPot)
        {
            EnablePotions(BoxHP);            
        }
        else
        {
            DisablePotions(BoxHP);
        }
    }
    // End:0x16A
    if((strID == "BoxMP") && Index > -1)
    {
        // End:0x15F
        if(!UseMPPot)
        {
            EnablePotions(BoxMP);            
        }
        else
        {
            DisablePotions(BoxMP);
        }
    }
    return;
}

function DisablePotions(ItemWindowHandle ItemWnd)
{
    switch(ItemWnd)
    {
        // End:0x70
        case ElixirBoxCP:
            AutoPotionsWnd.KillTimer(10198);
            ElixirToggleCP.HideWindow();
            ElixirUseCPPot = false;
            UseAutoElixirPotionCP = false;
            AddSystemMessage(SetText("Deactivate", Elixir_CP_Item), SetColor("System"));
            // End:0x217
            break;
        // End:0xD9
        case ElixirBoxHP:
            AutoPotionsWnd.KillTimer(10199);
            ElixirToggleHP.HideWindow();
            ElixirUseHPPot = false;
            UseAutoElixirPotionHP = false;
            AddSystemMessage(SetText("Deactivate", Elixir_HP_Item), SetColor("System"));
            // End:0x217
            break;
        // End:0x142
        case BoxCP:
            AutoPotionsWnd.KillTimer(10200);
            ToggleCP.HideWindow();
            UseCPPot = false;
            UseAutoPotionCP = false;
            AddSystemMessage(SetText("Deactivate", CP_Item), SetColor("System"));
            // End:0x217
            break;
        // End:0x1AB
        case BoxHP:
            AutoPotionsWnd.KillTimer(10201);
            ToggleHP.HideWindow();
            UseHPPot = false;
            UseAutoPotionHP = false;
            AddSystemMessage(SetText("Deactivate", HP_Item), SetColor("System"));
            // End:0x217
            break;
        // End:0x214
        case BoxMP:
            AutoPotionsWnd.KillTimer(10202);
            ToggleMP.HideWindow();
            UseMPPot = false;
            UseAutoPotionMP = false;
            AddSystemMessage(SetText("Deactivate", MP_Item), SetColor("System"));
            // End:0x217
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function EnablePotions(ItemWindowHandle ItemWnd)
{
    switch(ItemWnd)
    {
        // End:0x5A
        case ElixirBoxCP:
            ElixirToggleCP.ShowWindow();
            ElixirUseCPPot = true;
            ExecuteEvent(230);
            AddSystemMessage(SetText("Activate", Elixir_CP_Item), SetColor("System"));
            // End:0x1A9
            break;
        // End:0xAD
        case ElixirBoxHP:
            ElixirToggleHP.ShowWindow();
            ElixirUseHPPot = true;
            ExecuteEvent(190);
            AddSystemMessage(SetText("Activate", Elixir_HP_Item), SetColor("System"));
            // End:0x1A9
            break;
        // End:0x100
        case BoxCP:
            ToggleCP.ShowWindow();
            UseCPPot = true;
            ExecuteEvent(230);
            AddSystemMessage(SetText("Activate", CP_Item), SetColor("System"));
            // End:0x1A9
            break;
        // End:0x153
        case BoxHP:
            ToggleHP.ShowWindow();
            UseHPPot = true;
            ExecuteEvent(190);
            AddSystemMessage(SetText("Activate", HP_Item), SetColor("System"));
            // End:0x1A9
            break;
        // End:0x1A6
        case BoxMP:
            ToggleMP.ShowWindow();
            UseMPPot = true;
            ExecuteEvent(210);
            AddSystemMessage(SetText("Activate", MP_Item), SetColor("System"));
            // End:0x1A9
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function string SetText(string param, ItemInfo a_ItemInfo)
{
    local string Text;

    switch(param)
    {
        // End:0x37
        case "Remain":
            Text = "This slot for " @ a_ItemInfo.Name;
            // End:0x9E
            break;
        // End:0x68
        case "Activate":
            Text = MakeFullSystemMsg(GetSystemMessage(1433), a_ItemInfo.Name);
            // End:0x9E
            break;
        // End:0x9B
        case "Deactivate":
            Text = MakeFullSystemMsg(GetSystemMessage(1434), a_ItemInfo.Name);
            // End:0x9E
            break;
        // End:0xFFFF
        default:
            break;
    }
    return Text;
}

function Color SetColor(string m_Color)
{
    local Color msnColor;

    switch(m_Color)
    {
        // End:0x40
        case "Yellow":
            msnColor.R = byte(255);
            msnColor.G = byte(255);
            msnColor.B = 0;
            // End:0x152
            break;
        // End:0x75
        case "System":
            msnColor.R = 176;
            msnColor.G = 155;
            msnColor.B = 121;
            // End:0x152
            break;
        // End:0xA9
        case "Amber":
            msnColor.R = 218;
            msnColor.G = 165;
            msnColor.B = 32;
            // End:0x152
            break;
        // End:0xE3
        case "White":
            msnColor.R = byte(255);
            msnColor.G = byte(255);
            msnColor.B = byte(255);
            // End:0x152
            break;
        // End:0x115
        case "Dim":
            msnColor.R = 177;
            msnColor.G = 173;
            msnColor.B = 172;
            // End:0x152
            break;
        // End:0x14F
        case "Magenta":
            msnColor.R = byte(255);
            msnColor.G = 0;
            msnColor.B = byte(255);
            // End:0x152
            break;
        // End:0xFFFF
        default:
            break;
    }
    return msnColor;
}

function Handle_CP_HP_MP_Update(int a_EventID)
{
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    switch(a_EventID)
    {
        // End:0x9C
        case 230 + 55667788:
            // End:0x99
            if(ElixirUseCPPot)
            {
                // End:0x91
                if((UserInfo.nCurCP < int(float(UserInfo.nMaxCP) * 0.1000000)) && UserInfo.nCurHP > 0)
                {
                    UseAutoElixirPotionCP = true;
                    AutoPotionsWnd.SetTimer(10198, 1000);
                    RequestUseItem(Elixir_CP_Item.ServerID);                    
                }
                else
                {
                    UseAutoElixirPotionCP = false;
                }
            }
            // End:0x29D
            break;
        // End:0x126
        case 190 + 11223344:
            // End:0x123
            if(ElixirUseHPPot)
            {
                // End:0x11B
                if((UserInfo.nCurHP < int(float(UserInfo.nMaxHP) * 0.4000000)) && UserInfo.nCurHP > 0)
                {
                    UseAutoElixirPotionHP = true;
                    AutoPotionsWnd.SetTimer(10199, 1000);
                    RequestUseItem(Elixir_HP_Item.ServerID);                    
                }
                else
                {
                    UseAutoElixirPotionHP = false;
                }
            }
            // End:0x29D
            break;
        // End:0x19F
        case 230:
            // End:0x19C
            if(UseCPPot)
            {
                // End:0x194
                if((UserInfo.nCurCP < (UserInfo.nMaxCP - 200)) && UserInfo.nCurHP > 0)
                {
                    UseAutoPotionCP = true;
                    AutoPotionsWnd.SetTimer(10200, 100);
                    RequestUseItem(CP_Item.ServerID);                    
                }
                else
                {
                    UseAutoPotionCP = false;
                }
            }
            // End:0x29D
            break;
        // End:0x21B
        case 190:
            // End:0x218
            if(UseHPPot)
            {
                // End:0x210
                if((UserInfo.nCurHP < (UserInfo.nMaxHP - 100)) && UserInfo.nCurHP > 0)
                {
                    UseAutoPotionHP = true;
                    AutoPotionsWnd.SetTimer(10201, 14000);
                    RequestUseItem(HP_Item.ServerID);                    
                }
                else
                {
                    UseAutoPotionHP = false;
                }
            }
            // End:0x29D
            break;
        // End:0x29A
        case 210:
            // End:0x297
            if(UseMPPot)
            {
                // End:0x28F
                if((UserInfo.nCurMP < (UserInfo.nMaxMP - 1000)) && UserInfo.nCurHP > 0)
                {
                    UseAutoPotionMP = true;
                    AutoPotionsWnd.SetTimer(10202, 1000);
                    RequestUseItem(MP_Item.ServerID);                    
                }
                else
                {
                    UseAutoPotionMP = false;
                }
            }
            // End:0x29D
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleBuffs(string param)
{
    local int i, Max;
    local StatusIconInfo Info;

    hasAcumen = false;
    hasWW = false;
    hasHaste = false;
    hasBlockBuffEffect = false;
    ParseInt(param, "Max", Max);
    i = 0;
    J0x3C:

    // End:0xE9 [Loop If]
    if(i < Max)
    {
        ParseInt(param, "SkillID_" $ string(i), Info.ClassID);
        // End:0x8E
        if(AcumenBuff(Info.ClassID))
        {
            hasAcumen = true;
        }
        // End:0xA9
        if(WindWalkBuff(Info.ClassID))
        {
            hasWW = true;
        }
        // End:0xC4
        if(HasteBuff(Info.ClassID))
        {
            hasHaste = true;
        }
        // End:0xDF
        if(IsBlockBuffEffect(Info.ClassID))
        {
            hasBlockBuffEffect = true;
        }
        i++;
        // [Loop Continue]
        goto J0x3C;
    }
    AutoPotionsWnd.KillTimer(4443);
    // End:0x196
    if(GetOptionBool("Custom", "BuffPotions") == true)
    {
        // End:0x196
        if(((!hasAcumen && HavePotions("Acumen")) || !hasHaste && HavePotions("Haste")) || !hasWW && HavePotions("WindWalk"))
        {
            AutoPotionsWnd.SetTimer(4443, 1500);
        }
    }
    return;
}

function TryUsePotions()
{
    local UserInfo UserInfo;

    GetPlayerInfo(UserInfo);
    // End:0x162
    if(UserInfo.nCurHP > 0)
    {
        // End:0x51
        if(((ImFighter()) && hasWW) && hasHaste)
        {
            AutoPotionsWnd.KillTimer(4443);            
        }
        else
        {
            // End:0x87
            if(((ImMage()) && hasWW) && hasAcumen)
            {
                AutoPotionsWnd.KillTimer(4443);                
            }
            else
            {
                // End:0x162
                if(!hasBlockBuffEffect)
                {
                    // End:0xFB
                    if(ImFighter())
                    {
                        // End:0xCB
                        if((HavePotions("WindWalk")) && !hasWW)
                        {
                            RequestUseItem(WindWalkPot.ServerID);
                        }
                        // End:0xF8
                        if((HavePotions("Haste")) && !hasHaste)
                        {
                            RequestUseItem(HastePot.ServerID);
                        }                        
                    }
                    else
                    {
                        // End:0x162
                        if(ImMage())
                        {
                            // End:0x134
                            if((HavePotions("WindWalk")) && !hasWW)
                            {
                                RequestUseItem(WindWalkPot.ServerID);
                            }
                            // End:0x162
                            if((HavePotions("Acumen")) && !hasAcumen)
                            {
                                RequestUseItem(AcumenPot.ServerID);
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function bool HavePotions(string Type)
{
    local bool ResultBool;

    ResultBool = false;
    // End:0x45
    if(Type == "Acumen")
    {
        GetItemInfo(6036, AcumenPot);
        // End:0x42
        if(AcumenPot.ItemNum >= 1)
        {
            ResultBool = true;
        }        
    }
    else
    {
        // End:0x81
        if(Type == "Haste")
        {
            GetItemInfo(1375, HastePot);
            // End:0x7E
            if(HastePot.ItemNum >= 1)
            {
                ResultBool = true;
            }            
        }
        else
        {
            // End:0xBD
            if(Type == "WindWalk")
            {
                GetItemInfo(1374, WindWalkPot);
                // End:0xBD
                if(WindWalkPot.ItemNum >= 1)
                {
                    ResultBool = true;
                }
            }
        }
    }
    return ResultBool;
}

function bool WindWalkBuff(int Id)
{
    local bool ResultBool;

    ResultBool = false;
    switch(Id)
    {
        // End:0x17
        case 1204:
        // End:0x1F
        case 1282:
        // End:0x32
        case 2034:
            ResultBool = true;
            // End:0x35
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

function bool HasteBuff(int Id)
{
    local bool ResultBool;

    ResultBool = false;
    switch(Id)
    {
        // End:0x17
        case 1086:
        // End:0x1F
        case 1251:
        // End:0x32
        case 2035:
            ResultBool = true;
            // End:0x35
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

function bool AcumenBuff(int Id)
{
    local bool ResultBool;

    ResultBool = false;
    switch(Id)
    {
        // End:0x17
        case 1004:
        // End:0x1F
        case 1085:
        // End:0x32
        case 2169:
            ResultBool = true;
            // End:0x35
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

function bool IsBlockBuffEffect(int Id)
{
    local bool ResultBool;

    ResultBool = false;
    switch(Id)
    {
        // End:0x17
        case 1418:
        // End:0x2A
        case 1427:
            ResultBool = true;
            // End:0x2D
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

function bool ImFighter()
{
    local bool ResultBool;
    local UserInfo Info;

    GetPlayerInfo(Info);
    ResultBool = false;
    switch(Info.nSubClass)
    {
        // End:0x23
        case 0:
        // End:0x27
        case 1:
        // End:0x2C
        case 2:
        // End:0x31
        case 88:
        // End:0x36
        case 3:
        // End:0x3B
        case 89:
        // End:0x40
        case 4:
        // End:0x45
        case 5:
        // End:0x4A
        case 90:
        // End:0x4F
        case 6:
        // End:0x54
        case 91:
        // End:0x59
        case 7:
        // End:0x5E
        case 8:
        // End:0x63
        case 93:
        // End:0x68
        case 9:
        // End:0x6D
        case 92:
        // End:0x72
        case 18:
        // End:0x77
        case 19:
        // End:0x7C
        case 20:
        // End:0x81
        case 99:
        // End:0x86
        case 21:
        // End:0x8B
        case 100:
        // End:0x90
        case 22:
        // End:0x95
        case 23:
        // End:0x9A
        case 101:
        // End:0x9F
        case 24:
        // End:0xA4
        case 102:
        // End:0xA9
        case 31:
        // End:0xAE
        case 32:
        // End:0xB3
        case 33:
        // End:0xB8
        case 106:
        // End:0xBD
        case 34:
        // End:0xC2
        case 107:
        // End:0xC7
        case 35:
        // End:0xCC
        case 108:
        // End:0xD1
        case 36:
        // End:0xD6
        case 37:
        // End:0xDB
        case 109:
        // End:0xE0
        case 44:
        // End:0xE5
        case 45:
        // End:0xEA
        case 46:
        // End:0xEF
        case 113:
        // End:0xF4
        case 47:
        // End:0xF9
        case 48:
        // End:0xFE
        case 114:
        // End:0x103
        case 53:
        // End:0x108
        case 54:
        // End:0x10D
        case 55:
        // End:0x112
        case 117:
        // End:0x117
        case 56:
        // End:0x11C
        case 57:
        // End:0x12C
        case 118:
            ResultBool = true;
            // End:0x12F
            break;
        // End:0xFFFF
        default:
            break;
    }
    return ResultBool;
}

function bool ImMage()
{
    return !ImFighter();
}
