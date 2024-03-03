codeunit 70005 "SF.SalesInvoiceModel" implements "SF.IModel"
{
    var
        _salesHeader: Record "Sales Header";
        _salesLine: Record "Sales Line";
        No: Text;
        DocNo: Text;
        CustNo: Text;
        ItemNo: Text;
        VariantCode: Text;
        Quantity: Decimal;
        Price: Decimal;
        UnitofMeasureCode: Text;
        LineNo: Integer;
        SalesJArray: JsonArray;
        jsonString: Text;
        kti_sourceSalesOrderid: Text;
        kti_sourceSalesOrderitemid: Text;
        LocationCode: Text;
        customername: Text;
        address: Text;
        address2: Text;
        city: Text;
        postcode: Text;
        country: Text;
        contactno: Text;
        phoneno: Text;
        email: Text;
        POS_UnitCost: Decimal;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure ToJson(): Text
    begin
        exit(FormatResponse(SalesJArray));
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure FromJson(inputJson: Text)
    begin
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure FromJsonHeader(inputJson: Text; var _listOfInvoiceNos: List of [Text])
    begin
        //to BC
        Clear(_listOfInvoiceNos);
        mapHeader(inputJson, _listOfInvoiceNos);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure FromJsonLine(inputJson: Text; _listOfInvoiceNos: List of [Text])
    begin
        //to BC
        mapLine(inputJson, _listOfInvoiceNos);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure mapHeader(jsonText: Text; var _listOfInvoiceNos: List of [Text])
    var
        Token: JsonToken;
        JT: JsonToken;
        JO: JsonObject;
        Token2: JsonToken;
        Token3: JsonToken;
        SO_JO: JsonObject;
        JV: JsonValue;
        HelperDomain: Codeunit "SF.HelperDomain";
        SINo: Code[20];
    begin
        Clear(_listOfInvoiceNos);
        Token.ReadFrom(jsonText);
        if Token.IsValue() then begin
            JV := Token.AsValue();
            Token2.ReadFrom(JV.AsText());
            JO := Token2.AsObject();
        end else
            JO := Token.AsObject();

        JO.Get('Invoice_header', Token3);
        foreach JT in Token3.AsArray() do begin
            if JT.IsObject() then begin
                // Evaluate(No, HelperDomain.GetFieldValue('No', JT.AsObject()));
                // Evaluate(DocNo, HelperDomain.GetFieldValue('DocNo', JT.AsObject()));
                Evaluate(kti_sourceSalesOrderid, HelperDomain.GetFieldValue('kti_sourceSalesOrderid', JT.AsObject()));
                Evaluate(CustNo, HelperDomain.GetFieldValue('CustNo', JT.AsObject()));
                Evaluate(LocationCode, HelperDomain.GetFieldValue('location', JT.AsObject()));
                Evaluate(customername, HelperDomain.GetFieldValue('customername', JT.AsObject()));
                Evaluate(address, HelperDomain.GetFieldValue('address', JT.AsObject()));
                // Evaluate(address2, HelperDomain.GetFieldValue('address2', JT.AsObject()));
                // Evaluate(city, HelperDomain.GetFieldValue('city', JT.AsObject()));
                // Evaluate(postcode, HelperDomain.GetFieldValue('postcode', JT.AsObject()));
                // Evaluate(country, HelperDomain.GetFieldValue('country', JT.AsObject()));
                // Evaluate(contactno, HelperDomain.GetFieldValue('contactno', JT.AsObject()));
                Evaluate(phoneno, HelperDomain.GetFieldValue('phoneno', JT.AsObject()));
                // Evaluate(email, HelperDomain.GetFieldValue('email', JT.AsObject()));
                if not IsSalesInvoiceExisting(kti_sourceSalesOrderid, SINo) then begin
                    if not IsPostedSalesInvoiceExisting(kti_sourceSalesOrderid, SINo) then begin
                        InsertSalesHeader(_salesHeader);
                        SINo := _salesHeader."No.";
                        _listOfInvoiceNos.Add(kti_sourceSalesOrderid);
                        _listOfInvoiceNos.Add(_salesHeader."No.");
                    end;
                end;
                Clear(SO_JO);
                // SO_JO.Add('ExternalDocNo', No);
                SO_JO.Add('kti_sourceSalesOrderid', kti_sourceSalesOrderid);
                SO_JO.Add('InvoiceNo', SINo);
                SalesJArray.Add(SO_JO);
            end;
        end;
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure mapLine(jsonText: Text; _listOfInvoiceNos: List of [Text])
    var
        Token: JsonToken;
        JT: JsonToken;
        JO: JsonObject;
        Token2: JsonToken;
        Token3: JsonToken;
        listOfKeys: List of [Text];
        JV: JsonValue;
        HelperDomain: Codeunit "SF.HelperDomain";
    begin
        Token.ReadFrom(jsonText);
        if Token.IsValue() then begin
            JV := Token.AsValue();
            Token2.ReadFrom(JV.AsText());
            JO := Token2.AsObject();
        end else
            JO := Token.AsObject();

        JO.Get('Invoice_line', Token3);
        foreach JT in Token3.AsArray() do begin
            if JT.IsObject() then begin
                if kti_sourceSalesOrderid <> HelperDomain.GetFieldValue('kti_sourceSalesOrderid', JT.AsObject()) then
                    Clear(LineNo);
                Evaluate(kti_sourceSalesOrderid, HelperDomain.GetFieldValue('kti_sourceSalesOrderid', JT.AsObject()));
                Clear(_salesHeader);
                _salesHeader.SetRange("Document Type", _salesHeader."Document Type"::Invoice);
                _salesHeader.SetRange("SF Source Sales Order ID", kti_sourceSalesOrderid);
                if _salesHeader.FindFirst() then begin
                    Evaluate(ItemNo, HelperDomain.GetFieldValue('ItemNo', JT.AsObject()));
                    Evaluate(VariantCode, HelperDomain.GetFieldValue('VariantCode', JT.AsObject()));
                    Evaluate(Quantity, HelperDomain.GetFieldValue('Quantity', JT.AsObject()));
                    Evaluate(Price, HelperDomain.GetFieldValue('Price', JT.AsObject()));
                    Evaluate(UnitofMeasureCode, HelperDomain.GetFieldValue('UnitofMeasureCode', JT.AsObject()));
                    Evaluate(kti_sourceSalesOrderitemid, HelperDomain.GetFieldValue('kti_sourceSalesOrderitemid', JT.AsObject()));
                    Evaluate(POS_UnitCost, HelperDomain.GetFieldValue('UnitCost', JT.AsObject()));
                    LineNo += 10000;
                    InsertSalesLine(_salesLine);
                end;
            end;
        end;
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure InsertSalesLine(var _salesLine: Record "Sales Line")
    begin
        Clear(_salesLine);
        _salesLine.Init();
        _salesLine.Validate("Document Type", _salesLine."Document Type"::Invoice);
        _salesLine.Validate("Document No.", _salesHeader."No.");
        _salesLine.Validate("Line No.", LineNo);
        _salesLine.Validate(Type, _salesLine.Type::Item);
        _salesLine.Validate("No.", ItemNo);
        if VariantCode <> '0' then
            _salesLine.Validate("Variant Code", VariantCode);

        _salesLine.Validate("Location Code", _salesHeader."Location Code");
        if customername <> '0' then
            _salesLine."SF Customer Name" := _salesHeader."SF Customer Name";
        if address <> '0' then
            _salesLine."SF Customer Address" := _salesHeader."SF Customer Address";
        if phoneno <> '0' then
            _salesLine."SF Customer Mobile Number" := _salesHeader."SF Customer Mobile Number";
        _salesLine.Validate(Quantity, Quantity);
        // _salesLine.Validate("Unit Price", Price);
        if Price > 0 then
            _salesLine.Validate("Line Amount", Quantity * Price)
        else begin
            _salesLine.Validate("Unit Price", Price);
            _salesLine."Line Amount" := 0;
        end;
        _salesLine.Validate("Bin Code", _salesHeader."Location Code");
        _salesLine.Validate("SF Source Sales Order Item ID", kti_sourceSalesOrderitemid);
        _salesLine.Validate("SF Unit Cost", POS_UnitCost);
        _salesLine.Validate("SF Source Sales Order ID", _salesHeader."SF Source Sales Order ID");
        _salesLine.Insert(true);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure InsertSalesHeader(var _salesHeader: Record "Sales Header")
    begin
        Clear(_salesHeader);
        _salesHeader.Init();
        _salesHeader.Validate("Document Type", _salesHeader."Document Type"::Invoice);
        _salesHeader.Validate("No. Series");
        _salesHeader.Validate("No.");
        _salesHeader.Validate("Sell-to Customer No.", CustNo);
        _salesHeader.Validate("Bill-to Customer No.", CustNo);
        _salesHeader.Validate("Posting Date", Today);
        _salesHeader.Validate("Document Date", Today);
        // _salesHeader.Validate("External Document No.", No);
        _salesHeader.Validate("SF Source Sales Order ID", kti_sourceSalesOrderid);
        if LocationCode <> '0' then
            _salesHeader.Validate("Location Code", LocationCode);
        if customername <> '0' then
            _salesHeader."SF Customer Name" := customername;
        if address <> '0' then
            _salesHeader."SF Customer Address" := address;
        // if address2 <> '0' then
        //     _salesHeader."Sell-to Address 2" := address2;
        // if city <> '0' then
        //     _salesHeader."Sell-to City" := city;
        // if postcode <> '0' then
        //     _salesHeader."Sell-to Post Code" := postcode;
        // if country <> '0' then
        //     _salesHeader."Sell-to Country/Region Code" := country;
        // if contactno <> '0' then
        //     _salesHeader."Sell-to Contact No." := contactno;
        if phoneno <> '0' then
            _salesHeader."SF Customer Mobile Number" := phoneno;
        // if email <> '0' then
        //     _salesHeader."Sell-to E-Mail" := email;
        _salesHeader.Insert(true);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure FormatResponse(JArray: JsonArray): Text
    var
        JArrayText: Text;
    begin
        JArray.WriteTo(JArrayText);
        exit(JArrayText);
    end;

    local procedure IsSalesInvoiceExisting(_sourceSalesOrderid: Text; var salesInvoiceNo: Code[20]): Boolean
    var
        SalesInvoiceRec: Record "Sales Header";
    begin
        SalesInvoiceRec.SetRange("SF Source Sales Order ID", _sourceSalesOrderid);
        if SalesInvoiceRec.FindFirst() then begin
            salesInvoiceNo := SalesInvoiceRec."No.";
            exit(true);
        end
        else
            exit(false);
    end;

    local procedure IsPostedSalesInvoiceExisting(_sourceSalesOrderid: Text; var salesInvoiceNo: Code[20]): Boolean
    var
        PostedSalesInvoiceRec: Record "Sales Invoice Header";
    begin
        PostedSalesInvoiceRec.SetRange("SF Source Sales Order ID", _sourceSalesOrderid);
        if PostedSalesInvoiceRec.FindFirst() then begin
            salesInvoiceNo := PostedSalesInvoiceRec."Pre-Assigned No.";
            exit(true);
        end
        else
            exit(false);

    end;

}

