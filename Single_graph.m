
classdef Single_graph < handle

    % Single_Graph represents the graph of contact between spheres spheres
    properties
        graph    % contains the adjacency matrix
        radiuses % contains the radiuses of the spheres
        length   % number of vertex of the contact graph.
                 % in this context, it is also the number of
                 % spheres
    end
    
    methods
    
       function G = Single_graph(n,comb,sphere_types, radius1, radius2, radius3)
       % This function is the constructor of a Single_graph object.
       
           % n           : number of vertex of the gaph
           % comb        : the combination of edges to be remove from the
           %               complete graph
           % sphere type : a vector containing the corresponding type 
           %               (wich correspond to the size) of the spheres

           G.length = n;
           G.radiuses = ones(size(sphere_types));
           
           % writing the value of radiuses according to the type of each sphere.
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
           	   % getting the graph indexes corresponding 
           	   % to each element of the comb vector
               [i,j] = G.get_indices(x);
               % a zero in the adjacency matrix means that the edge has been 
               % remove from the contact graph.
               G.graph(i,j) = 0;
           end
       end
       
       function connected = isconnected (G,n)
       % This function checks if one graph is connected, 
       % by a depth-first traversal. Every node met is tagged 
       % as connected, if one or more nodes remain unconnected at the end,
       % the graph is said to be unconnected.
       
           % I want to use the queue utility.
           import java.util.LinkedList;
           
           already_explored =  LinkedList();
           to_explore = LinkedList();
          
           % no nodes are seen as connected now
           connected_nodes = zeros(1,n);
           % we begin to explore the last node.
           to_explore.add(n);
           while (to_explore.size() ~= 0)
               cur_node = to_explore.removeFirst();
               for i = 1:n
               		% if the i  vertex of the graph have not been explored, and i is linked 
               		% with cur_node, the vertex i has to be explored after.
                   if (G.graph(i,cur_node) == 1 && ~already_explored.contains(i))
                       to_explore.add(i);
                   % this second condition is here because the graph structure we use is an 
                   % upper triangular adjacency matrix. (ie G.graph(i,cur_node) == 1 does not imply 
                   % G.graph(cur_node,i) ==1, so  we have to check the two conditions )
                   elseif (G.graph(cur_node,i) ==1 && ~already_explored.contains(i))
                       to_explore.add(i);
                   end
               end
               
               % we tag cur_nod as a connected node.
               connected_nodes(cur_node) = 1;
               already_explored.add(cur_node);
           end 
           
           % if one node is not connected, then the product is null and the 
           % graph is not completely connected
           connected = prod(connected_nodes);
          
       end
       
       function [i,j] = get_indices (G, z)
       % This function is a bijection between the edges of a graph and [[1...n(n-1)/2]]
       % the second number is the number of edges in the complete graph, with two elements.
           
           % z is the edge_number which we want to know the corresponding
           % indices [i,j] in the graph (adjacency matrix )
           j = 2;
           while ~( ((j-1)*(j-2)/2 < z) && (z <= (j)*(j-1)/2 ))
               j = j + 1;
           end
           i = z - (j-1)*(j-2)/2;
       end
       
    end
    
end

