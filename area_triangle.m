function a = area_triangle(Ax,Ay,Bx,By,Cx,Cy)
    a = 0.5*abs(Ax*(By-Cy)+Bx*(Cy-Ay)+Cx*(Ay-By));
end
