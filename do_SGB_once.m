%SGB Schätzung
%Vorgehen analog zu Satapathy, S. M., et al., Effort estimation on web-based, 2016,
%Funktion: fitensemble
%Erfahrungswerte : Schätzwerte der Nicht-ML-Techniken aus dem Projekt
%die zum Schätzzeitpunkt schon zur Verfügung stehen: Für Anforderung_ID x sind dies
%dementsprechend alle 1 bis x-1 Erfahrungswerte der umgesetzten Anforderungen.
%fitensemble generates in-bag samples by oversampling classes with large misclassification costs and undersampling classes with small misclassification costs. Consequently, out-of-bag samples have fewer observations from classes with large misclassification costs and more observations from classes with small misclassification costs. If you train a classification ensemble using a small data set and a highly skewed cost matrix, then the number of out-of-bag observations per class can be low. Therefore, the estimated out-of-bag error can have a large variance and can be difficult to interpret. The same phenomenon can occur for classes with large prior probabilities.
function [predAnf]=do_SGB_once(Anforderung_ID)
load('Trainingdata_SGB.mat');

%Trainingsset entstammt aus eigenem Projekt: darf nur die bereits
%umgesetzten Anforderungen berücksichtigen

categorical_vektor=1:6;
%zu schätzende
% Anforderung_ID=Anforderung_Uebersicht{contains(cellstr(Anforderung_Uebersicht.(12)),'SGB')|contains(cellstr(Anforderung_Uebersicht.(14)),'SGB'),1}; 
% 
% Ergebnis=cell(size(Anforderung_ID,2),9);
% for i=1:size(Anforderung_ID,2)
%Ziel: Regression; Methode LSBoost, 100 Trainingszyklen, Anlage einer
%Baumstruktur, Eingabedaten sind vom Typ categorical
Training = Anforderung_Uebersicht(1:Anforderung_ID-1,3:8);
Mdl = fitensemble(Training,Anforderung_Uebersicht(1:Anforderung_ID-1,16),'LSBoost',100,'Tree','CategoricalPredictors',categorical_vektor);

%Eingabe der Eigenschaften der zu schätzenden Anforderung und
%Typenkonversion
schaetz_eigenschaften=categorical(cellstr(Anforderung_Uebersicht{Anforderung_ID,3:8}));
			
%Schätzung auf der Grundlage des ML-Modells
predAnf = predict(Mdl,schaetz_eigenschaften);
% Ergebnis(i,:)=[table2cell(Anforderung_Uebersicht(Anforderung_ID(i),[1:8])),predAnf];
% end	
%save('SGB_Schätzung.mat', 'Ergebnis');
end
