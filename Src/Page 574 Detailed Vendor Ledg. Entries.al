pageextension 70402 PageExt70402 extends "Detailed Vendor Ledg. Entries"
{
    layout
    {
        modify("Source Code")
        {
            Visible = true;
        }
        addafter("Source Code")
        {
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction No. field.', Comment = '%';
            }

            field("Applied Exchange GL Entry No."; Rec."Applied Exchange GL Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction No. field.', Comment = '%';
            }
        }

    }
}
