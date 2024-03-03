page 70000 "SF.CustomerPaymentsPage"
{
    ApplicationArea = All;
    Caption = 'POS Customer Payments';
    PageType = List;
    SourceTable = "SF.POSCustomerPayments";
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
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customer No. which uses the Payment Code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bal. Acct. Type for the Payment Code.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bal. Acct. No. for the Payment Code.';
                }
            }
        }
    }
}
