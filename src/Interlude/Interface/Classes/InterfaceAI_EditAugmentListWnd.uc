class InterfaceAI_EditAugmentListWnd extends UICommonAPI;

const MAX_LS = 1650;
const MAX_SELECT = 20;
const MAX_LIST = 100;

var WindowHandle m_hEditAugmentListWnd;
var bool bLock;
var ListCtrlHandle m_hAllSelectListCtrl;
var ListCtrlHandle m_hCurSelectListCtrl;
var ListCtrlHandle m_hAllCustomListCtrl;
var ListCtrlHandle m_hCurCustomListCtrl;
var int m_targetID;
var TabHandle m_hTabCtrl;
var EnchantAIWnd script;

function OnLoad()
{
    RegisterXmls();
    script = EnchantAIWnd(GetScript("EnchantAIWnd"));
    LoadAllSelectList();
    LoadCurSelectList();
    LoadAllCustomList();
    LoadCurCustomList();
    return;
}

function RegisterXmls()
{
    m_hEditAugmentListWnd = GetHandle("InterfaceAI_EditAugmentListWnd");
    m_hAllSelectListCtrl = ListCtrlHandle(GetHandle("InterfaceAI_EditAugmentListWnd.listEditSelect"));
    m_hCurSelectListCtrl = ListCtrlHandle(GetHandle("InterfaceAI_EditAugmentListWnd.listCurSelect"));
    m_hAllCustomListCtrl = ListCtrlHandle(GetHandle("InterfaceAI_EditAugmentListWnd.listEditCustom"));
    m_hCurCustomListCtrl = ListCtrlHandle(GetHandle("InterfaceAI_EditAugmentListWnd.listCurCustom"));
    m_hTabCtrl = TabHandle(GetHandle("InterfaceAI_EditAugmentListWnd.TabListCtrl"));
    return;
}

function OnShow()
{
    m_hTabCtrl.InitTabCtrl();
    InitLocalization();
    return;
}

function OnHide()
{
    return;
}

function InitLocalization()
{
    local string AllSelectList, CurSelectList, AllCustomList, CurCustomList;

    AllSelectList = "Skills base for select list:";
    CurSelectList = "Current skills of select list:";
    AllCustomList = "Skills base for custom list:";
    CurCustomList = "Current skills of custom list:";
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("InterfaceAI_EditAugmentListWnd.EditSelectListWnd.txtAllSelectList", AllSelectList);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("InterfaceAI_EditAugmentListWnd.EditSelectListWnd.txtCurSelectList", CurSelectList);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("InterfaceAI_EditAugmentListWnd.EditCustomListWnd.txtAllCustomList", AllCustomList);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("InterfaceAI_EditAugmentListWnd.EditCustomListWnd.txtCurCustomList", CurCustomList);
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x2C
        case "btnCloseLSEdit":
            m_hEditAugmentListWnd.HideWindow();
            // End:0x2F
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function GetRefineryParam(int Id, out array<string> arrSplit)
{
    local string Value;
    local int SplitCount;

    RefineryParam(Id, Value);
    SplitCount = Split(Value, ",", arrSplit);
    return;
}

function string GetRefinerySkillName(int Id)
{
    local array<string> arrSplit;

    GetRefineryParam(Id, arrSplit);
    return arrSplit[3];
}

function string GetRefineryQualityName(int Id)
{
    local array<string> arrSplit;
    local int TypeID;
    local string Names;

    GetRefineryParam(Id, arrSplit);
    TypeID = int(arrSplit[1]);
    switch(TypeID)
    {
        // End:0x3B
        case 3:
            Names = "Hight";
            // End:0x51
            break;
        // End:0x4E
        case 4:
            Names = "Top";
            // End:0x51
            break;
        // End:0xFFFF
        default:
            break;
    }
    return Names;
}

function string GetRefineryTypeName(int Id)
{
    local array<string> arrSplit;
    local int TypeID;
    local string Names;

    GetRefineryParam(Id, arrSplit);
    TypeID = int(arrSplit[2]);
    switch(TypeID)
    {
        // End:0x3C
        case 1:
            Names = "Active";
            // End:0x80
            break;
        // End:0x53
        case 2:
            Names = "Passive";
            // End:0x80
            break;
        // End:0x69
        case 3:
            Names = "Chance";
            // End:0x80
            break;
        // End:0x7D
        case 4:
            Names = "Stat";
            // End:0x80
            break;
        // End:0xFFFF
        default:
            break;
    }
    return Names;
}

function int GetRefinerySkillLvl(int Id)
{
    local array<string> arrSplit;

    GetRefineryParam(Id, arrSplit);
    return int(arrSplit[4]);
}

function GetRefinerySelectList(out array<string> arrSplit)
{
    local string Value;
    local int SplitCount;

    GetINIString("AutoRefinery", "SelectList", Value, "Option");
    SplitCount = Split(Value, ",", arrSplit);
    return;
}

function GetRefineryCustomList(out array<string> arrSplit)
{
    local string Value;
    local int SplitCount;

    GetINIString("AutoRefinery", "CustomList", Value, "Option");
    SplitCount = Split(Value, ",", arrSplit);
    return;
}

function LoadAllSelectList()
{
    local int SkillID;
    local string SkillName;
    local int SkillLevel;
    local string SkillType, SkillQuality;
    local array<string> arrCurrentSelect;
    local int i, j, B;
    local bool IgnoreRecord;
    local LVDataRecord Record;
    local LVData data1, data2, data3, data4, data5;

    j = 0;
    IgnoreRecord = false;
    arrCurrentSelect.Length = 0;
    m_hAllSelectListCtrl.DeleteAllItem();
    GetRefinerySelectList(arrCurrentSelect);
    i = 14578;
    J0x3C:

    // End:0x1E1 [Loop If]
    if(i <= 16380)
    {
        B = 0;
        J0x52:

        // End:0x96 [Loop If]
        if(B <= arrCurrentSelect.Length)
        {
            IgnoreRecord = false;
            // End:0x8C
            if(int(arrCurrentSelect[B]) == i)
            {
                IgnoreRecord = true;
                // [Explicit Break]
                goto J0x96;
            }
            B++;
            // [Loop Continue]
            goto J0x52;
        }
        J0x96:

        // End:0x1D7
        if(!IgnoreRecord)
        {
            SkillLevel = GetRefinerySkillLvl(i);
            // End:0x1D7
            if(SkillLevel != 0)
            {
                SkillID = i;
                SkillName = GetRefinerySkillName(i);
                SkillType = GetRefineryTypeName(i);
                SkillQuality = GetRefineryQualityName(i);
                data1.nReserved1 = j;
                data1.szData = SkillName;
                Record.LVDataList[0] = data1;
                data2.szData = SkillType;
                Record.LVDataList[1] = data2;
                data3.szData = string(SkillLevel);
                Record.LVDataList[2] = data3;
                data4.szData = SkillQuality;
                Record.LVDataList[3] = data4;
                data5.szData = string(SkillID);
                Record.LVDataList[4] = data5;
                ++j;
                m_hAllSelectListCtrl.InsertRecord(Record);
            }
        }
        i++;
        // [Loop Continue]
        goto J0x3C;
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditSelectListWnd.valListSelectAll", (string(m_hAllSelectListCtrl.GetRecordCount()) $ "/") $ string(1650));
    return;
}

function LoadCurSelectList()
{
    local int SkillID;
    local string SkillName;
    local int SkillLevel;
    local string SkillType, SkillQuality;
    local int i, j, B;
    local array<string> arrCurrentSelect;
    local LVDataRecord Record;
    local LVData data1, data2, data3, data4, data5;

    j = 0;
    arrCurrentSelect.Length = 0;
    GetRefinerySelectList(arrCurrentSelect);
    m_hCurSelectListCtrl.DeleteAllItem();
    i = 14578;
    J0x34:

    // End:0x1BE [Loop If]
    if(i <= 16380)
    {
        B = 0;
        J0x4A:

        // End:0x1B4 [Loop If]
        if(B <= arrCurrentSelect.Length)
        {
            // End:0x1AA
            if(int(arrCurrentSelect[B]) == i)
            {
                SkillID = i;
                SkillName = GetRefinerySkillName(i);
                SkillLevel = GetRefinerySkillLvl(i);
                SkillType = GetRefineryTypeName(i);
                SkillQuality = GetRefineryQualityName(i);
                data1.nReserved1 = j;
                data1.szData = SkillName;
                Record.LVDataList[0] = data1;
                data2.szData = SkillType;
                Record.LVDataList[1] = data2;
                data3.szData = string(SkillLevel);
                Record.LVDataList[2] = data3;
                data4.szData = SkillQuality;
                Record.LVDataList[3] = data4;
                data5.szData = string(SkillID);
                Record.LVDataList[4] = data5;
                // End:0x1A7
                if(SkillLevel != 0)
                {
                    ++j;
                    m_hCurSelectListCtrl.InsertRecord(Record);
                }
                // [Explicit Break]
                goto J0x1B4;
            }
            B++;
            // [Loop Continue]
            goto J0x4A;
        }
        J0x1B4:

        i++;
        // [Loop Continue]
        goto J0x34;
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditSelectListWnd.valListSelectCur", (string(m_hCurSelectListCtrl.GetRecordCount()) $ "/") $ string(20));
    script.ComboBoxParam();
    return;
}

function LoadAllCustomList()
{
    local int SkillID;
    local string SkillName;
    local int SkillLevel;
    local string SkillType, SkillQuality;
    local array<string> arrCurrentSelect;
    local int i, j, B;
    local bool IgnoreRecord;
    local LVDataRecord Record;
    local LVData data1, data2, data3, data4, data5;

    j = 0;
    IgnoreRecord = false;
    arrCurrentSelect.Length = 0;
    m_hAllCustomListCtrl.DeleteAllItem();
    GetRefineryCustomList(arrCurrentSelect);
    i = 14578;
    J0x3C:

    // End:0x1E1 [Loop If]
    if(i <= 16380)
    {
        B = 0;
        J0x52:

        // End:0x96 [Loop If]
        if(B <= arrCurrentSelect.Length)
        {
            IgnoreRecord = false;
            // End:0x8C
            if(int(arrCurrentSelect[B]) == i)
            {
                IgnoreRecord = true;
                // [Explicit Break]
                goto J0x96;
            }
            B++;
            // [Loop Continue]
            goto J0x52;
        }
        J0x96:

        // End:0x1D7
        if(!IgnoreRecord)
        {
            SkillLevel = GetRefinerySkillLvl(i);
            // End:0x1D7
            if(SkillLevel != 0)
            {
                SkillID = i;
                SkillName = GetRefinerySkillName(i);
                SkillType = GetRefineryTypeName(i);
                SkillQuality = GetRefineryQualityName(i);
                data1.nReserved1 = j;
                data1.szData = SkillName;
                Record.LVDataList[0] = data1;
                data2.szData = SkillType;
                Record.LVDataList[1] = data2;
                data3.szData = string(SkillLevel);
                Record.LVDataList[2] = data3;
                data4.szData = SkillQuality;
                Record.LVDataList[3] = data4;
                data5.szData = string(SkillID);
                Record.LVDataList[4] = data5;
                ++j;
                m_hAllCustomListCtrl.InsertRecord(Record);
            }
        }
        i++;
        // [Loop Continue]
        goto J0x3C;
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditCustomListWnd.valListCustomAll", (string(m_hAllCustomListCtrl.GetRecordCount()) $ "/") $ string(1650));
    return;
}

function LoadCurCustomList()
{
    local int SkillID;
    local string SkillName;
    local int SkillLevel;
    local string SkillType, SkillQuality;
    local int i, j, B;
    local array<string> arrCurrentSelect;
    local LVDataRecord Record;
    local LVData data1, data2, data3, data4, data5;

    j = 0;
    arrCurrentSelect.Length = 0;
    GetRefineryCustomList(arrCurrentSelect);
    m_hCurCustomListCtrl.DeleteAllItem();
    i = 14578;
    J0x34:

    // End:0x1BE [Loop If]
    if(i <= 16380)
    {
        B = 0;
        J0x4A:

        // End:0x1B4 [Loop If]
        if(B <= arrCurrentSelect.Length)
        {
            // End:0x1AA
            if(int(arrCurrentSelect[B]) == i)
            {
                SkillID = i;
                SkillName = GetRefinerySkillName(i);
                SkillLevel = GetRefinerySkillLvl(i);
                SkillType = GetRefineryTypeName(i);
                SkillQuality = GetRefineryQualityName(i);
                data1.nReserved1 = j;
                data1.szData = SkillName;
                Record.LVDataList[0] = data1;
                data2.szData = SkillType;
                Record.LVDataList[1] = data2;
                data3.szData = string(SkillLevel);
                Record.LVDataList[2] = data3;
                data4.szData = SkillQuality;
                Record.LVDataList[3] = data4;
                data5.szData = string(SkillID);
                Record.LVDataList[4] = data5;
                // End:0x1A7
                if(SkillLevel != 0)
                {
                    ++j;
                    m_hCurCustomListCtrl.InsertRecord(Record);
                }
                // [Explicit Break]
                goto J0x1B4;
            }
            B++;
            // [Loop Continue]
            goto J0x4A;
        }
        J0x1B4:

        i++;
        // [Loop Continue]
        goto J0x34;
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditCustomListWnd.valListCustomCur", (string(m_hCurCustomListCtrl.GetRecordCount()) $ "/") $ string(100));
    return;
}

function OnDBClickListCtrlRecord(string ListCtrlID)
{
    local LVDataRecord Record;
    local int RecordIndex;

    // End:0x14F
    if(ListCtrlID == "listEditSelect")
    {
        // End:0x14C
        if(m_hCurSelectListCtrl.GetRecordCount() < 20)
        {
            Record = m_hAllSelectListCtrl.GetSelectedRecord();
            AddSelectListOption(int(Record.LVDataList[4].szData));
            m_hCurSelectListCtrl.InsertRecord(Record);
            RecordIndex = m_hAllSelectListCtrl.GetSelectedIndex();
            m_hAllSelectListCtrl.DeleteRecord(RecordIndex);
            script.ComboBoxParam();
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditSelectListWnd.valListSelectAll", (string(m_hAllSelectListCtrl.GetRecordCount()) $ "/") $ string(1650));
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditSelectListWnd.valListSelectCur", (string(m_hCurSelectListCtrl.GetRecordCount()) $ "/") $ string(20));
        }        
    }
    else
    {
        // End:0x2AE
        if(ListCtrlID == "listCurSelect")
        {
            Record = m_hCurSelectListCtrl.GetSelectedRecord();
            DelSelectListOption(int(Record.LVDataList[4].szData));
            m_hAllSelectListCtrl.InsertRecord(Record);
            RecordIndex = m_hCurSelectListCtrl.GetSelectedIndex();
            // End:0x1E7
            if(m_hCurSelectListCtrl.GetRecordCount() == 1)
            {
                m_hCurSelectListCtrl.DeleteAllItem();                
            }
            else
            {
                m_hCurSelectListCtrl.DeleteRecord(RecordIndex);
            }
            script.ComboBoxParam();
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditSelectListWnd.valListSelectAll", (string(m_hAllSelectListCtrl.GetRecordCount()) $ "/") $ string(1650));
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditSelectListWnd.valListSelectCur", (string(m_hCurSelectListCtrl.GetRecordCount()) $ "/") $ string(20));            
        }
        else
        {
            // End:0x3EE
            if(ListCtrlID == "listEditCustom")
            {
                // End:0x3EB
                if(m_hCurCustomListCtrl.GetRecordCount() < 100)
                {
                    Record = m_hAllCustomListCtrl.GetSelectedRecord();
                    AddCustomListOption(int(Record.LVDataList[4].szData));
                    m_hCurCustomListCtrl.InsertRecord(Record);
                    RecordIndex = m_hAllCustomListCtrl.GetSelectedIndex();
                    m_hAllCustomListCtrl.DeleteRecord(RecordIndex);
                    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditCustomListWnd.valListCustomAll", (string(m_hAllCustomListCtrl.GetRecordCount()) $ "/") $ string(1650));
                    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditCustomListWnd.valListCustomCur", (string(m_hCurCustomListCtrl.GetRecordCount()) $ "/") $ string(100));
                }                
            }
            else
            {
                // End:0x53B
                if(ListCtrlID == "listCurCustom")
                {
                    Record = m_hCurCustomListCtrl.GetSelectedRecord();
                    DelCustomListOption(int(Record.LVDataList[4].szData));
                    m_hAllCustomListCtrl.InsertRecord(Record);
                    RecordIndex = m_hCurCustomListCtrl.GetSelectedIndex();
                    // End:0x486
                    if(m_hCurCustomListCtrl.GetRecordCount() == 1)
                    {
                        m_hCurCustomListCtrl.DeleteAllItem();                        
                    }
                    else
                    {
                        m_hCurCustomListCtrl.DeleteRecord(RecordIndex);
                    }
                    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditCustomListWnd.valListCustomAll", (string(m_hAllCustomListCtrl.GetRecordCount()) $ "/") $ string(1650));
                    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("EditCustomListWnd.valListCustomCur", (string(m_hCurCustomListCtrl.GetRecordCount()) $ "/") $ string(100));
                }
            }
        }
    }
    return;
}

function DelSelectListOption(int Id)
{
    local array<string> arrCurrentSelect;
    local int i;
    local string ResultSelectList;

    arrCurrentSelect.Length = 0;
    ResultSelectList = "";
    GetRefinerySelectList(arrCurrentSelect);
    i = 0;
    J0x22:

    // End:0x61 [Loop If]
    if(i <= arrCurrentSelect.Length)
    {
        // End:0x57
        if(int(arrCurrentSelect[i]) == Id)
        {
            arrCurrentSelect[i] = "";
        }
        i++;
        // [Loop Continue]
        goto J0x22;
    }
    JoinArray(arrCurrentSelect, ResultSelectList, ",", true);
    SetINIString("AutoRefinery", "SelectList", ResultSelectList, "Option");
    return;
}

function AddSelectListOption(int Id)
{
    local array<string> arrCurrentSelect;
    local string ResultSelectList;

    arrCurrentSelect.Length = 0;
    ResultSelectList = "";
    GetRefinerySelectList(arrCurrentSelect);
    arrCurrentSelect.Insert(arrCurrentSelect.Length, 1);
    arrCurrentSelect[arrCurrentSelect.Length] = string(Id);
    JoinArray(arrCurrentSelect, ResultSelectList, ",", true);
    SetINIString("AutoRefinery", "SelectList", ResultSelectList, "Option");
    return;
}

function AddCustomListOption(int Id)
{
    local array<string> arrCurrentCustom;
    local string ResultCustomList;

    arrCurrentCustom.Length = 0;
    ResultCustomList = "";
    GetRefineryCustomList(arrCurrentCustom);
    arrCurrentCustom.Insert(arrCurrentCustom.Length, 1);
    arrCurrentCustom[arrCurrentCustom.Length] = string(Id);
    JoinArray(arrCurrentCustom, ResultCustomList, ",", true);
    SetINIString("AutoRefinery", "CustomList", ResultCustomList, "Option");
    return;
}

function DelCustomListOption(int Id)
{
    local array<string> arrCurrentCustom;
    local int i;
    local string ResultCustomList;

    arrCurrentCustom.Length = 0;
    ResultCustomList = "";
    GetRefineryCustomList(arrCurrentCustom);
    i = 0;
    J0x22:

    // End:0x61 [Loop If]
    if(i <= arrCurrentCustom.Length)
    {
        // End:0x57
        if(int(arrCurrentCustom[i]) == Id)
        {
            arrCurrentCustom[i] = "";
        }
        i++;
        // [Loop Continue]
        goto J0x22;
    }
    JoinArray(arrCurrentCustom, ResultCustomList, ",", true);
    SetINIString("AutoRefinery", "CustomList", ResultCustomList, "Option");
    return;
}
