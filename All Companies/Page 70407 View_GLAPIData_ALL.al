page 70407 View_GLAPIData_ALL
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;    
    SourceTable = GLAPIData_ALL;

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
                 field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }

                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ApplicationArea = All;
                }   
                field("Cost Center Name"; Rec."Cost Center Name")
                {
                    ApplicationArea = All;
                }
                field("Market Code"; Rec."Market Code")
                {
                    ApplicationArea = All;
                } 
                field("Market Name"; Rec."Market Name")
                {
                    ApplicationArea = All;
                }
                field(Combination; Rec.Combination)
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
                field("IC Partner";Rec."IC Partner")
                {
                    ApplicationArea = All;
                }
               field("IC Partner Name";Rec."IC Partner Name")
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
                field("Company Name"; Rec."Company Name")
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
                    GLAPIDataBatch: Report GLAPIDataBatch_ICPartner_ALL;
                begin
                    GLAPIDataBatch.Run();
                end;
            }
        }
    }
}

   
