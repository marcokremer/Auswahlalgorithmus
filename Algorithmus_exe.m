%führt den gesamten Algorithmus einmal aus
%Algorithmus
%-----------
% 0. Initialisierung (Input: Eingaben vom Nutzer / automatische Vorbelegung
% / Initialwerte_Erfahrung.mat, Output: workspace_Algorithmus_Initialisierung.mat)
% 1. Aktionsraum erstellen (Modul; Input: Initialwerte_Erfahrung.mat, workspace_Algorithmus_Initialisierung.mat, Output: Aktionsraum.mat)
% 2. Umweltzustände ermitteln (Modul; Input:- ,  Output: Umweltzustand.mat)
% 3. Transformation Aktions- und Umweltzustandsraum (Modul; Input: 'Aktionsraum.mat', 'Umweltzustaende.mat', Output: workspace_Aktion_Zustand_trans.mat)
% 4. Ergebnisraum erstellen (Funktion; Input: workspace_Aktion_Zustand_trans.mat,
% Output: Ergebnisraum.mat)
% 5. Auswahl-Algorithmus ausführen (Modul; Input: workspace_Aktion_Zustand_trans.mat, Output: Ergebniswerte_Algorithmus.mat)
% 5.1 Auswahl-Algorithmus verwendet Entscheidungsregel-Funktionen maxEN,
% EBA, Lexi)
%%%%%%%%

Bestandsabfrage='Bestandsabfrage oder neue Eingabe?';
title = 'Auswahlalgorithmus - Dialog';
answer_txt = questdlg(Bestandsabfrage,title,'Bestandsabfrage','neue Eingabe', 'Cancle','Cancle');

if strcmp(answer_txt,'Bestandsabfrage')
    answer=1;
    grenze=50;
    Bestandsabfrage='Welches Data-Set soll bearbeitet werden?';
    title_2 = 'Auswahlalgorithmus - Dialog II';
    answer_txt_2 = questdlg(Bestandsabfrage,title,'1-Algor m Erfhrg','2-Algor o Erfhrg', '3-Zufall','1-Algor m Erfhrg');
else
    if strcmp(answer_txt,'neue Eingabe')
        answer=0;
        grenze=1;
    else
        return
    end
end

% load('alle_Ergebnisse.mat');
% alle_ergebnisse_neu=alle_Ergebnisse(1,:);
% load ('Initialwerte_Erfahrung.mat');
% load 'workspace_Aktion_Zustand_trans.mat';
% load 'Methode_Basic_Ergebnisse.mat';
for h = 1:grenze %h=1 setzen für regulären Betrieb
    otherflag=0;
    if strcmp(answer_txt_2,'1-Algor m Erfhrg')
        create_Aktionsraum;
        create_Umweltzustaende;
        transform_aktionsraum_umweltzustand;
        
        %Fehlermeldung_1='Bitte Zielreihenfolge auswählen und neustarten.';
        Auswahlregel = [("maxEN") ,("EBA"), ("Lexi")]; %Auswahl der Regel durch Nutzer
        if answer==1
            %Nachfolgend wird der Zielvektor manipuliert, bei dem für Genauigkeit 
            %in der Forderung 'hoch' und/oder 'Schätzaufwand in der Forderung
            %'sehr gering/gering' die ersten beiden Plätze reserviert werder.
            %Auf diese Weise wird für die statistische Auswertung ein homogener
            %Datensatz forciert. 
            if strcmp(string(alle_Ergebnisse{h,3}),'hoch')
                if strcmp(string(alle_Ergebnisse{h,4}),'sehr gering/gering')
                a=randperm(2);
                b=randperm(4)+2;
                p=[a b];
                else
                    p= [1 (randperm(5)+1)];
                end
            else
                 if strcmp(string(alle_Ergebnisse{h,4}),'sehr gering/gering')
                 b=randperm(5)+1;
                 b(b==2)=1;
                 p= [2 b];
                 else
                 p=randperm(6);     
                 end
            end
            p=randperm(6); 
           %Zufällige Zielreihenfolge
            q=[1 1 1 1 1 1 ]; %Gleichgewichtung der Ziele
            r=[p;q];
            zielvektor=r(randsample(2,1),:);  %zufällige Auswahl des Zielvektors aus p und q
            % Zielvektoren=cell(1,1);
            % Zielgewichtungen=cell(1,1);
            
            zielgewichtung=[0.5 0.3 0.1 0.06 0.04 0 ]; %Angabe der Zielgewichtung durch Nutzer
            %         zielreihenfolge_vorgabe=[1 2 5 6 4 7 ]; %Angabe der Zielreihenfolge durch Nutzer
            %1-Genauigkeit 2-Schätzaufwand (3-Typ (*wird nicht zur Auswahl
            %gestellt*)) 4-Spezialisierung 5-Informationsbedarf
            %6-Einsatzzeitpunkt 7-Dimension
            Auswahlregel_select=Auswahlregel{randsample(3,1)};
        else
            %nimmt Initialangaben zum Algorithmus auf
            %startet Algorithmus mit Initialangaben
            prompt1 = 'Bitte Zielreihenfolge angeben (wichtigstes Ziel zuerst, Leerzeichen-getrennt; Ziele: 1-Genauigkeit 2-Schätzaufwand * 4-Spezialisierung 5-Informationsbedarf 6-Einsatzzeitpunkt 7-Dimension (*3-Anforderungstyp ist bereits durch Anforderung festgelegt \nund steht nicht zur Auswahl))';
            prompt2 = 'Bitte Zielgewichtung angeben (Summe aller Gewichte muss "1" ergeben, Leerzeichen-getrennt): ';
            definput ={'1 2 4 5 6 7'; '0.5 0.2 0.1 0.1 0.05 0.05'};
            dims=[1 100];
            opts.Interpreter = 'tex';
            ziel_txt = inputdlg({prompt1,prompt2},'Zieleingaben',dims, definput,opts);
            zielvektor=str2num(ziel_txt{1});
            zielgewichtung=str2num(ziel_txt{2});
            
            title = 'Auswahl Entscheidungsregel';
            options= {'maxEN', 'EBA', 'Lexi'};
            definput = {'maxEN'};
            Auswahlregel_select = listdlg('PromptString',Bestandsabfrage,'SelectionMode','single','ListString', options);
        end
        %starte Algorithmus
        Ergebniswert_Algorithmus=do_algorithmus_once(h,Initialwerte_Algorithmus, Auswahlregel_select,zielvektor,zielgewichtung);
    else
        %hier muss jetzt als Datenbasis der weiteren Berechnung
        %1. die Ziele von Datenset1 für Datenset2 und 3 übernommen werden
        %sowie
        %2. die Methoden für Datenset3 aus den Festlegungen aus
        %alle_Ergebnisse entnommen werden
        load 'Ergebniswert_Algorithmus_dummy';
        load('alle_Ergebnisse_Dataset1.mat');
        load('workspace_Algorithmus_Initialisierung.mat');
        Auswahlregel_select=alle_Ergebnisse_dataset1{h,9};
        zielvektor=str2num(alle_Ergebnisse_dataset1{h,10});
        zielgewichtung=str2num(string(alle_Ergebnisse_dataset1{h,11}));
        if strcmp(answer_txt_2,'2-Algor o Erfhrg')
            Ergebniswert_Algorithmus=do_algorithmus_once(h,Initialwerte_Algorithmus, Auswahlregel_select,zielvektor,zielgewichtung);
        else
            load 'Ergebniswert_Algorithmus_dummy';
            Ergebniswert_Algorithmus{h,3}=alle_Ergebnisse_dataset1{h,15};
        end
    end
    
    %Schätzung in Abhängigkeit vom Ergebniswert:
    %ML: nimm Formel
    %Rest: manuelle Bestimmung.
    if answer==1
        if strcmp(string(alle_Ergebnisse.Algorithmus(h)),string(Ergebniswert_Algorithmus.MethodeAlgorithmus(h)))
            %Erfahrungswerte liegen in alle_Ergebnisse.mat vor
            schaetzerg=alle_Ergebnisse{h,13};
            schaetzaufw=alle_Ergebnisse{h,14};
        else
            %Berechne Schätzung neu
            switch string(Ergebniswert_Algorithmus.MethodeAlgorithmus(h))
                case 'ANN'
                    schaetzerg=do_ANN_once(h);
                case 'Basic'
                    schaetzerg=Methode_Basic_Ergebnisse{h,4};
                    schaetzaufw=Methode_Basic_Ergebnisse{h,1};
                case 'BN'
                    schaetzerg=do_BN_once(h);
                case 'CART'
                    schaetzerg=do_CART_once(h);
                case 'CBR'
                    schaetzerg=do_CBR_once(h);
                case 'CBR '
                    schaetzerg=do_CBR_once(h);
                case 'RI'
                    schaetzerg=do_RI_once(h);
                case 'SGB'
                    schaetzerg=do_SGB_once(h);
                case 'SVM'
                    schaetzerg=do_SVM_once(h);
                case 'SWR'
                    %schaetzerg=do_SWR_once(h);
                    schaetzerg=do_RI_once(h);
                otherwise
                    %nimm Ergebnis aus der xls.DB
                    disp(['ID: ',Ergebniswert_Algorithmus.ID(h),'ausgewählte Methode: ',string(Ergebniswert_Algorithmus.MethodeAlgorithmus(h))]);
                    prompt = 'Was ist das Schätzergebnis? (Bitte nur den Wert angeben. Die Dimension wird automatisch aus der Schätzmethode ermittelt!) ';
                    schaetzerg = inputdlg(prompt,'Schätzergebnis');
                    schaetzerg=str2num(schaetzerg{1});
                    otherflag=1;
                    
            end
            
            if strcmp(string(Ergebniswert_Algorithmus.MethodeAlgorithmus(h)),'Basic')
            else
                disp(['ID: ',Ergebniswert_Algorithmus.ID(h),'ausgewählte Methode: ',string(Ergebniswert_Algorithmus.MethodeAlgorithmus(h))]);
                prompt = 'Wie hoch ist der Schätzaufwand in Minuten? ';
                schaetzaufw = inputdlg(prompt,'Schätzaufwand');
                schaetzaufw=str2num(schaetzaufw{1});
            end
        end
        
    else %answer !=1
        disp(['ID: ',Ergebniswert_Algorithmus.ID(h),'ausgewählte Methode: ',string(Ergebniswert_Algorithmus.MethodeAlgorithmus(h))]);
        prompt = 'Was ist das Schätzergebnis? (Bitte nur den Wert angeben. Die Dimension wird automatisch aus der Schätzmethode ermittelt!) ';
        schaetzerg = inputdlg(prompt,'Schätzergebnis');
        schaetzerg=str2num(schaetzerg{1});
        
        prompt = 'Wie hoch ist der Schätzaufwand in Minuten? ';
        schaetzaufw = inputdlg(prompt,'Schätzaufwand');
        schaetzaufw=str2num(schaetzaufw{1});
        otherflag=1;
    end
    
    if answer==1
        %speichere Ergebnis in alle_Ergebnisse
        
        alle_Ergebnisse{h,9}=categorical(Ergebniswert_Algorithmus{h,11});
        alle_Ergebnisse{h,10}=string(num2str(Ergebniswert_Algorithmus{h,12}{1}));
        alle_Ergebnisse{h,11}=categorical(cellstr(num2str(Ergebniswert_Algorithmus{h,13}{1})));
        alle_Ergebnisse{h,12}=Ergebniswert_Algorithmus.MethodeAlgorithmus(h);
        alle_Ergebnisse{h,13}=schaetzerg;
        alle_Ergebnisse{h,14}=schaetzaufw;
        Update_Grdlg=alle_Ergebnisse;
        
    else
        %speichere Ergebniss in neuer DB
        alle_Ergebnisse_neu{h,9}=categorical(Ergebniswert_Algorithmus{h,11});
        alle_Ergebnisse_neu{h,10}=string(num2str(Ergebniswert_Algorithmus{h,12}{1}));
        alle_Ergebnisse_neu{h,11}=categorical(cellstr(num2str(Ergebniswert_Algorithmus{h,13}{1})));
        alle_Ergebnisse_neu{h,12}=Ergebniswert_Algorithmus.MethodeAlgorithmus(h);
        alle_Ergebnisse_neu{h,13}=str2num(schaetzerg{1});
        alle_Ergebnisse_neu{h,14}=str2num(schaetzaufw{1});
        Update_Grdlg=alle_Ergebnisse_neu;
    end
    
    if strcmp(answer_txt_2,'1-Algor m Erfhrg')||answer<1
        if otherflag==1
            Bestandsabfrage='Erfahrungswerte jetzt erfassen?';
            
            title = 'Erfahrungswert erfassen - Dialog';
            answer_Erfahrungswerte = questdlg(Bestandsabfrage,title,'Cancel');
            if strcmp(answer_Erfahrungswerte,'Yes')
                update_Erfahrungswerte_manually(h,answer,schaetzaufw,Update_Grdlg);
            end
        else
            update_Erfahrungswerte(h,answer, schaetzerg,schaetzaufw,Update_Grdlg );
        end
    end
    %     Initialwerte_Algorithmus=Ergebniswert_Algorithmus;
    
    if answer==1
        switch answer_txt_2
            case '1-Algor m Erfhrg'
                alle_Ergebnisse_dataset1=alle_Ergebnisse;
                save('alle_Ergebnisse_dataset1.mat','alle_Ergebnisse_dataset1');
            case '2-Algor o Erfhrg'
                alle_Ergebnisse_dataset2=alle_Ergebnisse;
                save('alle_Ergebnisse_dataset2.mat','alle_Ergebnisse_dataset2');
            case '3-Zufall'
                alle_Ergebnisse_dataset3=alle_Ergebnisse;
                save('alle_Ergebnisse_dataset3.mat','alle_Ergebnisse_dataset3');
        end
    else
        save('alle_Ergebnisse_neu.mat','alle_Ergebnisse_neu');
    end
end





