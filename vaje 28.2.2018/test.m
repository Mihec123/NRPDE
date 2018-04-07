%test

u = @(x,y) exp(-x.^2-y.^2);
tocna = @(x,y) 4.*exp(-x.^2-y.^2) .*(x.^2+y.^2-1);

