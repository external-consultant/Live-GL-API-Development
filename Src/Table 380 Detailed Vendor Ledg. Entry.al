tableextension 70401 TableExt70401 extends "Detailed Vendor Ledg. Entry"
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
