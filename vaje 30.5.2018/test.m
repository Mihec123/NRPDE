%test

a = -2;
b = 4;
T = 6.28;
dt = 0.1;
dx = 0.1;
c = @(t,x) sin(t);
f = @(x) exp(-x.^2);
u = @(t,x) exp(-(x-(1-cos(t))).^2);

g = @(t) u(t,a);
h = @(t) u(t,b);
x = [a:dx:b];
y = [0:dt:T];
[X,Y] = meshgrid(x,y);

U = resiPoVetru(c,f,g,h,T,a,b,dt,dx);
surf(X,Y,U)

V = u(Y,X);
max(max(abs(V-U)))