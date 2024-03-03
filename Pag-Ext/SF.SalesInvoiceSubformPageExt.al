pageextension 70002 "SF.SalesInvoiceSubformPageExt" extends "Sales Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("SF Source Sales Order ID"; Rec."SF Source Sales Order ID")
            {
                ApplicationArea = All;
                Editable = true;
                Caption = 'SF Source SO ID';
            }
            field("SF Source Sales Order Item ID"; Rec."SF Source Sales Order Item ID")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'SF Source SO Item ID';
            }
            field("SF Unit Cost"; Rec."SF Unit Cost")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'SF Unit Cost';
            }
            field("SF Customer Name"; Rec."SF Customer Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SF Customer Address"; Rec."SF Customer Address")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SF Customer Mobile Number"; Rec."SF Customer Mobile Number")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
