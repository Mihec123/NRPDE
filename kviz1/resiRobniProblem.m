function [y,x,S] = resiRobniProblem(a,b,p,q,r,alpha,beta,n)
% Opis:
%  resiRobniProblem uporabi diferencno metodo za izracun numericne resitve
%  navadne diferencialne enacbe -(p(x) y')' + q(x) y = r(x) na intervalu
%  (a,b) pri robnih pogojih y(a) = alpha in y(b) = beta
%
% Definicija:
%  [y,x] = resiRobniProblem(a,b,p,q,r,alpha,beta,n)
%
% Vhodni podatki:
%  a, b         robova intervala, na katerem resujemo enacbo,
%  p, q, r      funkcije, ki nastopajo v enacbi,
%  alpha, beta  robni vrednosti resitve,
%  n            parameter, ki doloca na koliko podintervalov je razdeljen
%               interval [a,b]
%
% Izhodna podatka:
%  y            seznam dolzine n+1, ki predstavlja priblizek za resitev
%               robnega problema v n+1 ekvidistantno razporejenih tockah na
%               intervalu [a,b],
%  x            seznam dolzine n+1, ki predstavlja ekvidistantno
%               razporejene tocke na intervlau [a,b]
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
B = zeros(n-1,3);
B(:,2) = diagonala;
B(1:end-1,1) = poddiag;
B(2:end,3) = naddiag; 
S = spdiags(B,[-1,0,1],n-1,n-1);
%M = diag(diagonala) + diag(naddiag,1) + diag(poddiag,-1);

b = zeros(n-1,1);

for i=1:n-1
    b(i) = r(x(i+1))*h^2;
end

b(1) = b(1) +pf(1)*alpha;
b(n-1) = b(n-1) + pf(n)*beta;
%y1 = M\b;
y1 = S\b;
y(1) = alpha;
y(n+1) = beta;
y(2:n) = y1;

plot(x,y);       



end

