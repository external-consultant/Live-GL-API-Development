tableextension 70402 TableExt70402 extends "Bank Account Ledger Entry"
{
    fields
    {
        field(70400; "Applied Exchange GL Entry No."; Integer)
        {
            Caption = 'Applied Exchange GL Entry No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Entry";
            Editable = false;
            BlankZero = true;
        }
    }
}
