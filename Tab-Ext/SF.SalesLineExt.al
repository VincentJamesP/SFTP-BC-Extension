tableextension 70003 "SF.SalesLineExt" extends "Sales Line"
{
    fields
    {
        field(70000; "SF Source Sales Order Item ID"; Text[30])
        {
            Caption = 'Source Sales Order Item ID';
            DataClassification = ToBeClassified;
        }
        field(70001; "SF Unit Cost"; Decimal)
        {
            Caption = 'SF Unit Cost';
            DataClassification = ToBeClassified;
        }
        field(70002; "SF Customer Name"; Text[100])
        {
            Caption = 'SF Customer Name';
            DataClassification = ToBeClassified;
        }
        field(70003; "SF Customer Address"; Text[100])
        {
            Caption = 'SF Customer Address';
            DataClassification = ToBeClassified;
        }
        field(70004; "SF Customer Mobile Number"; Text[20])
        {
            Caption = 'SF Customer Mobile Number';
            DataClassification = ToBeClassified;
        }
        field(70005; "SF Source Sales Order ID"; Text[30])
        {
            Caption = 'Source Sales Order ID';
            DataClassification = ToBeClassified;
        }
    }
}
