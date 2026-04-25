class MacroEditWnd extends UICommonAPI;

const MACRO_ICONANME = "L2UI.MacroWnd.Macro_Icon";
const MACROICON_MAX_COUNT = 104;
const MACROCOMMAND_MAX_COUNT = 12;
const MACRO_MAX_COUNT = 24;

var bool m_bShow;
var int unkInt3;
var int m_CurMacroID;
var int unkInt1;
var int unkInt2;

function OnLoad()
{
    RegisterEvent(150);
    RegisterEvent(1710);
    RegisterEvent(1260);
    RegisterEvent(1270);
    m_bShow = false;
    unkInt3 = 1;
    m_CurMacroID = 0;
    unkInt1 = 7;
    InitTabOrder();
    HandleMacroList();
    unkInt2 = 1;
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
        case "BtnInfo":
            unkFunction();
            // End:0x8B
            break;
        // End:0x31
        case "BtnHelp":
            OnClickHelp();
            // End:0x8B
            break;
        // End:0x48
        case "BtnCancel":
            OnClickCancel();
            // End:0x8B
            break;
        // End:0x5D
        case "BtnLeft":
            OnClickLeft();
            // End:0x8B
            break;
        // End:0x73
        case "BtnRight":
            OnClickRight();
            // End:0x8B
            break;
        // End:0x88
        case "BtnSave":
            OnClickSave();
            // End:0x8B
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x21
    if((Event_ID == 1260))
    {
        HandleMacroShowEditWnd(param);        
    }
    else
    {
        // End:0x42
        if((Event_ID == 1270))
        {
            HandleMacroDeleted(param);            
        }
        else
        {
            // End:0x60
            if((Event_ID == 1710))
            {
                // End:0x60
                if(!DialogIsMine())
                {
                }
            }
        }
    }
    return;
}

function InitTabOrder()
{
    local int idx;

    Class'NWindow.UIAPI_WINDOW'.static.SetTabOrder("MacroEditWnd", "MacroEditWnd.txtName", "MacroEditWnd.TxtShortName");
    Class'NWindow.UIAPI_WINDOW'.static.SetTabOrder("MacroEditWnd.TxtName", "MacroEditWnd.TxtShortName", "MacroEditWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetTabOrder("MacroEditWnd.TxtShortName", "MacroEditWnd.TxtEdit0", "MacroEditWnd.txtName");
    idx = 0;

    while((idx < 12))
    {
        // End:0x174
        if((idx == 0))
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetTabOrder("MacroEditWnd.TxtEdit0", "MacroEditWnd.txtEdit1", "MacroEditWnd.txtShortName");            
        }
        else
        {
            // End:0x1E3
            if((idx == (12 - 1)))
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetTabOrder("MacroEditWnd.TxtEdit11", "MacroEditWnd.txtName", "MacroEditWnd.txtEdit10");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetTabOrder(("MacroEditWnd.TxtEdit" $ string(idx)), ("MacroEditWnd.txtEdit" $ string((idx + 1))), ("MacroEditWnd.txtEdit" $ string((idx - 1))));
            }
        }
        idx++;
    }
    return;
}

function unkFunction()
{
    // End:0xF9
    if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("MacroEditWnd.AreaEdit"))
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("MacroEditWnd.InfoHead", "Macro Content");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroEditWnd.BtnSave");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroEditWnd.BtnCancel");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroEditWnd.AreaEdit");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroEditWnd.IconEdit");        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("MacroEditWnd.InfoHead", "Change Icon");
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroEditWnd.IconEdit");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroEditWnd.AreaEdit");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroEditWnd.BtnCancel");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroEditWnd.BtnSave");
    }
    return;
}

function HandleMacroList()
{
    local int idx;
    local ItemInfo ItemInfo;

    ItemInfo.IconName = "L2UI.Macro_Icon105";
    ItemInfo.Name = "105";
    Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("MacroEditWnd.MacroItem", ItemInfo);
    idx = 1;

    while((idx < 8))
    {
        ItemInfo.IconName = ("L2UI.Macro_Icon" $ string(idx));
        ItemInfo.Name = ("" $ string(idx));
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("MacroEditWnd.MacroItem", ItemInfo);
        idx++;
    }
    idx = 104;

    while((idx > 7))
    {
        ItemInfo.IconName = ("L2UI.Macro_Icon" $ string(idx));
        ItemInfo.Name = ("" $ string(idx));
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("MacroEditWnd.MacroItem", ItemInfo);
        idx--;
    }
    return;
}

function OnClickItem(string strID, int Index)
{
    local ItemInfo ItemInfo;

    // End:0xCB
    if(((strID == "MacroItem") && (Index > -1)))
    {
        // End:0xCB
        if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("MacroEditWnd.MacroItem", Index, ItemInfo))
        {
            unkInt3 = int(ItemInfo.Name);
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("MacroEditWnd.TexMacro", ("L2UI.MacroWnd.Macro_Icon" $ ItemInfo.Name));
            unkFunction();
        }
    }
    return;
}

function OnClickHelp()
{
    local string strParam;

    ParamAdd(strParam, "FilePath", "..L2texthelp_macro.htm");
    ExecuteEvent(1210, strParam);
    return;
}

function OnClickCancel()
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroEditWnd");
    return;
}

function OnClickSave()
{
    SaveMacro();
    return;
}

function OnDropItem(string strID, ItemInfo ItemInfo, int X, int Y)
{
    // End:0x17
    if((Len(strID) < 1))
    {
        return;
    }
    // End:0x3B
    if((Left(strID, unkInt1) != "TxtEdit"))
    {
        return;
    }
    Class'NWindow.UIAPI_EDITBOX'.static.SetString(("MacroEditWnd." $ strID), ItemInfo.MacroCommand);
    Class'NWindow.UIAPI_EDITBOX'.static.SetHighLight(("MacroEditWnd." $ strID), false);
    return;
}

function OnDragItemStart(string strID, ItemInfo ItemInfo)
{
    // End:0x17
    if((Len(strID) < 1))
    {
        return;
    }
    // End:0x3B
    if((Left(strID, unkInt1) != "TxtEdit"))
    {
        return;
    }
    Class'NWindow.UIAPI_EDITBOX'.static.SetHighLight(("MacroEditWnd." $ strID), true);
    return;
}

function OnDragItemEnd(string strID)
{
    // End:0x17
    if((Len(strID) < 1))
    {
        return;
    }
    // End:0x3B
    if((Left(strID, unkInt1) != "txtEdit"))
    {
        return;
    }
    Class'NWindow.UIAPI_EDITBOX'.static.SetHighLight(("MacroEditWnd." $ strID), false);
    return;
}

function OnChangeEditBox(string strID)
{
    switch(strID)
    {
        // End:0x21
        case "TxtShortName":
            UpdateIconName();
            // End:0x24
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnClickLeft()
{
    unkInt3--;
    // End:0x22
    if((unkInt3 < 1))
    {
        unkInt3 = 104;
    }
    UpdateIcon();
    return;
}

function OnClickRight()
{
    unkInt3++;
    // End:0x22
    if((unkInt3 > 104))
    {
        unkInt3 = 1;
    }
    UpdateIcon();
    return;
}

function UpdateIcon()
{
    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("MacroEditWnd.TexMacro", ("L2UI.MacroWnd.Macro_Icon" $ string(unkInt3)));
    return;
}

function UpdateIconName()
{
    local string strShortName;

    strShortName = Class'NWindow.UIAPI_EDITBOX'.static.GetString("MacroEditWnd.TxtShortName");
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("MacroEditWnd.TxtMacroName", strShortName);
    return;
}

function Clear()
{
    local int idx;
    local WindowHandle m_MacroEditWnd;

    unkInt3 = 105;
    m_MacroEditWnd = GetHandle("MacroEditWnd.AreaEdit");
    Class'NWindow.UIAPI_EDITBOX'.static.SetString("MacroEditWnd.TxtName", "");
    Class'NWindow.UIAPI_EDITBOX'.static.SetString("MacroEditWnd.TxtShortName", "");
    idx = 0;

    while((idx < 12))
    {
        Class'NWindow.UIAPI_EDITBOX'.static.SetString(("MacroEditWnd.txtEdit" $ string(idx)), "");
        idx++;
    }
    UpdateIcon();
    UpdateIconName();
    return;
}

function HandleMacroDeleted(string param)
{
    local int MacroID;

    ParseInt(param, "MacroID", MacroID);
    // End:0x5D
    if((m_bShow && (m_CurMacroID == MacroID)))
    {
        PlayConsoleSound(IFST_WINDOW_CLOSE);
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroEditWnd");
    }
    return;
}

function HandleMacroShowEditWnd(string param)
{
    local int MacroCount;
    local Color TextColor;

    Clear();
    m_CurMacroID = 0;
    // End:0x90
    if(ParseInt(param, "MacroID", m_CurMacroID))
    {
        SetMacroID(m_CurMacroID);
        // End:0x68
        if((!m_bShow))
        {
            PlayConsoleSound(IFST_WINDOW_OPEN);
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroEditWnd");
        }
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroEditWnd.TxtName");        
    }
    else
    {
        // End:0xC1
        if(m_bShow)
        {
            PlayConsoleSound(IFST_WINDOW_CLOSE);
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroEditWnd");            
        }
        else
        {
            MacroCount = Class'NWindow.UIDATA_MACRO'.static.GetMacroCount();
            // End:0x138
            if((MacroCount >= 24))
            {
                TextColor.R = 176;
                TextColor.G = 155;
                TextColor.B = 121;
                TextColor.A = byte(255);
                DialogShow(DIALOG_Notice, GetSystemMessage(797));
                DialogSetID(0);
                return;
            }
            PlayConsoleSound(IFST_WINDOW_OPEN);
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroEditWnd");
            Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroEditWnd.TxtName");
        }
    }
    return;
}

function SetMacroID(int MacroID)
{
    local int idx;
    local MacroInfo Info;
    local MacroInfoWnd MacroInfoWnd;

    // End:0x11
    if((MacroID < 1))
    {
        return;
    }
    // End:0x173
    if(Class'NWindow.UIDATA_MACRO'.static.GetMacroInfo(MacroID, Info))
    {
        Class'NWindow.UIAPI_EDITBOX'.static.SetString("MacroEditWnd.TxtName", Info.Name);
        Class'NWindow.UIAPI_EDITBOX'.static.SetString("MacroEditWnd.TxtShortName", Info.IconName);
        unkInt3 = GetMacroIconNumFromTextureName(Info.IconTextureName);
        if((unkInt3 < 1))
        {
            unkInt3 = GetMacroNumByID(MacroID);
        }
        if((unkInt3 < 1))
        {
            unkInt3 = GetMacroNum(Info.Name);
        }
        UpdateIcon();
        MacroInfoWnd = MacroInfoWnd(GetScript("MacroInfoWnd"));
        MacroInfoWnd.SetInfoText(Info.Description);
        idx = 0;

        while((idx < 12))
        {
            Class'NWindow.UIAPI_EDITBOX'.static.SetString(("MacroEditWnd.TxtEdit" $ string(idx)), Info.CommandList[idx]);
            idx++;
        }
    }
    return;
}

function SaveMacro()
{
    local int idx;
    local MacroInfoWnd MacroInfoWnd;
    local string Name, IconName, Description, unkLocStr;
    local array<string> CommandList;

    MacroInfoWnd = MacroInfoWnd(GetScript("MacroInfoWnd"));
    Name = Class'NWindow.UIAPI_EDITBOX'.static.GetString("MacroEditWnd.TxtName");
    IconName = Class'NWindow.UIAPI_EDITBOX'.static.GetString("MacroEditWnd.TxtShortName");
    Description = MacroInfoWnd.GetInfoText();
    idx = 0;

    while((idx < 12))
    {
        unkLocStr = Class'NWindow.UIAPI_EDITBOX'.static.GetString(("MacroEditWnd.TxtEdit" $ string(idx)));
        CommandList.Insert(CommandList.Length, 1);
        CommandList[(CommandList.Length - 1)] = unkLocStr;
        idx++;
    }
    SaveMacroIconNum(m_CurMacroID, Name, unkInt3);
    // End:0x19B
    if(Class'NWindow.MacroAPI'.static.RequestMakeMacro(m_CurMacroID, Name, IconName, (unkInt3 - 1), Description, CommandList))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("MacroEditWnd");
    }
    return;
}

function SetFocus()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroEditWnd.TxtHead");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroEditWnd.TxtNameHead");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroEditWnd.TxtName");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroEditWnd.TxtShortName");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroEditWnd.TxtShortNameHead");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("MacroEditWnd.TxtMacroName");
    return;
}
