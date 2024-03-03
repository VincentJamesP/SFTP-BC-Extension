page 70001 "SF.POS Payment Codes"
{
    ApplicationArea = All;
    Caption = 'POS Payment Codes';
    PageType = List;
    SourceTable = "SF.POS Payment Codes";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Payment Code"; Rec."Payment Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
