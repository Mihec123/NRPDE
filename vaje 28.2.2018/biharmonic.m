function bu = biharmonic(u,x,y,h)
% Description:
%  biharmonic computes an approximation for the value of the biharmonic
%  operator applied to a given function at some point in domain
%
% Definition:
%  bu = biharmonic(u,x,y,h)
%
% Input:
%  u    function of two variables,
%  x,y  coordinates of the point in domain,
%  h    offset (used for approximation) in x and y direction
%
% Output:
%  bu   approximate value of the biharnomic operator applied to u at (x,y)

bu = 1/h^4 * (20*u(x,y)-8*u(x-h,y)+u(x-2*h,y)-8*u(x+h,y)+u(x+2*h,y)-8*u(x,y-h)-8*u(x,y+h) + u(x,y+2*h)+u(x,y-2*h)+ 2*u(x-h,y-h)+2*u(x+h,y-h)+2*u(x-h,y+h)+2*u(x+h,y+h));

end

