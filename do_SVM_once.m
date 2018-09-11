
%SVR Schätzung
%Vorgehen analog zu Satapathy, S. M., et al., Effort estimation on web-based, 2016,
%mit RBF Kernel (wies bei Satapathy kleinste MMRE auf für alle betrachteten Datasets)
%ohne Cross Validation (Datensatz ist zu klein)
%Funktion: fitrsvm
%Erfahrungswerte : Schätzwerte der Nicht-ML-Techniken aus dem Projekt
%die zum Schätzzeitpunkt schon zur Verfügung stehen: Für Anforderung_ID x sind dies
%dementsprechend alle 1 bis x-1 Erfahrungswerte der umgesetzten Anforderungen.
%fitrsvm trains or cross-validates a support vector machine (SVM) regression model on a low- through moderate-dimensional predictor data set. fitrsvm supports mapping the predictor data using kernel functions, and supports SMO, ISDA, or L1 soft-margin minimization via quadratic programming for objective-function minimization.load('Trainingdata_SGB.mat');
function [predAnf]=do_SGB_once(Anforderung_ID)
load('Trainingdata_SGB.mat');
%Trainingsset entstammt aus eigenem Projekt: darf nur die bereits
%umgesetzten Anforderungen berücksichtigen

categorical_vektor=1:6;
%zu schätzende
%Anforderung_ID=[2 4 5 33 36 48];
% Anforderung_ID=Anforderung_Uebersicht{contains(cellstr(Anforderung_Uebersicht.(12)),'SVM')|contains(cellstr(Anforderung_Uebersicht.(14)),'SVM'),1}; 
% Ergebnis=cell(size(Anforderung_ID,1),9);
% for i=1:size(Anforderung_ID,1)
%Ziel: Regression; Methode LSBoost, 100 Trainingszyklen, Anlage einer
%Baumstruktur, Eingabedaten sind vom Typ categorical
Training = Anforderung_Uebersicht(1:Anforderung_ID-1,3:8);
Mdl = fitrsvm(Training,Anforderung_Uebersicht(1:Anforderung_ID-1,16),'KernelFunction','gaussian','Standardize',true,'CategoricalPredictors',categorical_vektor ); %'CrossVal','on',
%Eingabe der Eigenschaften der zu schätzenden Anforderung und
%Typenkonversion
schaetz_eigenschaften=categorical(cellstr(Anforderung_Uebersicht{Anforderung_ID,3:8}));
			
%Schätzung auf der Grundlage des ML-Modells
predAnf = predict(Mdl,schaetz_eigenschaften);
% Ergebnis(i,:)=[table2cell(Anforderung_Uebersicht(Anforderung_ID(i),[1:8])),predAnf];
% end	
% save('SVM_Schätzung.mat', 'Ergebnis');
end