%Stand: 02.05.2018
%In diesem Modul ist die Use Case Point Methode abgebildet. Übergabewerte
%sind die entsprechenden Use Cases und die aus diesen Use Cases
%entnommenen Faktoren zur Bestimmung der UCPs
%use_case_nr muss vorher als Datensatz über alle Methoden eingespielt
%werden.

erg_UCP_use_cases=zeros(anz_use_case,1);
c_vec=[1,1,1,1,1,0.5,0.5,2,1,1,1,1,1];
e_vec=[1.5,-1,0.5,0.5,1,1,-1,2];
for i = 1 : anz_use_case
use_case_daten=[use_case_nr,25:51];
UAW=use_case_daten(1)+use_case_daten(2)*2+use_case_daten(3)*3;
UUCW=use_case_daten(4)*5+use_case_daten(5)*10+use_case_daten(6)*15 + UAW;
TCF=sum(c_vec.*use_case_daten(7:19));
EF=sum(e_vec.*use_case_daten(20:end));
UCP=UUCW*TCF*EF;
erg_UCP_use_cases(i)=UCP;
end
save ('erg_UCP', erg_UCP_use_cases);
