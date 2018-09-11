%Entscheidungsregel EbA
% Die Regel wird durch den Entscheider durch folgendes Vorgehen initialisiert:
% 1.	Lege die relevanten Auswahlkriterien fest.
% 2.	Lege die Selektionsstufen der relevanten Auswahlkriterien fest.
% 3.	Starte den Auswahlalgorithmus.
% Der Auswahlalgorithmus  arbeitet dann wie folgt:
% 4.	Lege eine Betrachtungsreihenfolge der Kriterien fest.
% 5.	Betrachte die Kriterien gemäß ihrer Reihenfolge, beginnend mit dem ersten Kriterium.
% 6.	Stoppe den Algorithmus, wenn alle Kriterien betrachtet wurden. In diesem Fall, wähle aus den verbliebenen Methoden eine mit gleicher Wahrscheinlichkeit aus.
% 7.	Ordne jeder Methode den Nutzen ‚1‘ zu, wenn ihre Ausprägung in der Kriteriumsdimen-sion gleich der Selektionsstufe des Kriteriums ist.
% 8.	Ordne jeder Methode den Nutzen ‚0‘ zu, wenn ihre Ausprägung in der Kriteriumsdimen-sion ungleich der Selektionsstufe des Kriteriums ist.
% 9.	Vergleiche alle Methoden bezüglich der Selektionsstufe des Kriteriums.
% 10.	Falls genau eine Methode bezüglich des Kriteriums den Nutzen ‚1‘ aufweist, wähle diese Methode als optimalen Schätzer aus.
% 11.	Falls mehr als eine Methode bezüglich des Kriteriums den Nutzen ‚1‘ aufweist, eliminiere alle unterlegenen Methoden und betrachte die verbliebenen Methoden bezüglich des nächste Kriteriums. Verfahre weiter ab Punkt 6.
% 12.	Falls keine Methode bezüglich des Kriteriums den Nutzen ‚1‘ aufweist, betrachte das nächste Kriterium. Verfahre weiter ab Punkt 6.

function Methode_select = EBA(ziel, Ergebnisraum_k)

Ergebnisraum_k=[Ergebnisraum_k (1:14)']; %hilft, die Methoden am Ende der Eliminierung identifizieren zu können.
for i=1:6 %do while mit size(Ergebnisraum_k,1) == 1 geht auch
    %finde max der Spalte
    %eliminiere alle Zeilen, deren Werte kleiner max ist
    Ergebnisraum_k=Ergebnisraum_k(Ergebnisraum_k(:,ziel(1,i))==max(Ergebnisraum_k(:,ziel(1,i))),:);
    %Anz Zeilen ==1 -> wähle Methode
    if size(Ergebnisraum_k,1) == 1
        Methode_select=Ergebnisraum_k(1,8);
        return %Testen, ob Rückgabewert ok!
    end   
end

if size(Ergebnisraum_k,1) > 1
    Methode_select=Ergebnisraum_k(randsample(size(Ergebnisraum_k,1),1),8);
end

end