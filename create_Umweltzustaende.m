%load 'workspace_Algorithmus_Initialisierung.mat' %ist schon da

%aus den Tabellen Anforderungen und Initial... wird die Tabelle
%Umweltzustände zusammengesetzt mit den Spalten Genauigkeit,
%Schaetzaufwand, Spezialisierung, Infobedarf, Einsatzzeitpunkt, Dimension
%(alle aus Initial...) und Typ (Anfordungen)
Umweltzustand=table(Initialwerte_Algorithmus.Genauigkeit,Initialwerte_Algorithmus.Schaetzaufwand, Anforderungen.Typ, Initialwerte_Algorithmus.Spezialisierung, Initialwerte_Algorithmus.Informationsbedarf, Initialwerte_Algorithmus.Einsatzzeitpunkt, Initialwerte_Algorithmus.Dimension);
save ('Umweltzustand.mat', 'Umweltzustand');

