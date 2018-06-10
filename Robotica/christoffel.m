function C = christoffel(Dt,dh,prim,junctions)
%Cijk => i = matriz, j= coluna k = linha

for i = 1:1:junctions
    if(prim(i) == 1)
        var(i) = dh(i,1);
    else
        var(i) = dh(i,2);
    end
end



for i = 1:1:junctions %matriz
    
    for j = 1:1:junctions %coluna
        
        for k = 1:1:junctions %linha
            
            C(k,j,i) = (diff(Dt(k,j),var(i)) + diff(Dt(k,i),var(j)) - diff(Dt(i,j),var(k)))/2;%dando pau%
        
        end
    end
end

