page 70402 API_RequestTBReport
{

    APIGroup = 'API';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    Caption = 'apiGetGLData';
    DelayedInsert = true;
    EntityName = 'apiRequestTBReport';
    EntityCaption = 'apiRequestTBReport';
    EntitySetName = 'apiRequestTBReports';    //Make Sure First Char in Small Letter and don't use any special char or space
    EntitySetCaption = 'apiRequestTBReports';
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
        GLAPIDataBatch_lRpt: Report GLAPIDataBatch_TB;

    begin
        IF SDate_gDte = 0D then
            Error('Enter Start Date');

        IF EDate_gDte = 0D then
            Error('Enter End Date');

        Clear(GLAPIDataBatch_lRpt);
        GLAPIDataBatch_lRpt.UseRequestPage(false);
        GLAPIDataBatch_lRpt.Setparameter(SDate_gDte, EDate_gDte);
        GLAPIDataBatch_lRpt.RunModal();



    end;

    var
        SDate_gDte: date;
        EDate_gDte: date;

}

//TB-T49-ICOAUTO-N-27032025