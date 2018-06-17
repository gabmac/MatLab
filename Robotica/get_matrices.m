function [ D, C, g ] = get_matrices(d_q, q)

    load('dinamic.mat');    
    
    D_ = subs(Dt, vars, q);
    C_ = subs(C, vars, q);
    C_ = subs(C_, d_vars, d_q);
    g_ = subs(g, vars, q);
    
    D = double(D_);
    C = double(C_);
    g = double(g_);
    
end
