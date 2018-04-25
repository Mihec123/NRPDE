function [U,X,Y,A,B] = resiPoissonDifu(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K,konst)
% Opis:
%  resiPoissonDif z uporabo diferencne metode resi Poissonovo enacbo na
%  pravokotniku pri Dirichletovih robnih pogojih
%
% Definicija:
%  [U,X,Y,A,B] = resiPoissonDif(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K)
%
% Vhodni podatki:
%  a,b,c,d  parametri, ki dolocajo pravokotnik [a,b] x [c,d],
%  F        funkcija, ki doloca Poissonovo enacbo - laplace U = F,
%  Gc,Gd    funkciji, ki dolocata robne pogoje v x smeri:
%           U(x,c) = Gc(x), U(x,d) = Gd(x)
%  Ga,Gb    funkciji, ki dolocata robne pogoje v y smeri:
%           U(a,y) = Ga(y), U(b,y) = Gb(y)
%  J,K      parametra diskretizacije pri diferencni metodi, ki dolocata
%           stevilo notranjih tock mreze v x oziroma y smeri
%  konst    pove konstanto pred fakotrjem u v encabi -laplace(u) - c*u = f
%
% Izhodni podatki:
%  U        tabela velikosti (J+2) x (K+2), ki predstavlja numericno
%           resitev Poissonove enacbe - laplace U = F pri danih robnih
%           pogojih,
%  X,Y      tabeli velikosti (J+2) x (K+2), ki vsebujeta x in y koordinate
%           tock mreze, na kateri se izvede diferencna metoda (vrednost
%           U(j,k) torej predstavlja numericni priblizek za resitev
%           Poissonove enacbe v tocki (X(j,k), Y(j,k)),
%  A,B      matrika in vektor sistema A*x = B, katerega resitev doloca
%           numericne priblizke v notranjih tockah mreze (A in B sta v
%           razprseni obliki)

%resitev = @(x,y) (x-y).^4; 
%test data: F = @(x,y) 3*(8 + (x - y).^2)+(x - y).^2;
%enacba laplace(u) + 3u = 3*(8 + (x - y).^2)+(x - y).^2;
% a = 0;
% b = 1;
% c = 0;
% d = 2;
% F = @(x,y) 3*(8 + (x - y).^2)+(x - y).^2;
% Gc = @(x) x.^4;
% Gd = @(x) (x-2).^4;
% Ga = @(x) x.^4;
% Gb = @(x) (x-1).^4;
% J = 1;
% K = 3;

U = zeros(J+2,K+2);
hx = (b-a)/(J+1)
hy = (d-c)/(K+1)

deltakv = hx^2*hy^2/(2*(hx^2 + hy^2));
thetax = deltakv/hx^2;
thetay = deltakv/hy^2;

x = [a:hx:b];
y = [c:hy:d];
[X,Y] = meshgrid(x,y);

diagonala = (deltakv*konst+1)*ones(J*K,1);
obdiag1 = [-thetax*ones(J*K-1,1);0];
obdiag2 = [0;-thetax*ones(J*K-1,1)];
if J >1
obdiag1(J:J:end) = 0;
obdiag2(J+1:J:end) = 0;
end
naddiag1 = [-thetay*ones(J*K-J,1);zeros(J,1)];
naddiag2 = [zeros(J,1);-thetay*ones(J*K-J,1)];
if J >1
A = spdiags([naddiag1,obdiag1,diagonala,obdiag2,naddiag2],[-J,-1,0,1,J],J*K,J*K);
else
    A = spdiags([naddiag1,diagonala,naddiag2],[-1,0,1],J*K,J*K);
end

vrednosti = F(X,Y);
vrednosti = vrednosti(2:end-1,2:end-1);
vrednosti = vrednosti';
B = vrednosti(:);
B = deltakv*B;

B(1:J) = B(1:J) - thetax*Gc(X(1,2:end-1))';

B(end-J+1:end) =  B(end-J+1:end) - thetax*Gd(X(1,2:end-1))';

B(1:J:end) = B(1:J:end) - thetay*Ga(Y(2:end-1,1));

B(J:J:end) = B(J:J:end) - thetay*Gb(Y(2:end-1,1));
res = -A\B;

U1 = reshape(res,[J,K]);
U(2:end-1,2:end-1) = U1;
U = U';
U(1,:) = Gc(X(1,:));
U(end,:) = Gd(X(1,:));
U(:,1) = Ga(Y(:,1));
U(:,end) = Gb(Y(:,1));
surf(X,Y,U);

end

