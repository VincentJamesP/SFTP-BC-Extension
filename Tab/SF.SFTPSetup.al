table 70004 "SF.SFTP Setup"
{
    Caption = 'SFTP Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Address; Code[2048])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(3; Port; Integer)
        {
            Caption = 'Port';
            DataClassification = ToBeClassified;
        }
        field(4; "User Name"; Text[2048])
        {
            Caption = 'User Name';
            DataClassification = ToBeClassified;
        }
        field(5; Password; Text[2048])
        {
            Caption = 'Password';
            DataClassification = ToBeClassified;
        }
        field(6; Path; Text[2048])
        {
            Caption = 'Path';
            DataClassification = ToBeClassified;
        }
        field(7; "Function App link"; Text[2048])
        {
            Caption = 'Function App link';
            DataClassification = ToBeClassified;
        }
        field(8; "BLOB Storage Connection String"; Text[2048])
        {
            Caption = 'BLOB Storage Connection String';
            DataClassification = ToBeClassified;
        }
        field(9; "BLOB Storage Container Name"; Text[2048])
        {
            Caption = 'BLOB Storage Container Name';
            DataClassification = ToBeClassified;
        }

        field(10; "Location Filter"; Text[1000])
        {
            Caption = 'Location Filter';
            DataClassification = ToBeClassified;

        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
