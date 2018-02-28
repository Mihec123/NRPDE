function bu = biharmonic(u,x,y,h)
%diskreten biharmonièen operator

bu = 1/h^4 * (20*u(x,y)-8*u(x-h,y)+u(x-2*h,y)-8*u(x+h,y)+u(x+2*h,y)-8*u(x,y-h)-8*u(x,y+h) + u(x,y+2*h)+u(x,y-2*h)+ 2*u(x-h,y-h)+2*u(x+h,y-h)+2*u(x-h,y+h)+2*u(x+h,y+h));

end

