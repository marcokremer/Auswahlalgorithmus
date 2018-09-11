%Historische Daten als Struktur erstellen
load ('Initialwerte_Erfahrung.mat');

for i=1:14
    feld_name=Initialwerte_Erfahrung.Methode_Name{i};
    feld_name(feld_name==' ') = [];
    History.(feld_name)=struct('MMRE',Initialwerte_Erfahrung.MMRE(i),'Mean_Schaetzaufwand',Initialwerte_Erfahrung.MeanSchaetzaufwand(i));
    
end

save('Historische_Werte.mat','History');