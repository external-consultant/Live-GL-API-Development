pageextension 70400 GlextPageExt70400 extends "General Ledger Entries"
{
    layout
    {
        modify("Source Code")
        {
            Visible = true;
        }

        modify("Source Type")
        {
            Visible = true;
        }
        modify("Source No.")
        {
            Visible = true;
        }

        addafter("Source No.")
        {
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction No. field.', Comment = '%';
            }
            field("Applied Exchange Detail EntNo."; Rec."Applied Exchange Detail EntNo.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Applied Exchange Detailed Entry No. field.', Comment = '%';
            }
        }

    }
}
