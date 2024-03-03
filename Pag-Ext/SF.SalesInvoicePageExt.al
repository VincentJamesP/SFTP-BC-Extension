pageextension 70000 "SF.SalesInvoicePageExt" extends "Sales Invoice"
{
    layout
    {
        addafter("Shipping and Billing")
        {
            group(POS)
            {
                field("SF Source Sales Order ID"; Rec."SF Source Sales Order ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Source Sales Order ID';
                    ToolTip = 'Specifies the Source Sales Order ID';
                }
                field("SF Created By"; Rec."SF Created By")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Created By';
                    ToolTip = 'Specifies the Created By from the POS the transaction';
                }
                field("SF Created Date"; Rec."SF Created Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Created Date';
                    ToolTip = 'Specifies the Create Date from POS the transaction';
                }
                field("SF Created Time"; Rec."SF Created Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Created Time';
                    ToolTip = 'Specifies the Create Time from POS the transaction';
                }
                field("SF Customer Name"; Rec."SF Customer Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'SF Customer Name';
                    ToolTip = 'Specifies the Customer Name from POS the transaction';
                }
                field("SF Customer Address"; Rec."SF Customer Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'SF Customer Address';
                    ToolTip = 'Specifies the Customer Address from POS the transaction';
                }
                field("SF Customer Mobile Number"; Rec."SF Customer Mobile Number")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'SF Customer Mobile Number';
                    ToolTip = 'Specifies the Customer Mobile Number from POS the transaction';
                }
            }
        }
    }
}
