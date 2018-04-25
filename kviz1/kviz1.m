%kviz1
% parameter1 = 80/201;
% u = @(x,y) cos(x.^2+y.^2);
% h = 0.1;
% 
% lu = laplace(u,parameter1,parameter1,h)
% bu = biharmonic(u,parameter1,parameter1,h)
% 
% tocna = @(x,y) -4*((x.^2 + y.^2) *cos(x.^2 + y.^2) + sin(x.^2 + y.^2));
% napaka = 1e-3;
% 
% for i =1:100
%     napaka1 = abs(tocna(parameter1,parameter1) - laplace(u,parameter1,parameter1,1/i));
%     if napaka1 < napaka
%         i
%         laplace(u,parameter1,parameter1,1/i)
%         break
%     end
% end

% parameter2 = 128/311;
% h = 0.1;
% p = @(x) (x+parameter2).^2;
% q = @(x) 0.*x + 2;
% r = @(x) x;
% a = 0;
% b = 1;
% alpha = 1;
% beta = parameter2;
% n = 10;
% [y,x,S] = resiRobniProblem(a,b,p,q,r,alpha,beta,n)
% q1 = @(x) 0.*x + 1;
% r1 = @(x) 0.*x;
% [y1,x1,S1] = resiRobniProblem(a,b,p,q1,r1,alpha,beta,n)

% parameter3 = 1+58/97;
% F = @(x,y) -parameter3*x.*sin(y);
% a = 0;
% b = 1;
% c = 0;
% d = 3;
% Gc = @(x) x.^3;
% Gd = @(x) 0.*x+1;
% Ga = @(x) (x./3).^2;
% Gb = @(x) cos(2.*pi.*x);
% J = 9;
% K = 29;
% [U,X,Y,A,B] = resiPoissonDif(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K);
% [U,X,Y,A,B] = resiPoissonDifu(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K,2)
% 
% i1 = find(X(1,:) == 0.5)
% j1 = find(Y(:,1) == 1.5)
% U(j1,i1)

parameter4 = 2+45/107;
F = @(x,y) -(x-parameter4).*(y-parameter4);
a = -1;
b = 1;
c = -1;
d = 1;
Gc = @(x) exp(1-x.^2);
Gd = @(x) x.^2;
Ga = @(x) 0.*x+1;
Gb = @(x) x.^4;
J = 19;
K = 9;
T = 0;
S = 300;
M = 1;
U0 = @(x,y) 0.*x+0.*y;
% [U,X,Y,s] = resiPoissonDifIter(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K,U0,T,S,M);
% 
% i1 = find(X(1,:) == 0)
% j1 = find(Y(:,1) == 0)
% U(j1,i1)

[U,X,Y,s] = resiPoissonDifIter(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K,U0,T,S,2);

i1 = find(X(1,:) == 0)
j1 = find(Y(:,1) == 0)
U(j1,i1)

% diskret = [1:2:19]./10
% vrednosti = zeros(length(diskret),1);
% for i = 1:length(diskret)
%     [U,X,Y,s] = resiPoissonDifIter(a,b,c,d,F,Gc,Gd,Ga,Gb,19,19,U0,1e-3,S,3,diskret(i));
%     vrednosti(i) = s;
% end
% povp = sum(vrednosti)./10



















