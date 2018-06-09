function k = kinect_energy(D,diffvar,junctions)

for i = 1:1:junctions
    k = simplify(.5*var*D*var.');

end
