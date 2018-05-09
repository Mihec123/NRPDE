function IfT = triintegral(f,T)
% Opis:
%  triintegral vrne priblizek za vrednost integrala funkcije na danem
%  trikotniku
%
% Definicija:
%  IfT = triintegral(f,T)
%
% Vhodna podatka:
%  f    funkcija dveh spremenljivk,
%  T    tabela velikosti 3 x 2, v kateri vsaka vrstica predstavlja
%       kartezicni koordinati oglisca trikotnika, na katerem integriramo
%       funkcijo f
%
% Izhodni podatek:
%  IfT  priblizek za integral funkcije f na trikotniku, podanem s tabelo T


%fi = @(u,v) [u*T(1,1)+v*T(2,1)+(1-u-v)*T(3,1),u*T(1,2)+v*T(2,2)+(1-u-v)*T(3,2)]

detJmat = abs(det([T(1,1)-T(3,1), T(1,2)-T(3,2); T(2,1)-T(3,1), T(2,2)-T(3,2)]));

fn = @(u,v) f(u*T(1,1)+v*T(2,1)+(1-u-v)*T(3,1),u*T(1,2)+v*T(2,2)+(1-u-v)*T(3,2)) * detJmat; 

IfT = integral2(fn,0,1,0,@(u)1-u);



end