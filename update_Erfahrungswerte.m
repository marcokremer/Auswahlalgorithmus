%update Erfahrungswerte
function update_Erfahrungswerte(Anforderung_ID,old_case, realaufw,schaufw,alle_Ergebnisse )
load ('Initialwerte_Erfahrung.mat');
load ('Historische_Werte.mat');

% Bestandsabfrage='Erfahrungswerte im Master Thesis Set bearbeiten?';
% 
% title = 'Erfahrungswert erfassen - Dialog';
% % options= {'ja', 'nein'};
% % definput = {'Bestandsabfrage'};
% % answer = listdlg('PromptString',Bestandsabfrage,'SelectionMode','single','ListString', options);
% answer = questdlg(Bestandsabfrage,title,'Cancel');
% 
% prompt = 'Welche Anforderung_ID soll bearbeitet werden? ';
% Anforderung_ID_txt = inputdlg(prompt,'Anforderung_ID');
% Anforderung_ID=str2num(Anforderung_ID_txt{1});


% if old_case==1
%     load('alle_Ergebnisse.mat');
    
    anforderung=table2cell(alle_Ergebnisse(Anforderung_ID,:));
    
    %insert error handling for case ID not found
% else
% %     if old_case==0
%         load('alle_Ergebnisse_neu.mat');
%         anforderung=table2cell(alle_Ergebnisse_neu(Anforderung_ID,:));
%         %insert error handling for case ID not found
% %     else
% %         return
% %     end
% end

% if isempty(anforderung{18})
%     prompt = 'Wie hoch ist der reale Entwicklungsaufwand in Entwickler-Stunden? ';
%     realaufw_txt = inputdlg(prompt,'Entwicklungsaufwand');
%     realaufw=str2num(realaufw_txt{1});
    genauigkeit_MRE=abs(realaufw-anforderung{13})/realaufw;
% else
%     genauigkeit_MRE=abs(anforderung{18}-anforderung{13})/anforderung{18};
% end

% if isempty(anforderung{14})
%     prompt = 'Wie hoch war der Schätzaufwand in Minuten? ';
%     schaufw_txt = inputdlg(prompt,'Schätzaufwand');
%     schaufw=str2num(schaufw_txt{1});
% else
%     schaufw=anforderung{14};
% end

%update Erfahrungswerte - verändert das aktuelle Schätzergebnis einen Initialwert?
%genauigkeit und schätzaufwand müssen nun in kontext mit den historischen daten gesetzt
%werden --> führt neuer Eintrag zu einer Veränderung?
%Eingabewerte: Historische Daten = alle Ergebnisse (bis zur und einschließlich ID). Ausgabe
%Genauigkeit (muss in categorical transformiert werden) und Aufwand
%(muss in categorical transformiert werden)
%Eintrag Ergebnis in Initialwerte_Erfahrung
%bn: Mdl = fitcnb(Training,Anforderung_Uebersicht(1:Anforderung_ID(i)-1,16),'CategoricalPredictors',categorical_vektor );
%Fragen klären: 1. Umrechnung Genauigkeit (~ML bzw. algorithmische
%Kostenmodelle)
%2. Umrechnung Schätzaufwand

%Vorgehen: Arithemtrisches Mittel aus historischen Daten und aktuellem
%Wert führt zu Festlegung neuer Initialwert

%Welche Methode ist betroffen?
%anforderung{12}
%Feldname von Struct:
feld_name=string(anforderung{12});
% feld_name(feld_name==' ') = [];
feld_name = strrep(feld_name, ' ', '');
new_entry=size(History.(feld_name).MMRE,2)+1;
if History.(feld_name).MMRE(new_entry-1)==0
    History.(feld_name).MMRE(new_entry-1)=genauigkeit_MRE;
else
    History.(feld_name).MMRE(new_entry)=genauigkeit_MRE;
end
Erfahrung_genau_aktuell=mean(History.(feld_name).MMRE);

new_entry=size(History.(feld_name).Mean_Schaetzaufwand,2)+1;
if isnan(History.(feld_name).Mean_Schaetzaufwand(new_entry-1))
    History.(feld_name).Mean_Schaetzaufwand(new_entry-1)=schaufw;
else
    History.(feld_name).Mean_Schaetzaufwand(new_entry)=schaufw;
end
Erfahrung_aufwand_aktuell=mean(History.(feld_name).Mean_Schaetzaufwand);

%Eintragung der neuen Werte in die Initialwerte_Tabelle
%Initialwerte_Erfahrung_ID=Initialwerte_Erfahrung{contains(cellstr(Initialwerte_Erfahrung.Methode_Name),string(anforderung{12}))};
Initialwerte_Erfahrung_ID=contains(Initialwerte_Erfahrung.Methode_Name,string(anforderung{12}));

Initialwerte_Erfahrung.(6)(Initialwerte_Erfahrung_ID)= Erfahrung_genau_aktuell;
Initialwerte_Erfahrung.(7)(Initialwerte_Erfahrung_ID)= Erfahrung_aufwand_aktuell;

%dynamische Intervallgrenzen der Skalentransformation
Erfahrung_MMRE=Initialwerte_Erfahrung.(6);
max_MMRE=max(Erfahrung_MMRE);
min_MMRE=min(Erfahrung_MMRE(Erfahrung_MMRE>0));
for i=1:14
    if Erfahrung_MMRE(i)>0
    if Erfahrung_MMRE(i)<=(min_MMRE+(max_MMRE-min_MMRE)/3)
        Initialwerte_Erfahrung.(3)(i)='hoch';
    else
        if Erfahrung_MMRE(i)>(min_MMRE+2*(max_MMRE-min_MMRE)/3)
            Initialwerte_Erfahrung.(3)(i)='gering';
        else
            Initialwerte_Erfahrung.(3)(i)='mittel';
        end
    end
    end
end

%erst Erfahrungswerte aktualisieren, sobald für jede Methode
%Erfahrungswerte bestehen
Erfahrung_Mean_Schaetzaufwand=Initialwerte_Erfahrung.(7);
if size(Erfahrung_Mean_Schaetzaufwand,1)==size(Erfahrung_Mean_Schaetzaufwand(Erfahrung_Mean_Schaetzaufwand>0),1)
    max_Mean_Schaetzaufwand=max(Erfahrung_Mean_Schaetzaufwand);
    min_Mean_Schaetzaufwand=min(Erfahrung_Mean_Schaetzaufwand(Erfahrung_Mean_Schaetzaufwand>0));
    for i=1:14
        if Erfahrung_Mean_Schaetzaufwand(i)<=(min_Mean_Schaetzaufwand+(max_Mean_Schaetzaufwand-min_Mean_Schaetzaufwand)/5)
            Initialwerte_Erfahrung.(4)(i)='sehr gering';
        else
            if Erfahrung_Mean_Schaetzaufwand(i)>(min_Mean_Schaetzaufwand+4*(max_Mean_Schaetzaufwand-min_Mean_Schaetzaufwand)/5)
                Initialwerte_Erfahrung.(4)(i)='sehr hoch';
            else
                if (Erfahrung_Mean_Schaetzaufwand(i)>(min_Mean_Schaetzaufwand+(max_Mean_Schaetzaufwand-min_Mean_Schaetzaufwand)/5))&&(Erfahrung_aufwand_aktuell<=(min_Mean_Schaetzaufwand+2*(max_Mean_Schaetzaufwand-min_Mean_Schaetzaufwand)/5))
                    Initialwerte_Erfahrung.(4)(i)='gering';
                end
                if (Erfahrung_Mean_Schaetzaufwand(i)>(min_Mean_Schaetzaufwand+2*(max_Mean_Schaetzaufwand-min_Mean_Schaetzaufwand)/5))&&(Erfahrung_aufwand_aktuell<=(min_Mean_Schaetzaufwand+3*(max_Mean_Schaetzaufwand-min_Mean_Schaetzaufwand)/5))
                    Initialwerte_Erfahrung.(4)(i)='mittel';
                end
                if (Erfahrung_Mean_Schaetzaufwand(i)>(min_Mean_Schaetzaufwand+3*(max_Mean_Schaetzaufwand-min_Mean_Schaetzaufwand)/5))&&(Erfahrung_aufwand_aktuell<=(min_Mean_Schaetzaufwand+4*(max_Mean_Schaetzaufwand-min_Mean_Schaetzaufwand)/5))
                    Initialwerte_Erfahrung.(4)(i)='hoch';
                end
            end
        end
    end
end

save('Historische_Werte.mat','History');
save('Initialwerte_Erfahrung.mat','Initialwerte_Erfahrung');
end

