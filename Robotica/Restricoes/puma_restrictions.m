function [ Q, d_Q ] = puma_restrictions( Q, d_Q )
%puma_restrictions Limit the moving based on the restrictions
%   Limit the robotic arms movement based on each joint restriction
    
    Q_limits = [
        degtorad(-170)  degtorad(170)
        degtorad(-160)  degtorad(65)
        degtorad(-51)   degtorad(225)
        degtorad(-200)  degtorad(200)
        degtorad(-135)  degtorad(135)
        degtorad(-360)   degtorad(360)
    ];

    d_Q_limits = [
        degtorad(275)
        degtorad(275)
        degtorad(289)
        degtorad(555)
        degtorad(555)
        degtorad(720)
    ];
    
    n_juntas = size(Q, 1);
    
    for i=1:n_juntas
        if Q(i) <  Q_limits(i,1)
            Q(i) = Q_limits(i,1);
        elseif Q(i) >  Q_limits(i,2)
            Q(i) = Q_limits(i,2);
        end
        
        if abs(d_Q(i)) >  d_Q_limits(i,1)
            d_Q(i) = d_Q_limits(i)*sign(d_Q(i));
        end
    end

end

