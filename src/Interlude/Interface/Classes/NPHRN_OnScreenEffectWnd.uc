class NPHRN_OnScreenEffectWnd extends UICommonAPI;

var WindowHandle Me;
var bool onceAppeared;
var TextureHandle Tex;

function OnLoad()
{
    RegisterEvent(190);
    Me = GetHandle("NPHRN_OnScreenEffectWnd");
    return;
}

function OnEvent(int Event_ID, string a_Param)
{
    switch(Event_ID)
    {
        // End:0x12
        case 190:
            ShowRedOverlay();
        // End:0xFFFF
        default:
            return;
            break;
    }
}

function ShowRedOverlay()
{
    local UserInfo Player;
    local float fPercent;
    local int hpPercent, Width, Height;
    local TextureHandle Tex;

    GetPlayerInfo(Player);
    Tex = TextureHandle(GetHandle("NPHRN_OnScreenEffectWnd.Tex"));
    fPercent = UnknownFunction171(UnknownFunction172(float(Player.nCurHP), float(Player.nMaxHP)), 100.0000000);
    hpPercent = int(fPercent);
    // End:0x13D
    if(UnknownFunction130(UnknownFunction152(hpPercent, 20), UnknownFunction129(onceAppeared)))
    {
        GetCurrentResolution(Width, Height);
        Me.SetWindowSize(Width, Height);
        Tex.SetTexture("Was.Scr_RedVignette");
        Me.ShowWindow();
        Me.SetAlpha(0, 1.0000000);
        Me.SetTimer(0, 1000);
        PlaySound("interface.Splash");
        onceAppeared = true;
    }
    // End:0x155
    if(UnknownFunction151(hpPercent, 20))
    {
        onceAppeared = false;
    }
    return;
}

function OnTimer(int TimerID)
{
    switch(TimerID)
    {
        // End:0x53
        case 0:
            Me.KillTimer(0);
            Me.SetAlpha(255);
            Me.HideWindow();
            Me.SetTimer(1, 1000);
            // End:0x75
            break;
        // End:0x72
        case 1:
            Me.KillTimer(1);
            onceAppeared = false;
            // End:0x75
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}
