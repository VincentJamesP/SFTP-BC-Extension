table 70000 "SF.POSCustomerPayments"
{
    Caption = 'POS Customer Payments';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Payment Code"; Code[20])
        {
            Caption = 'Payment Code';
            TableRelation = "SF.POS Payment Codes"."Payment Code";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                POSPaymentCodes: Record "SF.POS Payment Codes";
                CustomerRec: Record Customer;
            begin
                TestField("Payment Code");
                POSPaymentCodes.Get("Payment Code");
                if CustomerRec.Get("Customer No.") then
                    Description := POSPaymentCodes.Description + ' - ' + CustomerRec.Name
                else
                    Description := POSPaymentCodes.Description;
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                POSPaymentCodes: Record "SF.POS Payment Codes";
                CustomerRec: Record Customer;
            begin
                TestField("Payment Code");
                POSPaymentCodes.Get("Payment Code");
                if CustomerRec.Get("Customer No.") then
                    Description := POSPaymentCodes.Description + ' - ' + CustomerRec.Name
                else
                    Description := POSPaymentCodes.Description;
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Bal. Account Type"; enum "Payment Balance Account Type")
        {
            Caption = 'Bal. Account Type';

            trigger OnValidate()
            begin
                "Bal. Account No." := '';
            end;
        }
        field(5; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";

            trigger OnValidate()
            begin
                if "Bal. Account Type" = "Bal. Account Type"::"G/L Account" then
                    CheckGLAcc("Bal. Account No.");
            end;
        }
    }
    keys
    {
        key(PK; "Payment Code", "Customer No.")
        {
            Clustered = true;
        }
    }
    local procedure CheckGLAcc(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin

        if AccNo <> '' then begin
            GLAcc.Get(AccNo);
            GLAcc.CheckGLAcc();
            GLAcc.TestField("Direct Posting", true);
        end;
    end;
}
