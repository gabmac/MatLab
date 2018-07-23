function uM = incerteza(A,diffvar,erros,junctions)%homogenea 0->n,variaveis de derivacao, matriz com os erros numericos,juntas
%devolve a incerteza em SI
aux = A(1:3,4,length(junctions));

for i = 1:1:3
    for j=1:1:length(junctions)
       
        auxM(i,j) = diff(aux(i),diffvar(j));
        
    end
    
end
uM = sym([0 0 0]');
for i = 1:1:3
    for j=1:1:length(junctions)
       
        uM(i) = (auxM(i,j)*erros(j))^2+uM(i);
        
    end
    uM(i) = sqrt(uM(i));
end

%scara%
% syms A1 A2 D1 D4 D3 t1 t2 t4;
% 
% uM = subs(uM,[A1 A2 D1 D4 t1 t2 D3 t4],[0.3 .4 .6 1 degtorad(30) degtorad(45) .3 degtorad(15)]);



