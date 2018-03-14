function [U,X,Y,A,B] = resiPoissonDif(a,b,c,d,F,Gab,Gcd,Gac,Gbd,J,K)
%Opis:
%   resiPoissonDif z uporabo diferencne metode resi Poissonovo enacbo
%   na pravokotniku pri Dirichletovih robnih pogojih
%   a,b,c,d parametri ki dolocajo pravokotnik
%   Gab,Gcd funkciji ki dolocata robne pogoje v x smeri 

U = zeros(J+2,K+2);
B=U;
hx = (b-a)/(J+1)
hy = (d-c)/(K+1)

deltakv = hx^2*hy^2/(2*(hx^2 + hy^2));
thetax = deltakv/hx^2;
thetay = deltakv/hy^2;

x = [a:hx:b];
y = [c:hy:d];
[X,Y] = meshgrid(x,y);

diagonala = ones(J*K,1);
obdiag1 = [-thetax*ones(J*K-1,1);0];
obdiag2 = [0;-thetax*ones(J*K-1,1)];
if J >1
obdiag1(J:J:end) = 0;
obdiag2(J+1:J:end) = 0;
end
naddiag1 = [-thetay*ones(J*K-J,1);zeros(J,1)];
naddiag2 = [zeros(J,1);-thetay*ones(J*K-J,1)];
A = spdiags([naddiag1,obdiag1,diagonala,obdiag2,naddiag2],[-J,-1,0,1,J],J*K,J*K);

vrednosti = F(X,Y);
vrednosti = vrednosti';
b = vrednosti(:);


end

