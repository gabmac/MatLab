function [S1,S2,Val,taux] = singularity(J, juntas)

    aux1 = J(1:3,1:juntas);
    aux2 = J(4:6,1:juntas);
    
    coluna_inicio = 1;
    coluna_fim = 3;
    i = 1;
    while(coluna_fim <= juntas)
        S1(i) = simplify(det( aux1(:,coluna_inicio:coluna_fim)));
        S2(i) = simplify(det( aux2(:,coluna_inicio:coluna_fim)));
        coluna_inicio = coluna_inicio + 1;
        coluna_fim = coluna_fim + 1;
        i = i + 1;
    end



clear t1 t2 t3 t4 t5;
i = 1;
j = 1;
for t1 = 0:0.5:2*pi
    for t2 = 0:0.5:2*pi
        for t3 = 0:0.5:2*pi
            for t4 = 0:0.5:2*pi
                for t5 = 0:0.5:2*pi
                   Val(i) = (207*sin(t3 - t2 + t4 + t5))/250000 + (69*sin(t2 + 2*t3 + t4 + t5))/12500 - (9*sin(t2 - t3))/3125 + (6*sin(t2 + 2*t3))/625 - (6*sin(t2 - t4))/625 - (69*sin(t2 - t5))/25000 + (9*sin(t2 + t3 + t4))/3125 - (69*sin(t2 + t4 + t5))/25000 + (69*sin(t2 + 2*t3 + 2*t4 + t5))/12500 + (9*sin(t3 - t2 + t4))/3125 + (12*sin(t2 + 2*t3 + t4))/625 + (69*sin(t4 - t2 + t5))/25000 + (207*sin(t2 + t3 + t4 + t5))/250000 + (9*sin(t2 + t3))/3125 - (6*sin(t2 + t4))/625 - (69*sin(t2 + t5))/25000 + (1587*sin(t2 + 2*t3 + 2*t4 + 2*t5))/2000000 - (39987*sin(t2))/2000000 + (6*sin(t2 + 2*t3 + 2*t4))/625;
                    if(abs(Val(i)) < 10^-320)
                        save(1,j) = Val(i);
                        taux(2,j) = radtodeg(t1);
                        taux(3,j) = radtodeg(t2);
                        taux(4,j) = radtodeg(t3);
                        taux(5,j) = radtodeg(t4);
                        taux(6,j) = radtodeg(t5);
                        j = j+1;
                    end
                    i = i+1;
                end
            end
        end    
    end
end

    
end    
