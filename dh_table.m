function J = dh_table(dh,junctions,rorp)%o for prism 1 for rot

    for i = 1:1:junctions
            A(:,:,i) = denavit_hatenberg(dh(i,1),dh(i,2),dh(i,3),dh(i,4));
    end
    
