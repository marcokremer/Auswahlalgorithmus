%Modul: Algorithmus ausf�hren

load 'workspace_Aktion_Zustand_trans.mat';
Fehlermeldung_1='Bitte Zielreihenfolge ausw�hlen und neustarten.';
Auswahlregel_select = [("maxEN") ,("EBA"), ("Lexi")]; %Auswahl der Regel durch Nutzer
Ergebniswerte_Algorithmus = Initialwerte_Algorithmus;
Zielvektoren=cell(50,1);
Zielgewichtungen=cell(50,1);
for k=1:50
Ergebnisraum_k=create_Ergebnisraum(k);
p=randperm(6); %Zuf�llige Zielreihenfolge
q=[1 1 1 1 1 1 ]; %Gleichgewichtung der Ziele
r=[p;q];
zielvektor=r(randsample(2,1),:);  %zuf�llige Auswahl des Zielvektors aus p und q
zielgewichtung=[0.5 0.3 0.1 0.06 0.04 0 ]; %Angabe der Zielgewichtung durch Nutzer
zielreihenfolge_vorgabe=[1 2 5 6 4 7 ]; %Angabe der Zielreihenfolge durch Nutzer

switch Auswahlregel_select{randsample(3,1)}
    case 'maxEN'
        ziel=[zielvektor;zielgewichtung];
        Methode_select=maxEN(ziel, Ergebnisraum_k,zielreihenfolge_vorgabe);
    case 'EBA'
        ziel=[p;0 0 0 0 0 0 ]; %EBA ben�tigt Reihenfolge vorgegeben von Algorithmus
        Methode_select=EBA(ziel, Ergebnisraum_k);
    case 'Lexi'
        %ziel=[zielreihenfolge_vorgabe;zielgewichtung]; %Lexi ben�tigt Reihenfolge vorgegeben von Algorithmus 
        ziel=[p;0 0 0 0 0 0 ];%F�r Algorithmustest ist die Zielreihenfolge aber  randomisiert
        Methode_select=EBA(ziel, Ergebnisraum_k); 
        if Methode_select==0
            disp(Fehlermeldung_1);
        end
end
% disp(Aktionsraum_trans(Methode_select,2)); %Ausgabe testen
Ergebniswerte_Algorithmus(k,3)=Aktionsraum_trans(Methode_select,2);%Speichern in einer Tabelle
Zielvektoren(k)={ziel(1,:)};
Zielgewichtungen(k)={ziel(2,:)};

end
Ergebniswerte_Algorithmus=addvars(Ergebniswerte_Algorithmus,Zielvektoren,Zielgewichtungen);
save ('Ergebniswerte_Algorithmus.mat','Ergebniswerte_Algorithmus');
