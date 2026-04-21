class PartyMatchWndCommon extends UIScript;

function string GetAmbiguousLevelString(int a_Level, bool a_HasSpace)
{
    local string AmbiguousLevelString;

    // End:0x33
    if(10 > a_Level)
    {
        // End:0x25
        if(a_HasSpace)
        {
            AmbiguousLevelString = "1 ~ 9";            
        }
        else
        {
            AmbiguousLevelString = "1~9";
        }        
    }
    else
    {
        // End:0xAE
        if(70 > a_Level)
        {
            // End:0x7C
            if(a_HasSpace)
            {
                AmbiguousLevelString = (string((a_Level / 10) * 10) $ " ~ ") $ string(((a_Level / 10) * 10) + 9);                
            }
            else
            {
                AmbiguousLevelString = (string((a_Level / 10) * 10) $ "~") $ string(((a_Level / 10) * 10) + 9);
            }            
        }
        else
        {
            // End:0xCD
            if(a_HasSpace)
            {
                AmbiguousLevelString = "70 ~ " $ string(80);                
            }
            else
            {
                AmbiguousLevelString = "70~" $ string(80);
            }
        }
    }
    return AmbiguousLevelString;
}
