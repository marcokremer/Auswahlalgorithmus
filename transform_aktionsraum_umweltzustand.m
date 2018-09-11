%Einträge in Aktionsraum und in Umweltzustand transformieren in
%Vergleichswerte
load 'Aktionsraum.mat'
load 'Umweltzustand.mat'

% transform_vektor_genauigkeit={'niedrig' 0;'mittel' 1;'hoch' 2};
% transform_vektor_schaetzaufwand={'sehr gering' 1; 'gering' 1; 'mittel' 0; 'hoch' 0;'sehr hoch' 0; '?' 0};
% transform_vektor_Einsatzzeitpunkt={'früh' 1; 'mittel' 0; 'spät' 0};
Umweltzustand_trans=Umweltzustand;
Aktionsraum_trans=Aktionsraum;
umweltzustand_trans_vektor=zeros(50,3);
aktionsraum_trans_vektor=zeros(14,3);

for i=1:50
if contains(cellstr(Umweltzustand{i,1}),cellstr('hoch'))
    umweltzustand_trans_vektor(i,1)=2;
else
    if contains(cellstr(Umweltzustand{i,1}),cellstr('mittel'))
        umweltzustand_trans_vektor(i,1)=1;
    else
       % umweltzustand_trans(i,1)=0;
    end
end

if contains(cellstr(Umweltzustand{i,2}),cellstr('gering'))
    umweltzustand_trans_vektor(i,2)=1;
else
    %umweltzustand_trans(i,2)=0;
end

if contains(cellstr(Umweltzustand{i,6}),cellstr('früh'))
    umweltzustand_trans_vektor(i,3)=1;
else
   % umweltzustand_trans(i,3)=0;
end
end

for i=1:14
if contains(cellstr(Aktionsraum{i,3}),cellstr('hoch'))
    aktionsraum_trans_vektor(i,1)=2;
else
    if contains(cellstr(Aktionsraum{i,3}),cellstr('mittel'))
        aktionsraum_trans_vektor(i,1)=1;
    else
      %  aktionsraum_trans(i,1)=0;
    end
end

if contains(cellstr(Aktionsraum{i,4}),cellstr('gering'))
    aktionsraum_trans_vektor(i,2)=1;
else
    %aktionsraum_trans(i,2)=0;
end

if contains(cellstr(Aktionsraum{i,8}),cellstr('früh'))
    aktionsraum_trans_vektor(i,3)=1;
else
   % aktionsraum_trans(i,3)=0;
end
end


Umweltzustand_trans.(1)=umweltzustand_trans_vektor(:,1);
Umweltzustand_trans.(2)=umweltzustand_trans_vektor(:,2);
Umweltzustand_trans.(6)=umweltzustand_trans_vektor(:,3);
Aktionsraum_trans.(3)=aktionsraum_trans_vektor(:,1);
Aktionsraum_trans.(4)=aktionsraum_trans_vektor(:,2);
Aktionsraum_trans.(8)=aktionsraum_trans_vektor(:,3);

save('workspace_Aktion_Zustand_trans.mat','Umweltzustand_trans','Aktionsraum_trans');