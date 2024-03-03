codeunit 70010 "SF.ExportData"
{
    procedure ExportProductEntries(var paramProduct: Record "SF.Product Buffer"; paramStore: Code[10])

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ExcelFileName: Label 'Product - %1 - %2';
        TempCSVBuffer: Record "CSV Buffer" temporary;
        TempBlob: Codeunit "Temp Blob";
        LineNo: Integer;
        InStr: InStream;
        OutStr: OutStream;
        Result: Text;
        CSVFileNameLbl: Label '%1 - %2';
        CSVFIleName: Text;
        FileMgt: Codeunit "File Management";
        cduSFTPWebServiceDomain: Codeunit "SF.SFTP Webservice Domain";
        recProductBuffer: Record "SF.Product Buffer";
    begin 
        
        /*
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Short Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Discountable', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('CLASS', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('CAT', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('SUBCAT', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('UOM', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('RETAIL', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('COST', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('Quantity', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('Bar Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Item No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Individual', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('Active', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);


        if paramProduct.FindSet() then repeat
            TempExcelBuffer.NewRow();
            TempExcelBuffer.AddColumn(paramProduct.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(paramProduct."Short Description", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(paramProduct.Discountable, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            TempExcelBuffer.AddColumn(paramProduct.CLASS, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(paramProduct.CAT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(paramProduct.SUBCAT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(paramProduct.UOM, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(paramProduct.RETAIL, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            TempExcelBuffer.AddColumn(paramProduct.COST, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            TempExcelBuffer.AddColumn(paramProduct.Quantity, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            TempExcelBuffer.AddColumn(paramProduct."Bar Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(paramProduct.UOM, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(paramProduct.Individual, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            TempExcelBuffer.AddColumn(paramProduct.Active, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            TempExcelBuffer.AddColumn(paramProduct."Location Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        until paramProduct.Next() = 0;

        TempExcelBuffer.CreateNewBook('POLL51' + FORMAT(Today, 0, '<DAY,2>-<MONTH,2>'));
        TempExcelBuffer.WriteSheet('POLL51' + FORMAT(Today, 0, '<DAY,2>-<MONTH,2>'), CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, paramStore, CurrentDateTime));
        TempExcelBuffer.OpenExcel();
        */

        

        TempCSVBuffer.Reset();
        TempCSVBuffer.DeleteAll();
        clear(TempBlob);
        Clear(InStr);
        clear(OutStr);
        clear(Result);

        recProductBuffer.Reset();
        //Message('Product Buffer Record Count is %1', recProductBuffer.Count);

        LineNo := 0;
              TempCSVBuffer.InsertEntry(LineNo, 1, '');
              TempCSVBuffer.InsertEntry(LineNo, 2, '');
              TempCSVBuffer.InsertEntry(LineNo, 3, '');
              TempCSVBuffer.InsertEntry(LineNo, 4, '');
              TempCSVBuffer.InsertEntry(LineNo, 5, '');
              TempCSVBuffer.InsertEntry(LineNo, 6, '');
              TempCSVBuffer.InsertEntry(LineNo, 7, '');
              TempCSVBuffer.InsertEntry(LineNo, 8, '');
              TempCSVBuffer.InsertEntry(LineNo, 9, '');
              TempCSVBuffer.InsertEntry(LineNo, 10, '');
              TempCSVBuffer.InsertEntry(LineNo, 11, '');
              TempCSVBuffer.InsertEntry(LineNo, 12, '');
              TempCSVBuffer.InsertEntry(LineNo, 13, '');
              TempCSVBuffer.InsertEntry(LineNo, 14, '');
              TempCSVBuffer.InsertEntry(LineNo, 15, '');


              LineNo := 1;
              TempCSVBuffer.InsertEntry(LineNo, 1, 'Description');
              TempCSVBuffer.InsertEntry(LineNo, 2, 'Short Description');
              TempCSVBuffer.InsertEntry(LineNo, 3, 'Discountable');
              TempCSVBuffer.InsertEntry(LineNo, 4, 'CLASS');
              TempCSVBuffer.InsertEntry(LineNo, 5, 'CAT');
              TempCSVBuffer.InsertEntry(LineNo, 6, 'SUBCAT');
              TempCSVBuffer.InsertEntry(LineNo, 7, 'UOM');
              TempCSVBuffer.InsertEntry(LineNo, 8, 'RETAIL');
              TempCSVBuffer.InsertEntry(LineNo, 9, 'COST');
              TempCSVBuffer.InsertEntry(LineNo, 10, 'Quantity');
              TempCSVBuffer.InsertEntry(LineNo, 11, 'Bar Code');
              TempCSVBuffer.InsertEntry(LineNo, 12, 'Item No.');
              TempCSVBuffer.InsertEntry(LineNo, 13, 'Individual');
              TempCSVBuffer.InsertEntry(LineNo, 14, 'Active');
              TempCSVBuffer.InsertEntry(LineNo, 15, 'Location Code');

        if recProductBuffer.FindSet() then repeat

              LineNo += 1;                    
              TempCSVBuffer.InsertEntry(LineNo, 1, recProductBuffer.Description);
              TempCSVBuffer.InsertEntry(LineNo, 2, recProductBuffer."Short Description");
              TempCSVBuffer.InsertEntry(LineNo, 3, FORMAT(recProductBuffer.Discountable));
              TempCSVBuffer.InsertEntry(LineNo, 4, recProductBuffer.CLASS);
              TempCSVBuffer.InsertEntry(LineNo, 5, recProductBuffer.CAT);
              TempCSVBuffer.InsertEntry(LineNo, 6, recProductBuffer.SUBCAT);
              TempCSVBuffer.InsertEntry(LineNo, 7, recProductBuffer.UOM);
              TempCSVBuffer.InsertEntry(LineNo, 8, DELCHR(FORMAT(recProductBuffer.RETAIL),'=',','));
              TempCSVBuffer.InsertEntry(LineNo, 9, DELCHR(FORMAT(recProductBuffer.COST),'=',','));
              TempCSVBuffer.InsertEntry(LineNo, 10, DELCHR(FORMAT(recProductBuffer.Quantity),'=',','));
              TempCSVBuffer.InsertEntry(LineNo, 11, recProductBuffer."Bar Code");
              TempCSVBuffer.InsertEntry(LineNo, 12, recProductBuffer."Item No.");
              TempCSVBuffer.InsertEntry(LineNo, 13, FORMAT(recProductBuffer.Individual));
              TempCSVBuffer.InsertEntry(LineNo, 14, FORMAT(recProductBuffer.Active));
              TempCSVBuffer.InsertEntry(LineNo, 15, recProductBuffer."Location Code");
            
        until recProductBuffer.Next() = 0;

        //TempCSVBuffer.SaveData('C:\TempPath\' + CSVFIleName, ',');
        
        TempCSVBuffer.SaveDataToBlob(TempBlob, ',');

        TempBlob.CreateInStream(InStr);
        TempBlob.CreateOutStream(OutStr);
 
        OutStr.WriteText(Result);

        InStr.ReadText(Result);

        CSVFIleName := StrSubstNo(CSVFileNameLbl, paramStore, FORMAT(CurrentDateTime, 0, '<Month,2><Day,2><Year>_<Hour><Minute,2><Second,2>'));
        
        CSVFIleName := CSVFIleName + '.csv';
        //DownloadFromStream(InStr, 'Download CSV', '', '',  CSVFileName);
        
        Clear(cduSFTPWebServiceDomain);
        cduSFTPWebserviceDomain.SendFile(InStr, CSVFileName, 'csv');


    end;



    

}
