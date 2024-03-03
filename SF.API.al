codeunit 70008 "SF.API"
{
    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure CreateAndPostCMwithRefund(jsonData: Text): Text
    var
        SalesCMDomain: Codeunit "SF.SalesCMDomain";
        CreatedSalesCMs: Text;
        PostedSalesCMs: Text;
        logText: Text;
        HelperModel: Codeunit "SF.HelperModel";
        refundDomain: Codeunit "SF.RefundDomain";
    begin
        CreatedSalesCMs := SalesCMDomain.Create(jsonData);
        PostedSalesCMs := PostSalesCM(CreatedSalesCMs);
        logText := refundDomain.Create(jsonData);
        PostRefundLines();
        exit(PostedSalesCMs);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure CreateAndPostSIwithPayment(jsonData: Text): Text
    var
        SalesInvoiceDomain: Codeunit "SF.SalesInvoiceDomain";
        CreatedSalesInvoices: Text;
        PostedSalesInvoices: Text;
        logText: Text;
        HelperModel: Codeunit "SF.HelperModel";
        paymentDomain: Codeunit "SF.PaymentDomain";
    begin
        CreatedSalesInvoices := SalesInvoiceDomain.Create(jsonData);
        PostedSalesInvoices := PostSalesInvoices(CreatedSalesInvoices);
        logText := paymentDomain.Create(jsonData);
        PostPaymentLines();
        exit(PostedSalesInvoices);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure CreateAndPostSI(jsonData: Text): Text
    var
        SalesInvoiceDomain: Codeunit "SF.SalesInvoiceDomain";
        CreatedSalesInvoices: Text;
        PostedSalesInvoices: Text;
        logText: Text;
        HelperModel: Codeunit "SF.HelperModel";
        paymentDomain: Codeunit "SF.PaymentDomain";
    begin
        CreatedSalesInvoices := SalesInvoiceDomain.Create(jsonData);
        PostedSalesInvoices := PostSalesInvoices(CreatedSalesInvoices);
        exit(PostedSalesInvoices);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure CreateAndPostPayment(jsonData: Text): Text
    var
        SalesInvoiceDomain: Codeunit "SF.SalesInvoiceDomain";
        CreatedSalesInvoices: Text;
        PostedSalesInvoices: Text;
        logText: Text;
        HelperModel: Codeunit "SF.HelperModel";
        paymentDomain: Codeunit "SF.PaymentDomain";
    begin
        logText := paymentDomain.Create(jsonData);
        PostPaymentLines();
        exit('{"message":"payments posted."}');
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure PostSalesInvoices(jsonData: Text): Text
    var
        JO: JsonObject;
        JT: JsonToken;
        JT2: JsonToken;
        Token: JsonToken;
        salesPost: Codeunit "Sales-Post";
        salesheader: Record "Sales Header";
        PostedSalesInvoices: JsonArray;
        SalesInvHeaderRec: Record "Sales Invoice Header";
        PostedSalesInvoicesText: Text;
    begin
        Token.ReadFrom(jsonData);
        salesPost.SetSuppressCommit(true);
        Clear(PostedSalesInvoices);
        foreach JT in Token.AsArray() do begin
            JT.AsObject().Get('InvoiceNo', JT2);
            salesheader.SetRange("Document Type", salesheader."Document Type"::Invoice);
            salesheader.SetRange("No.", JT2.AsValue().AsText());
            if salesheader.FindFirst() then begin
                salesPost.Run(salesheader);
            end;
            SalesInvHeaderRec.SetRange("Pre-Assigned No.", JT2.AsValue().AsText());
            if SalesInvHeaderRec.FindFirst() then begin
                Clear(JO);
                JO := JT.AsObject();
                JO.Add('PostedSalesInvNo', SalesInvHeaderRec."No.");
                PostedSalesInvoices.Add(JO);
            end;
        end;
        PostedSalesInvoices.WriteTo(PostedSalesInvoicesText);
        exit(PostedSalesInvoicesText);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure PostPaymentLines()
    var
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
    begin
        GenJnlPostBatch.SetSuppressCommit(true);
        GenJnlTemplate.SetRange(Type, GenJnlTemplate.Type::"Cash Receipts");
        if GenJnlTemplate.FindFirst() then
            GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate.Name);
        GenJnlLine.SetRange("Journal Batch Name", 'PAYMENT');
        if GenJnlLine.FindSet() then
            GenJnlPostBatch.Run(GenJnlLine);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure PostRefundLines()
    var
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
    begin
        GenJnlPostBatch.SetSuppressCommit(true);
        GenJnlTemplate.SetRange(Type, GenJnlTemplate.Type::"Cash Receipts");
        if GenJnlTemplate.FindFirst() then
            GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate.Name);
        GenJnlLine.SetRange("Journal Batch Name", 'PAYMENT');
        if GenJnlLine.FindSet() then
            GenJnlPostBatch.Run(GenJnlLine);
    end;

    local procedure PostSalesCM(jsonData: Text): Text
    var
        JO: JsonObject;
        JT: JsonToken;
        JT2: JsonToken;
        Token: JsonToken;
        salesPost: Codeunit "Sales-Post";
        salesheader: Record "Sales Header";
        PostedSalesCMs: JsonArray;
        SalesCMHeaderRec: Record "Sales Cr.Memo Header";
        PostedSalesCMsText: Text;
    begin
        Token.ReadFrom(jsonData);
        salesPost.SetSuppressCommit(true);
        Clear(PostedSalesCMs);
        foreach JT in Token.AsArray() do begin
            JT.AsObject().Get('CMNo', JT2);
            salesheader.SetRange("Document Type", salesheader."Document Type"::"Credit Memo");
            salesheader.SetRange("No.", JT2.AsValue().AsText());
            if salesheader.FindFirst() then begin
                salesPost.Run(salesheader);
            end;
            SalesCMHeaderRec.SetRange("Pre-Assigned No.", JT2.AsValue().AsText());
            if SalesCMHeaderRec.FindFirst() then begin
                Clear(JO);
                JO := JT.AsObject();
                JO.Add('PostedSalesCMNo', SalesCMHeaderRec."No.");
                PostedSalesCMs.Add(JO);
            end;
        end;
        PostedSalesCMs.WriteTo(PostedSalesCMsText);
        exit(PostedSalesCMsText);
    end;
}

