class InterfaceAI_StartMainWnd extends UICommonAPI;

var WindowHandle Me;
var WindowHandle m_hMainWnd;

function OnLoad()
{
    RegisterEvent(150);
    Me = GetHandle("InterfaceAI_StartMainWnd");
    m_hMainWnd = GetHandle("InterfaceAI_MainWnd");
    return;
}

function OnEvent(int a_EventID, string a_Param)
{
    switch(a_EventID)
    {
        // End:0x1E
        case 150:
            Me.ShowWindow();
            // End:0x21
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x55
        case "btnStartInterfaceAI":
            // End:0x43
            if(m_hMainWnd.IsShowWindow())
            {
                m_hMainWnd.HideWindow();                
            }
            else
            {
                m_hMainWnd.ShowWindow();
            }
            // End:0x58
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}
