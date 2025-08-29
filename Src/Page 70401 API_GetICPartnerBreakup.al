page 70401 API_GetICPartnerBreakup
{
    APIGroup = 'API';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiGetICPartnerBreakup';
    DelayedInsert = true;
    EntityName = 'apiGetICPartnerBreakup';
    EntitySetName = 'apiGetICPartnerBreakups';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = GLAPIData;
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
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(locationName; Rec."Location Name")
                {
                    Caption = 'Location Name';
                }
                field(costCenterCode; Rec."Cost Center Code")
                {
                    Caption = 'Cost Center Code';
                }
                field(costCenterName; Rec."Cost Center Name")
                {
                    Caption = 'Cost Center Name';
                }
                field(marketCode; Rec."Market Code")
                {
                    Caption = 'Market Code';
                }
                field(marketName; Rec."Market Name")
                {
                    Caption = 'Market Name';
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
                field(icPartner; Rec."IC Partner")
                {
                    Caption = 'IC Partner';
                }
                field(icPartnerName; Rec."IC Partner Name")
                {
                    Caption = 'IC Partner Name';
                }
                field(companyName; Rec."Company Name")
                {
                    Caption = 'Company Name';
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