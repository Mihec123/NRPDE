function z = trilin(T,t,x,y,o)
% Opis:
%  trilin izracuna vrednosti (odvodov) linearne funkcije, ki je dolocena z
%  vrednostmi v ogliscih trikotnika
%
% Definicija:
%  t = trilin(T,t,x,y,o)
%
% Vhodni podatki:
%  T    tabela velikosti 3 x 2, v kateri vsaka vrstica predstavlja
%       kartezicni koordinati oglisca trikotnika
%  t    stolpec dolzine 3, v katerem vsak element predstavlja vrednost
%       linearne funkcije v ogliscu trikotnika,
%  x,y  seznama kartezicnih koordinat tock, v katerih racunamo vrednosti
%       funkcije,
%  o    parameter, ki doloca odvod: ce ni podan, metoda vraca vrednosti
%       linearne funkcije, ce je o = 'x' ali o = 'y' pa vrednosti odvodov
%       funkcije po x oziroma po y
%
% Izhodni podatek:
%  z    vrednosti (odvodov) linearne funkcije v tockah, dolocenih s
%       seznamoma x in y
odvod = 1;

if nargin <5
    odvod = 0;
end

A = zeros(3);
A(:,1) = ones(3,1);
A(:,2) = T(:,1);
A(:,3) = T(:,2);
u = A\t;

if odvod == 0
    z = zeros(1,length(x));
    for i = 1:length(x)
        z(i) = u(1) + u(2)*x(i) + u(3)*y(i);
    end
else
    if o == 'x'
        z = u(2) * ones(1,length(x));
    elseif o == 'y'
        z = u(3) * ones(1,length(x));
    end
end
    








end