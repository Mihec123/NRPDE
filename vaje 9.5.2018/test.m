%testni primer 1
% X = [1/4;3/4;0;1/2;1;1;1;1/2;0;0];
% Y = [1/2;1/2;0;0;0;1/2;1;1;1;1/2];
% TRI = [1 3 4; 1 3 10;1 9 10; 1 8 9; 1 2 8; 1 2 4; 2 4 5;2 5 6;2 6 7;2 7 8];
% t = TriRep(TRI,X,Y);
% p = @(x,y) 1+0.*x;
% q = @(x,y) 1+0.*x;
% r = @(x,y) 0.*x;
% f = @(x,y) 1+0.*x;
% g = @(x,y) 0.*x;
% [u,A,b] = mke(p,q,r,f,t,g);
% trisurf(u);
% z = u.X(:,3);

%testni primer 2
p = @(x,y) 1+0.*x;
q = @(x,y) 1+0.*x;
r = @(x,y) 0.*x;
f = @(x,y) 1+0.*x;
g = @(x,y) funkcija(x,y);
[X,Y] = meshgrid(linspace(0,1,11));
X = X(:);
Y = Y(:);
TRI = delaunay(X,Y);
t = TriRep(TRI,X,Y);
[u,A,b] = mke(p,q,r,f,t,g);
z1 = u.X(:,3);
trisurf(u);
[U,X,Y,A,B] = resiPoissonDif(0,1,0,1,f,@(x) x.^3,@(x) x.^2,@(y) sin(2*pi*y),@(y) cos(2*pi*y),9,9);
z2 = reshape(U,121,1);
max(abs(z1-z2))

%testni primeri 3
% p = @(x,y) -1.*x;
% q = @(x,y) -1.*y;
% r = @(x,y) 4*pi^2.*(x+y);
% f = @(x,y) 2*pi*cos(2*pi.*(x+y));
% g = @(x,y) cos(2*pi.*x).*sin(2*pi.*y);
% L = load('slo.mat');
% t = TriRep(L.TRI, L.X, L.Y);
% [u,A,b] = mke(p,q,r,f,t,g);
% trisurf(u);