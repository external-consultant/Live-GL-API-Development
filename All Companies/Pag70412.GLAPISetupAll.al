page 70412 GLAPISetup_All
{
    ApplicationArea = All;
    Caption = 'GLAPISetup_All';
    PageType = Card;
    SourceTable = GLAPISetup_All;
    UsageCategory = Administration;


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                    ToolTip = 'Start Date';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                    ToolTip = 'if date is not provided, JEDOX Post Request Job Queue will take the current date as end date';
                }

            }
        }
    }
}
