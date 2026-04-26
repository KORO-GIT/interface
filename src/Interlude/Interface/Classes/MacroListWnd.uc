class MacroListWnd extends UICommonAPI;

const MACRO_MAX_COUNT = 24;

var WindowHandle WndHandle;
var bool m_bShow;
var int m_DeleteID;
var int m_Max;
var ItemWindowHandle ItemWindowHandle;
var array<int> MacroDelayFlags;
var array<int> MacroDelaySeconds;
var array<string> MacroCommands;
var int SelectedMacroID;
var int MacroCommandCount;
var int DelayCommandValueOffset;
var int MacroTimerBaseID;
var int NextCommandOffset;
var int MacroTimerDelayMs;
var string DelayCommand;
var string WindowName;
var string SelectedMacroTexture;
var string EmptyString;
var MacroEditWnd MacroEditWnd;

function OnLoad()
{
    WindowName = "MacroListWnd";
    WndHandle = GetHandle(WindowName);
    ItemWindowHandle = ItemWindowHandle(GetHandle((WindowName $ ".MacroItem")));
    MacroEditWnd = MacroEditWnd(GetScript("MacroEditWnd"));
    RegisterEvent(1710);
    RegisterEvent(1230);
    RegisterEvent(1240);
    RegisterEvent(1250);
    m_bShow = false;
    m_DeleteID = 0;
    Init();
    return;
}

function Init()
{
    SelectedMacroTexture = "l2_skilltime.ToggleEffect001";
    EmptyString = "";
    DelayCommand = "/delay";
    MacroCommandCount = 12;
    DelayCommandValueOffset = 7;
    NextCommandOffset = 1;
    MacroTimerBaseID = 0;
    MacroTimerDelayMs = 1000;
    return;
}

function OnEnterState(name a_PreStateName)
{
    Class'NWindow.MacroAPI'.static.RequestMacroList();
    return;
}

function OnShow()
{
    m_bShow = true;
    SetFocus();
    return;
}

function OnHide()
{
    m_bShow = false;
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1C
        case "BtnHelp":
            OnClickHelp();
            // End:0x52
            break;
        // End:0x30
        case "BtnAdd":
            OnClickAdd();
            // End:0x52
            break;
        // End:0x4F
        case "BtnClose":
            WndHandle.HideWindow();
            // End:0x52
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x1C
    if((Event_ID == 1230))
    {
        HandleMacroShowListWnd();
    }
    else
    {
        // End:0x38
        if((Event_ID == 1240))
        {
            RefreshMacroList();
        }
        else
        {
            // End:0x59
            if((Event_ID == 1250))
            {
                HandleMacroList(param);
            }
            else
            {
                // End:0xC5
                if((Event_ID == 1710))
                {
                    // End:0xC5
                    if(DialogIsMine())
                    {
                        // End:0xC5
                        if((m_DeleteID > MacroTimerBaseID))
                        {
                            Class'NWindow.MacroAPI'.static.RequestDeleteMacro(m_DeleteID);
                            m_DeleteID = MacroTimerBaseID;
                            // End:0xC5
                            if((m_Max == NextCommandOffset))
                            {
                                HandleMacroList(EmptyString);
                            }
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
    local ItemInfo ItemInfo;

    // End:0x64
    if(((strID == "MacroItem") && (Index > -1)))
    {
        // End:0x64
        if(ItemWindowHandle.GetItem(Index, ItemInfo))
        {
            Class'NWindow.MacroAPI'.static.RequestUseMacro(ItemInfo.ClassID);
        }
    }
    return;
}

function OnRClickItem(string strID, int Index)
{
    local ItemInfo ItemInfo;
    local MacroInfo MacroInfo;
    local int idx;

    if((strID != "MacroItem") || Index < 0)
    {
        return;
    }
    ResetMacroPlayback();
    if(!ItemWindowHandle.GetItem(Index, ItemInfo))
    {
        RefreshMacroList();
        return;
    }
    if(ItemInfo.ClassID == SelectedMacroID)
    {
        SelectedMacroID = MacroTimerBaseID;
        RefreshMacroList();
        return;
    }
    SelectedMacroID = ItemInfo.ClassID;
    if(!Class'NWindow.UIDATA_MACRO'.static.GetMacroInfo(ItemInfo.ClassID, MacroInfo))
    {
        SelectedMacroID = MacroTimerBaseID;
        RefreshMacroList();
        return;
    }
    MacroDelayFlags.Length = MacroCommandCount;
    MacroDelaySeconds.Length = MacroCommandCount;
    MacroCommands.Length = MacroCommandCount;
    idx = MacroTimerBaseID;

    while(idx < MacroCommandCount)
    {
        MacroDelayFlags[idx] = MacroTimerBaseID;
        MacroDelaySeconds[idx] = 0;
        MacroCommands[idx] = EmptyString;
        if(Left(MacroInfo.CommandList[idx], DelayCommandValueOffset - NextCommandOffset) ~= DelayCommand)
        {
            MacroDelayFlags[idx] = 1;
            MacroDelaySeconds[idx] = int(Right(MacroInfo.CommandList[idx], Len(MacroInfo.CommandList[idx]) - DelayCommandValueOffset));
            if(MacroDelaySeconds[idx] < 1)
            {
                MacroDelaySeconds[idx] = 1;
            }
        }
        else
        {
            MacroCommands[idx] = MacroInfo.CommandList[idx];
        }
        idx++;
    }
    WndHandle.SetTimer(MacroTimerBaseID, (MacroTimerDelayMs / 4));
    RefreshMacroList();
    return;
}

function OnClickHelp()
{
    local string strParam;

    ParamAdd(strParam, "FilePath", "..L2texthelp_macro.htm");
    ExecuteEvent(1210, strParam);
    return;
}

function OnClickAdd()
{
    MacroEditWnd.m_bShow = false;
    Class'NWindow.UIAPI_MULTIEDITBOX'.static.SetString("MacroInfoWnd.txtInfo", "");
    ExecuteEvent(1260, "");
    return;
}

function RefreshMacroList()
{
    Class'NWindow.MacroAPI'.static.RequestMacroList();
    return;
}

function HandleMacroShowListWnd()
{
    // End:0x31
    if(m_bShow)
    {
        PlayConsoleSound(IFST_WINDOW_CLOSE);
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroListWnd");
    }
    else
    {
        PlayConsoleSound(IFST_WINDOW_OPEN);
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroListWnd");
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroListWnd");
    }
    return;
}

function Clear()
{
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("MacroListWnd.MacroItem");
    return;
}

function ResetMacroPlayback()
{
    local int idx;

    idx = MacroTimerBaseID;

    while((idx < MacroCommandCount))
    {
        WndHandle.KillTimer(idx);
        idx++;
    }
    MacroDelayFlags.Length = MacroTimerBaseID;
    MacroDelaySeconds.Length = MacroTimerBaseID;
    MacroCommands.Length = MacroTimerBaseID;
    RefreshMacroList();
    return;
}

function HandleMacroList(string param)
{
    local int idx, MacroCount, MacroID;
    local string strIconName, strMacroName, strDescription, TextureName, strTmp;

    local ItemInfo ItemInfo;
    local int Index;

    Clear();
    ParseInt(param, "Max", MacroCount);
    m_Max = MacroCount;
    idx = MacroTimerBaseID;

    while((idx < MacroCount))
    {
        MacroID = MacroTimerBaseID;
        strIconName = EmptyString;
        strMacroName = EmptyString;
        strDescription = EmptyString;
        TextureName = EmptyString;
        ParseInt(param, ("ID_" $ string(idx)), MacroID);
        ParseString(param, ("IconName_" $ string(idx)), strIconName);
        ParseString(param, ("MacroName_" $ string(idx)), strMacroName);
        ParseString(param, ("Description_" $ string(idx)), strDescription);
        ParseString(param, ("TextureName_" $ string(idx)), TextureName);
        ItemInfo.ClassID = MacroID;
        ItemInfo.Name = strMacroName;
        ItemInfo.AdditionalName = strIconName;
        ItemInfo.IconName = TextureName;
        ItemInfo.Description = strDescription;
        ItemInfo.ItemSubType = 4;
        Index = GetMacroIconNumFromTextureName(TextureName);
        if(Index > 0)
        {
            SaveMacroIconNum(MacroID, ItemInfo.Name, Index);
            if(Index > DelayCommandValueOffset)
            {
                ItemInfo.IconName = "L2UI.Macro_Icon" $ string(Index);
            }
        }
        // End:0x1CC
        if((ItemInfo.ClassID == SelectedMacroID))
        {
            ItemInfo.ForeTexture = SelectedMacroTexture;
        }
        else
        {
            ItemInfo.ForeTexture = EmptyString;
        }
        // End:0x241
        if((TextureName == EmptyString))
        {
            Index = GetMacroNumByID(MacroID);
            if(Index < 1)
            {
                Index = GetMacroNum(ItemInfo.Name);
            }
            // End:0x241
            if((Index > DelayCommandValueOffset))
            {
                ItemInfo.IconName = ("L2UI.Macro_Icon" $ string(Index));
            }
        }
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("MacroListWnd.MacroItem", ItemInfo);
        idx++;
    }
    // End:0x29F
    if((MacroCount < 10))
    {
        strTmp = (strTmp $ "0");
    }
    strTmp = (strTmp $ string(MacroCount));
    strTmp = (((("(" $ strTmp) $ "/") $ string(24)) $ ")");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("MacroListWnd.txtCount", strTmp);
    return;
}

function OnDropItem(string strID, ItemInfo ItemInfo, int X, int Y)
{
    switch(strID)
    {
        // End:0x22
        case "BtnTrash":
            DeleteMacro(ItemInfo);
            // End:0x3F
            break;
        // End:0x3C
        case "BtnEdit":
            EditMacro(ItemInfo);
            // End:0x3F
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnTimer(int Index)
{
    local int NextIndex;

    WndHandle.KillTimer(Index);
    if((Index < MacroTimerBaseID) || Index >= MacroCommandCount)
    {
        WndHandle.SetTimer(MacroTimerBaseID, MacroTimerDelayMs);
        return;
    }
    if((MacroDelayFlags.Length < MacroCommandCount) || (MacroDelaySeconds.Length < MacroCommandCount) || (MacroCommands.Length < MacroCommandCount))
    {
        ResetMacroPlayback();
        return;
    }
    NextIndex = Index + NextCommandOffset;
    // End:0xCC
    if((MacroDelayFlags[Index] == MacroTimerBaseID))
    {
        if(MacroCommands[Index] != EmptyString)
        {
            ExecuteCommand(MacroCommands[Index]);
        }
        // End:0xB0
        if((NextIndex < MacroCommandCount) && ((MacroCommands[NextIndex] != EmptyString) || (MacroDelayFlags[NextIndex] != MacroTimerBaseID)))
        {
            WndHandle.SetTimer(NextIndex, MacroTimerDelayMs);
        }
        else
        {
            WndHandle.SetTimer(MacroTimerBaseID, MacroTimerDelayMs);
        }
    }
    else
    {
        if(NextIndex < MacroCommandCount)
        {
            WndHandle.SetTimer(NextIndex, (MacroDelaySeconds[Index] * MacroTimerDelayMs));
        }
        else
        {
            WndHandle.SetTimer(MacroTimerBaseID, MacroTimerDelayMs);
        }
    }
    return;
}

function DeleteMacro(ItemInfo ItemInfo)
{
    local string strMsg;

    // End:0x17
    if((ItemInfo.ItemSubType != 4))
    {
        return;
    }
    strMsg = MakeFullSystemMsg(GetSystemMessage(828), ItemInfo.Name, EmptyString);
    m_DeleteID = ItemInfo.ClassID;
    DialogShow(DIALOG_Warning, strMsg);
    // End:0x78
    if((ItemInfo.ClassID == SelectedMacroID))
    {
        ResetMacroPlayback();
    }
    return;
}

function EditMacro(ItemInfo ItemInfo)
{
    local int MacroID;
    local string param;

    // End:0x43
    if((!Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("MacroEditWnd")))
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroEditWnd");
    }
    // End:0x5A
    if((ItemInfo.ItemSubType != 4))
    {
        return;
    }
    MacroID = ItemInfo.ClassID;
    ParamAdd(param, "MacroID", string(MacroID));
    ExecuteEvent(1260, param);
    return;
}

function SetFocus()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroListWnd.TxtHead");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroListWnd.TxtCount");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroListWnd.MacroItem");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroListWnd.BtnAdd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroListWnd.BtnHelp");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroListWnd.BtnEdit");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroListWnd.BtnTrash");
    return;
}
