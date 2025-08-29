tableextension 70403 TableExt70403 extends "G/L Entry"
{
    fields
    {
        field(70400; "Applied Exchange Detail EntNo."; Integer)
        {
            Caption = 'Applied Exchange Detailed Entry No.';
            BlankZero = true;
            DataClassification = ToBeClassified;
            TableRelation = if ("Source Type" = const(Customer)) "Detailed Cust. Ledg. Entry"
            else
            if ("Source Type" = const(Vendor)) "Detailed Vendor Ledg. Entry"
            else
            if ("Source Type" = const("Bank Account")) "Bank Account Ledger Entry";
            Editable = false;
        }
    }
}
