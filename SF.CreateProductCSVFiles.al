codeunit 70009 "SF.CreateProductCSVFiles"
{
    trigger OnRun()
    
    begin
        
        recSFTPSetup.Get();

        recLocation.Reset();
        recLocation.SetRange("Use As In-Transit", false);
        
        If recSFTPSetup."Location Filter" <> '' then
          recLocation.SetFilter(Code, recSFTPSetup."Location Filter");

        if recLocation.Findset() then repeat            
            
            clear(sourceData);
            clear(ProductItems);
            clear(Result);
            clear(TempBlob);
            clear(Instr);
            clear(Outstr);

            recProductBuffer.DeleteAll(); 

            txtJSONQueryString := '[{"Store": "' + recLocation.Code + '"}]';
            sourceData := cduHelperModel.MapToJsonArray(txtJSONQueryString);
            ProductItems := cduProductDomain.GetProductsByLocation(sourceData);
            ProductItems.WriteTo(Result);

            //Create CSV File
            Clear(cduExportData);
            cduExportData.ExportProductEntries(recProductBuffer, recLocation.Code);
            
        until recLocation.Next() = 0;

    end;
    
    var
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        Outstr: OutStream;
        Filename: Text;
        Result: Text;
        Object: JsonObject;
        cduProductModel: Codeunit "SF.ProductModel";
        recItem: Record Item;
        ProductItems: JsonArray;

        cduProductDomain: Codeunit "SF.ProductDomain";

        sourceData: JsonArray;

        cduHelperModel: Codeunit "SF.HelperModel";

        recLocation: Record "Location";

        txtJSONQueryString: Text;

        cduExportData: Codeunit "SF.ExportData";

        recProductBuffer: Record "SF.Product Buffer";

        recSFTPSetup: Record "SF.SFTP Setup";
}
