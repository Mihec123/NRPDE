a = 0;
b = 1;
c = 0;
d = 2;
F = @(x,y) 24*(x-y).^2;
Gc = @(x) x.^4;
Gd = @(x) (x-2).^4;
Ga = @(x) x.^4;
Gb = @(x) (x-1).^4;
J = 1;
K = 3;
T = 1e-10;
S = 100000;
U0 = @(x,y)0.*x+0.*y;
M = 3;
w = 1.3;
[U,X,Y,s] = resiPoissonDifIter(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K,U0,T,S,M,w);
[U1,X1,Y1,s1] = resiPoissonDifIter(a,b,c,d,F,Gc,Gd,Ga,Gb,2*J+1,2*K+1,U0,T,S,M,w);
[U2,X2,Y2,s2] = resiPoissonDifIter(a,b,c,d,F,Gc,Gd,Ga,Gb,19,39,U0,T,S,M,w);

tocnares = @(x,y) (x-y).^4;

T = tocnares(X,Y);
T1 = tocnares(X1,Y1);
T2 = tocnares(X2,Y2);
