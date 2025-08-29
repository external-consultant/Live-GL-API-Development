Report 70401 "GL Entry Gain Loss Source Fnd"
{
    //T52067-N
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    //DefaultLayout = RDLC;
    //RDLCLayout = './Layouts/R70401.rdl';
    Permissions = tabledata "G/L Entry" = RM, tabledata "Detailed Vendor Ledg. Entry" = RM, tabledata "Detailed Cust. Ledg. Entry" = RM, tabledata "Bank Account Ledger Entry" = RM;
    dataset
    {
        dataitem(ExchRateAdjReg; "Exch. Rate Adjmt. Reg.")
        {

            RequestFilterFields = "No.";


            trigger OnAfterGetRecord()
            var
                ModGlEntry_lRec: Record "G/L Entry";
                OtherLegModGlEntry_lRec: Record "G/L Entry";
                DetailCustLedEntry_lRec: Record "Detailed Cust. Ledg. Entry";
                DetailVendLedEntry_lRec: Record "Detailed Vendor Ledg. Entry";
                TotalAmtLCyDLE_lDec: Decimal;
            begin
                Curr_gInt += 1;
                Win_gDlg.Update(2, Curr_gInt);

                ExchRateAdjReg.CalcFields("Adjusted Customers", "Adjusted Vendors");

                IF ExchRateAdjReg."Adjusted Customers" > 1 Then begin

                    TotalAmtLCyDLE_lDec := 0;
                    DetailCustLedEntry_lRec.RESET;
                    DetailCustLedEntry_lRec.SetRange("Exch. Rate Adjmt. Reg. No.", ExchRateAdjReg."No.");
                    //DetailCustLedEntry_lRec.SetRange("Applied Exchange GL Entry No.", 0);
                    IF DetailCustLedEntry_lRec.FindSet() Then Begin
                        repeat
                            TotalAmtLCyDLE_lDec += DetailCustLedEntry_lRec."Amount (LCY)";
                        until DetailCustLedEntry_lRec.Next() = 0;
                    End;

                    IF TotalAmtLCyDLE_lDec <> 0 Then begin

                        ModGlEntry_lRec.RESET;
                        ModGlEntry_lRec.RESET;
                        ModGlEntry_lRec.SetRange("Source Code", 'EXCHRATADJ');
                        ModGlEntry_lRec.SetRange("Document No.", DetailCustLedEntry_lRec."Document No.");
                        ModGlEntry_lRec.SetRange("Transaction No.", DetailCustLedEntry_lRec."Transaction No.");
                        ModGlEntry_lRec.SetRange(Amount, TotalAmtLCyDLE_lDec);
                        ModGlEntry_lRec.SetRange("Source Type", ModGlEntry_lRec."Source Type"::" ");
                        IF ModGlEntry_lRec.FindFirst() Then begin
                            ModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::Customer;
                            ModGlEntry_lRec."Source No." := DetailCustLedEntry_lRec."Customer No.";
                            ModGlEntry_lRec."Applied Exchange Detail EntNo." := 0;
                            ModGlEntry_lRec.Modify();


                            OtherLegModGlEntry_lRec.RESET;
                            OtherLegModGlEntry_lRec.SetRange("Source Code", 'EXCHRATADJ');
                            OtherLegModGlEntry_lRec.SetRange("Document No.", ModGlEntry_lRec."Document No.");
                            OtherLegModGlEntry_lRec.SetRange("Posting Date", ModGlEntry_lRec."Posting Date");
                            OtherLegModGlEntry_lRec.SetRange("Transaction No.", ModGlEntry_lRec."Transaction No.");
                            OtherLegModGlEntry_lRec.SetRange(Amount, -1 * ModGlEntry_lRec.Amount);
                            OtherLegModGlEntry_lRec.SetRange("Source Type", ModGlEntry_lRec."Source Type"::" ");
                            IF OtherLegModGlEntry_lRec.FindFirst() Then begin
                                OtherLegModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::Customer;
                                OtherLegModGlEntry_lRec."Source No." := DetailCustLedEntry_lRec."Customer No.";
                                OtherLegModGlEntry_lRec."Applied Exchange Detail EntNo." := 0;
                                OtherLegModGlEntry_lRec.Modify();
                            End;

                            DetailCustLedEntry_lRec.RESET;
                            DetailCustLedEntry_lRec.SetRange("Exch. Rate Adjmt. Reg. No.", ExchRateAdjReg."No.");
                            IF DetailCustLedEntry_lRec.FindSet() Then Begin
                                repeat
                                    DetailCustLedEntry_lRec."Applied Exchange GL Entry No." := ModGlEntry_lRec."Entry No.";
                                    DetailCustLedEntry_lRec.Modify();
                                until DetailCustLedEntry_lRec.Next() = 0;
                            End;
                        end;

                    End;
                end;


                IF ExchRateAdjReg."Adjusted Vendors" > 1 Then begin

                    TotalAmtLCyDLE_lDec := 0;
                    DetailVendLedEntry_lRec.RESET;
                    DetailVendLedEntry_lRec.SetRange("Exch. Rate Adjmt. Reg. No.", ExchRateAdjReg."No.");
                    //   DetailVendLedEntry_lRec.SetRange("Applied Exchange GL Entry No.", 0);
                    IF DetailVendLedEntry_lRec.FindSet() Then Begin
                        repeat
                            TotalAmtLCyDLE_lDec += DetailVendLedEntry_lRec."Amount (LCY)";
                        until DetailVendLedEntry_lRec.Next() = 0;
                    End;

                    IF TotalAmtLCyDLE_lDec <> 0 Then begin

                        ModGlEntry_lRec.RESET;
                        ModGlEntry_lRec.RESET;
                        ModGlEntry_lRec.SetRange("Source Code", 'EXCHRATADJ');
                        ModGlEntry_lRec.SetRange("Document No.", DetailVendLedEntry_lRec."Document No.");
                        ModGlEntry_lRec.SetRange("Transaction No.", DetailVendLedEntry_lRec."Transaction No.");
                        ModGlEntry_lRec.SetRange(Amount, TotalAmtLCyDLE_lDec);
                        ModGlEntry_lRec.SetRange("Source Type", ModGlEntry_lRec."Source Type"::" ");
                        IF ModGlEntry_lRec.FindFirst() Then begin
                            ModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::Vendor;
                            ModGlEntry_lRec."Source No." := DetailVendLedEntry_lRec."Vendor No.";
                            ModGlEntry_lRec."Applied Exchange Detail EntNo." := 0;
                            ModGlEntry_lRec.Modify();


                            OtherLegModGlEntry_lRec.RESET;
                            OtherLegModGlEntry_lRec.SetRange("Source Code", 'EXCHRATADJ');
                            OtherLegModGlEntry_lRec.SetRange("Document No.", ModGlEntry_lRec."Document No.");
                            OtherLegModGlEntry_lRec.SetRange("Posting Date", ModGlEntry_lRec."Posting Date");
                            OtherLegModGlEntry_lRec.SetRange("Transaction No.", ModGlEntry_lRec."Transaction No.");
                            OtherLegModGlEntry_lRec.SetRange(Amount, -1 * ModGlEntry_lRec.Amount);
                            OtherLegModGlEntry_lRec.SetRange("Source Type", ModGlEntry_lRec."Source Type"::" ");
                            IF OtherLegModGlEntry_lRec.FindFirst() Then begin
                                OtherLegModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::Vendor;
                                OtherLegModGlEntry_lRec."Source No." := DetailVendLedEntry_lRec."Vendor No.";
                                OtherLegModGlEntry_lRec."Applied Exchange Detail EntNo." := 0;
                                OtherLegModGlEntry_lRec.Modify();
                            End;

                            DetailVendLedEntry_lRec.RESET;
                            DetailVendLedEntry_lRec.SetRange("Exch. Rate Adjmt. Reg. No.", ExchRateAdjReg."No.");
                            IF DetailVendLedEntry_lRec.FindSet() Then Begin
                                repeat
                                    DetailVendLedEntry_lRec."Applied Exchange GL Entry No." := ModGlEntry_lRec."Entry No.";
                                    DetailVendLedEntry_lRec.Modify();
                                until DetailVendLedEntry_lRec.Next() = 0;
                            End;
                        end;

                    End;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Win_gDlg.Close;
            end;

            trigger OnPreDataItem()
            var
            begin
                Win_gDlg.Open('Gl Entry Update \ Total #1###########\Current #2############');
                Win_gDlg.Update(1, Count);
                Curr_gInt := 0;
            end;
        }

        dataitem(GLEntry; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Entry No.", "Document No.";




            trigger OnAfterGetRecord()
            var
                ModGlEntry_lRec: Record "G/L Entry";
                OtherLegModGlEntry_lRec: Record "G/L Entry";
            begin
                Curr_gInt += 1;
                Win_gDlg.Update(2, Curr_gInt);

                Clear(BALE_gRec);
                Clear(DCLE_gRec);
                Clear(DVLE_gRec);


                DVLE_gRec.RESET;
                DVLE_gRec.SetRange("Source Code", 'EXCHRATADJ');
                DVLE_gRec.SetRange("Document No.", "Document No.");
                DVLE_gRec.SetRange("Posting Date", "Posting Date");
                DVLE_gRec.SetRange("Transaction No.", "Transaction No.");
                DVLE_gRec.SetFilter("Amount (LCY)", '%1|%2', -1 * Amount, Amount);
                DVLE_gRec.SetRange("Applied Exchange GL Entry No.", 0);
                IF DVLE_gRec.FindFirst() Then begin
                    DVLE_gRec."Applied Exchange GL Entry No." := "Entry No.";
                    DVLE_gRec.Modify();

                    ModGlEntry_lRec.GEt("Entry No.");
                    ModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::Vendor;
                    ModGlEntry_lRec."Source No." := DVLE_gRec."Vendor No.";
                    ModGlEntry_lRec."Applied Exchange Detail EntNo." := DVLE_gRec."Entry No.";
                    ModGlEntry_lRec.Modify();

                    OtherLegModGlEntry_lRec.RESET;
                    OtherLegModGlEntry_lRec.SetRange("Source Code", 'EXCHRATADJ');
                    OtherLegModGlEntry_lRec.SetRange("Document No.", ModGlEntry_lRec."Document No.");
                    OtherLegModGlEntry_lRec.SetRange("Posting Date", ModGlEntry_lRec."Posting Date");
                    OtherLegModGlEntry_lRec.SetRange("Transaction No.", ModGlEntry_lRec."Transaction No.");
                    OtherLegModGlEntry_lRec.SetRange(Amount, -1 * ModGlEntry_lRec.Amount);
                    OtherLegModGlEntry_lRec.SetRange("Source Type", ModGlEntry_lRec."Source Type"::" ");
                    IF OtherLegModGlEntry_lRec.FindFirst() Then begin
                        OtherLegModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::Vendor;
                        OtherLegModGlEntry_lRec."Source No." := DVLE_gRec."Vendor No.";
                        OtherLegModGlEntry_lRec."Applied Exchange Detail EntNo." := DVLE_gRec."Entry No.";
                        OtherLegModGlEntry_lRec.Modify();
                    End;
                end;


                DCLE_gRec.RESET;
                DCLE_gRec.SetRange("Source Code", 'EXCHRATADJ');
                DCLE_gRec.SetRange("Document No.", "Document No.");
                DCLE_gRec.SetRange("Posting Date", "Posting Date");
                DCLE_gRec.SetRange("Transaction No.", "Transaction No.");
                DCLE_gRec.SetFilter("Amount (LCY)", '%1|%2', -1 * Amount, Amount);
                DCLE_gRec.SetRange("Applied Exchange GL Entry No.", 0);
                IF DCLE_gRec.FindFirst() Then begin
                    DCLE_gRec."Applied Exchange GL Entry No." := "Entry No.";
                    DCLE_gRec.Modify();

                    ModGlEntry_lRec.GEt("Entry No.");
                    ModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::Customer;
                    ModGlEntry_lRec."Source No." := DCLE_gRec."Customer No.";
                    ModGlEntry_lRec."Applied Exchange Detail EntNo." := DCLE_gRec."Entry No.";
                    ModGlEntry_lRec.Modify();

                    OtherLegModGlEntry_lRec.RESET;
                    OtherLegModGlEntry_lRec.SetRange("Source Code", 'EXCHRATADJ');
                    OtherLegModGlEntry_lRec.SetRange("Document No.", ModGlEntry_lRec."Document No.");
                    OtherLegModGlEntry_lRec.SetRange("Posting Date", ModGlEntry_lRec."Posting Date");
                    OtherLegModGlEntry_lRec.SetRange("Transaction No.", ModGlEntry_lRec."Transaction No.");
                    OtherLegModGlEntry_lRec.SetRange(Amount, -1 * ModGlEntry_lRec.Amount);
                    OtherLegModGlEntry_lRec.SetRange("Source Type", ModGlEntry_lRec."Source Type"::" ");
                    IF OtherLegModGlEntry_lRec.FindFirst() Then begin
                        OtherLegModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::Customer;
                        OtherLegModGlEntry_lRec."Source No." := DCLE_gRec."Customer No.";
                        OtherLegModGlEntry_lRec."Applied Exchange Detail EntNo." := DCLE_gRec."Entry No.";
                        OtherLegModGlEntry_lRec.Modify();
                    End;
                end;

                BALE_gRec.RESET;
                BALE_gRec.SetRange("Source Code", 'EXCHRATADJ');
                BALE_gRec.SetRange("Document No.", "Document No.");
                BALE_gRec.SetRange("Posting Date", "Posting Date");
                BALE_gRec.SetRange("Transaction No.", "Transaction No.");
                BALE_gRec.SetFilter("Amount (LCY)", '%1|%2', -1 * Amount, Amount);
                BALE_gRec.SetRange("Applied Exchange GL Entry No.", 0);
                IF BALE_gRec.FindFirst() Then begin
                    BALE_gRec."Applied Exchange GL Entry No." := "Entry No.";
                    BALE_gRec.Modify();

                    ModGlEntry_lRec.GEt("Entry No.");
                    ModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::"Bank Account";
                    ModGlEntry_lRec."Source No." := BALE_gRec."Bal. Account No.";
                    ModGlEntry_lRec."Applied Exchange Detail EntNo." := BALE_gRec."Entry No.";
                    ModGlEntry_lRec.Modify();

                    OtherLegModGlEntry_lRec.RESET;
                    OtherLegModGlEntry_lRec.SetRange("Source Code", 'EXCHRATADJ');
                    OtherLegModGlEntry_lRec.SetRange("Document No.", ModGlEntry_lRec."Document No.");
                    OtherLegModGlEntry_lRec.SetRange("Posting Date", ModGlEntry_lRec."Posting Date");
                    OtherLegModGlEntry_lRec.SetRange("Transaction No.", ModGlEntry_lRec."Transaction No.");
                    OtherLegModGlEntry_lRec.SetRange(Amount, -1 * ModGlEntry_lRec.Amount);
                    OtherLegModGlEntry_lRec.SetRange("Source Type", ModGlEntry_lRec."Source Type"::" ");
                    IF OtherLegModGlEntry_lRec.FindFirst() Then begin
                        OtherLegModGlEntry_lRec."Source Type" := ModGlEntry_lRec."Source Type"::"Bank Account";
                        OtherLegModGlEntry_lRec."Source No." := BALE_gRec."Bal. Account No.";
                        OtherLegModGlEntry_lRec."Applied Exchange Detail EntNo." := BALE_gRec."Entry No.";
                        OtherLegModGlEntry_lRec.Modify();
                    End;
                end;

            end;

            trigger OnPostDataItem()
            begin
                Win_gDlg.Close;
            end;

            trigger OnPreDataItem()
            var
                UpdateExistingBankGlEntry_lRec: Record "G/L Entry";
                ModifyDiffLegGLENtry_lRec: Record "G/L Entry";
            begin
                UpdateExistingBankGlEntry_lRec.RESET;
                UpdateExistingBankGlEntry_lRec.SetRange("Source Code", 'EXCHRATADJ');
                UpdateExistingBankGlEntry_lRec.SetRange("Source Type", UpdateExistingBankGlEntry_lRec."Source Type"::"Bank Account");
                IF UpdateExistingBankGlEntry_lRec.FindSet() Then begin
                    Win_gDlg.Open('bank Enrty Updat \ Total #1###########\Current #2############');
                    Win_gDlg.Update(1, UpdateExistingBankGlEntry_lRec.Count);
                    repeat
                        Curr_gInt += 1;
                        Win_gDlg.Update(2, Curr_gInt);
                        ModifyDiffLegGLENtry_lRec.RESET;
                        ModifyDiffLegGLENtry_lRec.SetRange("Source Code", 'EXCHRATADJ');
                        ModifyDiffLegGLENtry_lRec.SetRange("Document No.", UpdateExistingBankGlEntry_lRec."Document No.");
                        ModifyDiffLegGLENtry_lRec.SetRange("Transaction No.", UpdateExistingBankGlEntry_lRec."Transaction No.");
                        ModifyDiffLegGLENtry_lRec.SetRange(Amount, -1 * UpdateExistingBankGlEntry_lRec.Amount);
                        ModifyDiffLegGLENtry_lRec.SetRange("Source Type", ModifyDiffLegGLENtry_lRec."Source Type"::" ");
                        IF ModifyDiffLegGLENtry_lRec.FindFirst() Then begin
                            ModifyDiffLegGLENtry_lRec."Source Type" := UpdateExistingBankGlEntry_lRec."Source Type";
                            ModifyDiffLegGLENtry_lRec."Source No." := UpdateExistingBankGlEntry_lRec."Source No.";
                            ModifyDiffLegGLENtry_lRec.Modify();
                        end;
                    until UpdateExistingBankGlEntry_lRec.Next() = 0;
                    Win_gDlg.Close();
                end;

                SetRange("Source Code", 'EXCHRATADJ');
                SetRange("Source Type", "Source Type"::" ");
                SetFilter(Amount, '<%1', 0);

                Win_gDlg.Open('Gl Entry Update \ Total #1###########\Current #2############');
                Win_gDlg.Update(1, Count);
                Curr_gInt := 0;
            end;
        }


    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Win_gDlg: Dialog;
        Curr_gInt: Integer;
        BALE_gRec: Record "Bank Account Ledger Entry";
        DCLE_gRec: Record "Detailed Cust. Ledg. Entry";
        DVLE_gRec: Record "Detailed Vendor Ledg. Entry";
}
