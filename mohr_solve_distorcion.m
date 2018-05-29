%para círculo de Mohr de valores provindo de rosetas
function [matriz,e1,e2,lmax,T1,T2,Ts] = mohr_solve_distorcion(t1,t2,t3,v1,v2,v3)
    
    B = [v1 v2 v3]';
    
    A = [(cos(t1*pi/180))^2 (sin(t1*pi/180))^2 cos(t1*pi/180)*sin(t1*pi/180);
          (cos(t2*pi/180))^2 (sin(t2*pi/180))^2 cos(t2*pi/180)*sin(t2*pi/180);
          (cos(t3*pi/180))^2 (sin(t3*pi/180))^2 cos(t3*pi/180)*sin(t3*pi/180)];
      
      
    matriz = linsolve(A,B);
    
    ec = (matriz(1)+matriz(2))/2
    
    R = sqrt((matriz(2)-ec)^2 + (matriz(3)/2)^2);
    e1 = ec+R;
    e2 = ec-R;
    lmax = -2*R;
    
    T2 = 0.5*atan(0.5*matriz(3)/(matriz(1)-ec));
    T2 = T2*180/pi;
    T1 = 90 - T2;
    Ts = 0.5*atan((matriz(1)-ec)/(0.5*matriz(3)));
    Ts = Ts*180/pi;
    figure;
    viscircles([ec,0],R);
