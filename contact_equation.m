function [ Res ] = contact_equation(x,graph)
% Vectorized objective function to be minimized, to build a geometrically valid sphere packing,
% according to the contact graph available in graph.graph 

% x      :  a matrix whose columns are vectors of the coordinate of the centers of the spheres
%           of the packing
% graph  :  a Single_graph object.

% Initialisation :
Res = 0*x(:,1);

% For each possible pair of spheres.
for i = 1:graph.length
    for j = 1+1:graph.length
    
        % index of the first coordinate of the center of the i^th sphere of the graph 
        I = (i-1)*3; 
        % index of the first coordinate of the center of the j^th sphere of the graph 
        J = (j-1)*3;
        
        % squared euclidian distance between the two centers 
        squareDist_centers =   (x(:,I+1) - x(:,J+1)).^2 + ...
            (x(:,I+2) - x(:,J+2)).^2 + (x(:,I+3) - x(:,J+3)).^2;
        % squared sum of radiuses
        Radiuses = (graph.radiuses(i) + graph.radiuses(j))^2 ;
        
        if ( squareDist_centers < Radiuses)
            %(1) Recall that the objective function can be negative using PSO algorithm. 
            % Be careful, not every optimizer can support this property.
            
            %(2) if squareDist_centers < Radiuses, spheres are intersecting.
            % we want to increase squareDist_centers thus we want to minimize
            % the quantity : Res - squareDist_centers .
            
            %(3) the  multiplicative factor is arbitrary, here it is big to make the optimizing
            % algorithm very sensible to this constraint.
            Res = Res - squareDist_centers.*(100000000000000000000000);
        end
        
        
        if (graph.graph(i,j) == 1)   
            % In this case a contact should exist between sphere i and j.
            % Thus (Radiuses - squareDist_centers).^2 should be minimized until zero.
            Res =  Res + (Radiuses - squareDist_centers).^2.*10000 ;
            
        else
            % these bowls should be as far as possible
            % inverse of distance between centers should be minimized
            Res = Res + ones(size(Res))./((Radiuses - squareDist_centers).^2);
            
            if ( squareDist_centers <= Radiuses)
                % One more time we penalize intersecting spheres.
                 Res = Res  - squareDist_centers;
            end
        end
        
        
        
    end
end
end


