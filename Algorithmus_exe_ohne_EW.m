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
options= {'Bestandsabfrage', 'neue Eingabe'};
definput = {'Bestandsabfrage'};
answer = listdlg('PromptString',Bestandsabfrage,'SelectionMode','single','ListString', options);

if answer==1
%starte Algorithmus
load ('Initialwerte_Erfahrung.mat');
create_Aktionsraum;
create_Umweltzustaende;
transform_aktionsraum_umweltzustand;
do_algorithmus;
else
%nehme Initialangaben zum Algorithmus auf
%starte Algorithmus mit Initialangaben
end

%update Erfahrungswerte
load('Initialwerte_Erfahrung.mat');
