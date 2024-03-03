page 70002 "SF API Testing"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("Choose a method")
            {
                field("API Method"; method)
                {
                    Editable = true;
                    ApplicationArea = All;
                    Caption = 'API Method';
                }
            }
            group("API Request Body - Postman")
            {
                field(APICall; APICallBody)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            group("API Response")
            {
                field(Response; response)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Adds the action called "My Actions" to the Action menu 
        area(Processing)
        {
            action("Call SF_API")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    sfAPI: Codeunit "SF.API";
                    HelperDomain: Codeunit "SF.HelperDomain";
                    source: Text;
                    TransType: Integer;
                    FunctionType: Integer;
                    jsonO: JsonObject;
                    JsonData: Text;
                begin
                    jsonO.ReadFrom(APICallBody);
                    Evaluate(JsonData, HelperDomain.GetFieldValue('jsonData', jsonO));
                    case method of
                        method::CreateAndPostSIwithPayment:
                            response := sfAPI.CreateAndPostSIwithPayment(JsonData);
                        method::CreateAndPostSI:
                            response := sfAPI.CreateAndPostSI(JsonData);
                        method::CreateAndPostPayment:
                            response := sfAPI.CreateAndPostPayment(JsonData);
                        method::CreateAndPostCMwithRefund:
                            response := sfAPI.CreateAndPostCMwithRefund(JsonData);
                    end;
                end;

            }
        }
    }

    var
        response: Text;
        APICallBody: Text;
        method: Option CreateAndPostSIwithPayment,CreateAndPostSI,CreateAndPostPayment,CreateAndPostCMwithRefund;
}