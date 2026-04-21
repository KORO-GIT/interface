class OptionWnd extends UICommonAPI;

var int nPixelShaderVersion;
var int nVertexShaderVersion;
var float gSoundVolume;
var float gMusicVolume;
var float gWavVoiceVolume;
var float gOggVoiceVolume;
var array<ResolutionInfo> ResolutionList;
var array<int> RefreshRateList;
var bool bShow;
var int m_iPrevSoundTick;
var int m_iPrevMusicTick;
var int m_iPrevSystemTick;
var int m_iPrevTutorialTick;
var bool m_bPartyMatchRoomState;
var AutoShotItemWnd AutoShotItemWnd;
var CheckBoxHandle Cb_AutoSS;

function ResetRefreshRate(optional int a_nWidth, optional int a_nHeight)
{
    local int i;

    GetRefreshRateList(RefreshRateList, a_nWidth, a_nHeight);
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("OptionWnd.RefreshRateBox");
    i = 0;
    J0x45:

    // End:0xC7 [Loop If]
    if(i < RefreshRateList.Length)
    {
        Debug("RefreshRateList[ i ] " $ string(RefreshRateList[i]));
        Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.RefreshRateBox", string(RefreshRateList[i]) $ "Hz");
        ++i;
        // [Loop Continue]
        goto J0x45;
    }
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.RefreshRateBox", i - 1);
    return;
}

function OnLoad()
{
    local int i, nMultiSample;
    local bool bEnableEngSelection;
    local UIEventManager.ELanguageType Language;
    local string strResolution;

    RegisterEvent(510);
    RegisterEvent(520);
    RegisterEvent(1550);
    RegisterEvent(1560);
    RegisterEvent(150);
    RegisterState("OptionWnd", "GamingState");
    RegisterState("OptionWnd", "LoginState");
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("OptionWnd.MinimapCB");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.MinimapCB", "None");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.MinimapCB", "Retail");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.MinimapCB", "Old");
    Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.MinimapCB", "New");
    GetShaderVersion(nPixelShaderVersion, nVertexShaderVersion);
    GetResolutionList(ResolutionList);
    SetOptionBool("Game", "HideDropItem", false);
    i = 0;
    J0x178:

    // End:0x20D [Loop If]
    if(i < ResolutionList.Length)
    {
        strResolution = ((((("" $ string(ResolutionList[i].nWidth)) $ "*") $ string(ResolutionList[i].nHeight)) $ " ") $ string(ResolutionList[i].nColorBit)) $ "bit";
        Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.ResBox", strResolution);
        ++i;
        // [Loop Continue]
        goto J0x178;
    }
    ResetRefreshRate();
    nMultiSample = GetMultiSample();
    // End:0x272
    if(0 == nMultiSample)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SYS_AddString("OptionWnd.AABox", 869);
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.AABox");        
    }
    else
    {
        // End:0x2EA
        if(1 == nMultiSample)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.SYS_AddString("OptionWnd.AABox", 869);
            Class'NWindow.UIAPI_COMBOBOX'.static.SYS_AddString("OptionWnd.AABox", 870);
            Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.AABox");            
        }
        else
        {
            // End:0x385
            if(2 == nMultiSample)
            {
                Class'NWindow.UIAPI_COMBOBOX'.static.SYS_AddString("OptionWnd.AABox", 869);
                Class'NWindow.UIAPI_COMBOBOX'.static.SYS_AddString("OptionWnd.AABox", 870);
                Class'NWindow.UIAPI_COMBOBOX'.static.SYS_AddString("OptionWnd.AABox", 871);
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.AABox");
            }
        }
    }
    bEnableEngSelection = IsEnableEngSelection();
    Language = GetLanguage();
    switch(Language)
    {
        // End:0x3AD
        case LANG_None:
            // End:0x7DA
            break;
        // End:0x46A
        case LANG_Korean:
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "Korean");
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "English");
            // End:0x441
            if(bEnableEngSelection)
            {
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.LanguageBox");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.LanguageBox");
            }
            // End:0x7DA
            break;
        // End:0x4A1
        case LANG_English:
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "English");
            // End:0x7DA
            break;
        // End:0x560
        case LANG_Japanese:
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "Russian ");
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "English");
            // End:0x537
            if(bEnableEngSelection)
            {
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.LanguageBox");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.LanguageBox");
            }
            // End:0x7DA
            break;
        // End:0x626
        case LANG_Taiwan:
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "Chinese(Taiwan)");
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "English");
            // End:0x5FD
            if(bEnableEngSelection)
            {
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.LanguageBox");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.LanguageBox");
            }
            // End:0x7DA
            break;
        // End:0x6E2
        case LANG_Chinese:
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "China");
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "English");
            // End:0x6B9
            if(bEnableEngSelection)
            {
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.LanguageBox");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.LanguageBox");
            }
            // End:0x7DA
            break;
        // End:0x79D
        case LANG_Thai:
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "Thai");
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "English");
            // End:0x774
            if(bEnableEngSelection)
            {
                Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.LanguageBox");                
            }
            else
            {
                Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.LanguageBox");
            }
            // End:0x7DA
            break;
        // End:0x7D4
        case LANG_Philippine:
            Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.LanguageBox", "English");
            // End:0x7DA
            break;
        // End:0xFFFF
        default:
            // End:0x7DA
            break;
            break;
    }
    // End:0x855
    if(CanUseHDR())
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SYS_AddString("OptionWnd.HDRBox", 1230);
        Class'NWindow.UIAPI_COMBOBOX'.static.SYS_AddString("OptionWnd.HDRBox", 1231);
        Class'NWindow.UIAPI_COMBOBOX'.static.SYS_AddString("OptionWnd.HDRBox", 1232);
    }
    InitVideoOption();
    InitAudioOption();
    InitGameOption();
    InitInterfaceOption();
    bShow = false;
    Cb_AutoSS = CheckBoxHandle(GetHandle("OptionWnd.Cb_AutoSS"));
    AutoShotItemWnd = AutoShotItemWnd(GetScript("AutoShotItemWnd"));
    Cb_AutoSS.SetTitle(" Show Auto SoulShot/SpiritShot");
    Cb_AutoSS.SetTooltipCustomType(MakeTooltipSimpleText("Open Auto SoulShot/SpiritShot Window"));
    return;
}

function RefreshLootingBox()
{
    // End:0x3F
    if(((GetPartyMemberCount()) > 0) || m_bPartyMatchRoomState)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.LootingBox");        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.LootingBox");
    }
    return;
}

function InitVideoOption()
{
    local int i, nResolutionIndex;
    local float fGamma;
    local bool bRenderDeco;
    local int nPostProcessType;
    local bool bShadow;
    local int nTextureDetail, nModelDetail, nSkipAnim;
    local bool bWaterEffect;
    local int nWaterEffectType, nRenderActorLimit, nMultiSample, nOption;
    local bool bOption;

    nResolutionIndex = GetResolutionIndex();
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.ResBox", nResolutionIndex);
    GetRefreshRateList(RefreshRateList);
    Class'NWindow.UIAPI_COMBOBOX'.static.Clear("OptionWnd.RefreshRateBox");
    i = 0;
    J0x6D:

    // End:0xC3 [Loop If]
    if(i < RefreshRateList.Length)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.AddString("OptionWnd.RefreshRateBox", string(RefreshRateList[i]) $ "Hz");
        ++i;
        // [Loop Continue]
        goto J0x6D;
    }
    nOption = GetOptionInt("Video", "RefreshRate");
    i = 0;
    J0xEA:

    // End:0x181 [Loop If]
    if(i < RefreshRateList.Length)
    {
        Debug((("RefreshRateList[ " $ string(i)) $ " ] = ") $ string(RefreshRateList[i]));
        // End:0x177
        if(RefreshRateList[i] == nOption)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.RefreshRateBox", i);
        }
        ++i;
        // [Loop Continue]
        goto J0xEA;
    }
    fGamma = GetOptionFloat("Video", "Gamma");
    // End:0x1D1
    if(1.2000000 <= fGamma)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.GammaBox", 0);        
    }
    else
    {
        // End:0x218
        if((1.0000000 <= fGamma) && fGamma < 1.2000000)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.GammaBox", 1);            
        }
        else
        {
            // End:0x260
            if((0.8000000 <= fGamma) && fGamma < 1.0000000)
            {
                Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.GammaBox", 2);                
            }
            else
            {
                // End:0x2A8
                if((0.6000000 <= fGamma) && fGamma < 0.8000000)
                {
                    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.GammaBox", 3);                    
                }
                else
                {
                    // End:0x2DC
                    if(fGamma < 0.6000000)
                    {
                        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.GammaBox", 4);
                    }
                }
            }
        }
    }
    nOption = GetOptionInt("Video", "PawnClippingRange");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.CharBox", nOption);
    nOption = GetOptionInt("Video", "TerrainClippingRange");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.TerrainBox", nOption);
    bRenderDeco = GetOptionBool("Video", "RenderDeco");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.DecoBox", bRenderDeco);
    nPostProcessType = GetOptionInt("Video", "PostProc");
    // End:0x423
    if((0 <= nPostProcessType) && nPostProcessType <= 5)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.HDRBox", nPostProcessType);        
    }
    else
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.HDRBox", 0);
    }
    bShadow = GetOptionBool("Video", "PawnShadow");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.ShadowBox", bShadow);
    nTextureDetail = GetOptionInt("Video", "TextureDetail");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.TextureBox", Max(0, Min(2, nTextureDetail)));
    nModelDetail = GetOptionInt("Video", "ModelDetail");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.ModelBox", nModelDetail);
    nSkipAnim = GetOptionInt("Video", "SkipAnim");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.AnimBox", nSkipAnim);
    // End:0x5C8
    if(nPixelShaderVersion < 12)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.ReflectBox");
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.ReflectBox", 0);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.ReflectBox");
        bWaterEffect = GetOptionBool("L2WaterEffect", "IsUseEffect");
        nWaterEffectType = GetOptionInt("L2WaterEffect", "EffectType");
        // End:0x671
        if(!bWaterEffect)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.ReflectBox", 0);            
        }
        else
        {
            // End:0x6A5
            if(nWaterEffectType == 1)
            {
                Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.ReflectBox", 1);                
            }
            else
            {
                // End:0x6DB
                if(nWaterEffectType == 2)
                {
                    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.ReflectBox", 2);                    
                }
                else
                {
                    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.ReflectBox", 0);
                }
            }
        }
    }
    bOption = GetOptionBool("Video", "UseTrilinear");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.TriBox", bOption);
    nRenderActorLimit = GetOptionInt("Video", "RenderActorLimited");
    // End:0x7A3
    if(nRenderActorLimit >= 6)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.PawnBox", 0);        
    }
    else
    {
        // End:0x7D5
        if(nRenderActorLimit == 5)
        {
            Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.PawnBox", 1);            
        }
        else
        {
            // End:0x808
            if(nRenderActorLimit == 4)
            {
                Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.PawnBox", 2);                
            }
            else
            {
                // End:0x83B
                if(nRenderActorLimit == 3)
                {
                    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.PawnBox", 3);                    
                }
                else
                {
                    // End:0x86E
                    if(nRenderActorLimit == 2)
                    {
                        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.PawnBox", 4);                        
                    }
                    else
                    {
                        // End:0x89D
                        if(nRenderActorLimit <= 1)
                        {
                            Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.PawnBox", 5);
                        }
                    }
                }
            }
        }
    }
    nMultiSample = GetMultiSample();
    // End:0x93B
    if((nMultiSample > 0) && !(3 <= nPostProcessType) && nPostProcessType <= 5)
    {
        nOption = GetOptionInt("Video", "AntiAliasing");
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.AABox", nOption);
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.AABox");        
    }
    else
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.AABox", 0);
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.AABox");
    }
    bOption = GetOptionBool("Video", "IsKeepMinFrameRate");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.FrameBox", bOption);
    // End:0x9DF
    if(bOption)
    {
        MinFrameRateOn();        
    }
    else
    {
        MinFrameRateOff();
    }
    nOption = GetOptionInt("Game", "ScreenShotQuality");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.CaptureBox", nOption);
    nOption = GetOptionInt("Video", "WeatherEffect");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.WeatherEffectComboBox", nOption);
    bOption = GetOptionBool("Video", "GPUAnimation");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.GPUAnimationCheckBox", bOption);
    // End:0xB4D
    if(nVertexShaderVersion < 20)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.GPUAnimationCheckBox");
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.GPUAnimationCheckBox", false);
    }
    return;
}

function InitAudioOption()
{
    local float fSoundVolume, fMusicVolume, fWavVoiceVolume, fOggVoiceVolume;
    local int iSoundVolume, iMusicVolume, iSystemVolume, iTutorialVolume;

    // End:0x4B
    if(GetOptionBool("Audio", "AudioMuteOn") == true)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.mutecheckbox", true);        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.mutecheckbox", false);
    }
    // End:0x5E6
    if(CanUseAudio())
    {
        fSoundVolume = GetOptionFloat("Audio", "SoundVolume");
        gSoundVolume = fSoundVolume;
        // End:0xD1
        if((0.0000000 <= fSoundVolume) && fSoundVolume < 0.2000000)
        {
            iSoundVolume = 0;            
        }
        else
        {
            // End:0xFB
            if((0.2000000 <= fSoundVolume) && fSoundVolume < 0.4000000)
            {
                iSoundVolume = 1;                
            }
            else
            {
                // End:0x126
                if((0.4000000 <= fSoundVolume) && fSoundVolume < 0.6000000)
                {
                    iSoundVolume = 2;                    
                }
                else
                {
                    // End:0x151
                    if((0.6000000 <= fSoundVolume) && fSoundVolume < 0.8000000)
                    {
                        iSoundVolume = 3;                        
                    }
                    else
                    {
                        // End:0x17C
                        if((0.8000000 <= fSoundVolume) && fSoundVolume < 1.0000000)
                        {
                            iSoundVolume = 4;                            
                        }
                        else
                        {
                            // End:0x193
                            if(1.0000000 <= fSoundVolume)
                            {
                                iSoundVolume = 5;
                            }
                        }
                    }
                }
            }
        }
        Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("OptionWnd.EffectVolumeSliderCtrl", iSoundVolume);
        fMusicVolume = GetOptionFloat("Audio", "MusicVolume");
        gMusicVolume = fMusicVolume;
        // End:0x21E
        if((0.0000000 <= fMusicVolume) && fMusicVolume < 0.2000000)
        {
            iMusicVolume = 0;            
        }
        else
        {
            // End:0x248
            if((0.2000000 <= fMusicVolume) && fMusicVolume < 0.4000000)
            {
                iMusicVolume = 1;                
            }
            else
            {
                // End:0x273
                if((0.4000000 <= fMusicVolume) && fMusicVolume < 0.6000000)
                {
                    iMusicVolume = 2;                    
                }
                else
                {
                    // End:0x29E
                    if((0.6000000 <= fMusicVolume) && fMusicVolume < 0.8000000)
                    {
                        iMusicVolume = 3;                        
                    }
                    else
                    {
                        // End:0x2C9
                        if((0.8000000 <= fMusicVolume) && fMusicVolume < 1.0000000)
                        {
                            iMusicVolume = 4;                            
                        }
                        else
                        {
                            // End:0x2E0
                            if(1.0000000 <= fMusicVolume)
                            {
                                iMusicVolume = 5;
                            }
                        }
                    }
                }
            }
        }
        Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("OptionWnd.MusicVolumeSliderCtrl", iMusicVolume);
        fWavVoiceVolume = GetOptionFloat("Audio", "WavVoiceVolume");
        gWavVoiceVolume = fWavVoiceVolume;
        // End:0x36D
        if((0.0000000 <= fWavVoiceVolume) && fWavVoiceVolume < 0.2000000)
        {
            iSystemVolume = 0;            
        }
        else
        {
            // End:0x397
            if((0.2000000 <= fWavVoiceVolume) && fWavVoiceVolume < 0.4000000)
            {
                iSystemVolume = 1;                
            }
            else
            {
                // End:0x3C2
                if((0.4000000 <= fWavVoiceVolume) && fWavVoiceVolume < 0.6000000)
                {
                    iSystemVolume = 2;                    
                }
                else
                {
                    // End:0x3ED
                    if((0.6000000 <= fWavVoiceVolume) && fWavVoiceVolume < 0.8000000)
                    {
                        iSystemVolume = 3;                        
                    }
                    else
                    {
                        // End:0x418
                        if((0.8000000 <= fWavVoiceVolume) && fWavVoiceVolume < 1.0000000)
                        {
                            iSystemVolume = 4;                            
                        }
                        else
                        {
                            // End:0x42F
                            if(1.0000000 <= fWavVoiceVolume)
                            {
                                iSystemVolume = 5;
                            }
                        }
                    }
                }
            }
        }
        Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("OptionWnd.SystemVolumeSliderCtrl", iSystemVolume);
        fOggVoiceVolume = GetOptionFloat("Audio", "OggVoiceVolume");
        gOggVoiceVolume = fOggVoiceVolume;
        // End:0x4BD
        if((0.0000000 <= fOggVoiceVolume) && fOggVoiceVolume < 0.2000000)
        {
            iTutorialVolume = 0;            
        }
        else
        {
            // End:0x4E7
            if((0.2000000 <= fOggVoiceVolume) && fOggVoiceVolume < 0.4000000)
            {
                iTutorialVolume = 1;                
            }
            else
            {
                // End:0x512
                if((0.4000000 <= fOggVoiceVolume) && fOggVoiceVolume < 0.6000000)
                {
                    iTutorialVolume = 2;                    
                }
                else
                {
                    // End:0x53D
                    if((0.6000000 <= fOggVoiceVolume) && fOggVoiceVolume < 0.8000000)
                    {
                        iTutorialVolume = 3;                        
                    }
                    else
                    {
                        // End:0x568
                        if((0.8000000 <= fOggVoiceVolume) && fOggVoiceVolume < 1.0000000)
                        {
                            iTutorialVolume = 4;                            
                        }
                        else
                        {
                            // End:0x57F
                            if(1.0000000 <= fOggVoiceVolume)
                            {
                                iTutorialVolume = 5;
                            }
                        }
                    }
                }
            }
        }
        Class'NWindow.UIAPI_SLIDERCTRL'.static.SetCurrentTick("OptionWnd.TutorialVolumeSliderCtrl", iTutorialVolume);
        m_iPrevSoundTick = iSoundVolume;
        m_iPrevMusicTick = iMusicVolume;
        m_iPrevSystemTick = iSystemVolume;
        m_iPrevTutorialTick = iTutorialVolume;        
    }
    else
    {
        Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.EffectVolumeSliderCtrl");
        Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.MusicVolumeSliderCtrl");
        Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.SystemVolumeSliderCtrl");
        Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.TutorialVolumeSliderCtrl");
    }
    // End:0x7E4
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.mutecheckbox"))
    {
        Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.EffectVolumeSliderCtrl");
        Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.MusicVolumeSliderCtrl");
        Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.SystemVolumeSliderCtrl");
        Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.TutorialVolumeSliderCtrl");
        SetSoundVolume(0.0000000);
        SetMusicVolume(0.0000000);
        SetWavVoiceVolume(0.0000000);
        SetOggVoiceVolume(0.0000000);
        SetOptionBool("Audio", "AudioMuteOn", true);        
    }
    else
    {
        Class'NWindow.UIAPI_SLIDERCTRL'.static.EnableWindow("OptionWnd.EffectVolumeSliderCtrl");
        Class'NWindow.UIAPI_SLIDERCTRL'.static.EnableWindow("OptionWnd.MusicVolumeSliderCtrl");
        Class'NWindow.UIAPI_SLIDERCTRL'.static.EnableWindow("OptionWnd.SystemVolumeSliderCtrl");
        Class'NWindow.UIAPI_SLIDERCTRL'.static.EnableWindow("OptionWnd.TutorialVolumeSliderCtrl");
    }
    return;
}

function InitGameOption()
{
    local bool bShowOtherPCName;
    local int nOption;
    local bool bOption;

    bOption = GetOptionBool("Game", "TransparencyMode");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.OpacityBox", bOption);
    bOption = GetOptionBool("Game", "IsNative");
    // End:0xA0
    if(bOption)
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.LanguageBox", 0);        
    }
    else
    {
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.LanguageBox", 1);
    }
    bOption = GetOptionBool("Game", "MyName");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.NameBox0", bOption);
    bOption = GetOptionBool("Game", "NPCName");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.NameBox1", bOption);
    bShowOtherPCName = GetOptionBool("Game", "GroupName");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.NameBox2", bShowOtherPCName);
    bOption = GetOptionBool("Game", "PledgeMemberName");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.NameBox3", bOption);
    bOption = GetOptionBool("Game", "PartyMemberName");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.NameBox4", bOption);
    bOption = GetOptionBool("Game", "OtherPCName");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.NameBox5", bOption);
    // End:0x2F0
    if(bShowOtherPCName)
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.NameBox3");
        Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.NameBox4");
        Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.NameBox5");        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.NameBox3");
        Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.NameBox4");
        Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.NameBox5");
    }
    bOption = GetOptionBool("Game", "EnterChatting");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.EnterChatBox", bOption);
    bOption = GetOptionBool("Game", "OldChatting");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.OldChatBox", bOption);
    // End:0x4B1
    if(IsUseKeyCrypt())
    {
        // End:0x42F
        if(IsCheckKeyCrypt())
        {
            Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.KeyboardBox", true);            
        }
        else
        {
            Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.KeyboardBox", false);
        }
        // End:0x488
        if(IsEnableKeyCrypt())
        {
            Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.KeyboardBox");            
        }
        else
        {
            Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.KeyboardBox");
        }        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.KeyboardBox", false);
        Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.KeyboardBox");
    }
    bOption = GetOptionBool("Game", "UseJoystick");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.JoypadBox", bOption);
    // End:0x578
    if(CanUseJoystick())
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.JoypadBox");        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.JoypadBox");
    }
    bOption = GetOptionBool("Game", "AutoTrackingPawn");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.CameraBox", bOption);
    bOption = GetOptionBool("Video", "UseColorCursor");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.CursorBox", bOption);
    bOption = GetOptionBool("Game", "ArrowMode");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.ArrowBox", bOption);
    bOption = GetOptionBool("Game", "ShowZoneTitle");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.ZoneNameBox", bOption);
    bOption = GetOptionBool("Game", "ShowGameTipMsg");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.GametipBox", bOption);
    bOption = GetOptionBool("Game", "IsRejectingDuel");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.DuelBox", bOption);
    bOption = GetOptionBool("Game", "HideDropItem");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.DropItemBox", bOption);
    nOption = GetOptionInt("Game", "PartyLooting");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.LootingBox", nOption);
    RefreshLootingBox();
    return;
}

function OnClickCheckBox(string strID)
{
    Debug(strID);
    switch(strID)
    {
        // End:0x11D
        case "NameBox2":
            // End:0xB1
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.NameBox2"))
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.NameBox3");
                Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.NameBox4");
                Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.NameBox5");                
            }
            else
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.NameBox3");
                Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.NameBox4");
                Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.NameBox5");
            }
            // End:0xF72
            break;
        // End:0x1EA
        case "SystemMsgBox":
            // End:0x1A1
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.SystemMsgBox"))
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.DamageBox");
                Class'NWindow.UIAPI_CHECKBOX'.static.EnableWindow("OptionWnd.ItemBox");                
            }
            else
            {
                Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.DamageBox");
                Class'NWindow.UIAPI_CHECKBOX'.static.DisableWindow("OptionWnd.ItemBox");
            }
            // End:0xF72
            break;
        // End:0x22F
        case "FrameBox":
            // End:0x226
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.FrameBox"))
            {
                MinFrameRateOn();                
            }
            else
            {
                MinFrameRateOff();
            }
            // End:0xF72
            break;
        // End:0x3FA
        case "mutecheckbox":
            // End:0x332
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.mutecheckbox"))
            {
                Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.EffectVolumeSliderCtrl");
                Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.MusicVolumeSliderCtrl");
                Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.SystemVolumeSliderCtrl");
                Class'NWindow.UIAPI_SLIDERCTRL'.static.DisableWindow("OptionWnd.TutorialVolumeSliderCtrl");                
            }
            else
            {
                Class'NWindow.UIAPI_SLIDERCTRL'.static.EnableWindow("OptionWnd.EffectVolumeSliderCtrl");
                Class'NWindow.UIAPI_SLIDERCTRL'.static.EnableWindow("OptionWnd.MusicVolumeSliderCtrl");
                Class'NWindow.UIAPI_SLIDERCTRL'.static.EnableWindow("OptionWnd.SystemVolumeSliderCtrl");
                Class'NWindow.UIAPI_SLIDERCTRL'.static.EnableWindow("OptionWnd.TutorialVolumeSliderCtrl");
            }
            // End:0xF72
            break;
        // End:0x492
        case "Cb_HideSkillSpam":
            // End:0x468
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("AutoSkillSpamWnd.Cb_HideSkillSpam"))
            {
                SetOptionBool("Custom", "AutoSkillSpamWnd", true);                
            }
            else
            {
                SetOptionBool("Custom", "AutoSkillSpamWnd", false);
            }
            HandleHideSkillSpam();
            // End:0xF72
            break;
        // End:0x532
        case "Cb_HideSkillSpamBox":
            // End:0x507
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("AutoSkillSpamWnd.Cb_HideSkillSpamBox"))
            {
                SetOptionBool("Custom", "HideSpamSkillsBox", true);                
            }
            else
            {
                SetOptionBool("Custom", "HideSpamSkillsBox", false);
            }
            HandleHideSkillSpamBox();
            // End:0xF72
            break;
        // End:0x5BC
        case "Cb_HideAutoBuff":
            // End:0x596
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("AutoSkillWnd.Cb_HideAutoBuff"))
            {
                SetOptionBool("Custom", "AutoSkillWnd", true);                
            }
            else
            {
                SetOptionBool("Custom", "AutoSkillWnd", false);
            }
            HandleHideAutoBuff();
            // End:0xF72
            break;
        // End:0x656
        case "Cb_HideAutoBuffBox":
            // End:0x62D
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("AutoSkillSpamWnd.Cb_HideAutoBuffBox"))
            {
                SetOptionBool("Custom", "HideAutoBuffBox", true);                
            }
            else
            {
                SetOptionBool("Custom", "HideAutoBuffBox", false);
            }
            HandleHideAutoBuffBox();
            // End:0xF72
            break;
        // End:0x703
        case "Cb_HideAssist":
            // End:0x6CB
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_HideAssist"))
            {
                SetOptionBool("Custom", "HideAssist", true);
                HideWindow("PartyWnd.AssistWnd");                
            }
            else
            {
                SetOptionBool("Custom", "HideAssist", false);
                ShowWindow("PartyWnd.AssistWnd");
            }
            // End:0xF72
            break;
        // End:0x790
        case "CB_SkillCastingBox":
            // End:0x76D
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_SkillCastingBox"))
            {
                SetOptionBool("Custom", "SkillCastingBox", true);                
            }
            else
            {
                SetOptionBool("Custom", "SkillCastingBox", false);
            }
            // End:0xF72
            break;
        // End:0x817
        case "assistIfNoblesse":
            // End:0x7F5
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.assistIfNoblesse"))
            {
                SetOptionBool("Custom", "NoblesseAssist", true);                
            }
            else
            {
                SetOptionBool("Custom", "NoblesseAssist", false);
            }
            // End:0xF72
            break;
        // End:0x8AE
        case "Cb_ChatTransparency":
            // End:0x884
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_ChatTransparency"))
            {
                SetOptionBool("Custom", "ChatTransparency", true);                
            }
            else
            {
                SetOptionBool("Custom", "ChatTransparency", false);
            }
            HandleChatTransparency();
            // End:0xF72
            break;
        // End:0x942
        case "Cb_HideAutoPotion":
            // End:0x91A
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("AutoPotionsWnd.Cb_HideAutoPotion"))
            {
                SetOptionBool("Custom", "HideAutoPotion", true);                
            }
            else
            {
                SetOptionBool("Custom", "HideAutoPotion", false);
            }
            HandleHideAutoPotion();
            // End:0xF72
            break;
        // End:0x9DD
        case "Cb_HideAutoPotionBox":
            // End:0x9B2
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_HideAutoPotionBox"))
            {
                SetOptionBool("Custom", "HideAutoPotionBox", true);                
            }
            else
            {
                SetOptionBool("Custom", "HideAutoPotionBox", false);
            }
            HandleHideAutoPotionBox();
            // End:0xF72
            break;
        // End:0xA58
        case "Cb_ShowDamage":
            // End:0xA39
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_ShowDamage"))
            {
                SetOptionBool("Options", "ShowDamage", true);                
            }
            else
            {
                SetOptionBool("Options", "ShowDamage", false);
            }
            // End:0xF72
            break;
        // End:0xAE3
        case "Cb_ShowEvent":
            // End:0xABB
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_ShowEvent"))
            {
                SetOptionBool("Custom", "ShowEvent", true);
                ExecuteEvent(2990);                
            }
            else
            {
                SetOptionBool("Custom", "ShowEvent", false);
                ExecuteEvent(2990);
            }
            // End:0xF72
            break;
        // End:0xB60
        case "Cb_DualCount":
            // End:0xB3C
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_DualCount"))
            {
                SetOptionBool("Custom", "ShowPvP/Pk", true);                
            }
            else
            {
                SetOptionBool("Custom", "ShowPvP/Pk", false);
            }
            HandleHideDualCount();
            // End:0xF72
            break;
        // End:0xBCF
        case "Cb_Time":
            // End:0xBAD
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_Time"))
            {
                SetOptionBool("Custom", "ShowTime", true);                
            }
            else
            {
                SetOptionBool("Custom", "ShowTime", false);
            }
            HandleHideShowTime();
            // End:0xF72
            break;
        // End:0xC76
        case "Cb_ShortcutTransparency":
            // End:0xC48
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_ShortcutTransparency"))
            {
                SetOptionBool("Custom", "ShortcutTransparency", true);                
            }
            else
            {
                SetOptionBool("Custom", "ShortcutTransparency", false);
            }
            SetShortcutTransparency();
            // End:0xF72
            break;
        // End:0xD27
        case "Cb_ShotcutTransparencyBox":
            // End:0xCF6
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_ShotcutTransparencyBox"))
            {
                SetOptionBool("Custom", "ShortcutTransparencyBox", true);                
            }
            else
            {
                SetOptionBool("Custom", "ShortcutTransparencyBox", false);
            }
            SetShortcutTransparencyBox();
            // End:0xF72
            break;
        // End:0xDD8
        case "Cb_ShotcutTransparencyNum":
            // End:0xDA7
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_ShotcutTransparencyNum"))
            {
                SetOptionBool("Custom", "ShortcutTransparencyNum", true);                
            }
            else
            {
                SetOptionBool("Custom", "ShortcutTransparencyNum", false);
            }
            SetShortcutTransparencyNum();
            // End:0xF72
            break;
        // End:0xE51
        case "Cb_HoldTarget":
            // End:0xE33
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_HoldTarget"))
            {
                SetOptionBool("Custom", "HoldTarget", true);                
            }
            else
            {
                SetOptionBool("Custom", "HoldTarget", false);
            }
            // End:0xF72
            break;
        // End:0xECA
        case "Cb_IgnoreAggr":
            // End:0xEAC
            if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.Cb_IgnoreAggr"))
            {
                SetOptionBool("Custom", "IgnoreAggr", true);                
            }
            else
            {
                SetOptionBool("Custom", "IgnoreAggr", false);
            }
            // End:0xF72
            break;
        // End:0xF6F
        case "Cb_AutoSS":
            // End:0xF34
            if(Cb_AutoSS.IsChecked())
            {
                SetOptionBool("Options", "AutoSS", true);
                Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("AutoShotItemWnd");
                AutoShotItemWnd.GetShotItemInfo();                
            }
            else
            {
                SetOptionBool("Options", "AutoSS", false);
                Class'NWindow.UIAPI_WINDOW'.static.HideWindow("AutoShotItemWnd");
            }
            // End:0xF72
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnShow()
{
    bShow = true;
    InitVideoOption();
    InitAudioOption();
    InitGameOption();
    SetFocus();
    return;
}

function OnHide()
{
    bShow = false;
    return;
}

function ApplyVideoOption()
{
    local bool bKeepMinFrameRate, bTrilinear;
    local int nTextureDetail, nModelDetail, nMotionDetail, nTerrainClippingRange, nPawnClippingRange, nReflectionEffect,
	    nHDR, nWeatherEffect, nSelectedNum;

    local float fGamma;
    local bool bRenderDeco, bShadow;
    local int nRenderActorLimit, nResolutionIndex, nRefreshRateIndex;
    local bool bIsChecked;

    bTrilinear = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.TriBox");
    SetOptionBool("Video", "UseTrilinear", bTrilinear);
    nTextureDetail = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.TextureBox");
    SetOptionInt("Video", "TextureDetail", nTextureDetail);
    nModelDetail = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.ModelBox");
    SetOptionInt("Video", "ModelDetail", nModelDetail);
    nMotionDetail = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.AnimBox");
    SetOptionInt("Video", "SkipAnim", nMotionDetail);
    nPawnClippingRange = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.CharBox");
    SetOptionInt("Video", "PawnClippingRange", nPawnClippingRange);
    nTerrainClippingRange = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.TerrainBox");
    SetOptionInt("Video", "TerrainClippingRange", nTerrainClippingRange);
    nSelectedNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.GammaBox");
    switch(nSelectedNum)
    {
        // End:0x203
        case 0:
            fGamma = 1.2000000;
            // End:0x251
            break;
        // End:0x215
        case 1:
            fGamma = 1.0000000;
            // End:0x251
            break;
        // End:0x228
        case 2:
            fGamma = 0.8000000;
            // End:0x251
            break;
        // End:0x23B
        case 3:
            fGamma = 0.6000000;
            // End:0x251
            break;
        // End:0x24E
        case 4:
            fGamma = 0.4000000;
            // End:0x251
            break;
        // End:0xFFFF
        default:
            break;
    }
    SetOptionFloat("Video", "Gamma", fGamma);
    nHDR = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.HDRBox");
    SetOptionInt("Video", "PostProc", nHDR);
    bRenderDeco = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.DecoBox");
    SetOptionBool("Video", "RenderDeco", bRenderDeco);
    bShadow = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.ShadowBox");
    SetOptionBool("Video", "PawnShadow", bShadow);
    nReflectionEffect = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.ReflectBox");
    SetOptionInt("L2WaterEffect", "EffectType", nReflectionEffect);
    // End:0x3C1
    if(0 == nReflectionEffect)
    {
        SetOptionBool("L2WaterEffect", "IsUseEffect", false);        
    }
    else
    {
        SetOptionBool("L2WaterEffect", "IsUseEffect", true);
    }
    nSelectedNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.PawnBox");
    switch(nSelectedNum)
    {
        // End:0x422
        case 5:
            nRenderActorLimit = 1;
            // End:0x473
            break;
        // End:0x432
        case 4:
            nRenderActorLimit = 2;
            // End:0x473
            break;
        // End:0x442
        case 3:
            nRenderActorLimit = 3;
            // End:0x473
            break;
        // End:0x452
        case 2:
            nRenderActorLimit = 4;
            // End:0x473
            break;
        // End:0x461
        case 1:
            nRenderActorLimit = 5;
            // End:0x473
            break;
        // End:0x470
        case 0:
            nRenderActorLimit = 6;
            // End:0x473
            break;
        // End:0xFFFF
        default:
            break;
    }
    SetOptionInt("Video", "RenderActorLimited", nRenderActorLimit);
    nSelectedNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.AABox");
    SetOptionInt("Video", "AntiAliasing", nSelectedNum);
    nSelectedNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.CaptureBox");
    SetOptionInt("Game", "ScreenShotQuality", nSelectedNum);
    nResolutionIndex = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.ResBox");
    nRefreshRateIndex = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.RefreshRateBox");
    SetResolution(nResolutionIndex, nRefreshRateIndex);
    nSelectedNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.WeatherEffectComboBox");
    switch(nSelectedNum)
    {
        // End:0x5DF
        case 0:
            nWeatherEffect = 0;
            // End:0x610
            break;
        // End:0x5ED
        case 1:
            nWeatherEffect = 1;
            // End:0x610
            break;
        // End:0x5FD
        case 2:
            nWeatherEffect = 2;
            // End:0x610
            break;
        // End:0x60D
        case 3:
            nWeatherEffect = 3;
            // End:0x610
            break;
        // End:0xFFFF
        default:
            break;
    }
    SetOptionInt("Video", "WeatherEffect", nWeatherEffect);
    bIsChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.GPUAnimationCheckBox");
    SetOptionBool("Video", "GPUAnimation", bIsChecked);
    bKeepMinFrameRate = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.FrameBox");
    SetOptionBool("Video", "IsKeepMinFrameRate", bKeepMinFrameRate);
    // End:0x746
    if(bKeepMinFrameRate)
    {
        Debug("KeepMinFrameRate");
        SetTextureDetail(2);
        SetModelingDetail(1);
        SetMotionDetail(1);
        SetShadow(false);
        SetBackgroundEffect(false);
        SetTerrainClippingRange(4);
        SetPawnClippingRange(4);
        SetReflectionEffect(0);
        SetHDR(0);
        SetWeatherEffect(0);        
    }
    else
    {
        Debug("Not KeepMinFrameRate nTextureDetail=" $ string(nTextureDetail));
        SetTextureDetail(nTextureDetail);
        SetModelingDetail(nModelDetail);
        SetMotionDetail(nMotionDetail);
        SetShadow(bShadow);
        SetBackgroundEffect(bRenderDeco);
        SetTerrainClippingRange(nTerrainClippingRange);
        SetPawnClippingRange(nPawnClippingRange);
        SetReflectionEffect(nReflectionEffect);
        SetHDR(nHDR);
        SetWeatherEffect(nWeatherEffect);
    }
    InitVideoOption();
    return;
}

function ApplyAudioOption()
{
    local float fSoundVolume, fMusicVolume, fWavVoiceVolume, fOggVoiceVolume;
    local int iSoundTick, iMusicTick, iSystemTick, iTutorialTick;

    // End:0x0D
    if(!CanUseAudio())
    {
        return;
    }
    iSoundTick = Class'NWindow.UIAPI_SLIDERCTRL'.static.GetCurrentTick("OptionWnd.EffectVolumeSliderCtrl");
    fSoundVolume = GetVolumeFromSliderTick(iSoundTick);
    SetOptionFloat("Audio", "SoundVolume", fSoundVolume);
    gSoundVolume = fSoundVolume;
    iMusicTick = Class'NWindow.UIAPI_SLIDERCTRL'.static.GetCurrentTick("OptionWnd.MusicVolumeSliderCtrl");
    fMusicVolume = GetVolumeFromSliderTick(iMusicTick);
    SetOptionFloat("Audio", "MusicVolume", fMusicVolume);
    gMusicVolume = fMusicVolume;
    iSystemTick = Class'NWindow.UIAPI_SLIDERCTRL'.static.GetCurrentTick("OptionWnd.SystemVolumeSliderCtrl");
    fWavVoiceVolume = GetVolumeFromSliderTick(iSystemTick);
    SetOptionFloat("Audio", "WavVoiceVolume", fWavVoiceVolume);
    gWavVoiceVolume = fWavVoiceVolume;
    iTutorialTick = Class'NWindow.UIAPI_SLIDERCTRL'.static.GetCurrentTick("OptionWnd.TutorialVolumeSliderCtrl");
    fOggVoiceVolume = GetVolumeFromSliderTick(iTutorialTick);
    SetOptionFloat("Audio", "OggVoiceVolume", fOggVoiceVolume);
    gOggVoiceVolume = fOggVoiceVolume;
    m_iPrevSoundTick = iSoundTick;
    m_iPrevMusicTick = iMusicTick;
    m_iPrevSystemTick = iSystemTick;
    m_iPrevTutorialTick = iTutorialTick;
    // End:0x27C
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.mutecheckbox"))
    {
        SetSoundVolume(0.0000000);
        SetMusicVolume(0.0000000);
        SetWavVoiceVolume(0.0000000);
        SetOggVoiceVolume(0.0000000);
        SetOptionBool("Audio", "AudioMuteOn", true);        
    }
    else
    {
        SetOptionBool("Audio", "AudioMuteOn", false);
    }
    return;
}

function ApplyGameOption()
{
    local int nSelectedNum;
    local bool bChecked;

    nSelectedNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.LanguageBox");
    // End:0x51
    if(0 == nSelectedNum)
    {
        SetOptionBool("Game", "IsNative", true);        
    }
    else
    {
        // End:0x73
        if(1 == nSelectedNum)
        {
            SetOptionBool("Game", "IsNative", false);
        }
    }
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.NameBox0");
    SetOptionBool("Game", "MyName", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.NameBox1");
    SetOptionBool("Game", "NPCName", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.NameBox3");
    SetOptionBool("Game", "PledgeMemberName", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.NameBox4");
    SetOptionBool("Game", "PartyMemberName", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.NameBox5");
    SetOptionBool("Game", "OtherPCName", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.NameBox2");
    SetOptionBool("Game", "GroupName", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.OpacityBox");
    SetOptionBool("Game", "TransparencyMode", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.ArrowBox");
    SetOptionBool("Game", "ArrowMode", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.CameraBox");
    SetOptionBool("Game", "AutoTrackingPawn", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.EnterChatBox");
    SetOptionBool("Game", "EnterChatting", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.OldChatBox");
    SetOptionBool("Game", "OldChatting", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.ZoneNameBox");
    SetOptionBool("Game", "ShowZoneTitle", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.GametipBox");
    SetOptionBool("Game", "ShowGameTipMsg", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.DuelBox");
    SetOptionBool("Game", "IsRejectingDuel", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.DropItemBox");
    SetOptionBool("Game", "HideDropItem", bChecked);
    // End:0x54E
    if(Class'NWindow.UIAPI_WINDOW'.static.IsEnableWindow("OptionWnd.LootingBox"))
    {
        nSelectedNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.LootingBox");
        SetOptionInt("Game", "PartyLooting", nSelectedNum);
    }
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.CursorBox");
    SetOptionBool("Video", "UseColorCursor", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.SystemMsgBox");
    SetOptionBool("Game", "SystemMsgWnd", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.DamageBox");
    SetOptionBool("Game", "SystemMsgWndDamage", bChecked);
    bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.ItemBox");
    SetOptionBool("Game", "SystemMsgWndExpendableItem", bChecked);
    // End:0x6E5
    if(CanUseJoystick())
    {
        bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.JoypadBox");
        SetOptionBool("Game", "UseJoystick", bChecked);
    }
    // End:0x727
    if(IsUseKeyCrypt())
    {
        bChecked = Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("OptionWnd.KeyboardBox");
        SetKeyCrypt(bChecked);
    }
    return;
}

function OnClickButton(string strID)
{
    Debug(strID);
    switch(strID)
    {
        // End:0x25
        case "VideoCancelBtn":
        // End:0x38
        case "AudioCancelBtn":
        // End:0x110
        case "GameCancelBtn":
            SetOptionInt("FirstRun", "FirstRun", 2);
            OnModifyCurrentTickSliderCtrl("EffectVolumeSliderCtrl", m_iPrevSoundTick);
            OnModifyCurrentTickSliderCtrl("MusicVolumeSliderCtrl", m_iPrevMusicTick);
            OnModifyCurrentTickSliderCtrl("SystemVolumeSliderCtrl", m_iPrevSystemTick);
            OnModifyCurrentTickSliderCtrl("TutorialVolumeSliderCtrl", m_iPrevTutorialTick);
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("OptionWnd");
            // End:0x219
            break;
        // End:0x11F
        case "VideoOKBtn":
        // End:0x12E
        case "AudioOKBtn":
        // End:0x187
        case "GameOKBtn":
            ApplyVideoOption();
            ApplyAudioOption();
            ApplyGameOption();
            SetOptionInt("FirstRun", "FirstRun", 2);
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("OptionWnd");
            // End:0x219
            break;
        // End:0x199
        case "VideoApplyBtn":
        // End:0x1AB
        case "AudioApplyBtn":
        // End:0x1D1
        case "GameApplyBtn":
            ApplyVideoOption();
            ApplyAudioOption();
            ApplyGameOption();
            // End:0x219
            break;
        // End:0x1EC
        case "WindowInitBtn":
            SetDefaultPosition();
            // End:0x219
            break;
        // End:0x216
        case "BtnClose":
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("OptionWnd");
            // End:0x219
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function float GetVolumeFromSliderTick(int iTick)
{
    local float fReturnVolume;

    switch(iTick)
    {
        // End:0x19
        case 0:
            fReturnVolume = 0.0000000;
            // End:0x7A
            break;
        // End:0x2B
        case 1:
            fReturnVolume = 0.2000000;
            // End:0x7A
            break;
        // End:0x3E
        case 2:
            fReturnVolume = 0.4000000;
            // End:0x7A
            break;
        // End:0x51
        case 3:
            fReturnVolume = 0.6000000;
            // End:0x7A
            break;
        // End:0x64
        case 4:
            fReturnVolume = 0.8000000;
            // End:0x7A
            break;
        // End:0x77
        case 5:
            fReturnVolume = 1.0000000;
            // End:0x7A
            break;
        // End:0xFFFF
        default:
            break;
    }
    return fReturnVolume;
}

function MinFrameRateOn()
{
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.TextureBox");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.ModelBox");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.AnimBox");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.ShadowBox");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.DecoBox");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.TerrainBox");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.CharBox");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.ReflectBox");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.HDRBox");
    Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.WeatherEffectComboBox");
    return;
}

function MinFrameRateOff()
{
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.TextureBox");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.ModelBox");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.AnimBox");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.ShadowBox");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.DecoBox");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.TerrainBox");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.CharBox");
    Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.WeatherEffectComboBox");
    // End:0x181
    if(nPixelShaderVersion < 12)
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.ReflectBox");
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.ReflectBox", 0);        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.ReflectBox");
    }
    // End:0x1E4
    if((nPixelShaderVersion >= 20) && nVertexShaderVersion >= 20)
    {
        Class'NWindow.UIAPI_WINDOW'.static.EnableWindow("OptionWnd.HDRBox");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.DisableWindow("OptionWnd.HDRBox");
        Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.HDRBox", 0);
    }
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    local bool bMinFrameRate;

    switch(a_EventID)
    {
        // End:0x81
        case 510:
            bMinFrameRate = GetOptionBool("Video", "IsKeepMinFrameRate");
            Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.FrameBox", bMinFrameRate);
            // End:0x72
            if(bMinFrameRate)
            {
                MinFrameRateOn();                
            }
            else
            {
                MinFrameRateOff();
            }
            ApplyVideoOption();
            // End:0xE0
            break;
        // End:0x92
        case 520:
            RefreshLootingBox();
            // End:0xE0
            break;
        // End:0xAB
        case 1550:
            m_bPartyMatchRoomState = true;
            RefreshLootingBox();
            // End:0xE0
            break;
        // End:0xC4
        case 1560:
            m_bPartyMatchRoomState = false;
            RefreshLootingBox();
            // End:0xE0
            break;
        // End:0xDD
        case 150:
            ExecuteEvent(11223344);
            LoadingINI();
            // End:0xE0
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnComboBoxItemSelected(string sName, int Index)
{
    local int nSelectedNum;

    Debug(sName);
    switch(sName)
    {
        // End:0x46
        case "ResBox":
            ResetRefreshRate(ResolutionList[Index].nWidth, ResolutionList[Index].nHeight);
            // End:0xAB
            break;
        // End:0xA8
        case "MinimapCB":
            nSelectedNum = Class'NWindow.UIAPI_COMBOBOX'.static.GetSelectedNum("OptionWnd.MinimapCB");
            SetOptionInt("Custom", "Minimap", nSelectedNum);
            ExecuteEvent(11223344);
            // End:0xAB
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnModifyCurrentTickSliderCtrl(string strID, int iCurrentTick)
{
    local float fVolume;

    fVolume = GetVolumeFromSliderTick(iCurrentTick);
    switch(strID)
    {
        // End:0x55
        case "EffectVolumeSliderCtrl":
            SetOptionFloat("Audio", "SoundVolume", fVolume);
            // End:0x130
            break;
        // End:0xAB
        case "MusicVolumeSliderCtrl":
            // End:0x89
            if(fVolume == 0.0000000)
            {
                fVolume = 0.0050000;
            }
            SetOptionFloat("Audio", "MusicVolume", fVolume);
            // End:0x130
            break;
        // End:0xEB
        case "SystemVolumeSliderCtrl":
            SetOptionFloat("Audio", "WavVoiceVolume", fVolume);
            // End:0x130
            break;
        // End:0x12D
        case "TutorialVolumeSliderCtrl":
            SetOptionFloat("Audio", "OggVoiceVolume", fVolume);
            // End:0x130
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function InitInterfaceOption()
{
    local int nOption;
    local bool bOption;

    nOption = GetOptionInt("Custom", "AbnormalSize");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.AbnormalSizeBox", nOption);
    nOption = GetOptionInt("Custom", "Minimap");
    Class'NWindow.UIAPI_COMBOBOX'.static.SetSelectedNum("OptionWnd.MinimapCB", nOption);
    bOption = GetOptionBool("Custom", "HideAssist");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_HideAssist", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_HideAssist", " Hide Assist Window");
    bOption = GetOptionBool("Custom", "SkillCastingBox");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.CB_SkillCastingBox", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.CB_SkillCastingBox", " Display Skill Casting Box");
    bOption = GetOptionBool("Custom", "AutoSkillSpamWnd");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_HideSkillSpam", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_HideSkillSpam", " Hide Skills Spam");
    bOption = GetOptionBool("Custom", "AutoSkillWnd");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_HideAutoBuff", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_HideAutoBuff", " Hide Auto Buff");
    bOption = GetOptionBool("Custom", "HideSpamSkillsBox");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_HideSkillSpamBox", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_HideSkillSpamBox", " Skills Spam: Hide Box");
    HandleHideSkillSpamBox();
    bOption = GetOptionBool("Custom", "HideAutoBuffBox");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_HideAutoBuffBox", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_HideAutoBuffBox", " Auto Buff: Hide Box");
    HandleHideAutoBuffBox();
    bOption = GetOptionBool("Custom", "NoblesseAssist");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.assistIfNoblesse", bOption);
    bOption = GetOptionBool("Custom", "BuffPotions");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.BuffPotions", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.BuffPotions", " Use Buff Potions Automatically");
    bOption = GetOptionBool("Options", "ShowDamage");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_ShowDamage", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_ShowDamage", " Show Damage On Screen");
    bOption = GetOptionBool("Custom", "ShowEvent");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.CB_ShowEvent", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_ShowEvent", " Show Resisted");
    bOption = GetOptionBool("Custom", "ShowPvP/Pk");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_DualCount", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_DualCount", " Show PvP/Pk Count And Karma Quantity");
    HandleHideDualCount();
    bOption = GetOptionBool("Custom", "ShowTime");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_Time", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_Time", " Show Current Time From Your Region");
    HandleHideShowTime();
    bOption = GetOptionBool("Custom", "HoldTarget");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_HoldTarget", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_HoldTarget", " Hold Target");
    bOption = GetOptionBool("Custom", "IgnoreAggr");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_IgnoreAggr", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_IgnoreAggr", " Ignore Aggression");
    bOption = GetOptionBool("Custom", "HideAutoPotion");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_HideAutoPotion", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_HideAutoPotion", " Hide Auto Potion");
    bOption = GetOptionBool("Custom", "HideAutoPotionBox");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_HideAutoPotionBox", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_HideAutoPotionBox", " Hide Auto Potion");
    HandleHideAutoPotionBox();
    bOption = GetOptionBool("Custom", "ShortcutTransparency");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_ShortcutTransparency", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_ShortcutTransparency", " Hide Shortcut");
    SetShortcutTransparency();
    bOption = GetOptionBool("Custom", "ShortcutTransparencyBox");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_ShotcutTransparencyBox", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_ShotcutTransparencyBox", " Hide Shortcut box");
    SetShortcutTransparencyBox();
    bOption = GetOptionBool("Custom", "ShortcutTransparencyNum");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_ShotcutTransparencyNum", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_ShotcutTransparencyNum", " Hide Shortcut numbers");
    SetShortcutTransparencyNum();
    bOption = GetOptionBool("Custom", "ChatTransparency");
    Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_ChatTransparency", bOption);
    Class'NWindow.UIAPI_CHECKBOX'.static.SetTitle("OptionWnd.Cb_ChatTransparency", " Chat Transparency");
    HandleChatTransparency();
    return;
}

function HandleHideSpamSkill()
{
    local ShortcutWnd script;

    script = ShortcutWnd(GetScript("ShortcutWnd"));
    // End:0x77
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("AutoSkillSpamWnd.Cb_HideSkillSpam"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("AutoSkillSpamWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("AutoSkillSpamWnd");
    }
    script.AutoPotionsWndPosition();
    return;
}

function HandleHideAutoPotion()
{
    local ShortcutWnd script;

    script = ShortcutWnd(GetScript("ShortcutWnd"));
    // End:0x77
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("AutoPotionsWnd.Cb_HideAutoPotionBox"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("AutoPotionsWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("AutoPotionsWnd");
    }
    script.AutoPotionsWndPosition();
    return;
}

function HandleHideSkillSpamBox()
{
    // End:0x14B
    if(UnknownFunction242(GetOptionBool("Custom", "HideSpamSkillsBox"), true))
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_5", "Was.Null");        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_1", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_2", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_3", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_4", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillSpamWnd.SpamBackTex_5", "Was.SkillBox");
    }
    return;
}

function HandleHideDualCount()
{
    // End:0x65
    if(UnknownFunction242(GetOptionBool("Custom", "ShowPvP/Pk"), true))
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.ShowWindow("MenuWnd.PVP1");
        Class'NWindow.UIAPI_TEXTBOX'.static.ShowWindow("MenuWnd.Username");        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.HideWindow("MenuWnd.PVP1");
        Class'NWindow.UIAPI_TEXTBOX'.static.HideWindow("MenuWnd.Username");
    }
    return;
}

function HandleHideShowTime()
{
    // End:0x62
    if(UnknownFunction242(GetOptionBool("Custom", "ShowTime"), true))
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.ShowWindow("MenuWnd.Time");
        Class'NWindow.UIAPI_TEXTBOX'.static.ShowWindow("MenuWnd.Current");        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.HideWindow("MenuWnd.Time");
        Class'NWindow.UIAPI_TEXTBOX'.static.HideWindow("MenuWnd.Current");
    }
    return;
}

function HandleHideAutoPotionBox()
{
    // End:0x12A
    if(UnknownFunction242(GetOptionBool("Custom", "HideAutoPotionBox"), true))
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.BoxMP1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.BoxHP1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.BoxCP1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.ElixirBoxCP1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.ElixirBoxHP1", "Was.Null");        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.BoxMP1", "Was.Potions_BoxMP");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.BoxHP1", "Was.Potions_BoxHP");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.BoxCP1", "Was.Potions_BoxCP");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.ElixirBoxCP1", "Was.Potions_Elixir_BoxCP");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoPotionsWnd.ElixirBoxHP1", "Was.Potions_Elixir_BoxHP");
    }
    return;
}

function HandleHideAutoBuffBox()
{
    // End:0x1B4
    if(UnknownFunction242(GetOptionBool("Custom", "HideAutoBuffBox"), true))
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_5", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_6", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_7", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_8", "Was.Null");        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_1", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_2", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_3", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_4", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_5", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_6", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_7", "Was.SkillBox");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("AutoSkillWnd.BackTex_8", "Was.SkillBox");
    }
    return;
}

function HandleHideSkillSpam()
{
    local ShortcutWnd script;

    script = ShortcutWnd(GetScript("ShortcutWnd"));
    // End:0x77
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("AutoSkillSpamWnd.Cb_HideSkillSpam"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("AutoSkillSpamWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("AutoSkillSpamWnd");
    }
    script.AutoPotionsWndPosition();
    return;
}

function HandleHideAutoBuff()
{
    local ShortcutWnd script;

    script = ShortcutWnd(GetScript("ShortcutWnd"));
    // End:0x6E
    if(Class'NWindow.UIAPI_CHECKBOX'.static.IsChecked("AutoSkillWnd.Cb_HideAutoBuff"))
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("AutoSkillWnd");        
    }
    else
    {
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("AutoSkillWnd");
    }
    script.AutoPotionsWndPosition();
    return;
}

function HandleChatTransparency()
{
    // End:0x21E
    if(GetOptionBool("Custom", "ChatTransparency"))
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.ChatWndHeadTex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.ChatWndBodyTex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.ChatWndBottomTex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.ChatWndBottomTex1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.TabBackgroundTexture", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.top", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.niz", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.BackTexture", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.ChatWndHeadTex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.ChatWndBottomTex2", "Was.Null");        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.ChatWndHeadTex", "Was.Chat_Head");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.ChatWndBodyTex", "Was.Chat_Tile");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.ChatWndBottomTex", "Was.Chat_Tile");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.ChatWndBottomTex1", "L2UI_CH3.ChatWnd.Chatting_Back1");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ChatWnd.TabBackgroundTexture", "L2UI_CH3.Minimap.MapWnd_back_max");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.top", "SavoWas.SavoChatBg");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.niz", "L2UI_CH3.Minimap.MapWnd_back_max");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.BackTexture", "Was.Chat_Tile");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.ChatWndHeadTex", "Was.Chat_Head");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("SystemMsgWnd.ChatWndBottomTex2", "Was.Chat_Bottom");
    }
    return;
}

function SetShortcutTransparency()
{
    // End:0x277
    if(UnknownFunction242(GetOptionBool("Custom", "ShortcutTransparency"), true))
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.Tex", "Was.Null");        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.Tex", "Was.Wnd_Shortcut_h");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.Tex", "Was.Wnd_Shortcut_h");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.Tex", "Was.Wnd_Shortcut_h");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.Tex", "Was.Wnd_Shortcut_h");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.Tex", "Was.Wnd_Shortcut_h");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.Tex", "Was.Wnd_Shortcut_v");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.Tex", "Was.Wnd_Shortcut_v");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.Tex", "Was.Wnd_Shortcut_v");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.Tex", "Was.Wnd_Shortcut_v");
    }
    return;
}

function SetShortcutTransparencyBox()
{
    // End:0x1C71
    if(UnknownFunction242(GetOptionBool("Custom", "ShortcutTransparencyBox"), true))
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_ShotcutTransparencyBox", true);
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_5", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_6", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_7", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_8", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_9", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_10", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_11", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_12", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_5", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_6", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_7", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_8", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_9", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_10", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_11", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_12", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_5", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_6", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_7", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_8", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_9", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_10", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_11", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_12", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_5", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_6", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_7", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_8", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_9", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_10", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_11", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_12", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_5", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_6", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_7", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_8", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_9", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_10", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_11", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_12", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_5", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_6", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_7", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_8", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_9", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_10", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_11", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_12", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_5", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_6", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_7", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_8", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_9", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_10", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_11", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_12", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_1", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_2", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_3", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_4", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_5", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_6", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_7", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_8", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_9", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_10", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_11", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_12", "Was.Null");        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_ShotcutTransparencyBox", false);
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_1", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_2", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_3", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_4", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_5", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_6", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_7", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_8", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_9", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_10", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_11", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropTex_12", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_1", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_2", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_3", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_4", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_5", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_6", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_7", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_8", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_9", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_10", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_11", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropTex_12", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_1", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_2", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_3", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_4", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_5", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_6", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_7", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_8", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_9", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_10", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_11", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropTex_12", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_1", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_2", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_3", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_4", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_5", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_6", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_7", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_8", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_9", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_10", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_11", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropTex_12", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_1", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_2", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_3", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_4", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_5", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_6", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_7", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_8", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_9", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_10", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_11", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.BackDropTex_12", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_1", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_2", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_3", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_4", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_5", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_6", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_7", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_8", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_9", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_10", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_11", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.BackDropTex_12", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_1", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_2", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_3", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_4", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_5", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_6", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_7", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_8", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_9", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_10", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_11", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.BackDropTex_12", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_1", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_2", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_3", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_4", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_5", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_6", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_7", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_8", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_9", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_10", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_11", "Was.ItemWindow_DF_SlotBox_2x2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.BackDropTex_12", "Was.ItemWindow_DF_SlotBox_2x2");
    }
    return;
}

function SetShortcutTransparencyNum()
{
    // End:0x1971
    if(UnknownFunction242(GetOptionBool("Custom", "ShortcutTransparencyNum"), true))
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_ShotcutTransparencyNum", true);
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F1Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F2Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F3Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F4Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F5Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F6Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F7Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F8Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F9Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F10Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F11Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F12Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F1Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F2Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F3Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F4Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F5Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F6Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F7Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F8Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F9Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F10Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F11Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F12Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F1Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F2Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F3Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F4Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F5Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F6Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F7Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F8Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F9Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F10Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F11Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F12Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F1Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F2Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F3Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F4Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F5Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F6Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F7Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F8Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F9Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F10Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F11Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F12Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F1Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F2Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F3Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F4Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F5Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F6Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F7Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F8Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F9Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F10Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F11Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F12Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F1Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F2Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F3Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F4Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F5Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F6Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F7Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F8Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F9Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F10Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F11Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F12Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F1Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F2Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F3Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F4Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F5Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F6Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F7Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F8Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F9Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F10Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F11Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F12Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F1Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F2Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F3Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F4Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F5Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F6Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F7Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F8Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F9Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F10Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F11Tex", "Was.Null");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F12Tex", "Was.Null");        
    }
    else
    {
        Class'NWindow.UIAPI_CHECKBOX'.static.SetCheck("OptionWnd.Cb_ShotcutTransparencyNum", false);
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F1Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F1");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F2Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F3Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F3");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F4Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F4");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F5Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F5");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F6Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F6");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F7Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F7");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F8Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F8");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F9Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F9");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F10Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F10");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F11Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F11");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F12Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F12");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F1Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_1");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F2Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F3Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_3");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F4Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_4");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F5Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_5");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F6Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_6");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F7Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_7");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F8Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_8");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F9Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_9");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F10Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_0");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F11Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_Minus");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F12Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_EQUALS");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F1Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF1");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F2Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F3Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF3");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F4Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF4");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F5Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF5");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F6Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF6");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F7Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF7");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F8Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF8");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F9Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF9");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F10Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF10");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F11Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF11");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F12Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF12");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F1Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A1");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F2Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F3Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A3");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F4Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A4");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F5Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A5");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F6Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A6");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F7Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A7");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F8Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A8");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F9Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A9");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F10Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A10");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F11Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A11");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F12Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A12");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F1Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F1");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F2Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F3Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F3");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F4Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F4");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F5Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F5");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F6Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F6");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F7Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F7");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F8Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F8");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F9Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F9");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F10Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F10");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F11Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F11");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical.F12Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_F12");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F1Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_1");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F2Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F3Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_3");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F4Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_4");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F5Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_5");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F6Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_6");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F7Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_7");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F8Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_8");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F9Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_9");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F10Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_0");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F11Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_Minus");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_1.F12Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_EQUALS");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F1Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF1");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F2Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F3Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF3");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F4Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF4");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F5Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF5");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F6Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF6");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F7Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF7");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F8Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF8");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F9Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF9");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F10Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF10");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F11Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF11");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_2.F12Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_AF12");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F1Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A1");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F2Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A2");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F3Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A3");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F4Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A4");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F5Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A5");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F6Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A6");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F7Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A7");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F8Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A8");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F9Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A9");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F10Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A10");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F11Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A11");
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("ShortcutWnd.ShortcutWndVertical_3.F12Tex", "L2UI_Sublimity.ShortcutWnd.ShortcutWnd_DF_Key_A12");
    }
    return;
}

function LoadingINI()
{
    local bool Index;

    Index = GetOptionBool("Options", "AutoSS");
    // End:0x6C
    if(Index == true)
    {
        Cb_AutoSS.SetCheck(true);
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("AutoShotItemWnd");
        AutoShotItemWnd.GetShotItemInfo();        
    }
    else
    {
        Cb_AutoSS.SetCheck(false);
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("AutoShotItemWnd");
    }
    return;
}

function SetFocus()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("OptionWnd.TabCtrl");
    return;
}
