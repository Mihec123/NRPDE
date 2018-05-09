function u = mke(p,q,r,f,t,g)
% Opis:
%  mke izracuna priblizek za resitev parcialne diferencialne enacbe
%   - d/dx (p(x,y) du/dx) - d/dy (q(x,y) du/dy) + r(x,y) u = f(x,y)
%  z robnim pogojem u = g po metodi koncnih elementov z zveznimi odsekoma
%  linearnimi funkcijami nad triangulacijo
%
% Definicija
%  u = mke(p,q,r,f,t,g)
%
% Vhodni podatki:
%  p,q,r,f  funkcije dveh spremenljivk, ki dolocajo parcialno diferencialno
%           enacbo,
%  t        triangulacija obmocja, predstavljena z razredom TriRep,
%  g        funkcija dveh spremenljivk, ki doloca vrednost resitve na robu
%           obmocja
%
% Izhodni podatek:
%  u        3D triangulacija, predstavljena z razredom TriRep, ki doloca
%           zvezno odsekoma linearno funkcijo, ki je priblizek za resitev
%           robnega problema po metodi najmanjsih kvadratov



%freeBoundary(t)
n = length(t.X);
robne1 = freeBoundary(t);
robne = unique(robne1(:));

indeksi = zeros(2,n);
indeksi(2,:) = 1:n;
j = 1;
for i = 1:n
    if ismember(i,robne) == 0
        indeksi(1,i) = j;
        j = j+1;
    end
end

indeksi
u = 1;

end