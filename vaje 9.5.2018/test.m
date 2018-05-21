%testni primeri
% p = @(x,y) -1.*x;
% q = @(x,y) -1.*y;
% r = @(x,y) 4*pi^2.*(x+y);
% f = @(x,y) 2*pi*cos(2*pi.*(x+y));
% g = @(x,y) cos(2*pi.*x).*sin(2*pi.*y);
% L = load('slo.mat');
% t = TriRep(L.TRI, L.X, L.Y);




X = [1/4;3/4;0;1/2;1;1;1;1/2;0;0];
Y = [1/2;1/2;0;0;0;1/2;1;1;1;1/2];
TRI = [1 3 4; 1 3 10;1 9 10; 1 8 9; 1 2 8; 1 2 4; 2 4 5;2 5 6;2 6 7;2 7 8];
t = TriRep(TRI,X,Y);
p = @(x,y) 1+0.*x;
q = @(x,y) 1+0.*x;
r = @(x,y) 0.*x;
f = @(x,y) 1+0.*x;
g = @(x,y) 0.*x;
u = mke(p,q,r,f,t,g)
%t1 = TriRep(TRI,X,Y,u);
trisurf(u);