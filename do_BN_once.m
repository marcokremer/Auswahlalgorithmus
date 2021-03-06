%BN-Schätzung
%Funktion: fitcnb
function [predAnf] = do_BN_once(Anforderung_ID)
load('Trainingdata_SGB.mat');
categorical_vektor=1:6;
%zu schätzende
%Anforderung_ID=[2 4 5 33 36 48];
% Anforderung_ID=Anforderung_Uebersicht{contains(cellstr(Anforderung_Uebersicht.(12)),'BN')|contains(cellstr(Anforderung_Uebersicht.(14)),'BN'),1}; 
% Ergebnis=cell(size(Anforderung_ID,1),9);
% for i=1:size(Anforderung_ID,1)
%Ziel: Regression; Methode LSBoost, 100 Trainingszyklen, Anlage einer
%Baumstruktur, Eingabedaten sind vom Typ categorical
Training = Anforderung_Uebersicht(1:Anforderung_ID-1,3:8);
Mdl = fitcnb(Training,Anforderung_Uebersicht(1:Anforderung_ID-1,16),'CategoricalPredictors',categorical_vektor ); %'CrossVal','on',
%Eingabe der Eigenschaften der zu schätzenden Anforderung und
%Typenkonversion
schaetz_eigenschaften=categorical(cellstr(Anforderung_Uebersicht{Anforderung_ID,3:8}));
			
%Schätzung auf der Grundlage des ML-Modells
predAnf = predict(Mdl,schaetz_eigenschaften);
% Ergebnis(i,:)=[table2cell(Anforderung_Uebersicht(Anforderung_ID(i),[1:8])),predAnf];
% end	
% save('BN_Schätzung.mat', 'Ergebnis');
end
