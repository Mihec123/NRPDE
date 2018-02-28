%error of harmonic biharmonic operator
tocna = -4;
h = [0.0000002:0.0000005:0.05];
u = @(x,y) exp(-x.^2-y.^2);
dol = length(h);
napaka = zeros(1,dol);
for i = 1:dol
    napaka(i) = abs(abs(tocna) - abs(harmonic(u,0,0,h(i))));
end
[minimum,indeks] = min(napaka);
opth = h(indeks)
plot([1:dol],log10(napaka))
%treba isto nardit se za biharmonièno