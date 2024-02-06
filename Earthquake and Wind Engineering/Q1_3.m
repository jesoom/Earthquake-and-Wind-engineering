%Civil Engeenireeng Student Interance-92
%Khatam Al-Anbiya Univercity Of Technology
%Written by: J,AVAZNASAB & M,AYATI BEHBAHANI
%Winter-2017
%--------------------------------------------
tic;
clear ; close all;
clc;
W = xlsread('1-3','W-Total','A2');
A=.35;
I=1;
Ru=5;
n=xlsread('1-3','H','A2');
WH = xlsread('1-3','W-Total');
T=.05*(WH(1,3)^.9);
%-------------------------------------------
T0=.1;Ts=.5;S0=1;S=1.5;
 if (T<=T0)
        B=S0+(S-S0+1)*(T/T0);
    elseif (T0<T)&&(T<=Ts)
        B=S+1;
    elseif Ts<T<=4
        B=(S+1)*(Ts/T)*(((.7/(4-Ts))*(T-Ts)+1));
    else
        B=1.7*(s+1)*(Ts/T);
 end
C1=(A*B*I)/Ru;
Cmin=0.12*A*I;
if C1>=Cmin
    C=C1;
else
    C=Cmin;
end
Vu=C*W;
%-------------------------------------------
if  T<0.5
    K=1;
elseif (0.5<=T)&&(T<=2.5)
    K=0.5*T+0.75;
else 
    K=2;
end
s=0;
    
for i=1:n
    W=WH(i,2);    
    h(i,1)=WH(i,3);
    rot90(W,-1);
    s =s+ W*(h(i,1)^K) ;
end
for i=1:n
    W(i,1)=WH(i,2);
    h(i,1)=WH(i,3);
    rot90(W,-1);
    Fu(i,1) = ((W(i,1)*(h(i,1)^K))/s)*Vu;
end
plot(Fu,1:n);
hold on;
for i=1:n
 x2(i,1)= Fu(i,1);
 x1(i,1)=sum(x2);
end
plot(flipud(x1),1:n,'k^:');hold on;
h1=rot90(h);
for i=1:n
    M(i,1)=(h1(1,1:i)-h1(1,i))*Fu(1:i,1);
end
plot(flipud(M),1:n,'b^:');
toc;