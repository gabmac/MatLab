function [ Q ] = reverse_kinematics( vars, A0n, initial, objective, tipo_juntas)
%inverse_cinematic Calculo da cinematica inversa
%   Calcula a cinematica iversa a partir de uma posição para um manipulador

    n_juntas = size(vars, 1);
    
    J = sym(zeros(3, n_juntas));
    XYZ =  A0n(1:3,4,n_juntas);
    for i=1:3
        for j=1:n_juntas
            J(i,j) = diff(XYZ(i), vars(j));
        end
    end
    
    Q = initial;

    for k=1:50
        XYZi = eval(subs(XYZ, vars, Q));
        Erro = objective - XYZi;
        
        Jn = eval(subs(J,vars,Q));
        %Erro
        Jinv = Jn'*inv(Jn*Jn');
        
        Q = Q + Jinv*Erro;
        
        for j=1:n_juntas
            if tipo_juntas == 1
                Q(j) = mod(Q(j), 2*pi);
                
                if Q(j) > pi
                    Q(j) = Q(j) - 2*pi;
                end
            end
        end
        
        if abs(Erro) < 1.0e-5
            break
        end
    end
    k
    Erro
end

