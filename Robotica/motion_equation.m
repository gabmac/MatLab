function Dt = motion_equation(dh,junctions,mass,Inertia,prism)%dh = tabela dh,numero de juncoes massa,vetor de inercia,vetor que decide como é  a junta

k = 0;
Aj = junctions - 1;



for i = 1: 1: junctions
    dhaux(i) = i;
    prismaux(i) = prism(i);
    [J,A,K] = dh_table(dh(dhaux,[1,2,3,4]),i,prismaux);
    if(i<junctions)
        aux1 = zeros(6,Aj);
        Aj = Aj-1;
        Jn(:,:,i) = cat(2,J,aux1);
    else
        Jn(:,:,i) = J;
    end
end

for i = 1:1:junctions
    vaux(i) = i;
end

aux = [];
for i = 1:1:junctions
    aux = Jn(:,:,i);
    Jvn(:,:,i) = aux([1,2,3],vaux);
    Jwn(:,:,i) = aux([4,5,6],vaux);
end
aux = [];
for i = 1:1:junctions
    aux = A(:,:,i);
    Dv(:,:,i) = simplify(mass(i)*(Jvn(:,:,i).'*Jvn(:,:,i)));
    Dw(:,:,i) = simplify(Jwn(:,:,i).'*aux([1,2,3],[1,2,3])*Inertia(:,:,i)*aux([1,2,3],[1,2,3]).'*Jwn(:,:,i));
    D(:,:,i) = Dv(:,:,i)+Dw(:,:,i);
end

[m,n] = size(D(:,:,1));

Dt = zeros(m,n);
for i = 1:1:junctions
    Dt = Dt+D(:,:,i);
end

Dt = simplify(Dt);







