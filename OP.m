%Stand: 02.05.2018
%In diesem Modul ist die Object Point Methode abgebildet. Übergabewerte
%sind die entsprechenden Use Cases und die aus diesen Use Cases
%entnommenen Faktoren zur Bestimmung der OPs
%use_case_nr muss vorher als Datensatz über alle Methoden eingespielt
%werden.

erg_OP_use_cases=zeros(anz_use_case,1);

Bildschirm_Matrix= [1	1	2
1	2	3
2	3	3];

Reports_Matrix=[2	2	5
2	5	8
5	8	8
];

GL_3=10;

for i = 1 : anz_use_case
use_case_daten=[use_case_nr,52:57];

%views
if use_case_daten(0)<3
    a=0;
else
    if use_case_daten(0)>7
        a=2;
    else
        a=1;
    end
end

%datenbanktabellen
if use_case_daten(1)<4
    b=0;
else
    if use_case_daten(1)>7
        b=2;
    else
        b=1;
    end
end

%sektionen
if use_case_daten(2)<2
    c=0;
else
    if use_case_daten(2)>3
        c=2;
    else
        c=1;
    end
end

OP=use_case_daten(4)*Bildschirm_Matrix(a,b)+use_case_daten(5)*Reports_Matrix(c,b)+use_case_daten(3)*GL_3;
erg_OP_use_cases(i)=OP;
end
save ('erg_OP', erg_OP_use_cases);
