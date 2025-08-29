pageextension 70404 GlAct70404 extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {
            field("IC Partner Report Bre Act"; Rec."IC Partner Report Bre Act")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consider for IC Partner Report Breakup Report (Jedox) field.', Comment = '%';
            }
        }
    }
}
