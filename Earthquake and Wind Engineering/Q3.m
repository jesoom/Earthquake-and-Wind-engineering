%Civil Engeenireeng Student Interance-92
%Khatam Al-Anbiya Univercity Of Technology
%Written by: Mahan ZareiGhanavati
%Winter-2017
%--------------------------------------------
tic;
clear ; close all;
clc;
M1=[234.82 245.89 245.89 249.142 252.1 252.1 252.1 252.1 264.33 276.2 276.2 276.2];
[m,n]=size(M1);
for i=1:n
    M(i,i)=M1(1,i);
end
k=[67555.6 67555.6 67555.6 111111.2 111111.2 111111.2 111111.2 111111.2 382221.96 382221.96 382221.96 382221.96];
K(1,1)=0;
for i=1:n    
    K(i,i)=K(i,i)+k(1,i);
    if i+1<=n
    K(i+1,i+1)=k(1,i);
    K(i+1,i)=-k(1,i);
    K(i,i+1)=-k(1,i);
    end
end
[Fi,Freq2] = eig(K,M);
for i=1:n
    for j=1:n
        Fi2(j,i)=Fi(j,i)/Fi(n,i);
    end
end
Fi2(n+1,n+1)=0;
plot(flipud(Fi2),1:n+1)
for i=1:n
    T(i,i)=(2*pi)/sqrt(Freq2(i,i));
end
M2=M*10000;
Ws=0;
for i=1:n;
    for j=1:n
       s1(j,i)=M2(j,j)*Fi2(j,i);
       S1=sum(s1)
       s2(j,i)=M2(j,j)*(Fi2(j,i))^2;
       S2=sum(s2);
     end
    W(i,i)=((S1(1,i))^2)/S2(1,i)/1000;
    Ws=Ws+W(i,i);
end
for i=1:n
    Wm(i,1)=100*W(i,i)/Ws;
end
%Baraye khatar nesbi ziyad va kheyli ziyad
T0=.1;Ts=.5;S0=1;S=1.5;
for i=1:n
    if (T(i,i)<=T0)
        B(i,i)=S0+(S-S0+1)*(T(i,i)/T0);
    elseif (T0<T(i,i))&&(T(i,i)<=Ts)
        B(i,i)=S+1;
    elseif Ts<T(i,i)<=4
        B(i,i)=(S+1)*(Ts/T(i,i))*(((.7/(4-Ts))*(T(i,i)-Ts)+1));
    else
        B(i,i)=1.7*(s+1)*(Ts/T(i,i));
    end
end
%A & I & Ru Ra daryaft mikonim
A=.3; I=1; Ru=5;
for i=1:n
    C(i,i)=(A*B(i,i)*I)/Ru;
    V(i,i)=C(i,i)*W(i,i)/1000;
    for j=1:n
        F(j,i)=s1(j,i)/S1(1,i)*V(i,i);
        V2(j,i)=sum(F(:,i));
    end
end
V2(n+1,n+1)=0;
plot(flipud(V2),1:n+1);
%ertefae tabeghat ra vared mikonim
H=[38.4 35.2 32 28.8 25.6 22.4 19.2 16 12.8 9.6 6.4 3.2 0];
F(n+1,n+1)=0;
for i=1:n+1
    for j=1:n+1
        M(j,i)=(H(1,1:j)-H(1,j))*F(1:j,i);
    end
end
plot(flipud(M),1:n+1);
for i=1:n
    for j=1:n
    Del0(i,j) = V2(i,j)/k(1,i);
    Del1=flipud(Del0);
    end
end
    Del=sum(Del1)
    for i=1:n
        for j=1:n-1
            Del(j+1,i)=Del1(j,i);
        end
    end
    Del(n+1,n+1)=0;
    plot(flipud(Del),1:n+1);
    %SRSS & CQC be jaye U dar formolha factor mad nazar ra gharar midim
    %agar r<=0.67 bashad mitavan az SRSS estefadeh kard dar gheire in soorat
    %bayad az CQC estefadeh kard
    %kesay a yvared mikonim
    kes=.05;
    for i=1:n-1;
        r(i,i)=T(i+1,i+1)/T(i,i);
        Ro(i,i)=(8*(kes^2)*(1+r(i,i))*r(i,i)^1.5)/((1-r(i,i)^2)^2+(4*(kes^2)*r(i,i)*(1+r(i,i))^2));
    end
    %----------SRSS-----------
    Vsrss0=rot90(Del,-1);
    Vsrss1=power(Vsrss0,2);
    Vsrss2=sum(Vsrss1);
    Vsrss=sqrt(Vsrss2);
    plot(Vsrss,1:n+1);
    hold on;
    %-----------CQC------------
    Ro(n,n)=Ro(n-1,n-1);
    for i=1:n
        for j=1:n-1
        Vcqc0(j,i)=Ro(i,i)*Del(i,j)*Del(i,j+1);
        end
    end
    Vcqc1=2*Vcqc0;
    Vcqc1(1,n+1)=0;
    Vcqc3=sum(Vcqc1);
    Vcqc2=fliplr(Vsrss2);
    Vcqc=sqrt(Vcqc3+Vcqc2);
    plot(fliplr(Vcqc),1:n+1);
    toc;