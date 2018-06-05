function [ U,lam ] = resiToplotnoEksDif(c,f,g,h,T,a,b,dt,dx)
% Opis:
%  resiToplotnoEksDif izracuna resitev toplotne enacbe
%  du/dt = c^2 du^2/dx^2 z zacetnim pogojem u(0,x) = f(x) ter robnima
%  pogojema u(t,a) = g(t) in u(t,b) = h(t) z uporabo eksplicitne diferencne
%  sheme pri predpisani diskretizaciji
%
% Definicija:
%  [U,lam] = resiToplotnoEksDif(c,f,g,h,T,a,b,dt,dx)
%
% Vhodni podatki:
%  c        parameter, ki doloca enacbo,
%  f        funkcija, ki doloca zacetni pogoj,
%  g,h      funkciji, ki dolocata robni pogoj,
%  T        maksimalni cas,
%  a,b      parametra, ki omejujeta prostorsko spremenljivko,
%  dt,dx    razmik diskretizacije v casovni in prostorski smeri
%
% Izhodna podatka:
%  U        tabela, ki vsebuje izracunane priblizke za resitev problema pri
%           casih med 0 in T z razmikom dt ter polozajih med a in b z
%           razmikom dx; natancneje, element na mestu (n,j) predstavlja
%           priblizek pri casu (n-1)*dt in polozaju a+(j-1)*dx,
%  lam      Courantovo stevilo problema

lam = c^2*dt/dx^2
J = (b-a)/dx+1
N = floor(T/dt)+1
U = zeros(N,J);
robna1 = zeros(N,1);
robna2 = zeros(N,1);

for i = 1:N
    robna1(i) = g((i-1)*dt);
    robna2(i) = h((i-1)*dt);
end
zacetni = zeros(1,J);
for i = 1:J
    zacetni(i) = f(a+(i-1)*dx);
end
U(1,:) = zacetni;
U(:,1) = robna1;
U(:,end) = robna2;

for i = 2:N
    for j=2:J-1
        U(i,j) = lam*U(i-1,j-1) + (1-2*lam)*U(i-1,j) + lam*U(i-1,j+1);
    end
end


end

