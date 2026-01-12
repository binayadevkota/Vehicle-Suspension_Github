function dx = quartercar_ode(t, x, ms, mu, ks, cs, kt, zr)

dx = zeros(4,1);

dx(1) = x(2);
dx(2) = (-ks*(x(1)-x(3)) - cs*(x(2)-x(4))) / ms;

dx(3) = x(4);
dx(4) = ( ks*(x(1)-x(3)) + cs*(x(2)-x(4)) - kt*(x(3)-zr) ) / mu;

end
