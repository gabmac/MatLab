function k = kinect_energy(D,var,junctions)

for i = 1:1:junctions
    k = simplify(.5*var*D*var.');
    
end