%statistische Auswertung der Datenerhebung:
%1. Hypothesentest Genauigkeit
%�Die Sch�tzgenauigkeit des durch Algorithmus ausgew�hlten Sch�tzers ist
%allgemein h�her als die Sch�tzgenauigkeit zuf�llig ausgew�hlter Sch�tzer.�
%Datenbasis: Dataset 1 und Dataset 3, jeweils alle Datens�tze, bei denen
%eine hohe Genauigkeit gefordert ist.
%
%2. Hypothesentest Sch�tzaufwand
% �Der Sch�tzaufwand bei dem durch Algorithmus ausgew�hlten Sch�tzer ist 
% allgemein niedriger als der Aufwand bei zuf�llig ausgew�hlten Sch�tzern.�
%Datenbasis: Dataset 1 und Dataset 3, jeweils alle Datens�tze, bei denen
%ein geringer oder sehr geringer  Aufwand gefordert ist.
%
%---------------------------
load('alle_Ergebnisse_dataset1.mat');
% load('alle_Ergebnisse_dataset2.mat');

%FP-Werte durch Entwicklerstunden ersetzen (Quelle: 20180911 Masterarbeit Datenerhebung.xlsm, Blatt �UWE�)
%  Anforderung_ID=alle_Ergebnisse_dataset1{contains(cellstr(alle_Ergebnisse_dataset1.(12)),'UWE')|contains(cellstr(alle_Ergebnisse_dataset1.(15)),'UWE'),1}; 
% UWE_vec=[3.003020551 7.657254697 3.659995751 0.42821111	7.817926509]; %alle bei Zufallsspalte
% aufwschaetz_zuf(Anforderung_ID)=UWE_vec;
testergebnis={'Genauigkeit',[0] ,[0] ;'Schaetzaufwand',[0],[0]};

for i=1:2 %durchlaufe beide Hypothesentests
%Auswahl der richtigen Datens�tze
tail_side={'right', 'left'};
if i==1 %Genauigkeit
%Algorithmus_Datens�tze
    schaetz_alg=abs(alle_Ergebnisse_dataset1{contains(cellstr(alle_Ergebnisse_dataset1.(3)),'hoch'),18}-alle_Ergebnisse_dataset1{contains(cellstr(alle_Ergebnisse_dataset1.(3)),'hoch'),13})./alle_Ergebnisse_dataset1{contains(cellstr(alle_Ergebnisse_dataset1.(3)),'hoch'),18}; 
%Zufall_Datens�tze
sch_erg=alle_Ergebnisse_dataset1{:,16};
% sch_erg(Anforderung_ID)=UWE_vec;
schaetz_zuf=sch_erg(contains(cellstr(alle_Ergebnisse_dataset1.(3)),'hoch')); 
schaetz_zuf=abs(alle_Ergebnisse_dataset1{contains(cellstr(alle_Ergebnisse_dataset1.(3)),'hoch'),18}-schaetz_zuf)./alle_Ergebnisse_dataset1{contains(cellstr(alle_Ergebnisse_dataset1.(3)),'hoch'),18}; 

else %Sch�tzaufwand
schaetz_alg=alle_Ergebnisse_dataset1{contains(cellstr(alle_Ergebnisse_dataset1.(4)),'sehr gering/gering'),14}; 
sch_erg=alle_Ergebnisse_dataset1{:,17};
% sch_erg(Anforderung_ID)=UWE_vec;
schaetz_zuf=sch_erg(contains(cellstr(alle_Ergebnisse_dataset1.(4)),'sehr gering/gering'));
% [h_tt,p_tt] = ttest2(schaetz_alg,schaetz_zuf,'Tail','left');
end
pop_vec(schaetz_alg<schaetz_zuf)=1;
p_0=0.5;
n=size(schaetz_alg,1);
[h_tt,p_tt] = ttest(pop_vec,p_0,'Tail','right');
testergebnis{i,2}=h_tt;
testergebnis{i,3}=p_tt;
end
 save('Hypothesentestergebnisse.mat', 'testergebnis');

