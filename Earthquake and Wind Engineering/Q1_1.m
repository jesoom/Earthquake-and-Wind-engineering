%Civil Engeenireeng Student Interance-92
%Khatam Al-Anbiya Univercity Of Technology
%Written by: J,AVAZNASAB
%Winter-2017
%--------------------------------------------
tic;
clear ; close all;
clc;
deltaT=.1;
T=10;
m=.2533;
k=10;
c=.1592;
u0=0;
v0=0;
p0=0;
a0=(p0-c*v0-k*u0)/m;
K=k+2*c/deltaT+4*m/(deltaT^2);
a=(4*m/deltaT)+2*c;
b=2*m;
d=zeros(T/deltaT,9);
d(1,:)=[0 0 0 0 0 u0 v0 a0 p0];
e=0;
for i=0:deltaT:T
    d(e+2,1)=i+deltaT;
    d(e+2,5)=10*deltaT+a*d(e+1,7)+b*d(e+1,8);
    d(e+2,2)=d(e+2,5)/K;
    d(e+2,3)=2/deltaT*d(e+2,2)-2*d(e+1,7);
    d(e+2,4)=4/(deltaT^2)*(d(e+2,2)-deltaT*d(e+1,7))-2*d(e+1,8);
    d(e+2,6)=d(e+1,6)+d(e+2,2);
    d(e+2,7)=d(e+1,7)+d(e+2,3);
    d(e+2,8)=d(e+1,8)+d(e+2,4);
    d(e+2,9)=d(e+1,9)+d(e+2,5);
    e=e+1;
end
hold on
plot(d(:,1),d(:,6),'b');
plot(d(:,1),d(:,7),'c');
plot(d(:,1),d(:,8),'y');
plot(d(:,6),d(:,9)/100,'m');
toc;