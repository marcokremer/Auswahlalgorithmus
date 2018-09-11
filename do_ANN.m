% ANN Schätzung
%Neuronales Netzwerk (App nftool) mit transformierten Daten aus Trainingsdata_SGB.mat
%trainieren;
%Einstellung: 
    %Input: Training_Values
    %Target: Entwicklungszeit
    %Training Validation Test [90 5 5]
    %Number of hidden neurons: 7 (optimales r und MSE aus Menge [1,10]
    %Training Algorithm: Bayesian Regularization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    


%Transformation
%conversion is needed from categorical to num
% load('Trainingdata_SGB.mat');
% Genauigkeit = Anforderung_Uebersicht.Genauigkeit;
% Schaetzaufwand = Anforderung_Uebersicht.Schaetzaufwand;
% Informationsbedarf = Anforderung_Uebersicht.Informationsbedarf;
% Einsatzzeitpunkt = Anforderung_Uebersicht.Einsatzzeitpunkt;
% Spezialisierung = Anforderung_Uebersicht.Spezialisierung;
% Dimension = Anforderung_Uebersicht.Dimension;
% 
% Genauigkeit_num = grp2idx(Genauigkeit);
% Schaetzaufwand_num =grp2idx(Schaetzaufwand);
% Informationsbedarf_num =grp2idx(Informationsbedarf);
% Einsatzzeitpunkt_num =grp2idx(Einsatzzeitpunkt);
% Spezialisierung_num =grp2idx(Spezialisierung);
% Dimension_num =grp2idx(Dimension);
% 
% Training_Values=[Genauigkeit_num Schaetzaufwand_num Informationsbedarf_num Einsatzzeitpunkt_num Spezialisierung_num Dimension_num];
%save('Trainingdata_ANN.mat', 'Training_Values','Entwicklungszeit')

load('Trainingdata_ANN.mat');
categorical_vektor=1:6;
%zu schätzende
%Anforderung_ID=[2 4 5 33 36 48];
Anforderung_ID=Anforderung_Uebersicht{contains(cellstr(Anforderung_Uebersicht.(12)),'ANN')|contains(cellstr(Anforderung_Uebersicht.(14)),'ANN'),1}; 
Ergebnis=cell(size(Anforderung_ID,1),9);
for i=1:size(Anforderung_ID,1)
%schaetz_eigenschaften=categorical(cellstr(Anforderung_Uebersicht{Anforderung_ID(i),[3:8]}));
		
%Schätzung auf der Grundlage des ML-Modells
predAnf = ANN_all(Training_Values(Anforderung_ID(i),:));
Ergebnis(i,:)=[table2cell(Anforderung_Uebersicht(Anforderung_ID(i),[1:8])),predAnf];
end	
save('ANN_Schätzung.mat', 'Ergebnis');
