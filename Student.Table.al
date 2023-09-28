table 50100 Student
{
    DataClassification = CustomerContent;
    Caption = 'Student';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nr.';

        }
        field(2; "Last Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';

        }
        field(3; "First Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';

        }
        field(4; city; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; Country; Text[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(10; Gender; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Gender';
            OptionMembers = " ",Male,Female;
            OptionCaption = ' ,Male,Female';
        }
        field(11; "Date of Birth"; Date)
        {

            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //Calcolo dell'età
                //Age ;= ...;
            end;
        }
        field(12; Age; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Average Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(21; Graduated; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(Key02; Country, "Average Rating")
        {


        }
    }


    trigger OnInsert()
    begin
        TestField(Code);

        if Rec.Graduated then
            Rec."Average Rating" := 100;
    end;

    trigger OnRename()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnModify()
    begin

    end;






}