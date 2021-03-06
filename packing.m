classdef packing < handle
    % The class is a sphere container. 
    %     The sphere contained in the container should represent a real 
    %     sphere packing enumeration at the end.
    
    properties
        graph  % matrix that contains the graph of contact of spheres
               % that are in the packing 
        bowls  % cell array vector that contains the spheres of this packing
        center % center of the first sphere that is to be inserted
        extremity 
               % if we place a sphere at this point, it should not be
               % conflicting with the packing (= it has to be sufficiently
               % far away from the mass center of the packing
        number % number of bowls present in this packing
    end
    
    
    methods
        function P = packing(center,extremity)
            % the parameters center and extremity are not very useful, moreover they 
            % are arbitrary
            P.bowls ={};
            P.center = center;
            P.extremity = extremity;
            P.number =0;
        end
        
        function addsphere (P, R)
        % this method is not used anymore by sphere_packing.m and generate_graphs.
            % P is this packing object, whereas R is the radius of the
            % sphere to be inserted
            if P.number == 0 % insert the first sphere in the packing
               %P.graph = zeros(size(P.graph)+1); 
                VS = visible_sphere( P.center, R );
                P.bowls{1} = VS;
            else % insert the next shperes
               %P.graph = zeros(size(P.graph)+1);
               %y = -ones(1,3);
               %x = rand(1,3);
               %y(x<0.5) = 1;
               %P.extremity = (P.extremity).*y;
               f =@(x)contact_opt(x,P);
               nonlcon = @(x)contact_con(x,P,R);
               center_solution = fmincon (f,P.extremity,zeros(3,3), ...
                   zeros(1,3),zeros(3,3), zeros(1,3),-P.extremity,...
                   P.extremity, nonlcon);
               P.bowls{P.number + 1} = visible_sphere(center_solution , R );
               
            end
            P.number = P. number +1;
        end
        
        function real = isgeometricallyvalid(P)
        % this function checks if the spheres contained 
        % in the packing are not intersecting each other
        % and returns the number of intersecting spheres
            real = 0;
            for i = 1:P.number
                for j = i+1:P.number
                    if i~=j
                        if  (distance(P.bowls{i},P.bowls{j}) < (P.bowls{i}.radius + P.bowls{j}.radius)^2)
                            real = real +1;
                        end
                    end
                end
            end
            %real = (real == 0);
        end
        
        function add (P,R,C)
        % add a sphere to the packing.
            % P : this object
            % R : radius
            % C : center
            P.number = P.number +1;
            VS = visible_sphere(C , R );
            P.bowls{P.number} = VS;
        end
        
        function  print3D (P)
        % Display all the spheres of the packing, in only one plot.
            for i = 1:P.number
                P.bowls{i}.print3D();
            end
            % the next call to any plotting function of matlab will overwrite the previous plot.
            hold off;
            % forcing a orthonormal axes representation.
            daspect([1 1 1]);       
        end
    end
    
end

