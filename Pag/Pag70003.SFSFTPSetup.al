page 70003 "SF.SFTP Setup"
{
    ApplicationArea = Basic, Suite;
    Caption = 'SFTP Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "SF.SFTP Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(Path; Rec.Path)
                {
                    ToolTip = 'Specifies the value of the Path field.';
                }
                field(Port; Rec.Port)
                {
                    ToolTip = 'Specifies the value of the Port field.';
                }
                field("Function App link"; Rec."Function App link")
                {
                    ToolTip = 'Specifies the value of the Function App link field.';
                }
                field("BLOB Storage Connection String"; Rec."BLOB Storage Connection String")
                {
                    ToolTip = 'Specifies the value of the BLOB Storage Connection String field.';
                }
                field("BLOB Storage Container Name"; Rec."BLOB Storage Container Name")
                {
                    ToolTip = 'Specifies the value of the BLOB Storage Container Name field.';
                }

                field("Location Filter"; Rec."Location Filter")
                {
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        xSFTPSetup := Rec;
    end;

    var
        xSFTPSetup: Record "SF.SFTP Setup";
}
