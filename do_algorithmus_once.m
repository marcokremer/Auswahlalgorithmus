%Modul: Algorithmus einmalig ausführen


 function [Ergebniswerte_Algorithmus] = do_algorithmus_once(Anforderung_ID,Initialwerte_Algorithmus, Auswahlregel_select,zielvektor,zielgewichtung)
load workspace_Aktion_Zustand_trans.mat Aktionsraum_trans;
Fehlermeldung_1='Bitte Auswahlregel auswählen und neustarten.';
Ergebniswerte_Algorithmus = Initialwerte_Algorithmus;
Ergebnisraum_k=create_Ergebnisraum(Anforderung_ID);
if Anforderung_ID<5 %Minimum Initialisierungswerte für ML-Techniken
Ergebnisraum_k(7:14,:)=0;
end
Zielvektoren=cell(50,1);
Zielgewichtungen=cell(50,1);
% p=randperm(6); %Zufällige Zielreihenfolge
% q=[1 1 1 1 1 1 ]; %Gleichgewichtung der Ziele
% r=[p;q];
switch Auswahlregel_select
    case 'maxEN'
        ziel=[zielvektor;zielgewichtung];
        Methode_select=maxEN(zielgewichtung, Ergebnisraum_k,zielvektor);
    case 'MaxEN'
        ziel=[zielvektor;zielgewichtung];
        Methode_select=maxEN(zielgewichtung, Ergebnisraum_k,zielvektor);    
    case 'EBA'
        ziel=[zielvektor;0 0 0 0 0 0 ]; %EBA benötigt Reihenfolge vorgegeben von Algorithmus
        Methode_select=EBA(ziel, Ergebnisraum_k);
    case 'Lexi'
        %ziel=[zielreihenfolge_vorgabe;zielgewichtung]; %Lexi benötigt Reihenfolge vorgegeben von Algorithmus 
        ziel=[zielvektor;0 0 0 0 0 0 ];%Für Algorithmustest ist die Zielreihenfolge aber  randomisiert
        Methode_select=EBA(ziel, Ergebnisraum_k); 
    otherwise
        disp(Fehlermeldung_1);
        return
end  
        

% disp(Aktionsraum_trans(Methode_select,2)); %Ausgabe testen

Ergebniswerte_Algorithmus(Anforderung_ID,3)=Aktionsraum_trans(Methode_select,2);%Speichern in einer Tabelle
Zielvektoren(Anforderung_ID)={ziel(1,:)};
Zielgewichtungen(Anforderung_ID)={ziel(2,:)};


Ergebniswerte_Algorithmus=addvars(Ergebniswerte_Algorithmus,Zielvektoren,Zielgewichtungen);
% save ('Ergebniswerte_Algorithmus.mat','Ergebniswerte_Algorithmus');
end