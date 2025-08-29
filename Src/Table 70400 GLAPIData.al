table 70400 GLAPIData
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "G/L Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Location Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Location Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cost Center Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Cost Center Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Market Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Market Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Combination; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Opening Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Net Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Closing Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "IC Partner"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "IC Partner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Company Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    // trigger OnInsert()
    // var
    //     GLrec_lrec: Record GLAPIData;

    // begin
    //     if GLrec_lrec.FindLast() then begin
    //         EntryNo := GLrec_lrec."EntryNo" + 1;
    //     end else begin
    //         EntryNo := 1;
    //     end;
    // end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}