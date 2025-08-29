report 70403 GLAPIDataBatch_ICPartner
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Description = 'T52067';

    dataset
    {

        dataitem("G/L Entry"; "G/L Entry")
        {
#pragma warning disable AL0254
            DataItemTableView = sorting("G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Source No.", "Posting Date", "VAT Reporting Date", "Source Currency Code");
            RequestFilterFields = "G/L Account No.";
#pragma warning restore AL0254
            trigger OnAfterGetRecord()
            begin
                DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Shortcut Dimension 3 Code");
                DimensionValue_gRec.SetRange(code, "G/L Entry"."Shortcut Dimension 3 Code");
                if DimensionValue_gRec.FindFirst() then
                    MarketName_gTxt := DimensionValue_gRec.Name;


                if ConsText_gTxt <> "G/L Entry"."G/L Account No." + "G/L Entry"."Global Dimension 1 Code" + "G/L Entry"."Global Dimension 2 Code" + "G/L Entry"."Shortcut Dimension 3 Code" + "G/L Entry"."Source No." then begin
                    GLEntry_gRec.Reset();
                    GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                    GLEntry_gRec.SetRange("Posting Date", 0D, ClosingDate(StartDate_gDte - 1));
                    GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                    GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                    GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                    GLEntry_gRec.SetRange("Source No.", "G/L Entry"."Source No.");
                    GLEntry_gRec.CalcSums(Amount);
                    OpeningBalance_gDec := GLEntry_gRec.Amount;

                    GLEntry_gRec.Reset();
                    // GLEntry_gRec.ChangeCompany(Company.Name);
                    GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                    GLEntry_gRec.SetRange("Posting Date", StartDate_gDte, ClosingDate(EndDate_gDte));
                    GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                    GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                    GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                    GLEntry_gRec.SetRange("Source No.", "G/L Entry"."Source No.");
                    GLEntry_gRec.CalcSums("Debit Amount", "Credit Amount");
                    DebitAmt_gDec := GLEntry_gRec."Debit Amount";
                    CreditAmt_gDec := GLEntry_gRec."Credit Amount";

                    ClosingBalance_gDec := OpeningBalance_gDec + DebitAmt_gDec - CreditAmt_gDec;
                    MakeExcelDataBody_lFnc();
                end;
                ConsText_gTxt := "G/L Entry"."G/L Account No." + "G/L Entry"."Global Dimension 1 Code" + "G/L Entry"."Global Dimension 2 Code" + "G/L Entry"."Shortcut Dimension 3 Code" + "G/L Entry"."Source No.";

            end;

            trigger OnPreDataItem()
            var
                GlAct_lRec: Record "G/L Account";
                GlActPipe_lTxt: Text;
            begin
                GlActPipe_lTxt := '';
                GlAct_lRec.RESET;
                GlAct_lRec.SetRange("IC Partner Report Bre Act", TRUE);
                IF GlAct_lRec.FindSet() Then begin
                    repeat
                        IF GlActPipe_lTxt = '' then
                            GlActPipe_lTxt := GlAct_lRec."No."
                        Else
                            GlActPipe_lTxt += '|' + GlAct_lRec."No.";

                    until GlAct_lRec.Next() = 0;
                end;

                IF GlActPipe_lTxt <> '' Then
                    SetFilter("G/L Account No.", GlActPipe_lTxt);

                ConsText_gTxt := '';
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Start Date"; StartDate_gDte)
                    {
                        ApplicationArea = All;

                    }
                    field("End Date"; EndDate_gDte)
                    {
                        ApplicationArea = All;

                    }
                    field("Company Name"; CompanyNameG)
                    {
                        ApplicationArea = all;
                        TableRelation = Company;
                    }
                }
            }
        }

    }
    trigger OnPostReport()
    begin
        EndTime := CurrentDateTime();
        Duration := EndTime - StartTime;
        Message('Execution time: %1', Duration);

    end;

    trigger OnPreReport()
    begin
        StartTime := CurrentDateTime();
        GLAPIData_gRec.RESET;
        GLAPIData_gRec.DeleteAll();
    end;

    local procedure MakeExcelDataBody_lFnc()
    begin
        clear(GLAPIData_gRec);
        GLAPIData_gRec.Init();
        GLAPIData_gRec."Company Name" := CompanyName;
        GLAPIData_gRec."G/L Account No." := "G/L Entry"."G/L Account No.";
        GLAPIData_gRec."G/L Account Name" := "G/L Entry"."G/L Account Name";
        GLAPIData_gRec."Location Code" := "G/L Entry"."Global Dimension 1 Code";
        GLAPIData_gRec."Location Name" := LocationName_gTxt;
        GLAPIData_gRec."Cost Center Code" := "G/L Entry"."Global Dimension 2 Code";
        GLAPIData_gRec."Cost Center Name" := CostCenterName_gTxt;
        GLAPIData_gRec."Market Code" := "G/L Entry"."Shortcut Dimension 3 Code";
        GLAPIData_gRec."Market Name" := MarketName_gTxt;
        GLAPIData_gRec."Opening Balance" := OpeningBalance_gDec;
        GLAPIData_gRec."Debit Amount" := DebitAmt_gDec;
        GLAPIData_gRec."Credit Amount" := CreditAmt_gDec;
        GLAPIData_gRec."Net Balance" := DebitAmt_gDec - CreditAmt_gDec;
        GLAPIData_gRec."Closing Balance" := ClosingBalance_gDec;
        GLAPIData_gRec."IC Partner" := "G/L Entry"."Source No.";
        GLAPIData_gRec."IC Partner Name" := CustVenName_gTxt;
        GLAPIData_gRec."Start Date" := StartDate_gDte;
        GLAPIData_gRec."End Date" := EndDate_gDte;
        GLAPIData_gRec.Insert(true);
    end;

    procedure Setparameter(St_idte: Date; En_idte: Date);
    var
        myInt: Integer;
    begin
        StartDate_gDte := St_idte;
        EndDate_gDte := En_idte;

    end;

    var
        ExcelBuffer_gRecTmp: Record "Excel Buffer";
        Win_gDlg: Dialog;
        Curr_gInt: Integer;
        Text002: label 'Company Name';
        Text003: label 'Report No.';
        Text005: label 'User ID';
        Text006: label 'Date';
        StartDate_gDte: Date;
        EndDate_gDte: Date;
        DimensionValue_gRec: Record "Dimension Value";
        GLSetup_gRec: Record "General Ledger Setup";
        LocationName_gTxt: Text;
        CostCenterName_gTxt: Text;
        MarketName_gTxt: Text;
        OpeningBalance_gDec: Decimal;
        ClosingBalance_gDec: Decimal;
        DebitAmt_gDec: Decimal;
        CreditAmt_gDec: Decimal;
        ConsText_gTxt: Text;
        GLEntry_gRec: Record "G/L Entry";
        CompanyNameG: Text;
        CustVenName_gTxt: Text;
        Customer_gRec: Record Customer;
        Vendor_gRec: Record Vendor;

        GLAPIData_gRec: Record GLAPIData;
        StartTime: DateTime;
        EndTime: DateTime;
        Duration: Duration;
}