function U = resiPoVetru(c,f,g,h,T,a,b,dt,dx)
% Opis:
%  resiPoVetru izracuna resitev advekcijske enacbe du/dt + c*du/dx = 0 pri
%  zacetnem pogoju u(0,x) = f(x) ter robnih pogojih u(t,a) = g(t) in
%  u(t,b) = h(t) z uporabo metode po vetru
%
% Definicija:
%  U = resiPoVetru(c,f,g,h,T,a,b,dt,dx)
%
% Vhodni podatki:
%  c        funkcija, ki doloca hitrost potovanja vala v odvisnosti od casa
%           in polozaja na x osi,
%  f        funkcija polozaja, ki doloca zacetni pogoj u(0,x) = f(x),
%  g,h      funkciji casa, ki dolocata robna pogoja u(t,a) = g(t) in
%           u(t,b) = h(t),
%  T        maksimalni cas,
%  a,b      parametra, ki omejujeta prostorsko spremenljivko,
%  dt,dx    razmik diskretizacije v casovni in prostorski smeri
%
% Izhodni podatek:
%  U        tabela, ki vsebuje izracunane priblizke za resitev problema pri
%           casih med 0 in T z razmikom dt ter polozajih med a in b z
%           razmikom dx; natancneje, element na mestu (n,j) predstavlja
%           priblizek pri casu (n-1)*dt in polozaju a+(j-1)*dx


J = (b-a)/dx+1;
N = floor(T/dt)+1;
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
    for k = 2:J-1
        Cjn = c((i-2)*dt,a+(k-1)*dx); % ce kej ni ok probi spremenit indeks k za +- 1
        lam = Cjn * dt/dx;
        if Cjn >= 0
            U(i,k) = lam*U(i-1,k-1) + (1-lam)*U(i-1,k);
        else
            U(i,k) = (1+lam)*U(i-1,k) - lam*U(i-1,k+1);
        end
    end
end

end

