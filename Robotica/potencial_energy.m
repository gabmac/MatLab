function g = potencial_energy(A,mass,junctions,var)
syms g;
P = 0
for i = 1:1:junctions
    P = mass(i)*g*A(3,4,i)+P;

end

for i = 1:1:junctions
    g(i) = simplify(diff(P,var(i)));

end