function [ Res ] = contact_quality(x,graph,quality)
% Evaluate the contact correctness between sphere according to the adjacency matrix.


% quality    :  the inexactitude allowed.
% x          : a vector containing the three dimension coordinate of lenght(x/3) centers.
% graph      : a Single_Graph object. (see the Single_graph file)

% Res is the number of calculated incorrect contacts.
Res = 0;
for i = 1:graph.length
    for j = i+1:graph.length
        I = (i-1)*3;
        J = (j-1)*3;
        
        Dist_centers = (x(I+1) - x(J+1)).^2 + ...
            (x(I+2) - x(J+2)).^2 + (x(I+3) - x(J+3)).^2 ;
        Radiuses =  (graph.radiuses(i) + graph.radiuses(j))^2 ;
        
        % the spheres should not intersect more than quality
        Res =  Res + (Dist_centers + quality < Radiuses);
        
        if graph.graph(i,j) == 1
            % if contact is asked,  Dist_centers - Radiuses should be <= quality
            Res = Res + (abs(Dist_centers - Radiuses) > quality);
        else
        	% if non contact is asked,  Dist_centers - Radiuses should be >= quality
            Res =  Res + (abs(Dist_centers - Radiuses) < quality);
        end
    end
end
end

