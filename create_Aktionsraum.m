%Aktionsraum herstellen
load 'Initialwerte_Erfahrung.mat'
load 'workspace_Algorithmus_Initialisierung.mat' 
Aktionsraum=table(Methoden.ID, Methoden.Methode_Name,Initialwerte_Erfahrung.Genauigkeit, Initialwerte_Erfahrung.Schaetzaufwand,Initialwerte_Erfahrung.Typ,Methoden.Spezialisierung, Methoden.Informationsbedarf, Methoden.Einsatzzeitpunkt, Methoden.Ergebnisdimension);
save ('Aktionsraum.mat', 'Aktionsraum');