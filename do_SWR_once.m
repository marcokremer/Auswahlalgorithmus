%SWR-Sch�tzung
%Funktion stepwiselm 
function[schaetz_eigenschaften]=do_SWR_once(Anforderung_ID)
load('Trainingdata_SGB.mat');
load('Trainingdata_ANN.mat');
% categorical_vektor=1:6;
%zu sch�tzende
%Anforderung_ID=[2 4 5 33 36 48];
% Anforderung_ID=Anforderung_Uebersicht{contains(cellstr(Anforderung_Uebersicht.(12)),'SWR')|contains(cellstr(Anforderung_Uebersicht.(14)),'SWR'),1}; 
% Ergebnis=cell(size(Anforderung_ID,1),9);

% for i=1:size(Anforderung_ID,1)
Entwicklungszeit=Anforderung_Uebersicht{1:Anforderung_ID-1,16};
Training = Training_Values(1:Anforderung_ID-1,:);

%Berechnung des Modellparamter-Vektors b
[b,~,~,~,~,~,~] = stepwisefit(Training,Entwicklungszeit);%

%Berechnung der Sch�tzung auf Grundlage der Modellparameter b 
schaetz_eigenschaften=sum(Training_Values(Anforderung_ID,:).*b');
			
%Sch�tzung auf der Grundlage des ML-Modells
%predAnf = predict(Mdl,schaetz_eigenschaften);
% Ergebnis(i,:)=[table2cell(Anforderung_Uebersicht(Anforderung_ID(i),[1:8])),sum(schaetz_eigenschaften)];
% end	
% save('SWR_Sch�tzung.mat', 'Ergebnis');
end