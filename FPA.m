%Stand: 02.05.2018
%In diesem Modul ist die Function Point Methode abgebildet. Übergabewerte
%sind die entsprechenden Use Cases und die aus diesen Use Cases
%entnommenen Faktoren zur Bestimmung der FPs
%use_case_nr muss vorher als Datensatz über alle Methoden eingespielt
%werden.

erg_FP_use_cases=zeros(anz_use_case,1);
for i = 1 : anz_use_case
use_case_daten=[use_case_nr,1:24];
count_total=sum(use_case_daten(1:5).*use_case_daten(6:10));
sum_of_Fi=sum(use_case_daten(11:end));
FP=count_total*(0.65+0.1*sum_of_Fi);
erg_FP_use_cases(i)=FP;
end
save ('erg_FP', erg_FP_use_cases);
