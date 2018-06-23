function [ Q ] = multiple_points_reverse_kinematics( dh, vars, pontos_tragetoria, Q0)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    n_pontos = size(pontos_tragetoria, 2);
    n_juncoes = size(dh,1);

    Q = zeros(n_juncoes, n_pontos);
    for i=1:n_pontos
        if i>1
            Q(:,i) = reverse_kinematics(vars, dh, Q(:,i-1), pontos_tragetoria(:,i));
        else 
            Q(:,i) = reverse_kinematics(vars, dh, Q0, pontos_tragetoria(:,i));
        end
    end
end

