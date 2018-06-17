function [ pos ] = get_pos( q )

    load('cinematic.mat');
    n = size(vars);
    for i=1:n(1,1)
        T = subs(T, vars(i), q(i));
    end
    pos = double(T(1:3,4));
end

