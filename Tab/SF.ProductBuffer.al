table 70002 "SF.Product Buffer"
{
    Caption = 'Product Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Short Description"; Text[50])
        {
            Caption = 'Short Description';
            DataClassification = ToBeClassified;
        }
        field(4; Discountable; Integer)
        {
            Caption = 'Discountable';
            DataClassification = ToBeClassified;
        }
        field(5; CLASS; Text[20])
        {
            Caption = 'CLASS';
            DataClassification = ToBeClassified;
        }
        field(6; CAT; Text[20])
        {
            Caption = 'CAT';
            DataClassification = ToBeClassified;
        }
        field(7; SUBCAT; Text[20])
        {
            Caption = 'SUBCAT';
            DataClassification = ToBeClassified;
        }
        field(8; UOM; Code[10])
        {
            Caption = 'UOM';
            DataClassification = ToBeClassified;
        }
        field(9; RETAIL; Decimal)
        {
            Caption = 'RETAIL';
            DataClassification = ToBeClassified;
        }
        field(10; COST; Decimal)
        {
            Caption = 'COST';
            DataClassification = ToBeClassified;
        }
        field(11; "Bar Code"; Code[20])
        {
            Caption = 'Bar Code';
            DataClassification = ToBeClassified;
        }
        field(12; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(13; Individual; Integer)
        {
            Caption = 'Individual';
            DataClassification = ToBeClassified;
        }
        field(14; Active; Integer)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
        }
        field(15; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
        }

        field(16; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
