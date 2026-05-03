class RecipeTreeWnd extends UICommonAPI;

const RECIPE_TREE_MAX_MATERIAL_COUNT = 64;

function int ClampRecipeMaterialCount(int Count)
{
    if(Count < 0)
    {
        return 0;
    }
    if(Count > RECIPE_TREE_MAX_MATERIAL_COUNT)
    {
        return RECIPE_TREE_MAX_MATERIAL_COUNT;
    }
    return Count;
}

function OnLoad()
{
    RegisterEvent(810);
    return;
}

function OnEvent(int Event_ID, string param)
{
    local int RecipeID, SuccessRate;

    // End:0x56
    if(Event_ID == 810)
    {
        ParseInt(param, "RecipeID", RecipeID);
        ParseInt(param, "SuccessRate", SuccessRate);
        StartRecipeTreeWnd(RecipeID, SuccessRate);
    }
    return;
}

function OnClickButton(string strID)
{
    switch(strID)
    {
        // End:0x1D
        case "btnClose":
            CloseWindow();
            // End:0x20
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
    Class'NWindow.UIAPI_WINDOW'.static.HideWindow("RecipeTreeWnd");
    PlayConsoleSound(IFST_WINDOW_CLOSE);
    return;
}

function Clear()
{
    Class'NWindow.UIAPI_TREECTRL'.static.Clear("RecipeTreeWnd.MainTree");
    return;
}

function StartRecipeTreeWnd(int RecipeID, int SuccessRate)
{
    Class'NWindow.UIAPI_WINDOW'.static.ShowWindow("RecipeTreeWnd");
    Class'NWindow.UIAPI_WINDOW'.static.SetFocus("RecipeTreeWnd");
    Clear();
    SetRecipeInfo(RecipeID, SuccessRate);
    return;
}

function SetRecipeInfo(int RecipeID, int SuccessRate)
{
    local string strTmp, strTmp2;
    local int nTmp;
    local XMLTreeNodeInfo infNode;
    local int ProductID;

    strTmp = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeIconName(RecipeID);
    // End:0x55
    if(Len(strTmp) > 0)
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("RecipeTreeWnd.texIcon", strTmp);        
    }
    else
    {
        Class'NWindow.UIAPI_TEXTURECTRL'.static.SetTexture("RecipeTreeWnd.texIcon", "Default.BlackTexture");
    }
    ProductID = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeProductID(RecipeID);
    strTmp = MakeFullItemName(ProductID);
    nTmp = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeCrystalType(RecipeID);
    strTmp2 = GetItemGradeString(nTmp);
    // End:0x109
    if(Len(strTmp2) > 0)
    {
        strTmp2 = ("`" $ strTmp2) $ "`";
    }
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeTreeWnd.txtName", (strTmp $ " ") $ strTmp2);
    nTmp = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeMpConsume(RecipeID);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeTreeWnd.txtMPConsume", "" $ string(nTmp));
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeTreeWnd.txtSuccessRate", string(SuccessRate) $ "%");
    nTmp = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeLevel(RecipeID);
    Class'NWindow.UIAPI_TEXTBOX'.static.SetText("RecipeTreeWnd.txtLevel", "Lv." $ string(nTmp));
    infNode.strName = "root";
    infNode.nOffSetX = 1;
    infNode.nOffSetY = 5;
    strTmp = Class'NWindow.UIAPI_TREECTRL'.static.InsertNode("RecipeTreeWnd.MainTree", "", infNode);
    // End:0x2BE
    if(Len(strTmp) < 1)
    {
        Debug("ERROR: Can't insert root node. Name: " $ infNode.strName);
        return;
    }
    AddRecipeItem(ProductID, SuccessRate, 0, "root");
    return;
}

function AddRecipeItem(int ProductID, int SuccessRate, int NeedCount, string NodeName)
{
    local int i;
    local ParamStack param;
    local int nTmp;
    local string strTmp, strTmp2;
    local int nMax;
    local bool bIamRoot;
    local array<int> arrMatID, arrMatRate, arrMatNeedCount;
    local XMLTreeNodeInfo infNode;
    local XMLTreeNodeItemInfo infNodeItem;
    local XMLTreeNodeInfo infNodeClear;
    local XMLTreeNodeItemInfo infNodeItemClear;
    local string strRetName;

    strTmp = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeNameBy2Condition(ProductID, SuccessRate);
    // End:0x6CA
    if(Len(strTmp) > 0)
    {
        // End:0x47
        if(NodeName == "root")
        {
            bIamRoot = true;            
        }
        else
        {
            bIamRoot = false;
        }
        infNode = infNodeClear;
        infNode.strName = (("" $ string(ProductID)) $ "_") $ string(SuccessRate);
        infNode.ToolTip = MakeTooltipSimpleText(strTmp);
        infNode.bFollowCursor = true;
        // End:0xB9
        if(!bIamRoot)
        {
            infNode.nOffSetX = 16;
        }
        infNode.bShowButton = 1;
        infNode.nTexBtnWidth = 12;
        infNode.nTexBtnHeight = 12;
        infNode.nTexBtnOffSetY = 10;
        infNode.strTexBtnExpand = "L2UI.RecipeWnd.TreePlus";
        infNode.strTexBtnCollapse = "L2UI.RecipeWnd.TreeMinus";
        strRetName = Class'NWindow.UIAPI_TREECTRL'.static.InsertNode("RecipeTreeWnd.MainTree", NodeName, infNode);
        // End:0x1AB
        if(Len(strRetName) < 1)
        {
            Log("ERROR: Can't insert node. Name: " $ infNode.strName);
            return;
        }
        strTmp2 = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeIconNameBy2Condition(ProductID, SuccessRate);
        // End:0x1F3
        if(Len(strTmp2) < 1)
        {
            strTmp2 = "Default.BlackTexture";
        }
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_TEXTURE;
        infNodeItem.nOffSetX = 2;
        infNodeItem.nOffSetY = 0;
        infNodeItem.u_nTextureWidth = 32;
        infNodeItem.u_nTextureHeight = 32;
        infNodeItem.u_strTexture = strTmp2;
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_TEXTURE;
        infNodeItem.nOffSetX = -32;
        infNodeItem.nOffSetY = 0;
        infNodeItem.u_nTextureWidth = 32;
        infNodeItem.u_nTextureHeight = 32;
        infNodeItem.u_strTexture = "L2UI.RecipeWnd.RecipeTreeIconBack";
        infNodeItem.u_strTextureExpanded = "L2UI.RecipeWnd.RecipeTreeIconBack_click";
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        // End:0x427
        if(!bIamRoot)
        {
            nTmp = GetInventoryItemCount(ProductID);
            // End:0x427
            if(nTmp < NeedCount)
            {
                infNodeItem = infNodeItemClear;
                infNodeItem.eType = XTNITEM_TEXTURE;
                infNodeItem.nOffSetX = -32;
                infNodeItem.nOffSetY = 0;
                infNodeItem.u_nTextureWidth = 32;
                infNodeItem.u_nTextureHeight = 32;
                infNodeItem.u_strTexture = "Default.ChatBack";
                Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
            }
        }
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_TEXT;
        infNodeItem.t_strText = strTmp;
        infNodeItem.t_bDrawOneLine = true;
        infNodeItem.nOffSetX = 5;
        infNodeItem.nOffSetY = 4;
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        // End:0x54F
        if(!bIamRoot)
        {
            infNodeItem = infNodeItemClear;
            infNodeItem.eType = XTNITEM_TEXT;
            infNodeItem.t_strText = ((("(" $ string(nTmp)) $ "/") $ string(NeedCount)) $ ")";
            infNodeItem.bLineBreak = true;
            infNodeItem.nOffSetX = 51;
            infNodeItem.nOffSetY = -14;
            Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        }
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_BLANK;
        infNodeItem.bStopMouseFocus = true;
        infNodeItem.b_nHeight = 6;
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        param = Class'NWindow.UIDATA_RECIPE'.static.GetRecipeMaterialItemBy2Condition(ProductID, SuccessRate);
        nMax = param.GetInt();
        nMax = ClampRecipeMaterialCount(nMax);
        arrMatID.Length = nMax;
        arrMatRate.Length = nMax;
        arrMatNeedCount.Length = nMax;
        i = 0;

        while(i < nMax)
        {
            arrMatID[i] = param.GetInt();
            arrMatRate[i] = param.GetInt();
            arrMatNeedCount[i] = param.GetInt();
            i++;
        }
        i = 0;

        while(i < nMax)
        {
            AddRecipeItem(arrMatID[i], arrMatRate[i], arrMatNeedCount[i], strRetName);
            i++;
        }        
    }
    else
    {
        strTmp = Class'NWindow.UIDATA_ITEM'.static.GetItemName(ProductID);
        infNode = infNodeClear;
        infNode.strName = (("" $ string(ProductID)) $ "_") $ string(SuccessRate);
        infNode.nOffSetX = 30;
        infNode.ToolTip = MakeTooltipSimpleText(strTmp);
        infNode.bFollowCursor = true;
        infNode.bShowButton = 0;
        strRetName = Class'NWindow.UIAPI_TREECTRL'.static.InsertNode("RecipeTreeWnd.MainTree", NodeName, infNode);
        // End:0x7C5
        if(Len(strRetName) < 1)
        {
            Log("ERROR: Can't insert node. Name: " $ infNode.strName);
            return;
        }
        strTmp2 = Class'NWindow.UIDATA_ITEM'.static.GetItemTextureName(ProductID);
        // End:0x808
        if(Len(strTmp2) < 1)
        {
            strTmp2 = "Default.BlackTexture";
        }
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_TEXTURE;
        infNodeItem.nOffSetX = 0;
        infNodeItem.nOffSetY = 0;
        infNodeItem.u_nTextureWidth = 32;
        infNodeItem.u_nTextureHeight = 32;
        infNodeItem.u_strTexture = strTmp2;
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_TEXTURE;
        infNodeItem.nOffSetX = -32;
        infNodeItem.nOffSetY = 0;
        infNodeItem.u_nTextureWidth = 32;
        infNodeItem.u_nTextureHeight = 32;
        infNodeItem.u_strTexture = "L2UI.RecipeWnd.RecipeTreeIconDisableBack";
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        nTmp = GetInventoryItemCount(ProductID);
        // End:0xA03
        if(nTmp < NeedCount)
        {
            infNodeItem = infNodeItemClear;
            infNodeItem.eType = XTNITEM_TEXTURE;
            infNodeItem.nOffSetX = -32;
            infNodeItem.nOffSetY = 0;
            infNodeItem.u_nTextureWidth = 32;
            infNodeItem.u_nTextureHeight = 32;
            infNodeItem.u_strTexture = "Default.ChatBack";
            Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        }
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_TEXT;
        infNodeItem.t_strText = strTmp;
        infNodeItem.t_bDrawOneLine = true;
        infNodeItem.nOffSetX = 5;
        infNodeItem.nOffSetY = 3;
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_TEXT;
        infNodeItem.t_strText = ((("(" $ string(nTmp)) $ "/") $ string(NeedCount)) $ ")";
        infNodeItem.bLineBreak = true;
        infNodeItem.nOffSetX = 37;
        infNodeItem.nOffSetY = -14;
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
        infNodeItem = infNodeItemClear;
        infNodeItem.eType = XTNITEM_BLANK;
        infNodeItem.bStopMouseFocus = true;
        infNodeItem.b_nHeight = 4;
        Class'NWindow.UIAPI_TREECTRL'.static.InsertNodeItem("RecipeTreeWnd.MainTree", strRetName, infNodeItem);
    }
    return;
}
