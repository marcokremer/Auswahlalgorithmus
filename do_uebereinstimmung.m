%Modul bestimmt die Übereinstimmung der Schätzerauswahl mit den Zielen

Ergebniswerte_Algorithmus = Initialwerte_Algorithmus;
load('alle_Ergebnisse_dataset1.mat');
m=[12,15];
uebereinstimmung=zeros(50,2);

for i=1:2
    
for k=1:50
    Ergebnisraum_k=create_Ergebnisraum(k);
    Ergebnisraum_k(:,3)=[];
    methoden_ID=Aktionsraum{strcmp(string(alle_Ergebnisse_dataset1{k,m(i)}),Aktionsraum{:,2}),1};
    
    ziele=str2num(alle_Ergebnisse_dataset1{k,10});
    if sum(ziele)==6
        ziele=[1 2 3 4 5 6]; 
    end
    
    ziele_gew=str2num(string(alle_Ergebnisse_dataset1{k,11}));
    if sum(ziele_gew)==0
        ziele_gew=[1/6 1/6 1/6 1/6 1/6 1/6];
    end
    score_schaetzer=0;
    for j=1:6
    score_schaetzer=score_schaetzer+Ergebnisraum_k(methoden_ID,ziele(j))*ziele_gew(j);
    end
    uebereinstimmung(k,i)=score_schaetzer;
     methode_select=maxEN(ziele_gew , Ergebnisraum_k, ziele);
end
end
save('uebereinstimmung.mat' , 'uebereinstimmung');