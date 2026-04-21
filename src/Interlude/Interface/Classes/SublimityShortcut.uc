class SublimityShortcut extends SublimityItem;

struct Bind
{
    var int nMainKey;
    var int nSubKey1;
    var int nSubKey2;
};

var int m_KeyState[256];
var string BindName[256];
var string KeyName[256];
var int LastMainKey;
var int CurSubKey1;
var int CurSubKey2;

function OnLoad()
{
    RegisterEvent(25002);
    LastMainKey = -1;
    return;
}

function OnKeyboardEvent(int a_Key, int a_State)
{
    return;
}

function bool IsSubKey(int a_Key)
{
    return ((a_Key == 16) || a_Key == 17) || a_Key == 18;
}
