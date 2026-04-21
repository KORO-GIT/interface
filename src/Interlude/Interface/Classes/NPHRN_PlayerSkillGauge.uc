class NPHRN_PlayerSkillGauge extends UICommonAPI;

var int m_UserID;
var StatusWnd dlgBox;
var WindowHandle Me;
var TextureHandle texHandle1;
var TextBoxHandle TextBoxHandle;
var float f;
var bool idx;

function OnLoad()
{
    unkFunc4();
    OnRegisterEvent();
    return;
}

function unkFunc4()
{
    Me = GetHandle("NPHRN_PlayerSkillGauge");
    texHandle1 = TextureHandle(GetHandle("NPHRN_PlayerSkillGauge.Slider.Substrate"));
    TextBoxHandle = TextBoxHandle(GetHandle("NPHRN_PlayerSkillGauge.Slider.Title"));
    dlgBox = StatusWnd(GetScript("StatusWnd"));
    return;
}

function OnRegisterEvent()
{
    RegisterEvent(150);
    RegisterEvent(290);
    RegisterEvent(50);
    RegisterEvent(2960);
    RegisterEvent(580);
    return;
}

function OnEvent(int EventID, string idx)
{
    local int Lm_UserID1, Lm_UserID2;

    switch(EventID)
    {
        // End:0x24
        case 150:
            Me.SetTimer(1, 1000);
            // End:0xE5
            break;
        // End:0x92
        case 290:
            // End:0x8F
            if(UnknownFunction242(GetOptionBool("Custom", "SkillCastingBox"), true))
            {
                ParseInt(idx, "AttackerID", Lm_UserID1);
                // End:0x8F
                if(UnknownFunction154(Lm_UserID1, m_UserID))
                {
                    sdfhserheawrhawh(idx);
                }
            }
            // End:0xE5
            break;
        // End:0xC3
        case 580:
            ParseInt(idx, "Index", Lm_UserID2);
            // End:0xC3
            if(UnknownFunction155(Lm_UserID2, 27))
            {
                return;
            }
        // End:0xCB
        case 2960:
        // End:0xE2
        case 50:
            Me.HideWindow();
            // End:0xE5
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function sdfhserheawrhawh(string strParam)
{
    local int f_IntINC;
    local SkillInfo SkillInfo;
    local UserInfo UserInfo;
    local float f1, f2;

    ParseInt(strParam, "SkillID", f_IntINC);
    // End:0x4E
    if(UnknownFunction132(idx, unkIDSFunc(f_IntINC)))
    {
        // End:0x4C
        if(unkSkillFunc3(f_IntINC))
        {
            f = 0.1000000;
        }
        return;
    }
    // End:0x1B5
    if(GetSkillInfo(f_IntINC, 1, SkillInfo))
    {
        idx = true;
        Me.ShowWindow();
        TextBoxHandle.SetText(SkillInfo.SkillName);
        // End:0x10C
        if(GetPlayerInfo(UserInfo))
        {
            // End:0xE4
            if(UnknownFunction154(SkillInfo.IsMagic, 1))
            {
                f2 = UnknownFunction172(float(UserInfo.nMagicCastingSpeed), 1000.0000000);
                UnknownFunction184(f2, f);                
            }
            else
            {
                f2 = UnknownFunction172(float(UserInfo.nPhysicalAttackSpeed), 1000.0000000);
            }
            f = 0.0000000;
        }
        f1 = UnknownFunction175(SkillInfo.HitTime, UnknownFunction171(f2, UnknownFunction172(SkillInfo.HitTime, 1.5000000)));
        // End:0x170
        if(UnknownFunction176(f1, 0.5000000))
        {
            f1 = UnknownFunction172(SkillInfo.HitTime, 6.0000000);
        }
        texHandle1.Move(205, 0, f1);
        Me.SetTimer(2, UnknownFunction146(int(UnknownFunction171(f1, 1000.0000000)), 300));
    }
    return;
}

function OnTimer(int TimerID)
{
    switch(TimerID)
    {
        // End:0x26
        case 2:
            Me.KillTimer(2);
            asdfhashawsh();
            // End:0x54
            break;
        // End:0x51
        case 1:
            Me.KillTimer(1);
            m_UserID = dlgBox.m_UserID;
            // End:0x54
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function asdfhashawsh()
{
    local Rect Rect;

    Rect = Me.GetRect();
    texHandle1.MoveTo(UnknownFunction147(Rect.nX, 24), Rect.nY);
    Me.HideWindow();
    idx = false;
    return;
}

function bool unkIDSFunc(int f_IntINC)
{
    local bool locBool1;

    locBool1 = false;
    switch(f_IntINC)
    {
        // End:0x17
        case 2039:
        // End:0x1F
        case 2150:
        // End:0x27
        case 2151:
        // End:0x2F
        case 2152:
        // End:0x37
        case 2153:
        // End:0x3F
        case 2154:
        // End:0x47
        case 2047:
        // End:0x4F
        case 2155:
        // End:0x57
        case 2156:
        // End:0x5F
        case 2157:
        // End:0x67
        case 2158:
        // End:0x6F
        case 2159:
        // End:0x77
        case 2061:
        // End:0x7F
        case 2160:
        // End:0x87
        case 2161:
        // End:0x8F
        case 2162:
        // End:0x97
        case 2163:
        // End:0x9F
        case 2164:
        // End:0xA7
        case 26060:
        // End:0xAF
        case 26061:
        // End:0xB7
        case 26062:
        // End:0xBF
        case 26063:
        // End:0xC7
        case 26064:
        // End:0xCF
        case 22036:
        // End:0xD7
        case 22037:
        // End:0xDF
        case 22038:
        // End:0xE7
        case 2033:
        // End:0xEF
        case 2008:
        // End:0xF7
        case 2009:
        // End:0xFF
        case 26050:
        // End:0x107
        case 26051:
        // End:0x10F
        case 26052:
        // End:0x117
        case 26053:
        // End:0x11F
        case 26054:
        // End:0x127
        case 26055:
        // End:0x12F
        case 26056:
        // End:0x137
        case 26057:
        // End:0x13F
        case 26058:
        // End:0x147
        case 26059:
        // End:0x14F
        case 22369:
        // End:0x157
        case 2498:
        // End:0x15F
        case 2499:
        // End:0x167
        case 2359:
        // End:0x16F
        case 2166:
        // End:0x177
        case 2034:
        // End:0x17F
        case 2037:
        // End:0x187
        case 2035:
        // End:0x18F
        case 2036:
        // End:0x197
        case 2011:
        // End:0x19F
        case 2032:
        // End:0x1A7
        case 2864:
        // End:0x1AF
        case 2398:
        // End:0x1B7
        case 2402:
        // End:0x1BF
        case 2403:
        // End:0x1C7
        case 2395:
        // End:0x1CF
        case 2401:
        // End:0x1D7
        case 2169:
        // End:0x1DF
        case 2397:
        // End:0x1E7
        case 2396:
        // End:0x1EF
        case 2012:
        // End:0x1F7
        case 2074:
        // End:0x1FF
        case 2077:
        // End:0x207
        case 2592:
        // End:0x20F
        case 2038:
        // End:0x217
        case 2627:
        // End:0x21F
        case 2289:
        // End:0x227
        case 2287:
        // End:0x22F
        case 2288:
        // End:0x237
        case 2169:
        // End:0x23F
        case 2076:
        // End:0x247
        case 22042:
        // End:0x24F
        case 2903:
        // End:0x257
        case 2901:
        // End:0x25F
        case 2900:
        // End:0x267
        case 2902:
        // End:0x26F
        case 2897:
        // End:0x277
        case 22029:
        // End:0x27F
        case 2899:
        // End:0x287
        case 22031:
        // End:0x28F
        case 22164:
        // End:0x297
        case 2898:
        // End:0x29F
        case 22030:
        // End:0x2A7
        case 22163:
        // End:0x2AF
        case 22162:
        // End:0x2B7
        case 22158:
        // End:0x2BF
        case 2282:
        // End:0x2C7
        case 2283:
        // End:0x2CF
        case 2284:
        // End:0x2D7
        case 2514:
        // End:0x2DF
        case 2513:
        // End:0x2E7
        case 2244:
        // End:0x2EF
        case 2278:
        // End:0x2F7
        case 2485:
        // End:0x2FF
        case 2247:
        // End:0x307
        case 2281:
        // End:0x30F
        case 2486:
        // End:0x317
        case 2245:
        // End:0x31F
        case 2279:
        // End:0x327
        case 2246:
        // End:0x32F
        case 2280:
        // End:0x337
        case 2285:
        // End:0x33F
        case 2512:
        // End:0x352
        case 2580:
            locBool1 = true;
            // End:0x355
            break;
        // End:0xFFFF
        default:
            break;
    }
    return locBool1;
}

function bool unkSkillFunc3(int f_IntINC)
{
    local bool locBool1;

    locBool1 = false;
    switch(f_IntINC)
    {
        // End:0x17
        case 2039:
        // End:0x1F
        case 2150:
        // End:0x27
        case 2151:
        // End:0x2F
        case 2152:
        // End:0x37
        case 2153:
        // End:0x3F
        case 2154:
        // End:0x47
        case 2047:
        // End:0x4F
        case 2155:
        // End:0x57
        case 2156:
        // End:0x5F
        case 2157:
        // End:0x67
        case 2158:
        // End:0x6F
        case 2159:
        // End:0x77
        case 2061:
        // End:0x7F
        case 2160:
        // End:0x87
        case 2161:
        // End:0x8F
        case 2162:
        // End:0x97
        case 2163:
        // End:0x9F
        case 2164:
        // End:0xA7
        case 26060:
        // End:0xAF
        case 26061:
        // End:0xB7
        case 26062:
        // End:0xBF
        case 26063:
        // End:0xC7
        case 26064:
        // End:0xCF
        case 26050:
        // End:0xD7
        case 26051:
        // End:0xDF
        case 26052:
        // End:0xE7
        case 26053:
        // End:0xEF
        case 26054:
        // End:0xF7
        case 26055:
        // End:0xFF
        case 26056:
        // End:0x107
        case 26057:
        // End:0x10F
        case 26058:
        // End:0x117
        case 26059:
        // End:0x12A
        case 22369:
            locBool1 = true;
            // End:0x12D
            break;
        // End:0xFFFF
        default:
            break;
    }
    return locBool1;
}
