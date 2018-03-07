function [y,x] = resiRobniProblem(a,b,p,q,r,alpha,beta,n)
%resujemo enacbo -(p(x)y)' + q(x)y = r(x) z operatorejm iz vaj na x \in (a,b)
%h = (b-a)/h;, kjer je y(a) = alpha,y(b) = beta iscemo za tocke 
%i=1,...,n-1
%testni primer:
% n = 4
% p = @(x) 1+x.^2
% q = @(x) x.^2
% r=@(x)-1;
% alpha = beta = 0;
% a = -1;
% b= 1;

h = (b-a)/n;

y = zeros(n+1,1);
x = [a:h:b];

%p v i +/- 1/2
pf = zeros(n+1);
for i=1:n+1
    pf(i) = p(x(i)+h/2);
end

diagonala = zeros(n-1,1);
for i =1:n-1
    diagonala(i) = pf(i)+pf(i+1) + h.^2*q(x(i+1));
end
naddiag = zeros(n-2,1);
poddiag = zeros(n-2,1);

for i=2:n-1
    poddiag(i-1) = -pf(i);
end


for i=1:n-2
    naddiag(i) = -pf(i+1);
end
M = diag(diagonala) + diag(naddiag,1) + diag(poddiag,-1);

b = zeros(n-1,1);

for i=1:n-1
    b(i) = r(x(i+1))*h^2;
end

b(1) = b(1) +pf(1)*alpha;
b(n-1) = b(n-1) + pf(n)*beta;
y1 = M\b;

y(1) = alpha;
y(n+1) = beta;
y(2:n) = y1;

plot(x,y);       



end

