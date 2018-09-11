function Ergebnisraum = create_Ergebnisraum(k)
load 'workspace_Aktion_Zustand_trans.mat'; % benötigt 

%Ergebnisvektoren bestimmen:
% Der Wert der Dimensionen ‚Anwendbarkeit‘, ‚Spezialisierung‘, ‚Informationsbedarf‘, ‚Einsatzzeitpunkt‘ und ‚Ergebnisdimension‘ wird nach folgender Bildungsvorschrift  festgelegt:
% „Vergleiche die Ausprägung der Dimension der betrachteten Alternative mit derjeni-gen des betrachteten Umweltzustands: bei Gleichheit, vergebe das Ergebnis ‚1‘, sonst vergebe das Ergebnis ‚0‘.“
% Für die Dimensionen Genauigkeit und Aufwand wird folgende Bildungsvorschrift festgelegt:
% „1. Lege für jede Ausprägungen der Dimension eine Eintrittswahrscheinlichkeit ge-mäß den aktuellen Erfahrungswerten fest, sodass die Summe der Eintrittswahrschein-lichkeiten gleich ‚1‘ ist und eine Verteilungsfunktion entsteht.  
% 2. Ermittle eine randomisierte Zufallszahl, dessen Wertebereich zwischen ‚0‘ und ‚1‘ liegt.
% 3. Ermittle anhand des Wertes der Zufallszahl in der Verteilungsfunktion eine Di-mensionsausprägung.
% 4. Vergleiche die so ermittelte Dimensionsausprägung der betrachteten Alternative mit derjenigen des betrachteten Umweltzustands: bei Gleichheit, vergebe das Ergeb-nis ‚1‘, sonst vergebe das Ergebnis ‚0‘.“



Ergebnisraum=zeros(14,7); %14 methoden mit 7 Merkmalen
%jedes Merkmal abgleichen mit entsprechendem Umweltzustand
%k=1; %für erste Anforderung. k muss bei Funktionsaufruf übergeben werden.

for i= 1:14 %alle Methoden
    
for j=1:7 %alle Eigenschaften
    switch j
        case 3 %Typ
            Ergebnisraum(i,j)=1;
        case 4 %Spezialisierung
            if strcmp(Umweltzustand_trans{k,j},'Andere') && strcmp(Aktionsraum_trans{i,j+2},'keine')
                Ergebnisraum(i,j)=1;
            else
                if strcmp(Aktionsraum_trans{i,j+2},Umweltzustand_trans{k,j})
                    Ergebnisraum(i,j)=1;
            else
                end
            end
        case 5 %Informationsbedarf
            if strcmp(Aktionsraum_trans{i,j+2},Umweltzustand_trans{k,j})
                Ergebnisraum(i,j)=1;
            end
        case 7 %Dimension
            Ergebnisraum(i,j)=1;
        otherwise  %Genauigkeit,%Schätzaufwand, %Einsatzzeitpunkt
            if Aktionsraum_trans{i,j+2} < Umweltzustand_trans{k,j}
            else
                Ergebnisraum(i,j)=1;
            end
    end
end
end

% save ('Ergebnisraum.mat', 'Ergebnisraum');
