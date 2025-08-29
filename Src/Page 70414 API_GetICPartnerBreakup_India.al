page 70414 API_GetICPartnerBreakup_India
{
    APIGroup = 'API';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiGetICPartnerBreakupIndia';
    DelayedInsert = true;
    EntityName = 'apiGetICPartnerBreakupIndia';
    EntitySetName = 'apiGetICPartnerBreakupIndias';
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
    /*  trigger OnOpenPage()   // OnOpenPage is called when the page is opened. GET API request is called with the filter values.
     var
         Report70409: Report GLAPIDataBatch_ICPartner_India;
         startDate: Date;
         endDate: Date;
     begin
         if ((rec.GetFilter("Start Date") <> '') and (rec.GetFilter("End Date") <> '')) then begin
             Evaluate(startDate, rec.GetFilter("Start Date"));
             Evaluate(endDate, rec.GetFilter("End Date"));
             Clear(Report70409);
             Report70409.UseRequestPage(false);
             Report70409.Setparameter(startDate, endDate);
             Report70409.RunModal();
             Commit();

         end;
     end; */
}