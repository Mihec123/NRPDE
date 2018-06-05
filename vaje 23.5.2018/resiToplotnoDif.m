function [ U,lam ] = resiToplotnoDif(c,f,g,h,T,a,b,dt,dx,th)
% Opis:
%  resiToplotnoDif izracuna resitev toplotne enacbe du/dt = c^2 du^2/dx^2 z
%  zacetnim pogojem u(0,x) = f(x) ter robnima pogojema u(t,a) = g(t) in
%  u(t,b) = h(t) z uporabo utezene diferencne sheme pri predpisani
%  diskretizaciji
%
% Definicija:
%  [U,lam] = resiToplotnoDif(c,f,g,h,T,a,b,dt,dx,th)
%
% Vhodni podatki:
%  c        parameter, ki doloca enacbo,
%  f        funkcija, ki doloca zacetni pogoj,
%  g,h      funkciji, ki dolocata robni pogoj,
%  T        maksimalni cas,
%  a,b      parametra, ki omejujeta prostorsko spremenljivko,
%  dt,dx    razmik diskretizacije v casovni in prostorski smeri,
%  th       parameter utezene diferencne sheme (0 = eksplicitna shema, 1 =
%           implicitna shema, 1/2 = Crank-Nicolsonova shema)
%
% Izhodna podatka:
%  U        tabela, ki vsebuje izracunane priblizke za resitev problema pri
%           casih med 0 in T z razmikom dt ter polozajih med a in b z
%           razmikom dx; natancneje, element na mestu (n,j) predstavlja
%           priblizek pri casu (n-1)*dt in polozaju a+(j-1)*dx,
%  lam      "Courantovo stevilo" problema (c^2*dt/dx^2)



lam = c^2*dt/dx^2;
J = (b-a)/dx+1;
N = floor(T/dt+1);
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

B = diag(-2*ones(J-2,1)) + diag(ones(J-3,1),1) + diag(ones(J-3,1),-1);

for i = 2:N
    
    Leva = eye(J-2) - lam*th*B;
    Desna = (eye(J-2) +(1-th)*lam*B)*U(i-1,2:end-1)';
    Desna(1) = Desna(1) + (1-th)*lam*U(i-1,1) + lam*th*U(i,1);
    Desna(end) = Desna(end) + (1-th)*lam*U(i-1,end)+ lam*th*U(i,end);
    
    u = Leva\Desna;
    U(i,2:end-1) = u';
    
    
    
end
    
    





end

