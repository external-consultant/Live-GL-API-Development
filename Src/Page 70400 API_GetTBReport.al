page 70400 API_GetTBReport
{
    APIGroup = 'API';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiGetTBReport';
    DelayedInsert = true;
    EntityName = 'apiGetTBReport';
    EntitySetName = 'apiGetTBReport';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = GLAPIData_TB;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(gLAccountNo; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                }
                field(gLAccountName; Rec."G/L Account Name")
                {
                    Caption = 'G/L Account Name';
                }
                field(openingBalance; Rec."Opening Balance")
                {
                    Caption = 'Opening Balance';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(netBalance; Rec."Net Balance")
                {
                    Caption = 'Net Balance';
                }
                field(closingBalance; Rec."Closing Balance")
                {
                    Caption = 'Closing Balance';
                }
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Start Date';
                }
                field(endDate; Rec."End Date")
                {
                    Caption = 'End Date';
                }

                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }

            }
        }
    }
}