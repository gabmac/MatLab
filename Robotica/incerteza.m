function uM = incerteza(A,diffvar,erros,junctions)%homogenea 0->n,variaveis de derivacao, matriz com os erros numericos,juntas
%devolve a incerteza em SI
aux = A([1,2,3],4);

for i = 1:1:3
    for j=1:1:junctions
       
        auxM(i,j) = diff(aux(i),diffvar(j));
        
    end
    
end
uM = sym([0 0 0]');
for i = 1:1:3
    for j=1:1:junctions
       
        uM(i) = (auxM(i,j)*erros(j))^2+uM(i);
        
    end
    uM(i) = sqrt(uM(i));
end

