class AbnormalStatusWnd extends UICommonAPI;

const NSTATUSICON_FRAMESIZE = 4;
const NSTATUSICON_MAXCOL = 12;
const ProbablyPotionsTimerDelay = 1250;
const ProbablyPotionsTimerID = 4443;

var int i_UnkInt1;
var int i_UnkInt2;
var int i_UnkInt3;
var int i_UnkInt4;
var int i_UnkInt5;
var int i_UnkInt6;
var bool m_bOnCurState;
var WindowHandle Me;
var StatusIconHandle StatusIcon;
var bool checkAbDebuff;
var bool checkAbSongDance;
var bool checkAbPrior;
var bool checkAbPriorDebuffSameRow;
var array<int> a_UnkArrayInt1;

function OnLoad()
{
    RegisterEvent(950);
    RegisterEvent(960);
    RegisterEvent(970);
    RegisterEvent(4444);
    RegisterEvent(40);
    RegisterEvent(50);
    RegisterEvent(310);
    RegisterEvent(1900);
    i_UnkInt1 = -1;
    i_UnkInt5 = -1;
    i_UnkInt6 = -1;
    i_UnkInt3 = -1;
    i_UnkInt4 = -1;
    m_bOnCurState = false;
    Init();
    return;
}

function Init()
{
    Me = GetHandle("AbnormalStatusWnd");
    StatusIcon = StatusIconHandle(GetHandle("AbnormalStatusWnd.StatusIcon"));
    return;
}

function OnEnterState(name a_PreStateName)
{
    m_bOnCurState = true;
    UpdateWindowSize();
    return;
}

function OnExitState(name a_NextStateName)
{
    m_bOnCurState = false;
    return;
}

function OnEvent(int Event_ID, string param)
{
    // End:0x1D
    if(Event_ID == 950)
    {
        HandleAddNormalStatus(param);        
    }
    else
    {
        // End:0x3A
        if(Event_ID == 960)
        {
            HandleAddEtcStatus(param);            
        }
        else
        {
            // End:0x57
            if(Event_ID == 970)
            {
                HandleAddShortStatus(param);                
            }
            else
            {
                // End:0x6C
                if(Event_ID == 40)
                {
                    HandleRestart();                    
                }
                else
                {
                    // End:0x81
                    if(Event_ID == 50)
                    {
                        HandleDie();                        
                    }
                    else
                    {
                        // End:0x99
                        if(Event_ID == 310)
                        {
                            HandleShowReplayQuitDialogBox();                            
                        }
                        else
                        {
                            // End:0xB1
                            if(Event_ID == 1900)
                            {
                                HandleLanguageChanged();                                
                            }
                            else
                            {
                                // End:0x164
                                if(Event_ID == 4444)
                                {
                                    checkAbDebuff = GetOptionBool("Custom", "checkAbDebuff");
                                    checkAbPrior = GetOptionBool("Custom", "checkAbPrior");
                                    checkAbSongDance = GetOptionBool("Custom", "checkAbSongDance");
                                    checkAbPriorDebuffSameRow = GetOptionBool("Custom", "checkAbPriorDebuffSameRow");
                                    ReHandleAddNormalStatus();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function HandleRestart()
{
    ClearAll();
    return;
}

function HandleDie()
{
    ClearStatus(false, false);
    ClearStatus(false, true);
    return;
}

function HandleShowReplayQuitDialogBox()
{
    Me.HideWindow();
    return;
}

function OnShow()
{
    local int RowCount;

    RowCount = StatusIcon.GetRowCount();
    // End:0x2F
    if(RowCount < 1)
    {
        Me.HideWindow();
    }
    return;
}

function ClearStatus(bool bEtcItem, bool bShortItem)
{
    local int i, j, RowCount, RowCountTmp, ColCount;

    local StatusIconInfo Info;

    // End:0x3B
    if((bEtcItem == false) && bShortItem == false)
    {
        i_UnkInt1 = -1;
        i_UnkInt3 = -1;
        i_UnkInt4 = -1;
    }
    // End:0x60
    if((bEtcItem == true) && bShortItem == false)
    {
        i_UnkInt5 = -1;
    }
    // End:0x85
    if((bEtcItem == false) && bShortItem == true)
    {
        i_UnkInt6 = -1;
    }
    RowCount = StatusIcon.GetRowCount();
    i = 0;
    J0xA1:

    // End:0x1A9 [Loop If]
    if(i < RowCount)
    {
        ColCount = StatusIcon.GetColCount(i);
        j = 0;
        J0xD1:

        // End:0x19F [Loop If]
        if(j < ColCount)
        {
            StatusIcon.GetItem(i, j, Info);
            // End:0x195
            if(Info.ClassID > 0)
            {
                // End:0x195
                if((Info.bEtcItem == bEtcItem) && Info.bShortItem == bShortItem)
                {
                    StatusIcon.DelItem(i, j);
                    j--;
                    ColCount--;
                    RowCountTmp = StatusIcon.GetRowCount();
                    // End:0x195
                    if(RowCountTmp != RowCount)
                    {
                        i--;
                        RowCount--;
                    }
                }
            }
            j++;
            // [Loop Continue]
            goto J0xD1;
        }
        i++;
        // [Loop Continue]
        goto J0xA1;
    }
    return;
}

function ClearAll()
{
    ClearStatus(false, false);
    ClearStatus(true, false);
    ClearStatus(false, true);
    return;
}

function HandleAddNormalStatus(string param)
{
    local array<StatusIconInfo> a_ArrayStatusIcon1, a_ArrayStatusIcon2, a_ArrayStatusIcon3;
    local int i, Max, BuffCnt, i_UnkIntLocal1;
    local StatusIconInfo Info;

    ClearStatus(false, false);
    Info.Size = getBuffSize(GetOptionInt("Custom", "AbnormalSize"));
    Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
    Info.bShow = true;
    Info.bEtcItem = false;
    Info.bShortItem = false;
    BuffCnt = 0;
    i_UnkIntLocal1 = 0;
    ParseInt(param, "Max", Max);
    i = 0;
    J0xAF:

    // End:0x315 [Loop If]
    if(i < Max)
    {
        ParseInt(param, "SkillID_" $ string(i), Info.ClassID);
        ParseInt(param, "SkillLevel_" $ string(i), Info.Level);
        ParseInt(param, "RemainTime_" $ string(i), Info.RemainTime);
        ParseString(param, "Name_" $ string(i), Info.Name);
        ParseString(param, "IconName_" $ string(i), Info.IconName);
        ParseString(param, "Description_" $ string(i), Info.Description);
        Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
        // End:0x30B
        if(Info.ClassID > 0)
        {
            // End:0x235
            if((isSongDanceCustom(Info.ClassID)) && checkAbSongDance)
            {
                a_ArrayStatusIcon1.Length = a_ArrayStatusIcon1.Length + 1;
                a_ArrayStatusIcon1[a_ArrayStatusIcon1.Length - 1] = Info;
                // [Explicit Continue]
                goto J0x30B;
            }
            // End:0x27B
            if((f_UnkFunc1(Info.ClassID)) && checkAbPrior)
            {
                a_ArrayStatusIcon2.Length = a_ArrayStatusIcon2.Length + 1;
                a_ArrayStatusIcon2[a_ArrayStatusIcon2.Length - 1] = Info;
                // [Explicit Continue]
                goto J0x30B;
            }
            // End:0x30B
            if(isDebuffCustom(Info.ClassID))
            {
                Info.BackTex = "L2UI_CH3.Debuff";
                // End:0x2E6
                if(checkAbPriorDebuffSameRow && checkAbPrior)
                {
                    a_ArrayStatusIcon2.Length = a_ArrayStatusIcon2.Length + 1;
                    a_ArrayStatusIcon2[a_ArrayStatusIcon2.Length - 1] = Info;
                    // [Explicit Continue]
                    goto J0x30B;
                }
                a_ArrayStatusIcon3.Length = a_ArrayStatusIcon3.Length + 1;
                a_ArrayStatusIcon3[a_ArrayStatusIcon3.Length - 1] = Info;
            }
        }
        J0x30B:

        i++;
        // [Loop Continue]
        goto J0xAF;
    }
    i = 0;
    J0x31C:

    // End:0x3DC [Loop If]
    if(i < a_ArrayStatusIcon2.Length)
    {
        // End:0x371
        if((i_UnkInt3 == -1) && i_UnkInt4 == -1)
        {
            i_UnkInt3 = i_UnkInt1 + 1;
            StatusIcon.InsertRow(i_UnkInt3);            
        }
        else
        {
            // End:0x3B3
            if((i_UnkInt3 == -1) && i_UnkInt4 > -1)
            {
                i_UnkInt3 = i_UnkInt4 + 1;
                StatusIcon.InsertRow(i_UnkInt3);
            }
        }
        StatusIcon.AddCol(i_UnkInt3, a_ArrayStatusIcon2[i]);
        i++;
        // [Loop Continue]
        goto J0x31C;
    }
    i = 0;
    J0x3E3:

    // End:0x50A [Loop If]
    if(i < a_ArrayStatusIcon3.Length)
    {
        // End:0x449
        if(((i_UnkInt2 == -1) && i_UnkInt3 == -1) && i_UnkInt4 == -1)
        {
            i_UnkInt2 = i_UnkInt1 + 1;
            StatusIcon.InsertRow(i_UnkInt2);            
        }
        else
        {
            // End:0x49F
            if(((i_UnkInt2 == -1) && i_UnkInt3 == -1) && i_UnkInt4 > -1)
            {
                i_UnkInt2 = i_UnkInt4 + 1;
                StatusIcon.InsertRow(i_UnkInt2);                
            }
            else
            {
                // End:0x4E1
                if((i_UnkInt2 == -1) && i_UnkInt3 > -1)
                {
                    i_UnkInt2 = i_UnkInt3 + 1;
                    StatusIcon.InsertRow(i_UnkInt2);
                }
            }
        }
        StatusIcon.AddCol(i_UnkInt2, a_ArrayStatusIcon3[i]);
        i++;
        // [Loop Continue]
        goto J0x3E3;
    }
    // End:0x57E
    if(i_UnkInt5 > -1)
    {
        i_UnkInt5 = i_UnkInt1 + 1;
        // End:0x544
        if(i_UnkInt4 > -1)
        {
            i_UnkInt5 = i_UnkInt4 + 1;
        }
        // End:0x561
        if(i_UnkInt3 > -1)
        {
            i_UnkInt5 = i_UnkInt3 + 1;
        }
        // End:0x57E
        if(i_UnkInt2 > -1)
        {
            i_UnkInt5 = i_UnkInt2 + 1;
        }
    }
    // End:0x600
    if(i_UnkInt6 > -1)
    {
        i_UnkInt6 = i_UnkInt1 + 1;
        // End:0x5B8
        if(i_UnkInt4 > -1)
        {
            i_UnkInt6 = i_UnkInt4 + 1;
        }
        i_UnkInt6 = i_UnkInt1 + 1;
        // End:0x5E3
        if(i_UnkInt3 > -1)
        {
            i_UnkInt6 = i_UnkInt3 + 1;
        }
        // End:0x600
        if(i_UnkInt2 > -1)
        {
            i_UnkInt6 = i_UnkInt2 + 1;
        }
    }
    ProbablyAddEmptyBuff();
    UpdateWindowSize();
    return;
}

function HandleAddEtcStatus(string param)
{
    local int i, Max, BuffCnt, CurRow;
    local bool bNewRow;
    local StatusIconInfo Info;

    ClearStatus(true, false);
    Info.Size = getBuffSize(GetOptionInt("Custom", "AbnormalSize"));
    Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
    Info.bShow = true;
    Info.bEtcItem = true;
    Info.bShortItem = false;
    // End:0xAA
    if(i_UnkInt6 > -1)
    {
        bNewRow = false;
        CurRow = i_UnkInt6;        
    }
    else
    {
        bNewRow = true;
        CurRow = i_UnkInt1;
        // End:0xD7
        if(i_UnkInt4 > -1)
        {
            CurRow = i_UnkInt4;
        }
        // End:0xED
        if(i_UnkInt2 > -1)
        {
            CurRow++;
        }
        // End:0x103
        if(i_UnkInt3 > -1)
        {
            CurRow++;
        }
    }
    BuffCnt = 0;
    ParseInt(param, "Max", Max);
    ProbablyRemoveEmptyBuff();
    i = 0;
    J0x12C:

    // End:0x2AB [Loop If]
    if(i < Max)
    {
        ParseInt(param, "SkillID_" $ string(i), Info.ClassID);
        ParseInt(param, "SkillLevel_" $ string(i), Info.Level);
        ParseInt(param, "RemainTime_" $ string(i), Info.RemainTime);
        ParseString(param, "Name_" $ string(i), Info.Name);
        ParseString(param, "IconName_" $ string(i), Info.IconName);
        ParseString(param, "Description_" $ string(i), Info.Description);
        // End:0x2A1
        if(Info.ClassID > 0)
        {
            // End:0x276
            if(bNewRow)
            {
                bNewRow = !bNewRow;
                CurRow++;
                StatusIcon.InsertRow(CurRow);
            }
            StatusIcon.AddCol(CurRow, Info);
            i_UnkInt5 = CurRow;
            BuffCnt++;
        }
        i++;
        // [Loop Continue]
        goto J0x12C;
    }
    ProbablyAddEmptyBuff();
    UpdateWindowSize();
    return;
}

function HandleAddShortStatus(string param)
{
    local int i, Max, BuffCnt, CurRow;
    local bool bNewRow;
    local StatusIconInfo Info;

    ClearStatus(false, true);
    Info.Size = getBuffSize(GetOptionInt("Custom", "AbnormalSize"));
    Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
    Info.bShow = true;
    Info.bEtcItem = false;
    Info.bShortItem = true;
    // End:0xAA
    if(i_UnkInt5 > -1)
    {
        bNewRow = false;
        CurRow = i_UnkInt5;        
    }
    else
    {
        bNewRow = true;
        CurRow = i_UnkInt1;
        // End:0xD7
        if(i_UnkInt4 > -1)
        {
            CurRow = i_UnkInt4;
        }
        // End:0xED
        if(i_UnkInt2 > -1)
        {
            CurRow++;
        }
        // End:0x103
        if(i_UnkInt3 > -1)
        {
            CurRow++;
        }
    }
    BuffCnt = 0;
    ParseInt(param, "Max", Max);
    ProbablyRemoveEmptyBuff();
    i = 0;
    J0x12C:

    // End:0x2AB [Loop If]
    if(i < Max)
    {
        ParseInt(param, "SkillID_" $ string(i), Info.ClassID);
        ParseInt(param, "SkillLevel_" $ string(i), Info.Level);
        ParseInt(param, "RemainTime_" $ string(i), Info.RemainTime);
        ParseString(param, "Name_" $ string(i), Info.Name);
        ParseString(param, "IconName_" $ string(i), Info.IconName);
        ParseString(param, "Description_" $ string(i), Info.Description);
        // End:0x2A1
        if(Info.ClassID > 0)
        {
            // End:0x276
            if(bNewRow)
            {
                bNewRow = !bNewRow;
                CurRow++;
                StatusIcon.InsertRow(CurRow);
            }
            StatusIcon.AddCol(CurRow, Info);
            i_UnkInt6 = CurRow;
            BuffCnt++;
        }
        i++;
        // [Loop Continue]
        goto J0x12C;
    }
    ProbablyAddEmptyBuff();
    UpdateWindowSize();
    return;
}

function UpdateWindowSize()
{
    local int RowCount;
    local Rect rectWnd;

    RowCount = StatusIcon.GetRowCount();
    // End:0xEC
    if(RowCount > 1)
    {
        // End:0x3B
        if(m_bOnCurState)
        {
            Me.ShowWindow();            
        }
        else
        {
            Me.HideWindow();
        }
        rectWnd = StatusIcon.GetRect();
        Me.SetWindowSize(rectWnd.nWidth + 4, rectWnd.nHeight - (getBuffSize(GetOptionInt("Custom", "AbnormalSize"))));
        Me.SetFrameSize(4, rectWnd.nHeight - (getBuffSize(GetOptionInt("Custom", "AbnormalSize"))));        
    }
    else
    {
        Me.HideWindow();
    }
    return;
}

function HandleLanguageChanged()
{
    local int i, j, RowCount, ColCount;
    local StatusIconInfo Info;

    RowCount = StatusIcon.GetRowCount();
    i = 0;
    J0x1C:

    // End:0x117 [Loop If]
    if(i < RowCount)
    {
        ColCount = StatusIcon.GetColCount(i);
        j = 0;
        J0x4C:

        // End:0x10D [Loop If]
        if(j < ColCount)
        {
            StatusIcon.GetItem(i, j, Info);
            // End:0x103
            if(Info.ClassID > 0)
            {
                Info.Name = Class'NWindow.UIDATA_SKILL'.static.GetName(Info.ClassID, Info.Level);
                Info.Description = Class'NWindow.UIDATA_SKILL'.static.GetDescription(Info.ClassID, Info.Level);
                StatusIcon.SetItem(i, j, Info);
            }
            j++;
            // [Loop Continue]
            goto J0x4C;
        }
        i++;
        // [Loop Continue]
        goto J0x1C;
    }
    return;
}

function ReHandleAddNormalStatus()
{
    local array<StatusIconInfo> a_ArrayStatusIcon1, a_ArrayStatusIcon2, a_ArrayStatusIcon3, a_ArrayStatusIcon4, a_ArrayStatusIcon5;

    local int i, i_UnkIntLocal2, BuffCnt, i_UnkIntLocal1;
    local StatusIconInfo Info;
    local int j, RowCount, ColCount;

    RowCount = StatusIcon.GetRowCount();
    i = 0;
    J0x1C:

    // End:0xFC [Loop If]
    if(i < RowCount)
    {
        ColCount = StatusIcon.GetColCount(i);
        j = 0;
        J0x4C:

        // End:0xF2 [Loop If]
        if(j < ColCount)
        {
            StatusIcon.GetItem(i, j, Info);
            // End:0xE8
            if((((Info.ClassID > 0) && !Info.bEtcItem) && !Info.bShortItem) && Info.ClassID != 98944)
            {
                a_ArrayStatusIcon5.Length = a_ArrayStatusIcon5.Length + 1;
                a_ArrayStatusIcon5[a_ArrayStatusIcon5.Length - 1] = Info;
            }
            j++;
            // [Loop Continue]
            goto J0x4C;
        }
        i++;
        // [Loop Continue]
        goto J0x1C;
    }
    ClearStatus(false, false);
    BuffCnt = 0;
    i_UnkIntLocal1 = 0;
    i_UnkIntLocal2 = a_ArrayStatusIcon5.Length;
    i = 0;
    J0x125:

    // End:0x2D1 [Loop If]
    if(i < i_UnkIntLocal2)
    {
        Info = a_ArrayStatusIcon5[i];
        Info.Size = getBuffSize(GetOptionInt("Custom", "AbnormalSize"));
        Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
        // End:0x2C7
        if(Info.ClassID > 0)
        {
            // End:0x1F1
            if((isSongDanceCustom(Info.ClassID)) && checkAbSongDance)
            {
                a_ArrayStatusIcon1.Length = a_ArrayStatusIcon1.Length + 1;
                a_ArrayStatusIcon1[a_ArrayStatusIcon1.Length - 1] = Info;
                // [Explicit Continue]
                goto J0x2C7;
            }
            // End:0x237
            if((f_UnkFunc1(Info.ClassID)) && checkAbPrior)
            {
                a_ArrayStatusIcon2.Length = a_ArrayStatusIcon2.Length + 1;
                a_ArrayStatusIcon2[a_ArrayStatusIcon2.Length - 1] = Info;
                // [Explicit Continue]
                goto J0x2C7;
            }
            // End:0x2C7
            if(isDebuffCustom(Info.ClassID))
            {
                Info.BackTex = "L2UI_CH3.Debuff";
                // End:0x2A2
                if(checkAbPriorDebuffSameRow && checkAbPrior)
                {
                    a_ArrayStatusIcon2.Length = a_ArrayStatusIcon2.Length + 1;
                    a_ArrayStatusIcon2[a_ArrayStatusIcon2.Length - 1] = Info;
                    // [Explicit Continue]
                    goto J0x2C7;
                }
                a_ArrayStatusIcon3.Length = a_ArrayStatusIcon3.Length + 1;
                a_ArrayStatusIcon3[a_ArrayStatusIcon3.Length - 1] = Info;
            }
        }
        J0x2C7:

        i++;
        // [Loop Continue]
        goto J0x125;
    }
    i = 0;
    J0x2D8:

    // End:0x348 [Loop If]
    if(i < a_ArrayStatusIcon4.Length)
    {
        // End:0x318
        if((float(BuffCnt) % float(12)) == float(0))
        {
            i_UnkInt1++;
            StatusIcon.InsertRow(i_UnkInt1);
        }
        StatusIcon.AddCol(i_UnkInt1, a_ArrayStatusIcon4[i]);
        BuffCnt++;
        i++;
        // [Loop Continue]
        goto J0x2D8;
    }
    i = 0;
    J0x34F:

    // End:0x3D9 [Loop If]
    if(i < a_ArrayStatusIcon1.Length)
    {
        // End:0x379
        if(i_UnkInt4 == -1)
        {
            i_UnkInt4 = i_UnkInt1;
        }
        // End:0x3A9
        if((float(i_UnkIntLocal1) % float(12)) == float(0))
        {
            i_UnkInt4++;
            StatusIcon.InsertRow(i_UnkInt4);
        }
        StatusIcon.AddCol(i_UnkInt4, a_ArrayStatusIcon1[i]);
        i_UnkIntLocal1++;
        i++;
        // [Loop Continue]
        goto J0x34F;
    }
    i = 0;
    J0x3E0:

    // End:0x4A0 [Loop If]
    if(i < a_ArrayStatusIcon2.Length)
    {
        // End:0x435
        if((i_UnkInt3 == -1) && i_UnkInt4 == -1)
        {
            i_UnkInt3 = i_UnkInt1 + 1;
            StatusIcon.InsertRow(i_UnkInt3);            
        }
        else
        {
            // End:0x477
            if((i_UnkInt3 == -1) && i_UnkInt4 > -1)
            {
                i_UnkInt3 = i_UnkInt4 + 1;
                StatusIcon.InsertRow(i_UnkInt3);
            }
        }
        StatusIcon.AddCol(i_UnkInt3, a_ArrayStatusIcon2[i]);
        i++;
        // [Loop Continue]
        goto J0x3E0;
    }
    i = 0;
    J0x4A7:

    // End:0x5CE [Loop If]
    if(i < a_ArrayStatusIcon3.Length)
    {
        // End:0x50D
        if(((i_UnkInt2 == -1) && i_UnkInt3 == -1) && i_UnkInt4 == -1)
        {
            i_UnkInt2 = i_UnkInt1 + 1;
            StatusIcon.InsertRow(i_UnkInt2);            
        }
        else
        {
            // End:0x563
            if(((i_UnkInt2 == -1) && i_UnkInt3 == -1) && i_UnkInt4 > -1)
            {
                i_UnkInt2 = i_UnkInt4 + 1;
                StatusIcon.InsertRow(i_UnkInt2);                
            }
            else
            {
                // End:0x5A5
                if((i_UnkInt2 == -1) && i_UnkInt3 > -1)
                {
                    i_UnkInt2 = i_UnkInt3 + 1;
                    StatusIcon.InsertRow(i_UnkInt2);
                }
            }
        }
        StatusIcon.AddCol(i_UnkInt2, a_ArrayStatusIcon3[i]);
        i++;
        // [Loop Continue]
        goto J0x4A7;
    }
    // End:0x642
    if(i_UnkInt5 > -1)
    {
        i_UnkInt5 = i_UnkInt1 + 1;
        // End:0x608
        if(i_UnkInt4 > -1)
        {
            i_UnkInt5 = i_UnkInt4 + 1;
        }
        // End:0x625
        if(i_UnkInt3 > -1)
        {
            i_UnkInt5 = i_UnkInt3 + 1;
        }
        // End:0x642
        if(i_UnkInt2 > -1)
        {
            i_UnkInt5 = i_UnkInt2 + 1;
        }
    }
    // End:0x6C4
    if(i_UnkInt6 > -1)
    {
        i_UnkInt6 = i_UnkInt1 + 1;
        // End:0x67C
        if(i_UnkInt4 > -1)
        {
            i_UnkInt6 = i_UnkInt4 + 1;
        }
        i_UnkInt6 = i_UnkInt1 + 1;
        // End:0x6A7
        if(i_UnkInt3 > -1)
        {
            i_UnkInt6 = i_UnkInt3 + 1;
        }
        // End:0x6C4
        if(i_UnkInt2 > -1)
        {
            i_UnkInt6 = i_UnkInt2 + 1;
        }
    }
    ProbablyAddEmptyBuff();
    UpdateWindowSize();
    return;
}

function bool f_UnkFunc1(int ClassID)
{
    local int j;

    j = 0;
    J0x07:

    // End:0x38 [Loop If]
    if(j < a_UnkArrayInt1.Length)
    {
        // End:0x2E
        if(a_UnkArrayInt1[j] == ClassID)
        {
            return true;
        }
        j++;
        // [Loop Continue]
        goto J0x07;
    }
    return false;
}

function int getBuffSize(int Index)
{
    local int resultIndex;

    switch(Index)
    {
        // End:0x16
        case 0:
            resultIndex = 24;
            // End:0x38
            break;
        // End:0x25
        case 1:
            resultIndex = 20;
            // End:0x38
            break;
        // End:0x35
        case 2:
            resultIndex = 16;
            // End:0x38
            break;
        // End:0xFFFF
        default:
            break;
    }
    return resultIndex;
}

function ProbablyAddEmptyBuff()
{
    local StatusIconInfo Info;
    local int RowCount;

    Info.Size = getBuffSize(GetOptionInt("Custom", "AbnormalSize"));
    Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
    Info.bShow = false;
    Info.bEtcItem = false;
    Info.bShortItem = false;
    Info.ClassID = 98944;
    Info.Level = 4;
    Info.IconName = "";
    RowCount = StatusIcon.GetRowCount();
    StatusIcon.InsertRow(RowCount);
    StatusIcon.AddCol(RowCount, Info);
    return;
}

function ProbablyRemoveEmptyBuff()
{
    local int i, j, RowCount, ColCount;
    local StatusIconInfo Info;

    RowCount = StatusIcon.GetRowCount();
    i = RowCount;
    J0x20:

    // End:0xCF [Loop If]
    if(i >= 0)
    {
        ColCount = StatusIcon.GetColCount(i);
        j = ColCount;
        J0x50:

        // End:0xC5 [Loop If]
        if(j >= 0)
        {
            StatusIcon.GetItem(i, j, Info);
            // End:0xBB
            if((Info.ClassID == 98944) && Info.Level == 4)
            {
                StatusIcon.DelItem(i, j);
                return;
            }
            j--;
            // [Loop Continue]
            goto J0x50;
        }
        i--;
        // [Loop Continue]
        goto J0x20;
    }
    return;
}
