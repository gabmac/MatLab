function [ Q ] = multiple_points_reverse_kinematics( dh, vars, pontos_tragetoria, Q0, tipo_juntas)

    n_pontos = size(pontos_tragetoria, 2);
    n_juncoes = size(dh,1);

    Q = zeros(n_juncoes, n_pontos);
    for i=1:n_pontos
        Q(:,i) = reverse_kinematics(vars, dh, Q0, pontos_tragetoria(:,i), tipo_juntas);
        Q0 = Q(:,i);
    end
end

