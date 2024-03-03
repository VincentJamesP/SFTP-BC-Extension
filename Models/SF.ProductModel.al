codeunit 70003 "SF.ProductModel" implements "SF.IModel"
{

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure ToJson(): Text
    begin
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure FromJson(inputJson: Text)
    begin
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure PopulateItemProps(ItemRow: Record Item; VariantCode: Code[10]; ProductLocation: Text): JsonObject;
    var
        ItemProperties: JsonObject;
        UnitPrice: Decimal;
        txtClass: Text;
        txtCAT: Text;
        recItemCategory: Record "Item Category";
        recItemCategory2: Record "Item Category";
        recProductBuffer: Record "SF.Product Buffer";
        recItemLedgEntry: Record "Item Ledger Entry";
        decQuantity: Decimal;
    begin
        UnitPrice := GetUnitPrice(ItemRow."No.", VariantCode);
        
        /*
        ItemProperties.Add('SKU', ItemRow."No.");
        ItemProperties.Add('ProductName', ItemRow.Description);
        ItemProperties.Add('VariantCode', VariantCode);
        ItemProperties.Add('Location', ProductLocation);
        ItemProperties.Add('Quantity', ItemRow.Inventory);
        ItemProperties.Add('UnitPrice', UnitPrice);
        ItemProperties.Add('UnitOfMeasureCode', ItemRow."Base Unit of Measure");
        */


        ItemProperties.Add('Description', ItemRow.Description);
        ItemProperties.Add('Short Description', ItemRow."Description 2");
        ItemProperties.Add('Discountable', 1); //Default
        
        
        ItemProperties.Add('SUBCAT', ItemRow."Item Category Code");
        
        recItemCategory.Reset();
        recItemCategory.SetRange(Code, ItemRow."Item Category Code");

        txtCAT := '';
        txtClass := '';

        if recItemCategory.FindFirst() then begin
          txtCAT := recItemCategory."Parent Category";

          recItemCategory2.Reset();
          recItemCategory2.SetRange(Code, txtCAT);

          if recItemCategory2.FindFirst() then
            txtClass := recItemCategory2."Parent Category";

        end;  
        
        ItemProperties.Add('CAT', txtCAT);
        ItemProperties.Add('CLASS', txtClass);
        ItemProperties.Add('UOM', ItemRow."Base Unit of Measure");
        ItemProperties.Add('RETAIL', UnitPrice);
        ItemProperties.Add('COST', ItemRow."Unit Cost");
        //ItemRow.CalcFields(Inventory);
        ItemProperties.Add('Quantity', ItemRow.Inventory);
        ItemProperties.Add('Bar Code', ItemRow."No.");
        ItemProperties.Add('Item No.', ItemRow."No.");
        ItemProperties.Add('Individual', 1); //Default
        If ItemRow.Blocked then
          ItemProperties.Add('Active', 0)
        else
          ItemProperties.Add('Active', 1);
        ItemProperties.Add('Location Code', ProductLocation);  


        //insert data to Product Buffer table
        recProductBuffer.Init();
        recProductBuffer.Description := ItemRow.Description;
        recProductBuffer."Short Description" := ItemRow."Description 2";
        recProductBuffer.Discountable := 1;
        recProductBuffer.CLASS := txtClass;
        recProductBuffer.CAT := txtCAT;
        recProductBuffer.SUBCAT := ItemRow."Item Category Code";
        recProductBuffer.UOM := ItemRow."Base Unit of Measure";

        recProductBuffer.RETAIL := UnitPrice;
        recProductBuffer.COST := ItemRow."Unit Cost";
        recProductBuffer.Quantity := ItemRow.Inventory;
        recProductBuffer."Bar Code" := ItemRow."No.";
        recProductBuffer."Item No." := ItemRow."No.";
        recProductBuffer.Individual := 1;
        If ItemRow.Blocked then
            recProductBuffer.Active := 0
        else
            recProductBuffer.Active := 1;
        recProductBuffer."Location Code" := ProductLocation;    
        recProductBuffer.Insert();


        exit(ItemProperties);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure GetUnitPrice(ItemNo: Text; VariantCode: Code[10]): Decimal;
    var
        ItemTable: Record Item;
        ProductType: Enum "Item Type";
        SalesPriceTable: Record "Sales Price";
        UnitPrice: Decimal;
        SalesType: Enum "Sales Price Type";
    begin
        // Set initial filters for sales price table
        SalesPriceTable.Reset();
        SalesPriceTable.SetRange("Item No.", ItemNo);
        SalesPriceTable.SetRange("Variant Code", VariantCode);
        SalesPriceTable.SetFilter("Starting Date", '<=%1', Today());
        SalesPriceTable.SetFilter("Ending Date", '>=%1', Today());
        if SalesPriceTable.FindSet() then begin
            // Check if sales type Campaign exist, if not reset filter
            SalesPriceTable.SetRange("Sales Type", SalesType::Campaign);
            if Not SalesPriceTable.FindFirst() then begin
                SalesPriceTable.SetRange("Sales Type");
            end;

            // Check if sales type filter is set if not then
            // Check sales type Customer exist, if not reset filter
            If SalesPriceTable.GetFilter("Sales Type") = '' then begin
                SalesPriceTable.SetRange("Sales Type", SalesType::Customer);
                if Not SalesPriceTable.FindFirst() then begin
                    SalesPriceTable.SetRange("Sales Type");
                end;
            end;

            // Check if sales type filter is set if not then
            // Check sales type Customer Price Group exist, if not reset filter
            If SalesPriceTable.GetFilter("Sales Type") = '' then begin
                SalesPriceTable.SetRange("Sales Type", SalesType::"Customer Price Group");
                if Not SalesPriceTable.FindFirst() then begin
                    SalesPriceTable.SetRange("Sales Type");
                end;
            end;

            // Check if sales type filter is set if not then
            // Check sales type All Customers exist, if not reset filter
            If SalesPriceTable.GetFilter("Sales Type") = '' then begin
                SalesPriceTable.SetRange("Sales Type", SalesType::"All Customers");
                if Not SalesPriceTable.FindFirst() then begin
                    SalesPriceTable.SetRange("Sales Type");
                end;
            end;

            UnitPrice := SalesPriceTable."Unit Price";
        end else begin
            // Filter Item Record using Item No.
            ItemTable.Reset();
            ItemTable.SetRange(Type, ProductType::Inventory);
            ItemTable.SetRange("No.", ItemNo);
            if ItemTable.FindFirst() then begin
                UnitPrice := ItemTable."Unit Price";
            end;
        end;
        exit(UnitPrice);
    end;

}
