function [ U,lam ] = resiToplotnoEksDif(c,f,g,h,T,a,b,dt,dx)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


lam = c^2*dt/dx^2;
J = (b-a)/dx+1;
N = T/dt+1;
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
    for j=2:J-1
        U(i,j) = lam*U(i-1,j-1) + (1-2*lam)*U(i-1,j) + lam*U(i-1,j+1);
    end
end


end

