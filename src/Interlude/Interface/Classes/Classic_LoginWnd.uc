class Classic_LoginWnd extends UICommonAPI;

var TextureHandle Theme;

function OnLoad()
{
    RegisterEvent(2900);
    HandleResolutionChanged();
    return;
}

function OnShow()
{
    HandleResolutionChanged();
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x18
        case 2900:
            HandleResolutionChanged();
            // End:0x1B
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function HandleResolutionChanged()
{
    local int ScreenWidth, ScreenHeight;

    Theme = TextureHandle(GetHandle("Classic_LoginWnd.Theme"));
    GetCurrentResolution(ScreenWidth, ScreenHeight);
    Theme.SetTextureSize(ScreenWidth, ScreenHeight);
    // End:0x83
    if(ScreenHeight > 1024)
    {
        Theme.SetTexture("Was.Theme_1080");        
    }
    else
    {
        // End:0xC5
        if((ScreenHeight > 960) && ScreenWidth < 1820)
        {
            Theme.SetTexture("Was.Theme_1024");            
        }
        else
        {
            // End:0x106
            if((ScreenHeight > 900) && ScreenWidth < 1707)
            {
                Theme.SetTexture("Was.Theme_960");                
            }
            else
            {
                // End:0x147
                if((ScreenHeight > 864) && ScreenWidth < 1600)
                {
                    Theme.SetTexture("Was.Theme_900");                    
                }
                else
                {
                    // End:0x188
                    if((ScreenHeight > 800) && ScreenWidth < 1536)
                    {
                        Theme.SetTexture("Was.Theme_864");                        
                    }
                    else
                    {
                        // End:0x1C9
                        if((ScreenHeight > 768) && ScreenWidth < 1422)
                        {
                            Theme.SetTexture("Was.Theme_800");                            
                        }
                        else
                        {
                            // End:0x20A
                            if((ScreenHeight > 720) && ScreenWidth < 1366)
                            {
                                Theme.SetTexture("Was.Theme_768");                                
                            }
                            else
                            {
                                // End:0x24B
                                if((ScreenHeight > 600) && ScreenWidth < 1280)
                                {
                                    Theme.SetTexture("Was.Theme_720");                                    
                                }
                                else
                                {
                                    // End:0x28C
                                    if((ScreenHeight < 600) && ScreenWidth < 1067)
                                    {
                                        Theme.SetTexture("Was.Theme_600");                                        
                                    }
                                    else
                                    {
                                        Theme.SetTexture("Was.Theme_1080");
                                    }
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
