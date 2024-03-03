tableextension 70001 "SF.SalesInvHeaderExt" extends "Sales Invoice Header"
{
    fields
    {
        field(70000; "SF Source Sales Order ID"; Text[30])
        {
            Caption = 'Source Sales Order ID';
            DataClassification = ToBeClassified;
        }
        field(70001; "SF Created By"; Text[30])
        {
            Caption = 'SF Created By';
            DataClassification = ToBeClassified;
        }
        field(70002; "SF Created Date"; Date)
        {
            Caption = 'SF Created Date';
            DataClassification = ToBeClassified;
        }
        field(70003; "SF Created Time"; Time)
        {
            Caption = 'SF Created Time';
            DataClassification = ToBeClassified;
        }
        field(70004; "SF Customer Name"; Text[100])
        {
            Caption = 'SF Customer Name';
            DataClassification = ToBeClassified;
        }
        field(70005; "SF Customer Address"; Text[100])
        {
            Caption = 'SF Customer Address';
            DataClassification = ToBeClassified;
        }
        field(70006; "SF Customer Mobile Number"; Text[20])
        {
            Caption = 'SF Customer Mobile Number';
            DataClassification = ToBeClassified;
        }
    }
}
