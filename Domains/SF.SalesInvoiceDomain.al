codeunit 70004 "SF.SalesInvoiceDomain" implements "SF.IDomain"
{
    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure Create(object: Text): Text
    var
        SalesInvoice: Codeunit "SF.SalesInvoiceModel";
        listOfInvoiceNos: List of [Text];
    begin
        SalesInvoice.FromJsonHeader(object, listOfInvoiceNos);
        SalesInvoice.FromJsonLine(object, listOfInvoiceNos);
        exit(SalesInvoice.ToJson());
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure Retrieve(id: text): Text
    begin
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure Update(object: Text): Text
    begin
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure Delete(id: Text): Text
    begin
    end;

}

