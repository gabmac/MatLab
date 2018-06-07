function [J] = dh_table(dh,junctions,prim)%o for prism 1 for rot

    for i = 1:1:junctions
            J(:,:,i) = denavit_hatenberg(dh(i,1),dh(i,2),dh(i,3),dh(i,4));
    end
    
    O = sym([0 0 0]');
    Z = sym([0 0 1]');
    AO = O;
    AZ = Z;
    
    T = eye(4);
    
    for i = 1:1:junctions
        T = simplify(T*J(:,:,i));
        Z(1,i+1) = T(1,3);
        Z(2,i+1) = T(2,3);
        Z(3,i+1) = T(3,3);
        O(1,i+1) = T(1,4);
        O(2,i+1) = T(2,4);
        O(3,i+1) = T(3,4);
    end
    
    OF(1,1) = O(1,i+1);
    OF(2,1) = O(2,i+1);
    OF(3,1) = O(3,i+1);
    k = 0;
    
    for i = 1:1:junctions
        
        if k==0
            if prim(i) == 0 % prismatico
                J = AZ;
                J = cat(1,J,[0 0 0]');
                k = 1;
            else % rotacional
                J = cross(AZ,(OF-AO));
                J = cat(1,J,AZ);
                k = 1;
            end
        else
            AZ(1,1) = Z(1,i);
            AZ(2,1) = Z(2,i);
            AZ(3,1) = Z(3,i);
            if prim(i) == 0 %prismatico
                Aux = AZ;
                Aux = cat(1,Aux,[0 0 0]');
            else
                AO(1,1) = O(1,i);
                AO(2,1) = O(2,i);
                AO(3,1) = O(3,i);
                
                Aux = cross(AZ,(OF-AO));
                Aux = cat(1,Aux,AZ);
            end
            J = cat(2,J,Aux);
         end
     end
        