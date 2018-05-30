function U = resiPoVetru(c,f,g,h,T,a,b,dt,dx)
% ce se dt ne izide gres do floor
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%


J = (b-a)/dx+1;
N = floor(T/dt)+1;
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
    for k = 2:J-1
        Cjn = c((i-2)*dt,a+(k-1)*dx);
        lam = Cjn * dt/dx;
        if Cjn >= 0
            U(i,k) = lam*U(i-1,k-1) + (1-lam)*U(i-1,k);
        else
            U(i,k) = (1+lam)*U(i-1,k) - lam*U(i-1,k+1);
        end
    end
end

end

