report 70409 GLAPIDataBatch_ICPartner_India
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'GLAPIDataBatch_ICPartner_India';
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
                Curr_gInt += 1;
                // Win_gDlg.Update(2, Curr_gInt);

                Clear(GLSetup_gRec);
                GLSetup_gRec.Get;

                CustVenName_gTxt := '';
                if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Customer then begin
                    //11-04-2025 Changes for IC Partner Breakup
                    Customer_gRec.Reset();
                    Customer_gRec.SetRange("IC Partner Code", "G/L Entry"."IC Partner Code");
                    if Customer_gRec.FindFirst() then
                        // if Customer_gRec.Get("G/L Entry"."Source No.") then //11-04-2025
                        CustVenName_gTxt := Customer_gRec.Name;
                end else if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor then begin
                    if Vendor_gRec.Get("G/L Entry"."Source No.") then
                        CustVenName_gTxt := Vendor_gRec.Name;
                End;

                "G/L Entry".CalcFields("G/L Account Name");
                Clear(LocationName_gTxt);
                Clear(CostCenterName_gTxt);
                Clear(MarketName_gTxt);
                Clear(OpeningBalance_gDec);
                Clear(DebitAmt_gDec);
                Clear(CreditAmt_gDec);
                Clear(ClosingBalance_gDec);
                Clear(MonthNumber_gInt);
                Clear(Day_gInt);
                Clear(Year_gInt);
                Clear(NewJanDate_gInt);
                Clear(PrejanDate_gInt);

                MonthNumber_gInt := DATE2DMY(StartDate_gDte, 2);
                Year_gInt := DATE2DMY(StartDate_gDte, 3);
                Day_gInt := DATE2DMY(StartDate_gDte, 1);
                NewJanDate_gInt := DMY2DATE(1, 1, Year_gInt);
                PrejanDate_gInt := DMY2DATE(1, 1, Year_gInt - 1);
                GLAccount_gRec.Get("G/L Entry"."G/L Account No.");

                CalcFields("Shortcut Dimension 3 Code");
                DimensionValue_gRec.Reset();

                DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Global Dimension 1 Code");
                DimensionValue_gRec.SetRange(code, "G/L Entry"."Global Dimension 1 Code");
                if DimensionValue_gRec.FindFirst() then
                    LocationName_gTxt := DimensionValue_gRec.Name;

                DimensionValue_gRec.Reset();

                DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Global Dimension 2 Code");
                DimensionValue_gRec.SetRange(code, "G/L Entry"."Global Dimension 2 Code");
                if DimensionValue_gRec.FindFirst() then
                    CostCenterName_gTxt := DimensionValue_gRec.Name;
                DimensionValue_gRec.Reset();

                DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Shortcut Dimension 3 Code");
                DimensionValue_gRec.SetRange(code, "G/L Entry"."Shortcut Dimension 3 Code");
                if DimensionValue_gRec.FindFirst() then
                    MarketName_gTxt := DimensionValue_gRec.Name;


                if ConsText_gTxt <> "G/L Entry"."G/L Account No." + "G/L Entry"."Global Dimension 1 Code" + "G/L Entry"."Global Dimension 2 Code" + "G/L Entry"."Shortcut Dimension 3 Code" + "G/L Entry"."Source No." then begin
                    if (MonthNumber_gInt = 1) and (Day_gInt = 1) then begin
                        GLAccount_gRec.Get("G/L Entry"."G/L Account No.");
                        if (GLAccount_gRec."Income/Balance" = GLAccount_gRec."Income/Balance"::"Income Statement") then begin
                            OpeningBalance_gDec := 0;
                        end else begin
                            GLEntry_gRec.Reset();
                            GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                            GLEntry_gRec.SetRange("Posting Date", 0D, CalcDate('-1D', StartDate_gDte));
                            GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                            GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                            GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                            GLEntry_gRec.SetRange("Source No.", "G/L Entry"."Source No.");
                            // GLEntry_gRec.CalcSums(Amount);
                            // OpeningBalance_gDec := Round(GLEntry_gRec.Amount, 0.01);
                            //14-05-2025-NS
                            if GLEntry_gRec.FindSet() then
                                repeat
                                    if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then
                                        OpeningBalance_gDec += Round(GLEntry_gRec.Amount, 0.01);
                                until GLEntry_gRec.Next() = 0;
                            //14-05-2025-NE
                        end;

                    end else begin
                        GLAccount_gRec.Get("G/L Entry"."G/L Account No.");
                        if (GLAccount_gRec."Income/Balance" = GLAccount_gRec."Income/Balance"::"Income Statement") then begin
                            /* GLEntry_gRec.Reset();
                            GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                            GLEntry_gRec.SetRange("Posting Date", NewJanDate_gInt, CalcDate('-1D', StartDate_gDte));
                            GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                            GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                            GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                            GLEntry_gRec.SetRange("Source No.", "G/L Entry"."Source No.");
                            GLEntry_gRec.CalcSums(Amount);
                            OpeningBalance_gDec := Round(GLEntry_gRec.Amount, 0.01); */
                            GLEntry_gRec.Reset();
                            GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                            GLEntry_gRec.SetRange("Posting Date", NewJanDate_gInt, CalcDate('-1D', StartDate_gDte));
                            GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                            GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                            GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                            GLEntry_gRec.SetRange("Source No.", "G/L Entry"."Source No.");
                            if GLEntry_gRec.FindSet() then
                                repeat
                                    if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then
                                        OpeningBalance_gDec += Round(GLEntry_gRec.Amount, 0.01);
                                until GLEntry_gRec.Next() = 0;
                        end else begin
                            GLEntry_gRec.Reset();
                            GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                            GLEntry_gRec.SetRange("Posting Date", 0D, CalcDate('-1D', StartDate_gDte));
                            GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                            GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                            GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                            GLEntry_gRec.SetRange("Source No.", "G/L Entry"."Source No.");
                            // GLEntry_gRec.CalcSums(Amount);
                            // OpeningBalance_gDec := Round(GLEntry_gRec.Amount, 0.01);
                            //14-05-2025-NS
                            if GLEntry_gRec.FindSet() then
                                repeat
                                    if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then
                                        OpeningBalance_gDec += Round(GLEntry_gRec.Amount, 0.01);
                                until GLEntry_gRec.Next() = 0;
                            //14-05-2025-NE
                        end;

                    end;

                    GLEntry_gRec.Reset();
                    GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                    GLEntry_gRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                    GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                    GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                    GLEntry_gRec.SetRange("Source No.", "G/L Entry"."Source No.");
                    // GLEntry_gRec.CalcSums("Debit Amount", "Credit Amount");
                    // DebitAmt_gDec := Round(GLEntry_gRec."Debit Amount", 0.01);
                    // CreditAmt_gDec := Round(GLEntry_gRec."Credit Amount", 0.01);
                    //14-05-2024-NS
                    if GLEntry_gRec.FindSet() then
                        repeat
                            if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then begin
                                DebitAmt_gDec += Round(GLEntry_gRec."Debit Amount", 0.01);
                                CreditAmt_gDec += Round(GLEntry_gRec."Credit Amount", 0.01);
                            end;
                        until GLEntry_gRec.Next() = 0;
                    //14-05-2024-NE

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
        RetainedEarningsGL_gDec: Decimal;
        RetainedEarningsGLEntry_gRec: Record "G/L Entry";
        MonthNumber_gInt: Integer;
        Day_gInt: Integer;
        Year_gInt: Integer;
        NewJanDate_gInt: Date;
        PrejanDate_gInt: Date;
        GLAccount_gRec: Record "G/L Account";
}