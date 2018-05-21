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

indeksi = zeros(1,n);
j = 1;
for i = 1:n
    if ismember(i,robne) == 0
        indeksi(i) = j;
        j = j+1;
    end
end
m = sum(not(indeksi == 0));
A = zeros(m);
b = zeros(m,1);
for i = 1:n
    trikotnik = t.Triangulation(i,:);
    for j = 1:3
        for k = j:3
            t1 = trikotnik(j);
            t2 = trikotnik(k);
            if indeksi(t1) || indeksi(t2)
                % vsaj ena notranja
                T = [t.X(trikotnik(1),:);t.X(trikotnik(2),:);t.X(trikotnik(3),:)];
                vr1 = (trikotnik == t1)';
                vr2 = (trikotnik == t2)';
                if indeksi(t1) && indeksi(t2)
                    %obe notranji
                    fn = @(x,y) p(x,y).*trilin(T,vr1,x,y,'x').*trilin(T,vr2,x,y,'x') +...
                        q(x,y).*trilin(T,vr1,x,y,'y').*trilin(T,vr2,x,y,'y') +...
                        r(x,y).*trilin(T,vr1,x,y).*trilin(T,vr2,x,y);
                    temp = triintegral(fn,T);
                    if t1 == t2
                        A(indeksi(t1),indeksi(t2)) = A(indeksi(t1),indeksi(t2))+ temp;
                    else
                        A(indeksi(t1),indeksi(t2)) = A(indeksi(t1),indeksi(t2)) + temp;
                        A(indeksi(t2),indeksi(t1)) = A(indeksi(t2),indeksi(t1)) + temp;
                    end
                   
                else
                    %natanko ena notranja tocka
                    if not (indeksi(t1) == 0)
                        %t1 je notranaj
                        fn = @(x,y) f(x,y).*trilin(T,vr1,x,y)-...
                            (p(x,y).* g(t.X(t2,1),t.X(t2,2)).*trilin(T,vr2,x,y,'x').*trilin(T,vr1,x,y,'x') +...
                            q(x,y).*trilin(T,vr1,x,y,'y').*g(t.X(t2,1),t.X(t2,2)).*trilin(T,vr2,x,y,'y')+...
                            r(x,y).*g(t.X(t2,1),t.X(t2,2)).*trilin(T,vr2,x,y).*trilin(T,vr1,x,y));
                        t1
                        t2
                        temp = triintegral(fn,T)
                        b(indeksi(t1)) = b(indeksi(t1)) + temp;
                    else
                        fi2odvx = @(x,y) trilin(T,vr2,x,y,'x');
                        fi1odvx = @(x,y) g(t.X(t2,1),t.X(t2,2)).*trilin(T,vr1,x,y,'x');
                        fi2odvy = @(x,y) trilin(T,vr2,x,y,'y');
                        fi1odvy = @(x,y) g(t.X(t2,1),t.X(t2,2)).*trilin(T,vr1,x,y,'y');
                        fi2 = @(x,y) trilin(T,vr2,x,y);
                        fi1 = @(x,y) g(t.X(t2,1),t.X(t2,2)).*trilin(T,vr1,x,y);
                        fn = @(x,y) f(x,y).*fi2(x,y)-(p(x,y).* fi2odvx(x,y).*fi1odvx(x,y) +...
                            q(x,y).*fi1odvy(x,y).*fi2odvy(x,y)+ r(x,y).*fi2(x,y).*fi1(x,y));
                        temp = triintegral(fn,T)
                        b(indeksi(t2)) = b(indeksi(t2)) + temp;
                    end
                end
                                                                  
                
            end
                
        end
    end
end
%b = [5/24;5/24];
alfa = A\b;
z = zeros(n,1);
A
b
alfa
for i = 1:length(robne)
    z(robne(i)) = g(t.X(robne(i),1),t.X(robne(i),2));
end

for i = 1:n
    if ~ismember(i,robne)
        z(i) = z(i) + alfa(indeksi(i));
    end
end
% for i = 1:n
%     trikotnik = t.Triangulation(i,:);
%     for j = 1:3
%         t1 = trikotnik(j);
%         vr1 = (trikotnik == t1)';
%         if indeksi(t1)            
%             u(i) = alfa(indeksi(t1)).*trilin(T,vr1,t.X(t1,1),t.X(t1,2));
%         else
%             u(i) = trilin(T,vr1,t.X(t1,1),t.X(t1,2));
%         end
%     end
% end
u = TriRep(t.Triangulation,t.X(:,1),t.X(:,2),z);
end