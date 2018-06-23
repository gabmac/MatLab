function [ Q ] = reverse_kinematics( vars, dh, initial, objective)
%inverse_cinematic Calculo da cinematica inversa
%   Calcula a cinematica iversa a partir de uma posição para um manipulador

    n_juntas = size(vars, 1);
    K = sym(zeros(4,4,n_juntas));
    A0n = sym(zeros(4,4,n_juntas));
    
    for i = 1:1:n_juntas
        K(:,:,i) = denavit_hatenberg(dh(i,1),dh(i,2),dh(i,3),dh(i,4));
    end
    
    for i=1:n_juntas
        A0n(:,:,i) = eye(4);
        for j=1:i
            A0n(:,:,i) = A0n(:,:,i)*K(:,:,j);
        end
    end
    A0n = simplify(A0n);
    
    XYZp = sym(zeros(3, n_juntas+1));
    
    for i=2:n_juntas+1
        XYZp(:,i) = A0n(1:3,4,i-1);
    end
    
    J = sym(zeros(3, n_juntas));
    XYZ =  simplify(A0n(1:3,4,n_juntas));
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
        if Erro == 0
            break
        end
    end
    Erro
end

