class HennaInfoWnd extends UIScript;

const HENNA_EQUIP = 1;
const HENNA_UNEQUIP = 2;

var int m_iState;
var int m_iHennaID;

function OnLoad()
{
    RegisterEvent(1660);
    RegisterEvent(1690);
    return;
}

function OnClickButton(string strID)
{
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("HennaInfoWnd");
    switch(strID)
    {
        // End:0x59
        case "btnPrev":
            // End:0x44
            if(m_iState == 1)
            {
                RequestHennaItemList();                
            }
            else
            {
                // End:0x56
                if(m_iState == 2)
                {
                    RequestHennaUnEquipList();
                }
            }
            // End:0xC6
            break;
        // End:0x96
        case "btnOK":
            // End:0x7C
            if(m_iState == 1)
            {
                RequestHennaEquip(m_iHennaID);                
            }
            else
            {
                // End:0x93
                if(m_iState == 2)
                {
                    RequestHennaUnEquip(m_iHennaID);
                }
            }
            // End:0xC6
            break;
        // End:0xC3
        case "BtnClose":
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("HennaInfoWnd");
            // End:0xC6
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnShow()
{
    // End:0x96
    if(m_iState == 1)
    {
        Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitleByText("HennaInfoWnd", GetSystemString(651));
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("HennaInfoWnd.HennaInfoWndUnEquip");
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("HennaInfoWnd.HennaInfoWndEquip");
        Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("HennaInfoWnd.HennaInfoWndEquip", 255);        
    }
    else
    {
        // End:0x12D
        if(m_iState == 2)
        {
            Class'NWindow.UIAPI_WINDOW'.static.SetWindowTitleByText("HennaInfoWnd", GetSystemString(652));
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("HennaInfoWnd.HennaInfoWndEquip");
            Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("HennaInfoWnd.HennaInfoWndUnEquip");
            Class'NWindow.UIAPI_WINDOW'.static.SetAlpha("HennaInfoWnd.HennaInfoWndUnEquip", 255);            
        }
        else
        {
            Debug("???? ????~~");
        }
    }
    SetFocus();
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x24
        case 1660:
            m_iState = 1;
            ShowHennaInfoWnd(param);
            // End:0x45
            break;
        // End:0x42
        case 1690:
            m_iState = 2;
            ShowHennaInfoWnd(param);
            // End:0x45
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function Color MakeHennaColor(byte R, byte G, byte B)
{
    local Color C;

    C.R = R;
    C.G = G;
    C.B = B;
    C.A = byte(255);
    return C;
}

function ApplyHennaTextColors()
{
    local Color HeaderColor, TextColor;

    HeaderColor = MakeHennaColor(220, 220, 220);
    TextColor = MakeHennaColor(185, 185, 185);

    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtDyeInfo", HeaderColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtTattooInfo", HeaderColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtDyeInfoUnEquip", HeaderColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtTattooInfoUnEquip", HeaderColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtVariation", HeaderColor);

    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtDyeName", TextColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtTattooName", TextColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtTattooAddName", TextColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtDyeNameUnEquip", TextColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtTattooNameUnEquip", TextColor);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtTattooAddNameUnEquip", TextColor);
}

function ShowHennaInfoWnd(string param)
{
    local string strAdenaComma;
    local int iAdena;
    local string strDyeName, strDyeIconName;
    local int iHennaID, iClassID, iNum, iFee;
    local string strTattooName, strTattooAddName, strTattooIconName;
    local int iINTnow, iINTchange, iSTRnow, iSTRchange, iCONnow, iCONchange,
	    iMENnow, iMENchange, iDEXnow, iDEXchange, iWITnow,
	    iWITchange;

    local Color col;

    ParseInt(param, "Adena", iAdena);
    ParseString(param, "DyeIconName", strDyeIconName);
    ParseString(param, "DyeName", strDyeName);
    ParseInt(param, "HennaID", iHennaID);
    ParseInt(param, "ClassID", iClassID);
    ParseInt(param, "NumOfItem", iNum);
    ParseInt(param, "Fee", iFee);
    ParseString(param, "TattooIconName", strTattooIconName);
    ParseString(param, "TattooName", strTattooName);
    ParseString(param, "TattooAddName", strTattooAddName);
    ParseInt(param, "INTnow", iINTnow);
    ParseInt(param, "INTchange", iINTchange);
    ParseInt(param, "STRnow", iSTRnow);
    ParseInt(param, "STRchange", iSTRchange);
    ParseInt(param, "CONnow", iCONnow);
    ParseInt(param, "CONchange", iCONchange);
    ParseInt(param, "MENnow", iMENnow);
    ParseInt(param, "MENchange", iMENchange);
    ParseInt(param, "DEXnow", iDEXnow);
    ParseInt(param, "DEXchange", iDEXchange);
    ParseInt(param, "WITnow", iWITnow);
    ParseInt(param, "WITchange", iWITchange);
    m_iHennaID = iHennaID;
    // End:0x552
    if(m_iState == 1)
    {
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtDyeInfo", GetSystemString(638));
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("HennaInfoWnd.textureDyeIconName", strDyeIconName);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtDyeName", strDyeName);
        col.R = 168;
        col.G = 168;
        col.B = 168;
        col.A = byte(255);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtFee", GetSystemString(637) $ " : ");
        Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtFee", col);
        strAdenaComma = MakeCostString("" $ string(iFee));
        col = GetNumericColor(strAdenaComma);
        col.A = byte(255);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtAdena", strAdenaComma);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtAdena", col);
        col.R = byte(255);
        col.G = byte(255);
        col.B = 0;
        col.A = byte(255);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtAdenaString", GetSystemString(469));
        Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtAdenaString", col);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtTattooInfo", GetSystemString(639));
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("HennaInfoWnd.textureTattooIconName", strTattooIconName);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtTattooName", strTattooName);
        Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtTattooAddName", strTattooAddName);        
    }
    else
    {
        // End:0x8C8
        if(m_iState == 2)
        {
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtTattooInfoUnEquip", GetSystemString(639));
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("HennaInfoWnd.textureTattooIconNameUnEquip", strTattooIconName);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtTattooNameUnEquip", (GetSystemString(652) $ ": ") $ strTattooName);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtTattooAddNameUnEquip", strTattooAddName);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtDyeInfoUnEquip", GetSystemString(638));
            Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("HennaInfoWnd.textureDyeIconNameUnEquip", strDyeIconName);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtDyeNameUnEquip", strDyeName);
            col.R = 168;
            col.G = 168;
            col.B = 168;
            col.A = byte(255);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtFeeUnEquip", GetSystemString(637) $ " : ");
            Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtFeeUnEquip", col);
            strAdenaComma = MakeCostString("" $ string(iFee));
            col = GetNumericColor(strAdenaComma);
            col.A = byte(255);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtAdenaUnEquip", strAdenaComma);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtAdenaUnEquip", col);
            col.R = byte(255);
            col.G = byte(255);
            col.B = 0;
            col.A = byte(255);
            Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtAdenaStringUnEquip", GetSystemString(469));
            Class'NWindow.UIAPI_TEXTBOX'.static.SetTextColor("HennaInfoWnd.txtAdenaStringUnEquip", col);
        }
    }
    ApplyHennaTextColors();
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtSTRBefore", iSTRnow);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtSTRAfter", iSTRchange);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtDEXBefore", iDEXnow);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtDEXAfter", iDEXchange);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtCONBefore", iCONnow);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtCONAfter", iCONchange);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtINTBefore", iINTnow);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtINTAfter", iINTchange);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtWITBefore", iWITnow);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtWITAfter", iWITchange);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtMENBefore", iMENnow);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetInt("HennaInfoWnd.txtMENAfter", iMENchange);
    strAdenaComma = MakeCostString("" $ string(iAdena));
    col = GetNumericColor(strAdenaComma);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("HennaInfoWnd.txtHaveAdena", strAdenaComma);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetTooltipString("HennaInfoWnd.txtHaveAdena", ConvertNumToText("" $ string(iAdena)));
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("HennaListWnd");
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("HennaInfoWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd");
    return;
}

function SetFocus()
{
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtVariation");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtSTRString");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtDEXString");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtCONString");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtINTString");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtWITString");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtMENString");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtSTRBefore");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtArrow");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtSTRAfter");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtDEXBefore");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtArrow1");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtDEXAfter");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtCONBefore");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtArrow2");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtCONAfter");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtINTBefore");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtINTBefore");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtINTAfter");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtWITBefore");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtArrow3");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtWITAfter");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtMENBefore");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtArrow4");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtMENAfter");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.txtHaveAdena");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.btnPrev");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("HennaInfoWnd.btnOK");
    return;
}
