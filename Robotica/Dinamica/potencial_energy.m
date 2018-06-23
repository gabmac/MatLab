function g = potencial_energy(A,mass,junctions,var)
grav = 9.81;
P = sym(0);
for i = 1:1:junctions
    P = mass(i)*grav*A(3,4,i)+P;

end

g = sym(zeros(junctions,1));
for i = 1:1:junctions
    g(i,1) = simplify(diff(P,var(i)));
end