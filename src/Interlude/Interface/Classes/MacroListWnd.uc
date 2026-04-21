class MacroListWnd extends UICommonAPI;

const MACRO_MAX_COUNT = 24;

var WindowHandle WndHandle;
var bool m_bShow;
var int m_DeleteID;
var int m_Max;
var ItemWindowHandle ItemWindowHandle;
var array<int> arrInt1;
var array<int> arrInt2;
var array<string> arrStr;
var int unkInt1;
var int unkInt2;
var int unkInt3;
var int unkInt4;
var int unkInt5;
var int unkInt6;
var string unkStr1;
var string unkStr2;
var string unkStr3;
var string unkStr4;
var string unkStr5;
var MacroEditWnd MacroEditWnd;

function OnLoad()
{
    unkStr2 = "MacroListWnd";
    WndHandle = GetHandle(unkStr2);
    ItemWindowHandle = ItemWindowHandle(GetHandle(UnknownFunction112(unkStr2, ".MacroItem")));
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
    unkStr3 = "L2ui.Macro_Icon";
    unkStr4 = "l2_skilltime.ToggleEffect001";
    unkStr5 = "";
    unkStr1 = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("/", lowerDigitNumber(13)), ""), lowerDigitNumber(3)), ""), lowerDigitNumber(19)), ""), lowerDigitNumber(11)), ""), lowerDigitNumber(6)), "");
    unkInt2 = int(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("", lowerDigitNumber(27)), ""), lowerDigitNumber(28)), ""));
    unkInt3 = int(lowerDigitNumber(33));
    unkInt5 = int(lowerDigitNumber(27));
    unkInt4 = int(lowerDigitNumber(36));
    unkInt6 = int(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("", lowerDigitNumber(27)), ""), lowerDigitNumber(36)), ""), lowerDigitNumber(36)), ""), lowerDigitNumber(36)), ""));
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
    if(UnknownFunction154(Event_ID, 1230))
    {
        HandleMacroShowListWnd();        
    }
    else
    {
        // End:0x38
        if(UnknownFunction154(Event_ID, 1240))
        {
            reqMacroList();            
        }
        else
        {
            // End:0x59
            if(UnknownFunction154(Event_ID, 1250))
            {
                HandleMacroList(param);                
            }
            else
            {
                // End:0xC5
                if(UnknownFunction154(Event_ID, 1710))
                {
                    // End:0xC5
                    if(DialogIsMine())
                    {
                        // End:0xC5
                        if(UnknownFunction151(m_DeleteID, unkInt4))
                        {
                            Class'NWindow.MacroAPI'.static.RequestDeleteMacro(m_DeleteID);
                            m_DeleteID = unkInt4;
                            // End:0xC5
                            if(UnknownFunction154(m_Max, unkInt5))
                            {
                                HandleMacroList(unkStr5);
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
    if(UnknownFunction130(UnknownFunction122(strID, "MacroItem"), UnknownFunction151(Index, -1)))
    {
        // End:0x64
        if(ItemWindowHandle.GetItem(Index, ItemInfo))
        {
            Class'NWindow.MacroAPI'.static.RequestUseMacro(ItemInfo.ClassID);
        }
    }
    return;
}

function OnRClickItem(string strID, int unkLocInt2)
{
    local ItemInfo ItemInfo;
    local MacroInfo MacroInfo;
    local int idx;

    // End:0x182
    if(UnknownFunction130(UnknownFunction122(strID, "MacroItem"), UnknownFunction151(unkLocInt2, -1)))
    {
        unkFunc();
        // End:0x182
        if(ItemWindowHandle.GetItem(unkLocInt2, ItemInfo))
        {
            // End:0x7C
            if(UnknownFunction154(ItemInfo.ClassID, unkInt1))
            {
                unkInt1 = unkInt4;
                reqMacroList();
                return;
            }
            unkInt1 = ItemInfo.ClassID;
            // End:0x182
            if(Class'NWindow.UIDATA_MACRO'.static.GetMacroInfo(ItemInfo.ClassID, MacroInfo))
            {
                idx = unkInt4;
                J0xB8:

                // End:0x182 [Loop If]
                if(UnknownFunction150(idx, unkInt2))
                {
                    // End:0x158
                    if(UnknownFunction124(UnknownFunction128(MacroInfo.CommandList[idx], UnknownFunction147(unkInt3, unkInt5)), unkStr1))
                    {
                        arrInt1[idx] = idx;
                        arrInt2[idx] = int(UnknownFunction234(MacroInfo.CommandList[idx], UnknownFunction147(UnknownFunction125(MacroInfo.CommandList[idx]), unkInt3)));                        
                    }
                    else
                    {
                        arrStr[idx] = MacroInfo.CommandList[idx];
                    }
                    UnknownFunction165(idx);
                    // [Loop Continue]
                    goto J0xB8;
                }
            }
        }
    }
    WndHandle.SetTimer(unkInt4, UnknownFunction145(unkInt6, 4));
    reqMacroList();
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

function reqMacroList()
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

function unkFunc()
{
    local int idx;

    idx = unkInt4;
    J0x0B:

    // End:0x40 [Loop If]
    if(UnknownFunction150(idx, unkInt2))
    {
        WndHandle.KillTimer(idx);
        UnknownFunction165(idx);
        // [Loop Continue]
        goto J0x0B;
    }
    arrInt1.Length = unkInt4;
    arrInt2.Length = unkInt4;
    arrStr.Length = unkInt4;
    reqMacroList();
    return;
}

function HandleMacroList(string param)
{
    local int idx, unkLocInt1, MacroID;
    local string strIconName, strMacroName, strDescription, unkLocStr1, strTmp;

    local ItemInfo ItemInfo;
    local int unkLocInt2;

    Clear();
    ParseInt(param, "Max", unkLocInt1);
    m_Max = unkLocInt1;
    idx = unkInt4;
    J0x31:

    // End:0x27B [Loop If]
    if(UnknownFunction150(idx, unkLocInt1))
    {
        MacroID = unkInt4;
        strIconName = unkStr5;
        strMacroName = unkStr5;
        strDescription = unkStr5;
        unkLocStr1 = unkStr5;
        ParseInt(param, UnknownFunction112("ID_", string(idx)), MacroID);
        ParseString(param, UnknownFunction112("IconName_", string(idx)), strIconName);
        ParseString(param, UnknownFunction112("MacroName_", string(idx)), strMacroName);
        ParseString(param, UnknownFunction112("Description_", string(idx)), strDescription);
        ParseString(param, UnknownFunction112("TextureName_", string(idx)), unkLocStr1);
        ItemInfo.ClassID = MacroID;
        ItemInfo.Name = strMacroName;
        ItemInfo.AdditionalName = strIconName;
        ItemInfo.IconName = unkLocStr1;
        ItemInfo.Description = strDescription;
        ItemInfo.ItemSubType = 4;
        // End:0x1CC
        if(UnknownFunction154(ItemInfo.ClassID, unkInt1))
        {
            ItemInfo.ForeTexture = unkStr4;            
        }
        else
        {
            ItemInfo.ForeTexture = unkStr5;
        }
        // End:0x241
        if(UnknownFunction122(unkLocStr1, unkStr5))
        {
            unkLocInt2 = GetMacroNum(ItemInfo.Name);
            // End:0x241
            if(UnknownFunction151(unkLocInt2, unkInt3))
            {
                ItemInfo.IconName = UnknownFunction112("L2UI.Macro_Icon", string(unkLocInt2));
            }
        }
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("MacroListWnd.MacroItem", ItemInfo);
        UnknownFunction165(idx);
        // [Loop Continue]
        goto J0x31;
    }
    // End:0x29F
    if(UnknownFunction150(unkLocInt1, 10))
    {
        strTmp = UnknownFunction112(strTmp, "0");
    }
    strTmp = UnknownFunction112(strTmp, string(unkLocInt1));
    strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(", strTmp), "/"), string(24)), ")");
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

function OnTimer(int unkLocInt2)
{
    WndHandle.KillTimer(unkLocInt2);
    // End:0xCC
    if(UnknownFunction154(arrInt1[unkLocInt2], unkInt4))
    {
        ExecuteCommand(arrStr[unkLocInt2]);
        // End:0xB0
        if(UnknownFunction132(UnknownFunction123(arrStr[UnknownFunction146(unkLocInt2, unkInt5)], unkStr5), UnknownFunction155(arrInt1[UnknownFunction146(unkLocInt2, unkInt5)], unkInt4)))
        {
            WndHandle.SetTimer(UnknownFunction146(unkLocInt2, unkInt5), unkInt6);            
        }
        else
        {
            WndHandle.SetTimer(unkInt4, unkInt6);
        }        
    }
    else
    {
        WndHandle.SetTimer(UnknownFunction146(unkLocInt2, unkInt5), UnknownFunction144(arrInt2[unkLocInt2], unkInt6));
    }
    return;
}

function DeleteMacro(ItemInfo ItemInfo)
{
    local string strMsg;

    // End:0x17
    if(UnknownFunction155(ItemInfo.ItemSubType, 4))
    {
        return;
    }
    strMsg = MakeFullSystemMsg(GetSystemMessage(828), ItemInfo.Name, unkStr5);
    m_DeleteID = ItemInfo.ClassID;
    DialogShow(DIALOG_Warning, strMsg);
    // End:0x78
    if(UnknownFunction154(ItemInfo.ClassID, unkInt1))
    {
        unkFunc();
    }
    return;
}

function EditMacro(ItemInfo ItemInfo)
{
    local int MacroID;
    local string param;

    // End:0x43
    if(UnknownFunction129(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("MacroEditWnd")))
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("MacroEditWnd");
    }
    // End:0x5A
    if(UnknownFunction155(ItemInfo.ItemSubType, 4))
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
