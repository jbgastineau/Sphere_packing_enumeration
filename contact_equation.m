function [ Res ] = contact_equation(x,graph)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Res = 0*x(:,1);
for i = 1:graph.length
    for j = 1+1:graph.length
        I = (i-1)*3;
        J = (j-1)*3;
        
        
        squareDist_centers =   (x(:,I+1) - x(:,J+1)).^2 + ...
            (x(:,I+2) - x(:,J+2)).^2 + (x(:,I+3) - x(:,J+3)).^2;
        Radiuses = (graph.radiuses(i) + graph.radiuses(j))^2 ;
        
        if ( squareDist_centers < Radiuses)
            % this added number is completely arbitrary 
            %Res = Res + ones(size(Res)).*(graph.radiuses(i).^2*100000000);
            %Res = Res  - squareDist_centers;
            Res = Res - squareDist_centers.*(100000000000000000000000);
        end
        
        
        if (graph.graph(i,j) == 1)
            
            % these bowls should be in contact
            Res =  Res + (Radiuses - squareDist_centers).^2.*10000 ;
            
        else
            % these bowls should be as far as possible
            % inverse of distance should be minimized
            
            % minimizing the inverse of distance maximizes the distance
            Res = Res + ones(size(Res))./((Radiuses - squareDist_centers).^2);
            if ( squareDist_centers <= Radiuses)
                % this added number is completely arbitrary 
                %Res = Res + ones(size(Res)).*(graph.radiuses(i).^2*1000000);
                Res = Res  - squareDist_centers;
            end
        end
        
        
        
    end
end
end


