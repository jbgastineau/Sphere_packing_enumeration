function [ Res ] = contact_quality(x,graph,quality)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Res = 0;
for i = 1:graph.length
    for j = i+1:graph.length
        I = (i-1)*3;
        J = (j-1)*3;
        
        Dist_centers = (x(I+1) - x(J+1)).^2 + ...
            (x(I+2) - x(J+2)).^2 + (x(I+3) - x(J+3)).^2 ;
        Radiuses =  (graph.radiuses(i) + graph.radiuses(j))^2 ;
        
        Res =  Res + (Dist_centers + quality < Radiuses);
        
        if graph.graph(i,j) == 1
            Res = Res + (abs(Dist_centers - Radiuses) > quality);
        else
            Res =  Res + (abs(Dist_centers - Radiuses) < quality);
        end
    end
    %Res =  (Res == 0);
end
end

