codeunit 70006 "SF.PaymentModel" implements "SF.IModel"
{
    var
        ErrorTextGenJnlBatchDoesNotExist: TextConst ENU = 'Gen. Journal Batch PAYMENT does not exist for %1 Template!';
        ErrorTextGenJnlTemplateDoesNotExist: TextConst ENU = 'Gen. Journal Template does not exist for Cash Receipts!';
        ErrorTextNoCustomerPaymentSetup: TextConst ENU = 'Customer %1 does not have setup for payment code %2!';
        GenJnlTemplate: Record "Gen. Journal Template";

    procedure ToJson(): Text
    begin
    end;

    procedure FromJson(inputJson: Text)
    begin
        map(inputJson);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure map(JsonText: Text)
    var
        Token: JsonToken;
        JT: JsonToken;
        JO: JsonObject;
        Token2: JsonToken;
        Token3: JsonToken;
        JV: JsonValue;
        LineNo: Integer;
        SalesInvHeader: Record "Sales Invoice Header";
        Amt: Decimal;
        ExternalDocNo: Text;
        tenderCode: Text;
        NoSeries: Codeunit NoSeriesManagement;
        DocNo: Code[20];
        CustPayment: Record "SF.POSCustomerPayments";
        GenJnlLine: Record "Gen. Journal Line";
        HelperDomain: Codeunit "SF.HelperDomain";
        JTTender: JsonToken;
        JOTender: JsonObject;
        JT2: JsonToken;
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        GenJnlTemplate.SetRange(Type, GenJnlTemplate.Type::"Cash Receipts");
        if GenJnlTemplate.FindFirst() then begin
            if GenJnlBatch.Get(GenJnlTemplate.Name, 'PAYMENT') then
                DocNo := NoSeries.GetNextNo(GenJnlBatch."No. Series", Today, true)
            else
                Error(ErrorTextGenJnlBatchDoesNotExist, GenJnlTemplate.Name);
        end else
            Error(ErrorTextGenJnlTemplateDoesNotExist);
        Token.ReadFrom(jsonText);
        if Token.IsValue() then begin
            JV := Token.AsValue();
            Token2.ReadFrom(JV.AsText());
            JO := Token2.AsObject();
        end else
            JO := Token.AsObject();
        GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate.Name);
        GenJnlLine.SetRange("Journal Batch Name", 'PAYMENT');
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll();
        JO.Get('payment_method', Token3);
        foreach JT in Token3.AsArray() do begin
            if JT.IsObject() then begin
                JOTender := JT.AsObject();
                JOTender.Get('tender_type', JTTender);
                SalesInvHeader.Reset();
                SalesInvHeader.SetRange("SF Source Sales Order ID", HelperDomain.GetFieldValue('kti_sourceSalesOrderid', JT.AsObject()));
                if SalesInvHeader.FindFirst() then begin
                    if not IsPaymentPosted(SalesInvHeader."No.", SalesInvHeader."Posting Date") then begin
                        foreach JT2 in JTTender.AsArray() do begin
                            Clear(ExternalDocNo);
                            Clear(Amt);
                            Clear(tenderCode);
                            Evaluate(ExternalDocNo, HelperDomain.GetFieldValue('TRN', JT2.AsObject()));
                            Evaluate(Amt, HelperDomain.GetFieldValue('amount', JT2.AsObject()));
                            Evaluate(tenderCode, HelperDomain.GetFieldValue('code', JT2.AsObject()));
                            if Amt > 0 then begin
                                CustPayment.Reset();
                                CustPayment.SetRange("Payment Code", tenderCode);
                                CustPayment.SetRange("Customer No.", SalesInvHeader."Sell-to Customer No.");
                                if CustPayment.FindFirst() then begin
                                    LineNo += 10000;
                                    insertCashReceiptJnl(LineNo, SalesInvHeader, Amt, DocNo, ExternalDocNo, CustPayment."Bal. Account Type", CustPayment."Bal. Account No.");
                                end else
                                    Error(ErrorTextNoCustomerPaymentSetup, SalesInvHeader."Sell-to Customer No.", tenderCode);
                            end;
                        end;
                    end;
                end;
            end;
        end;

    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure insertCashReceiptJnl(LineNo: Integer; _salesInvHdr: Record "Sales Invoice Header"; _amount: Decimal; _docNo: Code[20]; _externalDocNo: Text; _balAcctType: Enum "Payment Balance Account Type"; _balAcctNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.Init();
        GenJnlLine.Validate("Journal Template Name", GenJnlTemplate.Name);
        GenJnlLine.Validate("Journal Batch Name", 'PAYMENT');
        GenJnlLine.Validate("Line No.", LineNo);
        GenJnlLine.Validate("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.Validate("Posting Date", Today);
        GenJnlLine.Validate("Document No.", _docNo);
        GenJnlLine.Validate(Comment, _externalDocNo);
        GenJnlLine."External Document No." := _salesInvHdr."External Document No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine.Validate("Account No.", _salesInvHdr."Sell-to Customer No.");
        GenJnlLine.Validate(Amount, -Abs(_amount));
        if _balAcctType = _balAcctType::"Bank Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account"
        else
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := _balAcctNo;
        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
        GenJnlLine."Applies-to Doc. No." := _salesInvHdr."No.";
        GenJnlLine.Insert();
    end;

    local procedure IsPaymentPosted(PostedSalesInvoiceNo: Code[20]; PostingDate: Date): Boolean
    var
        CustLedgEntryRec: Record "Cust. Ledger Entry";
    begin
        CustLedgEntryRec.SetRange("Document No.", PostedSalesInvoiceNo);
        CustLedgEntryRec.SetRange("Posting Date", PostingDate);
        if CustLedgEntryRec.FindFirst() then begin
            if CustLedgEntryRec."Closed by Entry No." = 0 then
                exit(false)
            else
                exit(true);
        end else
            exit(false);
    end;
}



