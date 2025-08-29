report 70406 GLAPIDataBatch_TB_JobQueue_ALL//Job Queue 01-05-2025
{
    // UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Company; Company)
        {
            dataitem("G/L Account"; "G/L Account")
            {
                RequestFilterFields = "No.";
                trigger OnAfterGetRecord()
                begin

                    Clear(OpeningBalance_gDec);
                    Clear(DebitAmt_gDec);
                    Clear(CreditAmt_gDec);
                    Clear(ClosingBalance_gDec);
                    Clear(GLAPIdataSetup_gRec);
                    GLAPIdataSetup_gRec.Get();

                    if GLAPIdataSetup_gRec."Start Date" <> 0D then
                        StartDate_gDte := GLAPIdataSetup_gRec."Start Date"
                    else
                        StartDate_gDte := 20250101D;
                    if GLAPIdataSetup_gRec."End Date" <> 0D then
                        EndDate_gDte := GLAPIdataSetup_gRec."End Date"
                    else
                        EndDate_gDte := Today;

                    GLEntry_gRec.Reset();
                    GLEntry_gRec.ChangeCompany(Company.Name);
                    GLEntry_gRec.SetRange("G/L Account No.", "G/L Account"."No.");
                    GLEntry_gRec.SetRange("Posting Date", 0D, ClosingDate(StartDate_gDte - 1));  //NG
                    GLEntry_gRec.CalcSums(Amount);
                    OpeningBalance_gDec := Round(GLEntry_gRec.Amount, 0.01);

                    GLEntry_gRec.Reset();
                    GLEntry_gRec.ChangeCompany(Company.Name);
                    GLEntry_gRec.SetRange("G/L Account No.", "G/L Account"."No.");
                    GLEntry_gRec.SetRange("Posting Date", StartDate_gDte, ClosingDate(EndDate_gDte));  //NG
                    GLEntry_gRec.CalcSums("Debit Amount", "Credit Amount");
                    DebitAmt_gDec := Round(GLEntry_gRec."Debit Amount", 0.01);
                    CreditAmt_gDec := Round(GLEntry_gRec."Credit Amount", 0.01);

                    ClosingBalance_gDec := OpeningBalance_gDec + DebitAmt_gDec - CreditAmt_gDec;

                    MakeExcelDataBody_lFnc();
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Account Type", "G/L Account"."Account Type"::Posting);
                end;


            }
            //G/L Account
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin


            end;

            trigger OnAfterGetRecord()
            begin
                GLEntry_gRec.ChangeCompany(Company.Name);
                DimensionValue_gRec.ChangeCompany(Company.Name);
                GLSetup_gRec.ChangeCompany(Company.Name);
                "G/L Account".ChangeCompany(Company.Name);
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

                }
            }
        }

    }
    trigger OnPostReport()
    begin
        // CreateExcelBook_lFnc();
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
        GLAPIData_gRec."Company Name" := Company.Name;
        GLAPIData_gRec."G/L Account No." := "G/L Account"."No.";
        GLAPIData_gRec."G/L Account Name" := "G/L Account".Name;
        GLAPIData_gRec."Opening Balance" := OpeningBalance_gDec;
        GLAPIData_gRec."Debit Amount" := DebitAmt_gDec;
        GLAPIData_gRec."Credit Amount" := CreditAmt_gDec;
        GLAPIData_gRec."Net Balance" := DebitAmt_gDec - CreditAmt_gDec;
        GLAPIData_gRec."Closing Balance" := ClosingBalance_gDec;
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
        StartDate_gDte: Date;
        EndDate_gDte: Date;
        DimensionValue_gRec: Record "Dimension Value";
        GLSetup_gRec: Record "General Ledger Setup";
        OpeningBalance_gDec: Decimal;
        ClosingBalance_gDec: Decimal;
        DebitAmt_gDec: Decimal;
        CreditAmt_gDec: Decimal;
        GLEntry_gRec: Record "G/L Entry";
        CustVenName_gTxt: Text;
        Customer_gRec: Record Customer;
        Vendor_gRec: Record Vendor;

        GLAPIData_gRec: Record GLAPIData_TB_ALL;
        StartTime: DateTime;
        EndTime: DateTime;
        Duration: Duration;
        GLAPIdataSetup_gRec: Record GLAPISetup_All;
}