%CBR Schätzung

load('C:\Users\Marco Kremer\Documents\MATLAB\Masterarbeit\Trainingdata_SGB.mat');
load('C:\Users\Marco Kremer\Documents\MATLAB\Masterarbeit\Trainingdata_ANN.mat');

Anforderung_ID=Anforderung_Uebersicht{contains(cellstr(Anforderung_Uebersicht.(12)),'CBR')|contains(cellstr(Anforderung_Uebersicht.(14)),'CBR'),1}; 
Ergebnis=cell(size(Anforderung_ID,1),9);


for i=1:size(Anforderung_ID,1)

%1. Finde möglichst ähnlichen Fall (gem. Voraussetzungen)
%Werte aktueller Fall:
Anforderung_value=Training_Values(Anforderung_ID(i),:);
Vergleichswerte=Training_Values(1:Anforderung_ID(i)-1,:);
ziele_str=Anforderung_Uebersicht.(10){Anforderung_ID(i)};
ziele=str2num(ziele_str(2:14));

%Ziel 3 kann vernachlässigt werden, da nicht diskriminierend
ziele(ziele==3)=[];
ziele(ziele>3)=ziele(ziele>3)-1;
Anforderung_value=Anforderung_value(:,ziele);
Vergleichswerte=Vergleichswerte(:,ziele);
count_down=6;
[~,ia,~] = intersect(Vergleichswerte,Anforderung_value,'rows');
while (isempty(ia) && (size(Anforderung_value,2)>0)) 
    
    [~,ia,~] = intersect(Vergleichswerte,Anforderung_value,'rows');
    Vergleichswerte(:,count_down)=[];
    Anforderung_value(:,count_down)=[];
    count_down=count_down-1;
end

%2. Schätze auf Grundlage Fall das Ergebnis der zu schätzenden Anwendung
Entwicklungszeit=mean(Anforderung_Uebersicht{ia,16});
Ergebnis(i,:)=[table2cell(Anforderung_Uebersicht(Anforderung_ID(i),[1:8])),Entwicklungszeit];
end	
save('CBR_Schätzung.mat', 'Ergebnis');