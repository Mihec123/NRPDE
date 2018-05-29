function [ z ] = funkcija( x,y )
%funkcija u vhod vektor x,y
z = 0;
if y == 0
    z = x.^3;
elseif y == 1
    z = x.^2;
elseif x == 0
    z = sin(2*pi*y);
elseif x== 1
    z = cos(2*pi*y);
end

end

