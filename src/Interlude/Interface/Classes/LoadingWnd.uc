class LoadingWnd extends UIScript;

var string LoadingTexture15;
var string LoadingTexture18;
var string LoadingTextureFree;

function OnLoad()
{
    RegisterEvent(EV_ServerAgeLimitChange);
    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("LoadingWnd.BackTex", LoadingTextureFree);
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    local int ServerAgeLimitInt;
    local UIEventManager.EServerAgeLimit ServerAgeLimit;

    // End:0x138
    if(a_EventID == EV_ServerAgeLimitChange)
    {
        // End:0x138
        if(ParseInt(a_Param, "ServerAgeLimit", ServerAgeLimitInt))
        {
            ServerAgeLimit = EServerAgeLimit(ServerAgeLimitInt);
            switch(ServerAgeLimit)
            {
                // End:0x93
                case SERVER_AGE_LIMIT_15:
                    Debug("LoadingTexture15=" $ LoadingTexture15);
                    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("LoadingWnd.BackTex", LoadingTexture15);
                    // End:0x138
                    break;
                // End:0xE3
                case SERVER_AGE_LIMIT_18:
                    Debug("LoadingTexture18=" $ LoadingTexture18);
                    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("LoadingWnd.BackTex", LoadingTexture18);
                    // End:0x138
                    break;
                // End:0x10A
                case SERVER_AGE_LIMIT_Free:
                    Debug("LoadingTextureFree=" $ LoadingTextureFree);
                // End:0xFFFF
                default:
                    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("LoadingWnd.BackTex", LoadingTextureFree);
                    // End:0x138
                    break;
                    break;
            }
        }
    }
    return;
}

defaultproperties
{
    LoadingTexture15="L2Font.loading03-k"
    LoadingTexture18="L2Font.loading04-k"
    LoadingTextureFree="L2Font.loading02-k"
}
