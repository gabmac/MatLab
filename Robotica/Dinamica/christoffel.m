function [C,Cs] = christoffel(Dt, junctions, var, d_var)
%Cijk => i = matriz, j= coluna k = linha

Cs = sym(zeros(junctions, junctions, junctions));

for i = 1:1:junctions %matriz
    
    for j = 1:1:junctions %coluna
        
        for k = 1:1:junctions %linha
            
            Cs(k,j,i) = (diff(Dt(k,j),var(i)) + diff(Dt(k,i),var(j)) - diff(Dt(i,j),var(k)))/2;%dando pau%
        
        end
    end
end

C  = sym(zeros(junctions, junctions));


for i = 1:1:junctions
    
    for j = 1:1:junctions
        
        for k = 1:1:junctions
            
            C(i,j) = Cs(i, j, k)*d_var(k) + C(i,j);
        
        end
    end
end

C = simplify(C);