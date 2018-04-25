function [U,X,Y,s] = resiPoissonDifIter(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K,U0,T,S,M,w)
% Opis:
%  resiPoissonDifIter z uporabo diferencne metode resi Poissonovo enacbo na
%  pravokotniku pri Dirichletovih robnih pogojih, pri cemer se za racunanje
%  priblizkov uporablja Jacobijeva ali Gauss-Seidlova metoda.
%
% Definicija:
%  [U,X,Y,s] = resiPoissonDifIter(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K,U0,T,S,M)
%
% Vhodni podatki:
%  a,b,c,d  parametri, ki dolocajo pravokotnik (a,b) x (c,d),
%  F        funkcija, ki doloca Poissonovo enacbo - laplace U = F,
%  Gc,Gd    funkciji, ki dolocata robne pogoje v x smeri:
%           U(x,c) = Gc(x), U(x,d) = Gd(x)
%  Ga,Gb    funkciji, ki dolocata robne pogoje v y smeri:
%           U(a,y) = Ga(y), U(b,y) = Gb(y)
%  J,K      parametra diskretizacije pri diferencni metodi, ki dolocata
%           stevilo notranjih tock mreze v x oziroma y smeri,
%  U0       funkcija, ki doloca zacetne priblizke v notranjosti mreze,
%  T        toleranca maksimalne absolutne razlike med komponentama dveh
%           zaporednih priblizkov v iteraciji,
%  S        maksimalno stevilo korakov iteracije,
%  M        parameter, ki doloca iterativno metodo: 1 = Jacobijeva metoda,
%           2 = Gauss-Seidlova metoda, 3 = SOR metoda
%  w        Parameter SOR metode. Default nastavitev w = 1. Torej
%           Gauss-Seidlova metoda.
%
% Izhodni podatki:
%  U        tabela velikosti (K+2) x (J+2), ki predstavlja numericno
%           resitev Poissonove enacbe - laplace U = F pri danih robnih
%           pogojih,
%  X,Y      tabeli velikosti (K+2) x (J+2), ki vsebujeta x in y koordinate
%           tock mreze, na kateri se izvede diferencna metoda (vrednost
%           U(k,j) torej predstavlja numericni priblizek za resitev
%           Poissonove enacbe v tocki (X(k,j), Y(k,j)),
%  s        stevilo opravljenih korakov iteracije

if nargin < 16
    w = 1;
end

napaka = 1;
hx = (b-a)/(J+1)
hy = (d-c)/(K+1)

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

if M == 1
    %Jacobijeva metoda
    Ustari = U;
    for s= 1:S
        for vrstica = 2:K+1
            for stolpec = 2:J+1
                U(vrstica,stolpec) = (thetay*Ustari(vrstica,stolpec-1) + thetax*Ustari(vrstica-1,stolpec)...
                    + thetay*Ustari(vrstica,stolpec+1) +thetax*Ustari(vrstica+1,stolpec) - deltakv*f(vrstica,stolpec));
            end
        end
        napaka = max(max(abs(U-Ustari)));
        if napaka < T
                    break;
        end
        Ustari = U;
    end
elseif M==2
    M
    %Gauss seidel
    Ustari = U;
        for s= 1:S
        for vrstica = 2:K+1
            for stolpec = 2:J+1
                U(vrstica,stolpec) = (thetay*U(vrstica,stolpec-1) + thetax*U(vrstica-1,stolpec) +thetay*U(vrstica,stolpec+1)...
                    +thetax*U(vrstica+1,stolpec) - deltakv*f(vrstica,stolpec));
            end
        end
        napaka = max(max(abs(U-Ustari)));
        if napaka < T
                    break;
        end
        Ustari = U;
        end
else
    %SOR
        Ustari = U;
        for s= 1:S
        for vrstica = 2:K+1
            for stolpec = 2:J+1
                U(vrstica,stolpec) = w*(thetay*U(vrstica,stolpec-1) + thetax*U(vrstica-1,stolpec) +thetay*U(vrstica,stolpec+1)...
                    + thetax*U(vrstica+1,stolpec) - deltakv*f(vrstica,stolpec)) + (1-w)*Ustari(vrstica,stolpec);
            end
        end
        napaka = max(max(abs(U-Ustari)));
        if napaka < T
                    break;
        end
        Ustari = U;
        end
    
    
end

surf(X,Y,U)

end

