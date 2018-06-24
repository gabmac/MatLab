function [ A, tempos_tragetoria, Q ] = get_trajectories( dh, vars, Q0, tipo_juntas )
    
    initial_pos = [0.2; 0.2; 0.2];
    
    pontos_tragetoria = [initial_pos [0.5; 0.2; 0.2] [0.2; 0.5; 0.2] initial_pos];
    n_pontos = size(pontos_tragetoria, 2);
    n_juntas = size(vars, 1);
    
    dt = 0.3;
    tempos_tragetoria = [
                        [0,       1]
                        [1+dt,   2.5+dt]
                        [2.5+2*dt, 3.5+2*dt]
        ];
    
    Q = multiple_points_reverse_kinematics(dh, vars, pontos_tragetoria, Q0, tipo_juntas);
    
    A = zeros(n_pontos-1, 6, n_juntas);
    
    for i=1:n_pontos-1
        for j=1:n_juntas
            A(i,:,j) = determine_tragectory_function_coefficients(Q(j,i), Q(j,i+1), tempos_tragetoria(i,1), tempos_tragetoria(i,2));
        end
    end
end

