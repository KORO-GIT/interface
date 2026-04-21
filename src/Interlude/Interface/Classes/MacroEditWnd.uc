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
    if(UnknownFunction154(Event_ID, 1260))
    {
        HandleMacroShowEditWnd(param);        
    }
    else
    {
        // End:0x42
        if(UnknownFunction154(Event_ID, 1270))
        {
            HandleMacroDeleted(param);            
        }
        else
        {
            // End:0x60
            if(UnknownFunction154(Event_ID, 1710))
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
    J0xFA:

    // End:0x277 [Loop If]
    if(UnknownFunction150(idx, 12))
    {
        // End:0x174
        if(UnknownFunction154(idx, 0))
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetTabOrder("MacroEditWnd.TxtEdit0", "MacroEditWnd.txtEdit1", "MacroEditWnd.txtShortName");            
        }
        else
        {
            // End:0x1E3
            if(UnknownFunction154(idx, UnknownFunction147(12, 1)))
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetTabOrder("MacroEditWnd.TxtEdit11", "MacroEditWnd.txtName", "MacroEditWnd.txtEdit10");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.SetTabOrder(UnknownFunction112("MacroEditWnd.TxtEdit", string(idx)), UnknownFunction112("MacroEditWnd.txtEdit", string(UnknownFunction146(idx, 1))), UnknownFunction112("MacroEditWnd.txtEdit", string(UnknownFunction147(idx, 1))));
            }
        }
        UnknownFunction165(idx);
        // [Loop Continue]
        goto J0xFA;
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
    J0x62:

    // End:0xEF [Loop If]
    if(UnknownFunction150(idx, 8))
    {
        ItemInfo.IconName = UnknownFunction112("L2UI.Macro_Icon", string(idx));
        ItemInfo.Name = UnknownFunction112("", string(idx));
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("MacroEditWnd.MacroItem", ItemInfo);
        UnknownFunction165(idx);
        // [Loop Continue]
        goto J0x62;
    }
    idx = 104;
    J0xF7:

    // End:0x184 [Loop If]
    if(UnknownFunction151(idx, 7))
    {
        ItemInfo.IconName = UnknownFunction112("L2UI.Macro_Icon", string(idx));
        ItemInfo.Name = UnknownFunction112("", string(idx));
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("MacroEditWnd.MacroItem", ItemInfo);
        UnknownFunction166(idx);
        // [Loop Continue]
        goto J0xF7;
    }
    return;
}

function OnClickItem(string strID, int Index)
{
    local ItemInfo ItemInfo;

    // End:0xCB
    if(UnknownFunction130(UnknownFunction122(strID, "MacroItem"), UnknownFunction151(Index, -1)))
    {
        // End:0xCB
        if(Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("MacroEditWnd.MacroItem", Index, ItemInfo))
        {
            unkInt3 = int(ItemInfo.Name);
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("MacroEditWnd.TexMacro", UnknownFunction112("L2UI.MacroWnd.Macro_Icon", ItemInfo.Name));
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
    if(UnknownFunction150(UnknownFunction125(strID), 1))
    {
        return;
    }
    // End:0x3B
    if(UnknownFunction123(UnknownFunction128(strID, unkInt1), "TxtEdit"))
    {
        return;
    }
    Class'NWindow.UIAPI_EDITBOX'.static.SetString(UnknownFunction112("MacroEditWnd.", strID), ItemInfo.MacroCommand);
    Class'NWindow.UIAPI_EDITBOX'.static.SetHighLight(UnknownFunction112("MacroEditWnd.", strID), false);
    return;
}

function OnDragItemStart(string strID, ItemInfo ItemInfo)
{
    // End:0x17
    if(UnknownFunction150(UnknownFunction125(strID), 1))
    {
        return;
    }
    // End:0x3B
    if(UnknownFunction123(UnknownFunction128(strID, unkInt1), "TxtEdit"))
    {
        return;
    }
    Class'NWindow.UIAPI_EDITBOX'.static.SetHighLight(UnknownFunction112("MacroEditWnd.", strID), true);
    return;
}

function OnDragItemEnd(string strID)
{
    // End:0x17
    if(UnknownFunction150(UnknownFunction125(strID), 1))
    {
        return;
    }
    // End:0x3B
    if(UnknownFunction123(UnknownFunction128(strID, unkInt1), "txtEdit"))
    {
        return;
    }
    Class'NWindow.UIAPI_EDITBOX'.static.SetHighLight(UnknownFunction112("MacroEditWnd.", strID), false);
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
    UnknownFunction166(unkInt3);
    // End:0x22
    if(UnknownFunction150(unkInt3, 1))
    {
        unkInt3 = 104;
    }
    UpdateIcon();
    return;
}

function OnClickRight()
{
    UnknownFunction165(unkInt3);
    // End:0x22
    if(UnknownFunction151(unkInt3, 104))
    {
        unkInt3 = 1;
    }
    UpdateIcon();
    return;
}

function UpdateIcon()
{
    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("MacroEditWnd.TexMacro", UnknownFunction112("L2UI.MacroWnd.Macro_Icon", string(unkInt3)));
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
    J0x85:

    // End:0xD7 [Loop If]
    if(UnknownFunction150(idx, 12))
    {
        Class'NWindow.UIAPI_EDITBOX'.static.SetString(UnknownFunction112("MacroEditWnd.txtEdit", string(idx)), "");
        UnknownFunction165(idx);
        // [Loop Continue]
        goto J0x85;
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
    if(UnknownFunction130(m_bShow, UnknownFunction154(m_CurMacroID, MacroID)))
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
        if(UnknownFunction129(m_bShow))
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
            if(UnknownFunction153(MacroCount, 24))
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
    if(UnknownFunction150(MacroID, 1))
    {
        return;
    }
    // End:0x173
    if(Class'NWindow.UIDATA_MACRO'.static.GetMacroInfo(MacroID, Info))
    {
        Class'NWindow.UIAPI_EDITBOX'.static.SetString("MacroEditWnd.TxtName", Info.Name);
        Class'NWindow.UIAPI_EDITBOX'.static.SetString("MacroEditWnd.TxtShortName", Info.IconName);
        unkInt3 = int(UnknownFunction234(Info.IconTextureName, 1));
        // End:0xCE
        if(UnknownFunction150(unkInt3, 1))
        {
            unkInt3 = GetMacroNum(Info.Name);
        }
        UpdateIcon();
        MacroInfoWnd = MacroInfoWnd(GetScript("MacroInfoWnd"));
        MacroInfoWnd.SetInfoText(Info.Description);
        idx = 0;
        J0x113:

        // End:0x173 [Loop If]
        if(UnknownFunction150(idx, 12))
        {
            Class'NWindow.UIAPI_EDITBOX'.static.SetString(UnknownFunction112("MacroEditWnd.TxtEdit", string(idx)), Info.CommandList[idx]);
            UnknownFunction165(idx);
            // [Loop Continue]
            goto J0x113;
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
    J0x96:

    // End:0x112 [Loop If]
    if(UnknownFunction150(idx, 12))
    {
        unkLocStr = Class'NWindow.UIAPI_EDITBOX'.static.GetString(UnknownFunction112("MacroEditWnd.TxtEdit", string(idx)));
        CommandList.Insert(CommandList.Length, 1);
        CommandList[UnknownFunction147(CommandList.Length, 1)] = unkLocStr;
        UnknownFunction165(idx);
        // [Loop Continue]
        goto J0x96;
    }
    // End:0x147
    if(UnknownFunction151(unkInt3, 7))
    {
        SetINIInt("MacroList", Name, unkInt3, "MacroGrp");
    }
    // End:0x19B
    if(Class'NWindow.MacroAPI'.static.RequestMakeMacro(m_CurMacroID, Name, IconName, UnknownFunction147(unkInt3, 1), Description, CommandList))
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
