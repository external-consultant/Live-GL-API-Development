pageextension 70403 PageExt70403 extends "Bank Account Ledger Entries"
{
    layout
    {
        modify("Source Code")
        {
            Visible = true;
        }
        modify("Amount (LCY)")
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
