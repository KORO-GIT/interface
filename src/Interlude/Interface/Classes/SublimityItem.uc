class SublimityItem extends UISublimityCommonAPI;

const MULTI_SELL_LIST = 0;
const BUFF_LIST = 1;

var bool bDebug;
var bool m_Capture;
var int a_Capture;
var int a_LastKey;

function OnDialogOK()
{
    return;
}

function OnDialogCancel()
{
    return;
}

function OnPCCafePointInfo(int a_TotalPoint, int a_AddPoint, int a_PeriodType, int a_RemainTime, int a_PointType)
{
    return;
}

function OnQuestListStart()
{
    return;
}

function OnQuestList(int a_QuestID, int a_Level, int a_Completed)
{
    return;
}

function OnQuestListEnd()
{
    return;
}

function OnArriveShowQuest(int a_QuestID)
{
    return;
}

function OnShortcutCommand(string a_Command)
{
    return;
}

function OnRestart()
{
    return;
}

function OnDie()
{
    return;
}

function OnAbnormalStatusNormalItem(array<StatusIconInfo> a_Items)
{
    return;
}

function OnAbnormalStatusEtcItem(array<StatusIconInfo> a_Items)
{
    return;
}

function OnAbnormalStatusShortItem(array<StatusIconInfo> a_Items)
{
    return;
}

function OnMultiSellShopID(int a_ID)
{
    return;
}

function OnMultiSellItemList(int a_Index, int a_Type, int a_ID, int a_SlotBitType, int a_ItemType, int a_ItemCount, int a_OutputRefineryOp1, int a_OutputRefineryOp2)
{
    return;
}

function OnMultiSellNeededItemList(int a_ID, int a_RefineryOp1, int a_RefineryOp2, int a_ClassID, int a_Count, int a_Enchant, int a_InputRefineryOp1, int a_InputRefineryOp2)
{
    return;
}

function OnMultiSellItemListEnd()
{
    return;
}

function ProcessPCCafePointInfo(string a_Param)
{
    local int m_TotalPoint, m_AddPoint, m_PeriodType, m_RemainTime, m_PointType;

    ParseInt(a_Param, "TotalPoint", m_TotalPoint);
    ParseInt(a_Param, "AddPoint", m_AddPoint);
    ParseInt(a_Param, "PeriodType", m_PeriodType);
    ParseInt(a_Param, "RemainTime", m_RemainTime);
    ParseInt(a_Param, "PointType", m_PointType);
    OnPCCafePointInfo(m_TotalPoint, m_AddPoint, m_PeriodType, m_RemainTime, m_PointType);
    return;
}

function ProcessQuestListStart(string a_Param)
{
    OnQuestListStart();
    return;
}

function ProcessQuestList(string a_Param)
{
    local int m_QuestID, m_Level, m_Completed;

    ParseInt(a_Param, "QuestID", m_QuestID);
    ParseInt(a_Param, "Level", m_Level);
    ParseInt(a_Param, "Completed", m_Completed);
    OnQuestList(m_QuestID, m_Level, m_Completed);
    return;
}

function ProcessQuestListEnd(string a_Param)
{
    OnQuestListEnd();
    return;
}

function ProcessArriveShowQuest(string a_Param)
{
    local int m_QuestID;

    ParseInt(a_Param, "QuestID", m_QuestID);
    OnArriveShowQuest(m_QuestID);
    return;
}

function ProcessShortcutCommand(string a_Param)
{
    local string m_Command;

    ParseString(a_Param, "Command", m_Command);
    OnShortcutCommand(m_Command);
    return;
}

function ProcessAbnormalStatusNormalItem(string a_Param)
{
    local array<StatusIconInfo> m_Items;

    ProcessAbnormalStatusList(m_Items, a_Param, false, false);
    OnAbnormalStatusNormalItem(m_Items);
    return;
}

function ProcessAbnormalStatusEtcItem(string a_Param)
{
    local array<StatusIconInfo> m_Items;

    ProcessAbnormalStatusList(m_Items, a_Param, true, false);
    OnAbnormalStatusEtcItem(m_Items);
    return;
}

function ProcessAbnormalStatusShortItem(string a_Param)
{
    local array<StatusIconInfo> m_Items;

    ProcessAbnormalStatusList(m_Items, a_Param, false, true);
    OnAbnormalStatusShortItem(m_Items);
    return;
}

function ProcessAbnormalStatusList(out array<StatusIconInfo> a_Items, string a_Param, bool a_bEtcItem, bool a_bShortItem)
{
    local int i, Max;
    local StatusIconInfo Info;

    ParseInt(a_Param, "Max", Max);
    i = 0;
    J0x1C:

    // End:0xC4 [Loop If]
    if(i < Max)
    {
        Info = ProcessAbmormalItem(a_Param, i);
        Info.Size = 24;
        Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
        Info.bShow = true;
        Info.bEtcItem = a_bEtcItem;
        Info.bShortItem = a_bShortItem;
        a_Items[a_Items.Length] = Info;
        i++;
        // [Loop Continue]
        goto J0x1C;
    }
    return;
}

function StatusIconInfo ProcessAbmormalItem(string a_Param, int a_Index)
{
    local StatusIconInfo Info;

    ParseInt(a_Param, "SkillID_" $ string(a_Index), Info.ClassID);
    ParseInt(a_Param, "SkillLevel_" $ string(a_Index), Info.Level);
    ParseInt(a_Param, "RemainTime_" $ string(a_Index), Info.RemainTime);
    ParseString(a_Param, "Name_" $ string(a_Index), Info.Name);
    ParseString(a_Param, "IconName_" $ string(a_Index), Info.IconName);
    ParseString(a_Param, "Description_" $ string(a_Index), Info.Description);
    return Info;
}

function ProcessMultiSellShopID(string a_Param)
{
    local int m_ShopID;

    ParseInt(a_Param, "shopID", m_ShopID);
    OnMultiSellShopID(m_ShopID);
    return;
}

function ProcessMultiSellItemList(string a_Param)
{
    local int m_Index, m_Type, m_ID, m_SlotBitType, m_ItemType, m_ItemCount,
	    m_OutputRefineryOp1, m_OutputRefineryOp2;

    ParseInt(a_Param, "index", m_Index);
    ParseInt(a_Param, "type", m_Type);
    ParseInt(a_Param, "ID", m_ID);
    ParseInt(a_Param, "slotBitType", m_SlotBitType);
    ParseInt(a_Param, "itemType", m_ItemType);
    ParseInt(a_Param, "itemCount", m_ItemCount);
    ParseInt(a_Param, "OutputRefineryOp1", m_OutputRefineryOp1);
    ParseInt(a_Param, "OutputRefineryOp2", m_OutputRefineryOp2);
    OnMultiSellItemList(m_Index, m_Type, m_ID, m_SlotBitType, m_ItemType, m_ItemCount, m_OutputRefineryOp1, m_OutputRefineryOp2);
    return;
}

function ProcessMultiSellNeededItemList(string a_Param)
{
    local int Id, RefineryOp1, RefineryOp2, ClassID, Count, Enchant,
	    InputRefineryOp1, InputRefineryOp2;

    ParseInt(a_Param, "ID", Id);
    ParseInt(a_Param, "refineryOp1", RefineryOp1);
    ParseInt(a_Param, "refineryOp2", RefineryOp2);
    ParseInt(a_Param, "ClassID", ClassID);
    ParseInt(a_Param, "count", Count);
    ParseInt(a_Param, "enchant", Enchant);
    ParseInt(a_Param, "inputRefineryOp1", InputRefineryOp1);
    ParseInt(a_Param, "inputRefineryOp2", InputRefineryOp2);
    OnMultiSellNeededItemList(Id, RefineryOp1, RefineryOp2, ClassID, Count, Enchant, InputRefineryOp1, InputRefineryOp2);
    return;
}

function ProcessMultiSellItemListEnd(string a_Param)
{
    OnMultiSellItemListEnd();
    return;
}

function OnShortcutDelete(int a_ShortcutID)
{
    return;
}

function ProcessShortcutDelete(string a_Param)
{
    local int m_ShortcutID;

    ParseInt(a_Param, "ShortcutID", m_ShortcutID);
    OnShortcutDelete(m_ShortcutID);
    return;
}

function OnShortcutUpdate(int a_ShortcutID)
{
    return;
}

function ProcessShortcutUpdate(string a_Param)
{
    local int m_ShortcutID;

    ParseInt(a_Param, "ShortcutID", m_ShortcutID);
    OnShortcutUpdate(m_ShortcutID);
    return;
}

function OnShortcutPageUpdate(int a_ShortcutPage)
{
    return;
}

function ProcessShortcutPageUpdate(string a_Param)
{
    local int m_ShortcutPage;

    ParseInt(a_Param, "ShortcutPage", m_ShortcutPage);
    OnShortcutPageUpdate(m_ShortcutPage);
    return;
}

function OnShortcutJoypad(int a_OnOff)
{
    return;
}

function ProcessShortcutJoypad(string a_Param)
{
    local int m_OnOff;

    ParseInt(a_Param, "OnOff", m_OnOff);
    OnShortcutJoypad(m_OnOff);
    return;
}

function OnShortcutClear()
{
    return;
}

function ProcessShortcutClear(string a_Param)
{
    OnShortcutClear();
    return;
}

function OnJoypadLButtonDown()
{
    return;
}

function ProcessJoypadLButtonDown(string a_Param)
{
    OnJoypadLButtonDown();
    return;
}

function OnJoypadLButtonUp()
{
    return;
}

function ProcessJoypadLButtonUp(string a_Param)
{
    OnJoypadLButtonUp();
    return;
}

function OnJoypadRButtonDown()
{
    return;
}

function ProcessJoypadRButtonDown(string a_Param)
{
    OnJoypadRButtonDown();
    return;
}

function OnJoypadRButtonUp()
{
    return;
}

function ProcessJoypadRButtonUp(string a_Param)
{
    OnJoypadRButtonDown();
    return;
}

function OnGamingStateEnter()
{
    return;
}

function ProcessGamingStateEnter(string a_Param)
{
    OnGamingStateEnter();
    return;
}

function OnGamingStateExit()
{
    return;
}

function ProcessGamingStateExit(string a_Param)
{
    OnGamingStateExit();
    return;
}

function OnUpdateUserInfo()
{
    return;
}

function ProcessUpdateUserInfo(string a_Param)
{
    OnUpdateUserInfo();
    return;
}

function OnPeaceZoneEnter()
{
    return;
}

function ProcessPeaceZoneEnter(string a_Param)
{
    OnPeaceZoneEnter();
    return;
}

function OnPeaceZoneLeave()
{
    return;
}

function ProcessPeaceZoneLeave(string a_Param)
{
    OnPeaceZoneLeave();
    return;
}

function OnGlobalTick(int a_Time)
{
    return;
}

function ProcessGlobalTick(string a_Param)
{
    local int m_Time;

    ParseInt(a_Param, "Time", m_Time);
    OnGlobalTick(m_Time);
    return;
}

function OnMouseEvent(int a_Key, int a_State, int X, int Y)
{
    return;
}

function OnMouseMoveEvent(int a_Key, int a_State, int X, int Y)
{
    return;
}

function ProcessMouseEvent(string a_Param)
{
    local int m_Key, m_State, X, Y;

    ParseInt(a_Param, "key", m_Key);
    ParseInt(a_Param, "state", m_State);
    ParseInt(a_Param, "X", X);
    ParseInt(a_Param, "Y", Y);
    OnMouseEvent(m_Key, m_State, X, Y);
    return;
}

function ProcessMouseMoveEvent(string a_Param)
{
    local int m_Key, m_State, X, Y;

    ParseInt(a_Param, "key", m_Key);
    ParseInt(a_Param, "state", m_State);
    ParseInt(a_Param, "X", X);
    ParseInt(a_Param, "Y", Y);
    OnMouseMoveEvent(m_Key, m_State, X, Y);
    return;
}

function ProcessRestart()
{
    return;
}

function OnKeyboardEvent(int a_Key, int a_State)
{
    return;
}

function ProcessKeyboardEvent(string a_Param)
{
    local int m_Key, m_State;

    ParseInt(a_Param, "key", m_Key);
    ParseInt(a_Param, "state", m_State);
    OnKeyboardEvent(m_Key, m_State);
    return;
}

function OnPinCheckRequest()
{
    return;
}

function OnPinCheckFail(int a_AttemptsLeft)
{
    return;
}

function OnPinCheckSuccess()
{
    return;
}

function OnPinCreateRequest()
{
    return;
}

function OnPinCreateFail()
{
    return;
}

function OnPinCreateSuccess()
{
    return;
}

function OnBotCheckRequest(int a_Time, int a_Tex1, int a_Tex2, int a_Tex3, int a_Tex4)
{
    return;
}

function OnBotCheckFail(int a_Time, int a_Tex1, int a_Tex2, int a_Tex3, int a_Tex4)
{
    return;
}

function OnBotCheckSuccess()
{
    return;
}

function OnSkillCastStart(int a_SkillID, int a_CastTime)
{
    return;
}

function OnSkillCastCancel()
{
    return;
}

function OnUnReadMessageCount(int a_MessageCount)
{
    return;
}

function OnQuestNotification(int a_QuestID, int a_Level)
{
    return;
}

function OnClanOnlineUpdate(int a_Count)
{
    return;
}

function OnMouseLock()
{
    return;
}

function OnMouseUnlock()
{
    return;
}

function OnShowCountdown(string a_Param)
{
    return;
}

function OnHideCountdown()
{
    return;
}

function OnSuccessCountdown()
{
    return;
}

function OnFailCountdown()
{
    return;
}

function OnBuffListStart(int a_BuffLimit)
{
    return;
}

function ProcessBuffListStart(string a_Param)
{
    local int m_BuffLimit;

    // End:0x27
    if(bDebug)
    {
        DebugMessage("OnBuffListStart" @ a_Param);
    }
    ParseInt(a_Param, "BuffLimit", m_BuffLimit);
    OnBuffListStart(m_BuffLimit);
    return;
}

function OnBuffListItem(int a_Category, int a_SkillID, int a_Level, int a_Available)
{
    return;
}

function ProcessBuffListItem(string a_Param)
{
    local int m_Category, m_SkillID, m_SkillLevel, m_Available;

    // End:0x26
    if(bDebug)
    {
        DebugMessage("OnBuffListItem" @ a_Param);
    }
    ParseInt(a_Param, "Category", m_Category);
    ParseInt(a_Param, "SkillID", m_SkillID);
    ParseInt(a_Param, "SkillLevel", m_SkillLevel);
    ParseInt(a_Param, "Available", m_Available);
    OnBuffListItem(m_Category, m_SkillID, m_SkillLevel, m_Available);
    return;
}

function OnBuffListEnd()
{
    return;
}

function ProcessBuffListEnd(string a_Param)
{
    // End:0x25
    if(bDebug)
    {
        DebugMessage("OnBuffListEnd" @ a_Param);
    }
    OnBuffListEnd();
    return;
}

function OnCameraPosition(float X, float Y, float Z, float FOV)
{
    return;
}

function ProcessCameraPosition(string a_Param)
{
    local float X, Y, Z, FOV;

    ParseFloat(a_Param, "X", X);
    ParseFloat(a_Param, "Y", Y);
    ParseFloat(a_Param, "Z", Z);
    ParseFloat(a_Param, "FOV", FOV);
    OnCameraPosition(X, Y, Z, FOV);
    return;
}

function ProcessPinCheckFail(string a_Param)
{
    local int m_AttemptsLeft;

    ParseInt(a_Param, "AttemptsLeft", m_AttemptsLeft);
    OnPinCheckFail(m_AttemptsLeft);
    return;
}

function ProcessBotCheckRequest(string a_Param)
{
    local int m_Time, m_Tex1, m_Tex2, m_Tex3, m_Tex4;

    ParseInt(a_Param, "Time", m_Time);
    ParseInt(a_Param, "Tex1", m_Tex1);
    ParseInt(a_Param, "Tex2", m_Tex2);
    ParseInt(a_Param, "Tex3", m_Tex3);
    ParseInt(a_Param, "Tex4", m_Tex4);
    OnBotCheckRequest(m_Time, m_Tex1, m_Tex2, m_Tex3, m_Tex4);
    return;
}

function ProcessBotCheckFail(string a_Param)
{
    local int m_Time, m_Tex1, m_Tex2, m_Tex3, m_Tex4;

    ParseInt(a_Param, "Time", m_Time);
    ParseInt(a_Param, "Tex1", m_Tex1);
    ParseInt(a_Param, "Tex2", m_Tex2);
    ParseInt(a_Param, "Tex3", m_Tex3);
    ParseInt(a_Param, "Tex4", m_Tex4);
    OnBotCheckFail(m_Time, m_Tex1, m_Tex2, m_Tex3, m_Tex4);
    return;
}

function ProcessSkillCastStart(string a_Param)
{
    local int m_SkillID, m_CastTime;

    ParseInt(a_Param, "SkillID", m_SkillID);
    ParseInt(a_Param, "CastTime", m_CastTime);
    OnSkillCastStart(m_SkillID, m_CastTime);
    return;
}

function ProcessSkillCastCancel(string a_Param)
{
    OnSkillCastCancel();
    return;
}

function ProcessUnReadMessageCount(string a_Param)
{
    local int m_MessageCount;

    ParseInt(a_Param, "MessageCount", m_MessageCount);
    OnUnReadMessageCount(m_MessageCount);
    return;
}

function ProcessQuestNotification(string a_Param)
{
    local int m_QuestID, m_Level;

    ParseInt(a_Param, "QuestID", m_QuestID);
    ParseInt(a_Param, "Level", m_Level);
    OnQuestNotification(m_QuestID, m_Level);
    return;
}

function ProcessClanOnlineUpdate(string a_Param)
{
    local int m_Count;

    ParseInt(a_Param, "Count", m_Count);
    OnClanOnlineUpdate(m_Count);
    return;
}

function ProcessMouseLock()
{
    OnMouseLock();
    return;
}

function ProcessMouseUnlock()
{
    OnMouseUnlock();
    return;
}

function ProcessShowCountdown(string a_Param)
{
    OnShowCountdown(a_Param);
    return;
}

function ProcessHideCountdown()
{
    OnHideCountdown();
    return;
}

function ProcessSuccessCountdown()
{
    OnSuccessCountdown();
    return;
}

function ProcessFailCountdown()
{
    OnFailCountdown();
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x1D
        case 1910:
            ProcessPCCafePointInfo(a_Param);
            // End:0x4DF
            break;
        // End:0x33
        case 700:
            ProcessQuestListStart(a_Param);
            // End:0x4DF
            break;
        // End:0x49
        case 710:
            ProcessQuestList(a_Param);
            // End:0x4DF
            break;
        // End:0x5F
        case 720:
            ProcessQuestListEnd(a_Param);
            // End:0x4DF
            break;
        // End:0x75
        case 1520:
            ProcessArriveShowQuest(a_Param);
            // End:0x4DF
            break;
        // End:0x88
        case 90:
            ProcessShortcutCommand(a_Param);
            // End:0x4DF
            break;
        // End:0x96
        case 40:
            OnRestart();
            // End:0x4DF
            break;
        // End:0xA4
        case 50:
            OnDie();
            // End:0x4DF
            break;
        // End:0xBA
        case 950:
            ProcessAbnormalStatusNormalItem(a_Param);
            // End:0x4DF
            break;
        // End:0xD0
        case 960:
            ProcessAbnormalStatusEtcItem(a_Param);
            // End:0x4DF
            break;
        // End:0xE6
        case 970:
            ProcessAbnormalStatusShortItem(a_Param);
            // End:0x4DF
            break;
        // End:0xFC
        case 630:
            ProcessShortcutUpdate(a_Param);
            // End:0x4DF
            break;
        // End:0x112
        case 631:
            ProcessShortcutDelete(a_Param);
            // End:0x4DF
            break;
        // End:0x128
        case 640:
            ProcessShortcutPageUpdate(a_Param);
            // End:0x4DF
            break;
        // End:0x13E
        case 660:
            ProcessShortcutJoypad(a_Param);
            // End:0x4DF
            break;
        // End:0x154
        case 650:
            ProcessShortcutClear(a_Param);
            // End:0x4DF
            break;
        // End:0x16A
        case 590:
            ProcessJoypadLButtonDown(a_Param);
            // End:0x4DF
            break;
        // End:0x180
        case 600:
            ProcessJoypadLButtonUp(a_Param);
            // End:0x4DF
            break;
        // End:0x196
        case 610:
            ProcessJoypadRButtonDown(a_Param);
            // End:0x4DF
            break;
        // End:0x1AC
        case 620:
            ProcessJoypadRButtonUp(a_Param);
            // End:0x4DF
            break;
        // End:0x1BF
        case 150:
            ProcessGamingStateEnter(a_Param);
            // End:0x4DF
            break;
        // End:0x1D2
        case 160:
            ProcessGamingStateExit(a_Param);
            // End:0x4DF
            break;
        // End:0x1E5
        case 180:
            ProcessUpdateUserInfo(a_Param);
            // End:0x4DF
            break;
        // End:0x1FB
        case 2530:
            ProcessMultiSellShopID(a_Param);
            // End:0x4DF
            break;
        // End:0x211
        case 2540:
            ProcessMultiSellItemList(a_Param);
            // End:0x4DF
            break;
        // End:0x227
        case 2550:
            ProcessMultiSellNeededItemList(a_Param);
            // End:0x4DF
            break;
        // End:0x23D
        case 2560:
            ProcessMultiSellItemListEnd(a_Param);
            // End:0x4DF
            break;
        // End:0x253
        case 25100:
            ProcessBuffListStart(a_Param);
            // End:0x4DF
            break;
        // End:0x269
        case 25101:
            ProcessBuffListItem(a_Param);
            // End:0x4DF
            break;
        // End:0x27F
        case 25102:
            ProcessBuffListEnd(a_Param);
            // End:0x4DF
            break;
        // End:0x299
        case 1710:
            // End:0x296
            if(DialogIsMine())
            {
                OnDialogOK();
            }
            // End:0x4DF
            break;
        // End:0x2B3
        case 1720:
            // End:0x2B0
            if(DialogIsMine())
            {
                OnDialogCancel();
            }
            // End:0x4DF
            break;
        // End:0x2C4
        case 100000:
            OnPinCheckRequest();
            // End:0x4DF
            break;
        // End:0x2DA
        case 100001:
            ProcessPinCheckFail(a_Param);
            // End:0x4DF
            break;
        // End:0x2EB
        case 100002:
            OnPinCheckSuccess();
            // End:0x4DF
            break;
        // End:0x2FC
        case 100003:
            OnPinCreateRequest();
            // End:0x4DF
            break;
        // End:0x30D
        case 100004:
            OnPinCreateFail();
            // End:0x4DF
            break;
        // End:0x31E
        case 100005:
            OnPinCreateSuccess();
            // End:0x4DF
            break;
        // End:0x334
        case 100006:
            ProcessBotCheckRequest(a_Param);
            // End:0x4DF
            break;
        // End:0x34A
        case 100007:
            ProcessBotCheckFail(a_Param);
            // End:0x4DF
            break;
        // End:0x35B
        case 100008:
            OnBotCheckSuccess();
            // End:0x4DF
            break;
        // End:0x371
        case 100009:
            ProcessSkillCastStart(a_Param);
            // End:0x4DF
            break;
        // End:0x387
        case 100010:
            ProcessSkillCastCancel(a_Param);
            // End:0x4DF
            break;
        // End:0x39D
        case 100011:
            ProcessUnReadMessageCount(a_Param);
            // End:0x4DF
            break;
        // End:0x3B3
        case 10002:
            ProcessQuestNotification(a_Param);
            // End:0x4DF
            break;
        // End:0x3C9
        case 200000:
            ProcessClanOnlineUpdate(a_Param);
            // End:0x4DF
            break;
        // End:0x3DF
        case 100012:
            ProcessPeaceZoneEnter(a_Param);
            // End:0x4DF
            break;
        // End:0x3F5
        case 100013:
            ProcessPeaceZoneLeave(a_Param);
            // End:0x4DF
            break;
        // End:0x406
        case 100014:
            ProcessMouseLock();
            // End:0x4DF
            break;
        // End:0x417
        case 100015:
            ProcessMouseUnlock();
            // End:0x4DF
            break;
        // End:0x42D
        case 100016:
            ProcessShowCountdown(a_Param);
            // End:0x4DF
            break;
        // End:0x43E
        case 100017:
            ProcessHideCountdown();
            // End:0x4DF
            break;
        // End:0x44F
        case 100018:
            ProcessSuccessCountdown();
            // End:0x4DF
            break;
        // End:0x460
        case 100019:
            ProcessFailCountdown();
            // End:0x4DF
            break;
        // End:0x476
        case 25000:
            ProcessGlobalTick(a_Param);
            // End:0x4DF
            break;
        // End:0x48C
        case 25001:
            ProcessMouseEvent(a_Param);
            // End:0x4DF
            break;
        // End:0x4A2
        case 25002:
            ProcessKeyboardEvent(a_Param);
            // End:0x4DF
            break;
        // End:0x4B8
        case 25003:
            ProcessCameraPosition(a_Param);
            // End:0x4DF
            break;
        // End:0x4CE
        case 25004:
            ProcessMouseMoveEvent(a_Param);
            // End:0x4DF
            break;
        // End:0x4DC
        case 40:
            ProcessRestart();
            // End:0x4DF
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}
