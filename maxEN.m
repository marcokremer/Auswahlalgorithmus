%Entscheidungsregel maximierter Erwartungsnutzen (maxEN)
%solange, bis im Algorithmus die Zielreihenfolge festgelegt ist, ist p ein
%randomisierter Permutationsvektor mit Integers von 1 bis 6


%Ergebnisraum_k wird benötigt
function Methode_select = maxEN(ziel, Ergebnisraum_k, zielreihenfolge)
if size(Ergebnisraum_k,2)>6
Ergebnisraum_k(:,3)=[];
end
if sum(ziel)==6 %alle Ziele gleichgewichtet
[~,Index]=max(sum(Ergebnisraum_k,2));

else
    nutzenvektor=zeros(14,1);
    for i=1:14
        for j=1:6
           nutzenvektor(i)=nutzenvektor(i)+Ergebnisraum_k(i,zielreihenfolge(j))*ziel(j);
        end
    end
    [~,Index]=max(nutzenvektor);
end
Methode_select= randsample(Index,1);

end