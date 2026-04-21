class AutoShotItemWnd extends UICommonAPI;

const MAX_SHOTITEM = 4;

struct struct_1
{
    var int int_2;
    var int int_3;
    var int int_4;
    var ItemWindowHandle item_3;
    var TextBoxHandle text_1;
    var TextureHandle texture_1;
    var bool bool_5;
    var bool bool_6;
    var int Reserve;
};

var WindowHandle Me;
var struct_1 int_1[4];
var ItemWindowHandle item_1;
var ItemWindowHandle item_2;
var bool bool_1;
var bool bool_2;
var bool bool_3;
var bool bool_4;
var int m_user;
var StatusWnd StatusWnd;

function OnLoad()
{
    local int int_4;

    Me = GetHandle("AutoShotItemWnd");
    item_1 = ItemWindowHandle(GetHandle("InventoryWnd.InventoryItem"));
    item_2 = ItemWindowHandle(GetHandle("InventoryWnd.EquipItem_RHand"));
    OnRegisterEvent();
    int_4 = 0;
    J0x86:

    // End:0x189 [Loop If]
    if(int_4 < 4)
    {
        int_1[int_4].item_3 = ItemWindowHandle(GetHandle(("AutoShotItemWnd.ShotItem" $ string(int_4))));
        int_1[int_4].text_1 = TextBoxHandle(GetHandle(("AutoShotItemWnd.Counter" $ string(int_4))));
        int_1[int_4].texture_1 = TextureHandle(GetHandle(("AutoShotItemWnd.Toggle" $ string(int_4))));
        MessageBox(string(int_4));
        int_1[int_4].texture_1.HideWindow();
        int_4++;
        // [Loop Continue]
        goto J0x86;
    }
    function1();
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("AutoShotItemWnd.PetShotItemWnd");
    StatusWnd = StatusWnd(GetScript("StatusWnd"));
    m_user = StatusWnd.m_UserID;
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("AutoShotItemWnd");
    return;
}

function OnEnterState(name a_PreStateName)
{
    // End:0x42
    if((!Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_AutoSS")))
    {
        Me.ShowWindow();
        GetShotItemInfo();
    }
    return;
}

function OnDefaultPosition()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetAnchor("AutoShotItemWnd", "Menu", "TopRight", "TopRight", -402, -86);
    return;
}

function function2(string string_1)
{
    local int int_4;

    ParseInt(string_1, "Index", int_4);
    switch(int_4)
    {
        // End:0x23
        case 35:
        // End:0x2B
        case 2154:
        // End:0x30
        case 46:
        // End:0x38
        case 1066:
        // End:0x40
        case 1067:
        // End:0x48
        case 1068:
        // End:0x50
        case 1069:
        // End:0x58
        case 1405:
        // End:0x60
        case 1406:
        // End:0xD0
        case 110:
            // End:0x87
            if(int_1[1].bool_6)
            {
                RequestUseItem(int_1[1].int_2);
            }
            // End:0xCD
            if(int_1[0].bool_6)
            {
                RequestUseItem(int_1[0].int_2);
                RequestUseItem(int_1[1].int_2);
                RequestUseItem(int_1[1].int_2);
            }
            // End:0x17A
            break;
        // End:0x12F
        case 1026:
            // End:0x108
            if(bool_3)
            {
                // End:0x105
                if(int_1[3].bool_6)
                {
                    RequestUseItem(int_1[3].int_2);
                }
            }
            else
            {
                // End:0x12C
                if(int_1[2].bool_6)
                {
                    RequestUseItem(int_1[2].int_2);
                }
            }
            // End:0x17A
            break;
        // End:0x141
        case 338:
            function3(0);
            // End:0x17A
            break;
        // End:0x153
        case 531:
            function3(1);
            // End:0x17A
            break;
        // End:0x15B
        case 417:
        // End:0x177
        case 1064:
            Me.SetTimer(0, 1);
            // End:0x17A
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnTimer(int int_5)
{
    Me.KillTimer(int_5);
    switch(int_5)
    {
        // End:0x28
        case 0:
            GetShotItemInfo();
            // End:0x7E
            break;
        // End:0x51
        case 1:
            // End:0x4E
            if(int_1[1].bool_6)
            {
                RequestUseItem(int_1[1].int_2);
            }
            // End:0x7E
            break;
        // End:0x7B
        case 2:
            // End:0x78
            if(int_1[0].bool_6)
            {
                RequestUseItem(int_1[0].int_2);
            }
            // End:0x7E
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnEvent(int Event_ID, string string_1)
{
    // End:0x8C
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_AutoSS"))
    {
        switch(Event_ID)
        {
            // End:0x44
            case 580:
                function2(string_1);
                // End:0x8C
                break;
            // End:0x4C
            case 2600:
            // End:0x62
            case 2610:
                function4(string_1);
                // End:0x8C
                break;
            // End:0x73
            case 3030:
                function1();
                // End:0x8C
                break;
            // End:0x89
            case 290:
                CheckSpeed(string_1);
                // End:0x8C
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

function CheckSpeed(string param)
{
    local SkillInfo s_info;
    local int SkillID;
    local float f1;
    local int AttackerID;
    local UserInfo AttackerInfo, PlayerInfo;

    ParseInt(param, "AttackerID", AttackerID);
    ParseInt(param, "SkillID", SkillID);
    GetUserInfo(AttackerID, AttackerInfo);
    GetPlayerInfo(PlayerInfo);
    // End:0xC4
    if(PlayerInfo.nID == AttackerID)
    {
        // End:0xC4
        if(GetSkillInfo(SkillID, 1, s_info))
        {
            f1 = s_info.HitTime;
            // End:0xC4
            if(f1 > float(1))
            {
                Me.SetTimer(1, int(f1));
                Me.SetTimer(2, int(f1));
            }
        }
    }
    return;
}

function function4(optional string string_1, optional ItemInfo Info)
{
    local ItemInfo info_2;
    local int int_4;

    // End:0x23
    if((string_1 != ""))
    {
        function5(string_1, info_2);
    }
    else
    {
        info_2 = Info;
    }
    int_4 = 0;
    J0x35:

    // End:0x121 [Loop If]
    if(int_4 < 4)
    {
        // End:0x117
        if((info_2.ClassID == int_1[int_4].int_3))
        {
            // End:0x90
            if((int_1[int_4].int_2 == 0))
            {
                function12(int_4, info_2);
                return;
            }
            // End:0xC7
            if((info_2.ItemNum > 99))
            {
                int_1[int_4].text_1.SetText("99+");
                // [Explicit Continue]
                goto J0x117;
            }
            // End:0xE9
            if((info_2.ItemNum == 0))
            {
                ClearContainer(int_4);
                // [Explicit Continue]
                goto J0x117;
            }
            int_1[int_4].text_1.SetText(("" $ string(info_2.ItemNum)));
        }
        J0x117:

        int_4++;
        // [Loop Continue]
        goto J0x35;
    }
    return;
}

function function12(int int_6, ItemInfo info_2)
{
    // End:0x148
    if(((info_2.ClassID == int_1[int_6].int_3) || (info_2.ClassID == int_1[int_6].Reserve)))
    {
        int_1[int_6].item_3.Clear();
        int_1[int_6].item_3.AddItem(info_2);
        int_1[int_6].text_1.ShowWindow();
        int_1[int_6].int_2 = info_2.ServerID;
        int_1[int_6].int_3 = info_2.ClassID;
        function4("", info_2);
        // End:0xFE
        if(int_1[int_6].bool_5)
        {
            function6(int_6);
        }
        // End:0x148
        if(!bool_2)
        {
            // End:0x148
            if(((int_1[0].int_2 != 0) && (int_1[1].int_2 != 0)))
            {
                bool_2 = true;
                OnClickButton("");
            }
        }
    }
    return;
}

function OnClickButton(string strID)
{
    local int int_4;

    int_4 = 0;
    J0x07:

    // End:0x9E [Loop If]
    if(int_4 < 4)
    {
        // End:0x3D
        if(bool_1)
        {
            function3(int_4);
            int_1[int_4].bool_5 = false;
            // [Explicit Continue]
            goto J0x94;
        }
        // End:0x94
        if(int_1[int_4].int_2 != 0)
        {
            function6(int_4);
            int_1[int_4].bool_5 = true;
            Me.SetTimer(1, 1);
            Me.SetTimer(2, 1);
        }
        J0x94:

        int_4++;
        // [Loop Continue]
        goto J0x07;
    }
    // End:0xB4
    if(!bool_1)
    {
        bool_1 = true;
    }
    else
    {
        bool_1 = false;
    }
    return;
}

function GetShotItemInfo(optional int int_5)
{
    local ItemInfo Info;
    local int int_6, int_4, temp;

    // End:0x2F
    if((!Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_AutoSS")))
    {
        return;
    }
    int_1[2].int_3 = 6645;
    int_1[3].int_3 = 6647;
    int_1[3].Reserve = 6646;
    // End:0x32F
    if((item_2.GetItem(int_4, Info) || (int_5 != 0)))
    {
        // End:0xB9
        if((int_5 != 0))
        {
            temp = int_5;
            int_5--;
        }
        else
        {
            temp = Info.CrystalType;
        }
        switch(temp)
        {
            // End:0x10D
            case 0:
                int_1[0].int_3 = 1835;
                int_1[1].int_3 = 3947;
                int_1[1].Reserve = 2509;
                // End:0x245
                break;
            // End:0x14A
            case 1:
                int_1[0].int_3 = 1463;
                int_1[1].int_3 = 3948;
                int_1[1].Reserve = 2510;
                // End:0x245
                break;
            // End:0x188
            case 2:
                int_1[0].int_3 = 1464;
                int_1[1].int_3 = 3949;
                int_1[1].Reserve = 2511;
                // End:0x245
                break;
            // End:0x1C6
            case 3:
                int_1[0].int_3 = 1465;
                int_1[1].int_3 = 3950;
                int_1[1].Reserve = 2512;
                // End:0x245
                break;
            // End:0x204
            case 4:
                int_1[0].int_3 = 1466;
                int_1[1].int_3 = 3951;
                int_1[1].Reserve = 2513;
                // End:0x245
                break;
            // End:0x242
            case 5:
                int_1[0].int_3 = 1467;
                int_1[1].int_3 = 3952;
                int_1[1].Reserve = 2514;
                // End:0x245
                break;
            // End:0xFFFF
            default:
                break;
        }
        int_4 = 0;
        J0x24C:

        // End:0x32C [Loop If]
        if(int_4 < 4)
        {
            ClearContainer(int_4);
            int_6 = item_1.FindItemWithClassID(int_1[int_4].int_3);
            // End:0x2B7
            if(item_1.GetItem(int_6, Info))
            {
                function12(int_4, Info);
                // [Explicit Continue]
                goto J0x322;
            }
            // End:0x322
            if((int_1[int_4].Reserve != 0))
            {
                int_6 = item_1.FindItemWithClassID(int_1[int_4].Reserve);
                // End:0x322
                if(item_1.GetItem(int_6, Info))
                {
                    function12(int_4, Info);
                }
            }
            J0x322:

            int_4++;
            // [Loop Continue]
            goto J0x24C;
        }
    }
    else
    {
        ClearContainer(0);
        ClearContainer(1);
    }
    return;
}

function function7()
{
    local int int_4;

    int_4 = 0;
    J0x07:

    // End:0x28 [Loop If]
    if(int_4 < 4)
    {
        ClearContainer(int_4);
        int_4++;
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function OnClickItem(string string_5, int int_6)
{
    local int int_5;

    int_5 = int(Right(string_5, 1));
    RequestUseItem(int_1[int_5].int_2);
    return;
}

function OnRClickItem(string string_5, int int_6)
{
    function8(string_5);
    return;
}

function function8(string string_5)
{
    local int int_5;

    int_5 = int(Right(string_5, 1));
    // End:0x4B
    if(!int_1[int_5].bool_6)
    {
        function6(int_5);
        int_1[int_5].bool_5 = true;
    }
    else
    {
        function3(int_5);
        int_1[int_5].bool_5 = false;
    }
    return;
}

function function6(int int_4)
{
    int_1[int_4].texture_1.ShowWindow();
    int_1[int_4].bool_6 = true;
    RequestUseItem(int_1[int_4].int_2);
    switch(int_4)
    {
        // End:0x62
        case 0:
            Me.SetTimer(1, 1);
            // End:0x7E
            break;
        // End:0x7B
        case 1:
            Me.SetTimer(2, 1);
            // End:0x7E
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function function3(int int_4)
{
    int_1[int_4].texture_1.HideWindow();
    int_1[int_4].bool_6 = false;
    return;
}

function ClearContainer(int int_4)
{
    function3(int_4);
    int_1[int_4].text_1.SetText("");
    int_1[int_4].item_3.Clear();
    int_1[int_4].int_2 = 0;
    return;
}

function OnDropItem(string string_5, ItemInfo Info, int X, int Y)
{
    local int int_5;

    int_5 = int(Right(string_5, 1));
    // End:0x6D
    if(((Info.ClassID == int_1[int_5].int_3) || (Info.ClassID == int_1[int_5].Reserve)))
    {
        function12(int_5, Info);
    }
    return;
}

function OnRegisterEvent()
{
    RegisterEvent(2600);
    RegisterEvent(2610);
    RegisterEvent(580);
    RegisterEvent(290);
    RegisterEvent(280);
    RegisterEvent(3030);
    return;
}

function function1()
{
    function11((Me.GetWindowName() $ ".BtnOn"), 1, 1);
    return;
}
