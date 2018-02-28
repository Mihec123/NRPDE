function lu = harmonic(u,x,y,h)
%diskreten harmonièen operator
%input u function of two variables
%x,y coordinates of points in domain
%h offset


lu = 1/h^2 * (-4*u(x,y)+u(x-h,y)+u(x+h,y)+u(x,y-h)+u(x,y+h));

end

