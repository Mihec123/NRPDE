function [ U,X,Y,s,napaka ] = resiPoissonDifIter(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K,U0,T,S,M)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

napaka = 1;
hx = (b-a)/(J+1);
hy = (d-c)/(K+1);

deltakv = hx^2*hy^2/(2*(hx^2 + hy^2));
thetax = deltakv/hx^2;
thetay = deltakv/hy^2;

x = [a:hx:b];
y = [c:hy:d];
[X,Y] = meshgrid(x,y);

f = F(X,Y);
U = U0(X,Y);
U(end,:) = Gd(X(1,:));
U(1,:) = Gc(X(1,:));
U(:,1) = Ga(Y(:,1));
U(:,end) = Gb(Y(:,1));

Ustari = U;

for s= 1:S
    for vrstica = 2:K+1
        for stolpec = 2:J+1
            U(vrstica,stolpec) = thetay*Ustari(vrstica,stolpec-1) + thetax*Ustari(vrstica-1,stolpec) +thetay*Ustari(vrstica,stolpec+1) +thetax*Ustari(vrstica+1,stolpec) + deltakv*f(vrstica,stolpec);
        end
    end
    napaka = max(max(abs(U-Ustari)));
    if napaka < T
                break;
    end
    Ustari = U;
end



end

