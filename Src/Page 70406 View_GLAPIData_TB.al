page 70406 View_GLAPIData_TB
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GLAPIData_TB;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                }               
                field("Opening Balance"; Rec."Opening Balance")
                {
                    ApplicationArea = All;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                }
                field("Net Balance"; Rec."Net Balance")
                {
                    ApplicationArea = All;
                }
                field("Closing Balance";Rec."Closing Balance")
                {
                    ApplicationArea = All;
                }  
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }          
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(get)
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Image = Refresh;
                trigger OnAction()
                var
                    GLAPIDataBatch: Report GLAPIDataBatch_TB;
                begin
                    GLAPIDataBatch.Run();
                end;
            }
             action(getIndiaEntity)
            {
                ApplicationArea = All;
                Caption = 'Refresh India Entity';
                Image = Refresh;
                trigger OnAction()
                var
                    GLAPIDataBatch: Report GLAPIDataBatch_TB_India;
                begin
                    GLAPIDataBatch.Run();
                end;
            }
        }
    }
}

   
