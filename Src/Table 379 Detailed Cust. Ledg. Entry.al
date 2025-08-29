tableextension 70400 TableExt70400 extends "Detailed Cust. Ledg. Entry"
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
