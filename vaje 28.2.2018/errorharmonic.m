%error of harmonic biharmonic operator
tocnalaplace = -4;
tocnabiharmonic = 32;
u = @(x,y) exp(-x.^2-y.^2);

%za laplace
delitev = [1e-5:1e-6:1e-3];
dol = length(delitev);
napaka = zeros(1,dol);
for i = 1:dol
    napaka(i) = abs(tocnalaplace - laplace(u,0,0,delitev(i)));
end
[minimum,indeks] = min(napaka);
opth = delitev(indeks)
figure;
plot([1:dol],log10(napaka))

%za biharmonicno
delitevbi = [1e-4:1e-5:1e-2];
dolbi = length(delitevbi);
napakabi = zeros(1,dol);
for i = 1:dolbi
    napakabi(i) = abs(tocnabiharmonic - biharmonic(u,0,0,delitevbi(i)));
end
[minimumbi,indeksbi] = min(napakabi);
opthbi = delitevbi(indeksbi)
figure;
plot([1:dolbi],log10(napakabi))