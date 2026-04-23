class GametipWnd extends UIScript;

var array<GameTipData> TipData;
var int CountRecord;
var UserInfo userinfofortip;
var string CurrentTip;
var int numb;

function OnLoad()
{
    LoadGameTipData();
    RegisterEvent(1900);
    return;
}

function OnEventWithStr(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x18
        case 1900:
            LoadGameTipData();
            // End:0x1B
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function LoadGameTipData()
{
    local int i;
    local bool gamedataloaded;
    local GameTipData TipData1;

    CountRecord = Class'NWindow.UIDATA_GAMETIP'.static.GetDataCount();
    i = 0;

    while(i < CountRecord)
    {
        gamedataloaded = Class'NWindow.UIDATA_GAMETIP'.static.GetDataByIndex(i, TipData1);
        TipData[i] = TipData1;
        ++i;
    }
    return;
}

function OnShow()
{
    local int RandomVal, PrioritySelect, UserLevelData;
    local bool userinfoloaded;
    local array<string> SelectedCondition;
    local int i, j, UserLevel, UserArrange, NumberSelect;

    j = 0;
    userinfoloaded = GetPlayerInfo(userinfofortip);
    // End:0x28
    if(userinfoloaded == false)
    {        
    }
    UserLevelData = userinfofortip.nLevel;
    // End:0x5B
    if((UserLevelData >= 1) && UserLevelData <= 20)
    {
        UserLevel = 1;        
    }
    else
    {
        // End:0x80
        if((UserLevelData >= 21) && UserLevelData <= 40)
        {
            UserLevel = 20;            
        }
        else
        {
            // End:0xA5
            if((UserLevelData >= 41) && UserLevelData <= 60)
            {
                UserLevel = 40;                
            }
            else
            {
                // End:0xCA
                if((UserLevelData >= 61) && UserLevelData <= 74)
                {
                    UserLevel = 60;                    
                }
                else
                {
                    // End:0xEC
                    if((UserLevelData >= 75) && UserLevelData <= 80)
                    {
                        UserLevel = 80;
                    }
                }
            }
        }
    }
    // End:0x103
    if(UserLevelData < 40)
    {
        UserArrange = 101;        
    }
    else
    {
        UserArrange = 102;
    }
    RandomVal = Rand(99) + 1;
    // End:0x13B
    if((RandomVal >= 1) && RandomVal <= 50)
    {
        PrioritySelect = 1;        
    }
    else
    {
        // End:0x160
        if((RandomVal >= 51) && RandomVal <= 75)
        {
            PrioritySelect = 2;            
        }
        else
        {
            // End:0x185
            if((RandomVal >= 76) && RandomVal <= 90)
            {
                PrioritySelect = 3;                
            }
            else
            {
                // End:0x1A7
                if((RandomVal >= 91) && RandomVal <= 100)
                {
                    PrioritySelect = 4;
                }
            }
        }
    }
    i = 0;

    while(i < TipData.Length)
    {
        // End:0x279
        if(TipData[i].TipMsg != "")
        {
            // End:0x279
            if((TipData[i].Priority == PrioritySelect) && TipData[i].Validity == true)
            {
                // End:0x279
                if(((TipData[i].TargetLevel == UserLevel) || TipData[i].TargetLevel == 0) || TipData[i].TargetLevel == UserArrange)
                {
                    SelectedCondition[j] = TipData[i].TipMsg;
                    ++j;
                }
            }
        }
        ++i;
    }
    NumberSelect = Rand(SelectedCondition.Length);
    // End:0x2A8
    if(SelectedCondition.Length == 0)
    {
        CurrentTip = "";        
    }
    else
    {
        CurrentTip = SelectedCondition[NumberSelect];
    }
    // End:0x403
    if(GetOptionBool("Game", "ShowGameTipMsg") == false)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText1", GetSystemString(1455));
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText1-1", GetSystemString(1455));
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText1-2", GetSystemString(1455));
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText", CurrentTip);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText-1", CurrentTip);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText-2", CurrentTip);        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText1", "");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText1-1", "");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText1-2", "");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText", "");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText-1", "");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("GametipWnd.GameTipText-2", "");
    }
    return;
}
