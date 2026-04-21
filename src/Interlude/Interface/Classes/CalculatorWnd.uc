class CalculatorWnd extends UICommonAPI;

const STATE_INSERT_OP1 = 0;
const STATE_OP1 = 1;
const STATE_OP = 2;
const STATE_INSERT_OP2 = 3;
const OP_PLUS = 0;
const OP_MINUS = 1;
const OP_MULTIPLY = 2;
const OP_DIVIDE = 3;
const OP_EQUAL = 4;

var int m_iState;
var float m_fOperand1;
var int m_nOperator;

function OnLoad()
{
    RegisterEvent(1700);
    return;
}

function OnShow()
{
    InitCalculator();
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("CalculatorWnd.editBoxCalculate");
    return;
}

function Clear()
{
    Class'NWindow.UIAPI_EDITBOX'.static.Clear("CalculatorWnd.editBoxCalculate");
    return;
}

function InitCalculator()
{
    m_fOperand1 = 0.0000000;
    m_nOperator = -1;
    SetState(1);
    AddNum(0.0000000);
    return;
}

function CE()
{
    Clear();
    SetString("0");
    return;
}

function SetState(int iState)
{
    m_iState = iState;
    return;
}

function SetOperand1(string Str)
{
    // End:0x1D
    if(Len(Str) > 0)
    {
        m_fOperand1 = float(Str);        
    }
    else
    {
        m_fOperand1 = 0.0000000;
    }
    return;
}

function SetOperator(int Op)
{
    m_nOperator = Op;
    return;
}

function AddString(string Str)
{
    local string strTempGet, strTempResult;

    strTempGet = GetString();
    strTempResult = (strTempGet $ "") $ Str;
    Class'NWindow.UIAPI_EDITBOX'.static.SetString("CalculatorWnd.editBoxCalculate", strTempResult);
    return;
}

function SetString(string Str)
{
    Class'NWindow.UIAPI_EDITBOX'.static.SetString("CalculatorWnd.editBoxCalculate", Str);
    return;
}

function string GetString()
{
    local string strTemp;

    strTemp = Class'NWindow.UIAPI_EDITBOX'.static.GetString("CalculatorWnd.editBoxCalculate");
    return strTemp;
}

function float GetOperand()
{
    local string Str;

    Str = GetString();
    // End:0x24
    if(Len(Str) > 0)
    {
        return float(Str);        
    }
    else
    {
        return 0.0000000;
    }
    return 0.0;
}

function AddNum(float Num)
{
    local string strTemp;

    Clear();
    AddString((strTemp $ "") $ string(int(Num)));
    return;
}

function float Calc(float A, float B, int Op)
{
    switch(Op)
    {
        // End:0x15
        case -1:
            return B;
        // End:0x26
        case 0:
            return A + B;
        // End:0x37
        case 1:
            return A - B;
        // End:0x49
        case 2:
            return A * B;
        // End:0x6E
        case 3:
            // End:0x61
            if(B == float(0))
            {
                return 0.0000000;
            }
            return A / B;
        // End:0xFFFF
        default:
            return 0.0000000;
            break;
    }
    return 0.0;
}

function bool ExecOverFlow(float A, float B, int Op, float Result)
{
    switch(Op)
    {
        // End:0x0B
        case 0:
        // End:0x57
        case 2:
            // End:0x54
            if(((A > float(0)) && B > float(0)) && (Result < float(0)) || Result > 100000000000000000000.0000000)
            {
                InitCalculator();
                return true;
            }
            // End:0x66
            break;
        // End:0x5B
        case 1:
        // End:0x63
        case 3:
            // End:0x66
            break;
        // End:0xFFFF
        default:
            break;
    }
    return false;
}

function BackSpace()
{
    local string strTemp, strResult;
    local int iLength;

    strTemp = GetString();
    iLength = Len(strTemp) - 1;
    // End:0x47
    if(iLength > 0)
    {
        strResult = Left(strTemp, iLength);
        SetString(strResult);        
    }
    else
    {
        CE();
    }
    return;
}

function OnEvent(int Event_ID, string param)
{
    switch(Event_ID)
    {
        // End:0x27
        case 1700:
            ShowWindowWithFocus("CalculatorWnd");
            // End:0x2A
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function ProcessBtn(int iValue)
{
    local int iTemp;
    local string strTemp, strTemp2;
    local float Result, fTmp;
    local string strTmp3, strTempGet;

    strTempGet = GetString();
    // End:0x1C
    if(Len(strTempGet) > 24)
    {
        return;
    }
    // End:0x30
    if(iValue == 13)
    {
        iValue = 61;
    }
    // End:0x119
    if((iValue >= 48) && iValue <= 57)
    {
        // End:0x83
        if((m_iState == 0) || m_iState == 3)
        {
            // End:0x83
            if((GetString()) == "0")
            {
                // End:0x83
                if(iValue != 48)
                {
                    Clear();
                }
            }
        }
        // End:0x9E
        if(m_iState == 1)
        {
            Clear();
            SetState(0);            
        }
        else
        {
            // End:0xC4
            if(m_iState == 2)
            {
                SetOperand1(GetString());
                Clear();
                SetState(3);
            }
        }
        strTemp = GetString();
        iTemp = iValue - 48;
        strTemp2 = "" $ string(iTemp);
        // End:0x10B
        if(Len(strTemp) > 0)
        {
            AddString(strTemp2);            
        }
        else
        {
            SetString(strTemp2);
        }        
    }
    else
    {
        // End:0x283
        if(((((iValue == 42) || iValue == 43) || iValue == 45) || iValue == 47) || iValue == 61)
        {
            // End:0x173
            if(m_iState == 1)
            {
                SetState(2);                
            }
            else
            {
                // End:0x195
                if(m_iState == 0)
                {
                    SetOperand1(GetString());
                    SetState(2);                    
                }
                else
                {
                    // End:0x1FF
                    if(m_iState == 3)
                    {
                        Result = Calc(m_fOperand1, GetOperand(), m_nOperator);
                        // End:0x1FC
                        if(!ExecOverFlow(m_fOperand1, GetOperand(), m_nOperator, Result))
                        {
                            SetOperand1(GetString());
                            AddNum(Result);
                            SetState(2);
                        }                        
                    }
                    else
                    {
                        // End:0x283
                        if((m_iState == 2) && iValue == 61)
                        {
                            fTmp = GetOperand();
                            Result = Calc(fTmp, m_fOperand1, m_nOperator);
                            // End:0x283
                            if(!ExecOverFlow(fTmp, m_fOperand1, m_nOperator, Result))
                            {
                                strTmp3 = "" $ string(int(Result));
                                Clear();
                                AddString(strTmp3);
                            }
                        }
                    }
                }
            }
        }
        // End:0x29A
        if(iValue == 42)
        {
            SetOperator(2);            
        }
        else
        {
            // End:0x2B0
            if(iValue == 43)
            {
                SetOperator(0);                
            }
            else
            {
                // End:0x2C6
                if(iValue == 45)
                {
                    SetOperator(1);                    
                }
                else
                {
                    // End:0x2DD
                    if(iValue == 47)
                    {
                        SetOperator(3);                        
                    }
                    else
                    {
                        // End:0x2E9
                        if(iValue == 61)
                        {
                        }
                    }
                }
            }
        }
    }
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1B
        case "btn7":
            ProcessBtn(55);
            // End:0x1C2
            break;
        // End:0x2F
        case "btn8":
            ProcessBtn(56);
            // End:0x1C2
            break;
        // End:0x43
        case "btn9":
            ProcessBtn(57);
            // End:0x1C2
            break;
        // End:0x59
        case "btnAdd":
            ProcessBtn(43);
            // End:0x1C2
            break;
        // End:0x6C
        case "btnCE":
            CE();
            // End:0x1C2
            break;
        // End:0x80
        case "btn4":
            ProcessBtn(52);
            // End:0x1C2
            break;
        // End:0x94
        case "btn5":
            ProcessBtn(53);
            // End:0x1C2
            break;
        // End:0xA8
        case "btn6":
            ProcessBtn(54);
            // End:0x1C2
            break;
        // End:0xBE
        case "btnSub":
            ProcessBtn(45);
            // End:0x1C2
            break;
        // End:0xD0
        case "btnC":
            InitCalculator();
            // End:0x1C2
            break;
        // End:0xE4
        case "btn1":
            ProcessBtn(49);
            // End:0x1C2
            break;
        // End:0xF8
        case "btn2":
            ProcessBtn(50);
            // End:0x1C2
            break;
        // End:0x10C
        case "btn3":
            ProcessBtn(51);
            // End:0x1C2
            break;
        // End:0x122
        case "btnMul":
            ProcessBtn(42);
            // End:0x1C2
            break;
        // End:0x135
        case "btnBS":
            BackSpace();
            // End:0x1C2
            break;
        // End:0x149
        case "btn0":
            ProcessBtn(48);
            // End:0x1C2
            break;
        // End:0x166
        case "btn00":
            ProcessBtn(48);
            ProcessBtn(48);
            // End:0x1C2
            break;
        // End:0x17C
        case "btnDiv":
            ProcessBtn(47);
            // End:0x1C2
            break;
        // End:0x191
        case "btnEQ":
            ProcessBtn(61);
            // End:0x1C2
            break;
        // End:0x1BF
        case "btnClose":
            Class'NWindow.UIAPI_WINDOW'.static.HideWindow("CalculatorWnd");
            // End:0x1C2
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}
