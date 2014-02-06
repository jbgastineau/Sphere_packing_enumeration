
classdef Single_graph < handle
    %UNTITLED3 this class is a graph
    %   Detailed explanation goes here
    
    
    properties
        graph    % contains the adjacence matrix
        radiuses % contains the radiuses of the spheres
        length     %
    end
    
    methods
       % graph = Single_graph(generate_graph(n,comb),sphere_type);
       function G = Single_graph(n,comb,sphere_types, radius1, radius2, radius3)
           % n : number of vertex of the gaph
           % comb : the combination of edges to be remove from the
           % complete graph
           % sphere type : a vector containing the corresponding type of
           % the spheres
           G.length = n;
           G.radiuses = ones(size(sphere_types));
           for i = 1:n
               if sphere_types(i) == 1
                   G.radiuses(i) = radius1;
               elseif sphere_types(i) == 2
                    G.radiuses(i) = radius2;
               elseif sphere_types(i) == 3
                    G.radiuses(i) = radius3;
               end   
           end
           G.graph =  ones(n,n) - tril(ones(n,n)); % the complete graph
           % assignig zero to the edges corresponding to the combination 
           % given
           for x = comb
               [i,j] = G.get_indices(x);
               G.graph(i,j) = 0;
           end
       end
       
       function connected = isconnected (G,n)
           import java.util.LinkedList;
           
           %nodes_adjacence = zeros(1,n);
           %for i = 1:n
             %nodes_adjacence(i) = sum (G.graph(i,:)) + sum(G.graph(:,i));
           %end
           %connected = prod(nodes_adjacence);

           already_explored =  LinkedList();
           to_explore = LinkedList();
          
           
           connected_nodes = zeros(1,n);
           to_explore.add(n);
           while (to_explore.size() ~= 0)
               cur_node = to_explore.removeFirst();
               for i = 1:n
                   if (G.graph(i,cur_node) == 1 && ~already_explored.contains(i))
                       to_explore.add(i);
                   elseif (G.graph(cur_node,i) ==1 && ~already_explored.contains(i))
                       to_explore.add(i);
                   end
               end
               connected_nodes(cur_node) = 1;
               already_explored.add(cur_node);
           end 
           connected = prod(connected_nodes);
          
       end
       
       function [i,j] = get_indices (G, z)
           % z is the edge_number zhich we want to know the corresponding
           % indices in the graph
           j = 2;
           while ~( ((j-1)*(j-2)/2 < z) && (z <= (j)*(j-1)/2 ))
               j = j + 1;
           end
           i = z - (j-1)*(j-2)/2;
       end
       
    end
    
end

