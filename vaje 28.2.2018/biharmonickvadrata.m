function [M] = biharmonickvadrata(u,h,a)
%izraèunamo biharmonièni operator funkcije na kvadratu s stranico 2a in ga narišemo
n = 2*a/h +1;
M = zeros(n);
for i =1:n
    for j=1:n
        M(i,j) = biharmonic(u,-1+i*h,-1+j*h,h);
    end
end
surf([-a:h:a],[-a:h:a],M);


end

