% c = 1/2;
% f1 = @(x)f(x);
% g = @(x) 0.*x;
% h =  @(x) 0.*x;
% T = 1;
% a = 0;
% b = 1;
% dt = 1/100;
% dx = 1/10;
% 
% x = [a:dx:b];
% y = [0:dt:T];
% [X,Y] = meshgrid(x,y);
% [ U,lam ] = resiToplotnoEksDif(c,f1,g,h,T,a,b,dt,dx);
% surf(X,Y,U)

%test2

% c = 1/2;
% f1 = @(x)f(x);
% g = @(x) 0.*x;
% h =  @(x) 0.*x;
% T = 1;
% a = 0;
% b = 1;
% dt = 21/1000;
% dx = 1/10;
% 
% x = [a:dx:b];
% y = [0:dt:T];
% [X,Y] = meshgrid(x,y);
% [ U,lam ] = resiToplotnoEksDif(c,f1,g,h,T,a,b,dt,dx);
% surf(X,Y,U(1:length(y),1:length(x)))


%test3

c = 1/2;
f1 = @(x)f(x);
g = @(x) x;
h =  @(x) x;
T = 1;
a = 0;
b = 1;
dt = 1/100;
dx = 1/10;

x = [a:dx:b];
y = [0:dt:T];
[X,Y] = meshgrid(x,y);
[ U,lam ] = resiToplotnoEksDif(c,f1,g,h,T,a,b,dt,dx);
surf(X,Y,U(1:length(y),1:length(x)))
