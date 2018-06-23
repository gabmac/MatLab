function [ A, tempos_tragetoria ] = get_trajectories( dh, vars, Q0 )
    
    initial_pos = [0.2; 0.2; 0.2];
    
    pontos_tragetoria = [initial_pos [0.5; 0.2; 0.2] [0.2; 0.5; 0.2] initial_pos];
    n_pontos = size(pontos_tragetoria, 2);
    n_juntas = size(vars, 1);
    
    dt = 0.3;
    tempos_tragetoria = [
                        [dt,       1+dt]
                        [1+2*dt,   2.5+2*dt]
                        [2.5+3*dt, 3.5+3*dt]
        ];
    
    Q = multiple_points_reverse_kinematics(dh, vars, pontos_tragetoria, Q0);
    
    A = zeros(6,n_juntas, n_pontos-1);
    
    for i=1:n_pontos-1
        for j=1:n_juntas
            A(:,j,i) = determine_tragectory_function_coefficients(Q(j,i), Q(j,i+1), tempos_tragetoria(i,1), tempos_tragetoria(i,2));
        end
    end

end

