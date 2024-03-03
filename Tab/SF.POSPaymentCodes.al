table 70001 "SF.POS Payment Codes"
{
    Caption = 'POS Payment Codes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Payment Code"; Code[20])
        {
            Caption = 'Payment Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Payment Code")
        {
            Clustered = true;
        }
    }
}
