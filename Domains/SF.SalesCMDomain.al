codeunit 70013 "SF.SalesCMDomain" implements "SF.IDomain"
{
    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure Create(object: Text): Text
    var
        SalesCM: Codeunit "SF.SalesCMModel";
        listOfCMNos: List of [Text];
    begin
        SalesCM.FromJsonHeader(object, listOfCMNos);
        SalesCM.FromJsonLine(object, listOfCMNos);
        exit(SalesCM.ToJson());
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