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
[U,X,Y,A,B]= resiPoissonDif(a,b,c,d,F,Gc,Gd,Ga,Gb,J,K);
[U1,X1,Y1]= resiPoissonDif(a,b,c,d,F,Gc,Gd,Ga,Gb,2*J+1,2*K+1);

U2 = U(2:end-1,2:end-1);
U3 = U1(2:end-1,2:end-1);
U3 = U3(2:2:end,2:2:end);

U4 = (4*U3-U2)./3;
E = U;
E(2:end-1,2:end-1) = U4;

tocnares = @(x,y) (x-y).^4;

T = tocnares(X,Y);
T1 = tocnares(X1,Y1);

x = 0.5;
y = 0.5;
i = find(X(1,:) == 0.5);
j = find(Y(:,1) == 0.5);