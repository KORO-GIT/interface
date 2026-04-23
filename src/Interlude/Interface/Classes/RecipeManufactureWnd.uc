class RecipeManufactureWnd extends UIScript;

const RECIPEWND_MAX_MP_WIDTH = 165.0f;

var int m_RecipeID;
var int m_SuccessRate;
var int m_RecipeBookClass;
var int m_MaxMP;
var int m_PlayerID;

function OnLoad()
{
    RegisterEvent(840);
    RegisterEvent(210);
    RegisterEvent(2600);
    RegisterEvent(2610);
    return;
}

function OnEvent(int Event_ID, string param)
{
    local Rect rectWnd;
    local int ServerID, MPValue, RecipeID, currentMP, maxMP, MakingResult,
	    Type;

    // End:0x17C
    if(Event_ID == 840)
    {
        Class'NWindow.UIAPI_WINDOW'.static.HideWindow("RecipeBookWnd");
        Clear();
        rectWnd = Class'NWindow.UIAPI_WINDOW'.static.GetRect("RecipeBookWnd");
        Class'NWindow.UIAPI_WINDOW'.static.MoveTo("RecipeManufactureWnd", rectWnd.nX, rectWnd.nY);
        Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("RecipeManufactureWnd");
        Class'NWindow.UIAPI_WINDOW'.static.SetFocus("RecipeManufactureWnd");
        ParseInt(param, "RecipeID", RecipeID);
        ParseInt(param, "CurrentMP", currentMP);
        ParseInt(param, "MaxMP", maxMP);
        ParseInt(param, "MakingResult", MakingResult);
        ParseInt(param, "Type", Type);
        ReceiveRecipeItemMakeInfo(RecipeID, currentMP, maxMP, MakingResult, Type);        
    }
    else
    {
        // End:0x1E7
        if(Event_ID == 210)
        {
            ParseInt(param, "ServerID", ServerID);
            ParseInt(param, "CurrentMP", MPValue);
            // End:0x1E4
            if((m_PlayerID == ServerID) && m_PlayerID > 0)
            {
                SetMPBar(MPValue);
            }            
        }
        else
        {
            // End:0x212
            if((Event_ID == 2600) || Event_ID == 2610)
            {
                HandleInventoryItem(param);
            }
        }
    }
    return;
}

function OnClickButton(string strID)
{
    local string param;

    switch(strID)
    {
        // End:0x1D
        case "btnClose":
            CloseWindow();
            // End:0x115
            break;
        // End:0x46
        case "btnPrev":
            Class'NWindow.RecipeAPI'.static.RequestRecipeBookOpen(m_RecipeBookClass);
            CloseWindow();
            // End:0x115
            break;
        // End:0xE8
        case "btnRecipeTree":
            // End:0x9A
            if(Class'NWindow.UIAPI_WINDOW'.static.IsShowWindow("RecipeTreeWnd"))
            {
                Class'NWindow.UIAPI_WINDOW'.static.HideWindow("RecipeTreeWnd");                
            }
            else
            {
                ParamAdd(param, "RecipeID", string(m_RecipeID));
                ParamAdd(param, "SuccessRate", string(m_SuccessRate));
                ExecuteEvent(810, param);
            }
            // End:0x115
            break;
        // End:0x112
        case "btnManufacture":
            Class'NWindow.RecipeAPI'.static.RequestRecipeItemMakeSelf(m_RecipeID);
            // End:0x115
            break;
        // End:0xFFFF
        default:
            break;
    }
    return;
}

function CloseWindow()
{
    Clear();
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("RecipeManufactureWnd");
    PlayConsoleSound(IFST_WINDOW_CLOSE);
    return;
}

function Clear()
{
    m_RecipeID = 0;
    m_SuccessRate = 0;
    m_RecipeBookClass = 0;
    m_MaxMP = 0;
    m_PlayerID = 0;
    Class'NWindow.UIAPI_ITEMWINDOW'.static.Clear("RecipeManufactureWnd.ItemWnd");
    return;
}

function ReceiveRecipeItemMakeInfo(int RecipeID, int currentMP, int maxMP, int MakingResult, int Type)
{
    local int i;
    local string strTmp;
    local int nTmp, ProductID, ProductNum;
    local string ItemName;
    local ParamStack param;
    local ItemInfo infItem;

    m_RecipeID = RecipeID;
    m_SuccessRate = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeSuccessRate(RecipeID);
    m_RecipeBookClass = Type;
    m_MaxMP = maxMP;
    m_PlayerID = Class'NWindow.UIDATA_PLAYER'.static.GetPlayerID();
    ProductID = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeProductID(RecipeID);
    strTmp = Class'NWindow.UIDATA_ITEM'.static.GetItemTextureName(ProductID);
    Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("RecipeManufactureWnd.texItem", strTmp);
    ItemName = MakeFullItemName(ProductID);
    nTmp = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeCrystalType(RecipeID);
    strTmp = GetItemGradeString(nTmp);
    // End:0x114
    if(Len(strTmp) > 0)
    {
        strTmp = ("`" $ strTmp) $ "`";
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeManufactureWnd.txtName", (ItemName $ " ") $ strTmp);
    nTmp = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeMpConsume(RecipeID);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeManufactureWnd.txtMPConsume", "" $ string(nTmp));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeManufactureWnd.txtSuccessRate", string(m_SuccessRate) $ "%");
    ProductNum = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeProductNum(RecipeID);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeManufactureWnd.txtResultValue", "" $ string(ProductNum));
    SetMPBar(currentMP);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeManufactureWnd.txtCountValue", "" $ string(GetInventoryItemCount(ProductID)));
    strTmp = "";
    // End:0x2C5
    if(MakingResult == 0)
    {
        strTmp = MakeFullSystemMsg(GetSystemMessage(960), ItemName, "");        
    }
    else
    {
        // End:0x2F7
        if(MakingResult == 1)
        {
            strTmp = MakeFullSystemMsg(GetSystemMessage(959), ItemName, "" $ string(ProductNum));
        }
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeManufactureWnd.txtMsg", strTmp);
    param = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeMaterialItem(RecipeID);
    nTmp = param.GetInt();
    i = 0;

    while(i < nTmp)
    {
        infItem.ClassID = param.GetInt();
        infItem.Reserved = param.GetInt();
        infItem.Name = Class'NWindow.UIDATA_ITEM'.static.GetItemName(infItem.ClassID);
        infItem.AdditionalName = Class'NWindow.UIDATA_ITEM'.static.GetItemAdditionalName(infItem.ClassID);
        infItem.IconName = Class'NWindow.UIDATA_ITEM'.static.GetItemTextureName(infItem.ClassID);
        infItem.Description = Class'NWindow.UIDATA_ITEM'.static.GetItemDescription(infItem.ClassID);
        infItem.ItemNum = GetInventoryItemCount(infItem.ClassID);
        // End:0x475
        if(infItem.Reserved > infItem.ItemNum)
        {
            infItem.bDisabled = true;            
        }
        else
        {
            infItem.bDisabled = false;
        }
        Class'NWindow.UIAPI_ITEMWINDOW'.static.AddItem("RecipeManufactureWnd.ItemWnd", infItem);
        i++;
    }
    return;
}

function SetMPBar(int currentMP)
{
    local int nTmp, nMPWidth;

    nTmp = 165 * currentMP;
    nMPWidth = nTmp / m_MaxMP;
    // End:0x3A
    if(float(nMPWidth) > 165.0000000)
    {
        nMPWidth = 165;
    }
    Class'NWindow.UIAPI_WINDOW'.static.SetWindowSize("RecipeManufactureWnd.texMPBar", nMPWidth, 12);
    return;
}

function HandleInventoryItem(string param)
{
    local int ClassID, idx;
    local ItemInfo infItem;

    // End:0x122
    if(ParseInt(param, "classID", ClassID))
    {
        idx = Class'NWindow.UIAPI_ITEMWINDOW'.static.FindItemWithClassID("RecipeManufactureWnd.ItemWnd", ClassID);
        // End:0x122
        if(idx > -1)
        {
            Class'NWindow.UIAPI_ITEMWINDOW'.static.GetItem("RecipeManufactureWnd.ItemWnd", idx, infItem);
            infItem.ItemNum = GetInventoryItemCount(infItem.ClassID);
            // End:0xDE
            if(infItem.Reserved > infItem.ItemNum)
            {
                infItem.bDisabled = true;                
            }
            else
            {
                infItem.bDisabled = false;
            }
            Class'NWindow.UIAPI_ITEMWINDOW'.static.SetItem("RecipeManufactureWnd.ItemWnd", idx, infItem);
        }
    }
    return;
}
