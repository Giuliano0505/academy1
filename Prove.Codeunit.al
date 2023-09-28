codeunit 50100 MyCodeunit
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    local procedure Test()
    var
        IntVal: Integer;
        DecVal: Decimal;
        Msg: Text;
        DatVal: Date;
    begin
        //codice
        IntVal := 27;
        DecVal := 4.25;
        Msg := 'ciao' + 'mondo'; //ciao mondo
        Msg := 'ciao'; //ciao
        Msg := 'mondo'; //modno
        Msg += ' mondo'; //ciao modno

        DatVal := 0D; //data vuota
        DatVal := 20230926D; //26/09/2023


        if Msg <> '' then
            Message(Msg);

        if IntVal > 7 then begin
            DecVal := IntVal;
            DatVal := 0D;
        end else begin
            Msg := 'OK'
            //altre istruzzioni
        end;

        if not ((IntVal <= 0) and (DecVal > 1))
        or (DatVal <> 0D) then begin

        end;

        if IntVal = 0 then
            if DecVal < 2 then begin

            end;
        case IntVal of
            1:
                begin
                    Message(Msg);
                    //...
                end;
            2, 3, 4, 5:
                begin

                end;
            10 .. 20:
                begin

                end;
            else begin

            end;
        end;



    end;



    local procedure AltroTest()
    var
    begin
        //codice
    end;

    var
        A: Integer;

    local procedure DoWhileLoop()
    begin
        myInt := 10;
        while myInt > 0 do begin
            //...
            myInt := myInt - 1;
            //myInt -= 1; forma contratta
            if A = 0 then
                break;
        end;
    end;

    local procedure RepeatUntilLoop()
    var
        Cust: Record Customer;
        TextVal: Text;
        CustomerLbl: Label 'Customer : %1 %2'; //'%1 cliente %2..'
        CustomerErr: Label 'Customer : %1 %2'; //'%1 cliente %2..'

    begin
        myInt := 10;
        repeat
            Message(Format(myInt));

        until myInt > 0;

        Cust.SetRange("Country/Region Code", 'IT');
        if Cust.FindSet() then
            repeat
                Message(Cust.Name);
                // TextVal := 'Cliente' + Cust.Name;
                TextVal := StrSubstNo(CustomerLbl, Cust.Name, cust.Address);
                Message(CustomerLbl, Cust.Name, cust.Address);
                Error('');
            // Confirm('');
            until Cust.Next() = 0;

    end;

    local procedure ForLoop()
    var
        I: Integer;
    begin
        myInt := 3;
        for I := 1 to 3 do begin
            Message(Format(1));
            //...
        end;

    end;

    local procedure ForEachLoop()
    var
        Names: List of [Text];
        I: Integer;
        Txt: Text;
    begin
        Names.Add('Gianni');
        Names.Add('Paolo');
        Names.Add('Marcella');

        for I := 1 to Names.Count() do begin
            Txt := Names.Get(I);

            Message(Txt);
        end;
        //Gianni,Paolo,Marcella

        foreach Txt in Names do begin
            Message(Txt);
        end;

    end;




    local procedure GetRecord()
    var
        Cust: Record Customer;
        SalesP: Record "Salesperson/Purchaser";
        SalesHdr: Record "Sales Header";
        CustNo: Code[20];
    begin
        Message(Cust.Name);  // "stringa vuota"

        Cust.Get('10000');
        Message(Cust.Name);   //nome del cliente

        if SalesP.Get(Cust."Salesperson Code") then
            Message('Esiste agente')
        else
            Message('Agente no settato');



        CustNo := '20000';
        Cust.Get(CustNo);

        SalesHdr.Get(SalesHdr."Document Type"::Order, '1003');


    end;

    local procedure FindSomething()
    var
        Vend: Record Vendor;
        LocCode1: Code[10];
        LocCode2: Code[10];
        Cust: Record Customer;
        SalesHdr: Record "Sales Header";
    begin

        if Vend.FindSet() = true then
            repeat
            until Vend.Next() = 0;

        Vend.Reset();


        //Vend.FindFirst();
        //Vend.FindLast();
        LocCode1 := 'BLU';
        LocCode2 := 'ROSSO';
        Vend.SetFilter(Name, 'A*');
        Vend.SetFilter("Location Code", '%1|%2', LocCode1, Cust."Location Code");
        Vend.SetFilter("Location Code", LocCode1 + '|' + LocCode2);
        Vend.SetFilter("Location Code", 'BLU|ROSSO');
        Vend.SetFilter(Balance, '>50');

        Vend.SetRange(Balance, 1000, 2000);
        Vend.SetRange(Balance, 7000);

        Vend.SetRange(Balance);  //senza parametri = togli i filtri impostati

        Vend.SetFilter(Balance, '>=1000<=2000');

        Vend.SetCurrentKey(Name, City);
        Vend.Ascending := false;
        if not Vend.IsEmpty() then;

        SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice);





    end;

    local procedure WriteSomething()
    var
        Vend: Record Vendor;
        Cust: Record Customer;
        SalesHdr: Record "Sales Header";
    begin

        Cust."No." := 'TEST-01';
        Cust.Name := 'Sono io';
        //...
        if not Cust.Insert() then;
        //....

        Cust.Get('10000');
        Cust.Name := 'Paolo Rossi'; //non parte il trigger onvalidate 
        Cust.Validate(Name, 'Paolo Rossi'); //fa partire il trigger onvalidate
        Cust.City := 'Vicenza';
        //...
        Cust.Modify(true);
        Cust.SetRange("Location Code", 'BLU');
        if Cust.FindSet() then
            repeat
                Cust."Location Code" := 'ROSSO';
                Cust.Modify();
            until Cust.Next() = 0;

        Cust.SetRange("Location Code", 'BLU');
        Cust.ModifyAll("Location Code", 'ROSSO', true);  //metodo piu veloce


        Cust.Get('10000');
        Cust.Delete();

        Cust.SetRange("Location Code", 'BLU');
        //if Cust.FindSet() then  legge tutto 
        if not Cust.IsEmpty then   //cancella solo se c'è qualcosa
            Cust.DeleteAll();






    end;





}