//TB-T49-ICOAUTO-N-27032025
page 70416 API_RequestICPartnerBreakupInd
{

    APIGroup = 'API';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    Caption = 'apiGetGLData';
    DelayedInsert = true;
    EntityName = 'apiRequestICPartnerBreakupIndia';
    EntityCaption = 'apiRequestICPartnerBreakupIndia';
    EntitySetName = 'apiRequestICPartnerBreakupIndias';    //Make Sure First Char in Small Letter and don't use any special char or space
    EntitySetCaption = 'apiRequestICPartnerBreakupIndias';
    PageType = API;
    SourceTable = GLAPIData;
    MultipleNewLines = true;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec.EntryNo)
                {
                    Caption = 'EntryNo';
                }
                field(sDate; SDate_gDte)
                {
                    Caption = 'StartDate';

                }
                field(eDate; EDate_gDte)
                {
                    Caption = 'endDate';
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Report70400: Report GLAPIDataBatch_ICPartner_India;
        FindGainSourceAct_lRpt: Report "GL Entry Gain Loss Source Fnd";
    begin
        IF SDate_gDte = 0D then
            Error('Enter Start Date');

        IF EDate_gDte = 0D then
            Error('Enter End Date');

        Clear(FindGainSourceAct_lRpt);
        FindGainSourceAct_lRpt.UseRequestPage(False);
        FindGainSourceAct_lRpt.RunModal();

        Commit();

        Clear(Report70400);
        Report70400.UseRequestPage(false);
        Report70400.Setparameter(SDate_gDte, EDate_gDte);
        Report70400.RunModal();

    end;

    var
        SDate_gDte: date;
        EDate_gDte: date;

}