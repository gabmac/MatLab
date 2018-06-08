function matriz = denavit_hatenberg(t,d,a,A)
%transforma cada linha da Dh em uma matriz homogena
   
    z1 = cos(t);
    z2 = sin(t);
    z3 = cos(a);
    z4 = sin(a);
    
    if isobject(z1) == 0 && z1 < 1*10^-6
        z1 = 0;
    end
    
    if isobject(z2) == 0 &&abs(z2) < 1*10^-6
        z2 = 0;
    end
    
    if isobject(z3) == 0 && abs(z3) < 1*10^-6
        z3 = 0;
    end
    
    if isobject(z4) == 0 && abs(z4) < 1*10^-6
        z4 = 0;
    end
    
    matriz = [z1 -z2*z3 z2*z4 A*z1;
          z2 (z1*z3) (-z1*z4) A*z2;
           0 z4 z3 d;
           0 0 0 1];
       
     