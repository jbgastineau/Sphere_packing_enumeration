classdef visible_sphere
    % A sphere object, ready to be displayed by matlab
    %   
    
    properties (SetAccess = private)
        center % three dimensional coordinates
        radius % real
        x % part of the the three dimensional matrix used to display the sphere.
        y % part of the the three dimensional matrix used to display the sphere.
        z % part of the the three dimensional matrix used to display the sphere.
    end
    
    methods 
        function print3D (VS)
            h1 = surf(VS.x ,VS.y,VS.z);  
            % hiding the axes of the plot.
            set(h1, 'edgecolor','none');
            % the next call to the "surf" function will add features to the same plot 
            hold on
        end
        
        function squaredist =  distance(B1, B2)
        	% calculus of the square distance beetween the centers of two spheres.
            squaredist = (B1.center(1) - B2.center(1))^2 + ...
                (B1.center(2) - B2.center(2))^2 + ....
                (B1.center(3) - B2.center(3))^2;
        end
        
        
        function VS = visible_sphere( center, radius )
        	% Constructor of the visible_sphere object
            VS.center = center;
            VS.radius = radius;
            [VS.x,VS.y,VS.z] = sphere(50); % here 50 is an arbitrary number.
            VS.x = VS.x*radius;
            VS.y = VS.y*radius;
            VS.z = VS.z*radius;
            
            VS.x = VS.x + VS.center(1);
            VS.y = VS.y + VS.center(2);
            VS.z = VS.z+  VS.center(3);
        end
    end

    
end

