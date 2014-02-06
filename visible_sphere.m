classdef visible_sphere
    %Visible_Sphere all information needed to print a sphere
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
        center % three dimensional coordinates
        radius % real
        x % part of the the three dimensional matrix.
        y % part of the the three dimensional matrix.
        z % part of the the three dimensional matrix.
    end
    
    methods 
        function print3D (VS)
            h1 = surf(VS.x ,VS.y,VS.z);  
            set(h1, 'edgecolor','none');
            hold on
        end
        
        function squaredist =  distance(B1, B2)
            squaredist = (B1.center(1) - B2.center(1))^2 + ...
                (B1.center(2) - B2.center(2))^2 + ....
                (B1.center(3) - B2.center(3))^2;
        end
        
        
        function VS = visible_sphere( center, radius )
            VS.center = center;
            VS.radius = radius;
            [VS.x,VS.y,VS.z] = sphere(50);
            VS.x = VS.x*radius;
            VS.y = VS.y*radius;
            VS.z = VS.z*radius;
            
            VS.x = VS.x + VS.center(1);
            VS.y = VS.y + VS.center(2);
            VS.z = VS.z+  VS.center(3);
        end
    end

    
end

