
function Packings = generate_graphs ( radius2, radius3, number1, number2, number3)
% This function tries to build all the possible connected sphere packings, with 
% arbitrary numbers of only three different kind of spheres.


% Detailed explanation , ideas, limitations.

%% (I) The task to be solved :
% Given are 3 different spheres: s1, s2 and s3. Assume that we have n s1, m s2 and p s3. 
% Draw in 3D all possible compactions of the spheres, such that spheres can share at most 
% one tangential point (sphere are not intersecting). Options: zooming, rotations 
% (cameras), saving 3D plot to .png.

%In order to draw all possible compactions of spheres, we have to define what are two different
% compactions, or ( the same ) what are equal compactions.
% (II ) Definitions :
%  What we call graph of contact is the 


% if you are tired to read my explanations, you can go there 
% http://www.youtube.com/watch?v=uqr8VxNvHYQ&list=RDhEnLlQ4XxSc
% What have been done, the strategy used here.




INPUTS : 
% number1 : number of spheres of type1
% number2 : number of spheres of type2
% number3 : number of spheres of type3
% radius2 : size ratio between the radius of type1 and type2 spheres
% radius3 : size ratio between the radius of type1 and type3 spheres


OUTPUTS :
% Packings : a collection of all sphere packings possible ( and possibly more)
%            given the input parameters. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Initialisation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
radius1 = 5;   % arbitrary, the scale is after defined by matlab for the plot. 
radius2 = radius1*radius2;
radius3 = radius1*radius3;
Packings = {};
Packings_size = 0;
n = number1 + number2 + number3;
% vector containing the type of spheres. (only three types are allowed )
sphere_types = zeros(1,n);
sphere_types(1:number1) = 1;
sphere_types(number1+1:number2+number1) = 2;
sphere_types(number2+number1+1:n) = 3;


%%%%%%%%%%%%%%%%%%%%%%%%%%% The complete graph case %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% The same code is copy-paste after in this file. See the comments there.%%%%%%%%%

complete =  ones(n,n) - tril(ones(n,n));
comb = [];
graph = Single_graph(n,comb,sphere_types, radius1, radius2,radius3);
[optOUT]=pso_Trelea_vectorized(@(x)contact_equation(x,graph),3*n);
x=optOUT(1:3*n);
quality = radius1/10;
geometrical_packing = contact_quality(x,graph,quality);
% we keep only real geometrical solutoins
if (geometrical_packing <2)
    P = packing([0.0,0.0,0.0],[100.0,100.0,100.0]);
    for k = 1:graph.length
        R = graph.radiuses(k);
        I = (k-1)*3;
        C = [x(I+1),x(I+2),x(I+3)];
        P.add(R,C);
    end
    P.print3D();
    Packings{Packings_size + 1} = P;
    Packings_size = Packings_size + 1;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               All the other contact graphs


% the number or edges in a n vertex connected graph.
connected_graph_limit = n*(n - 1)/2;

for i = 1 : connected_graph_limit

    % This is the only correct initialization for comb , if the
    % the function generate_comb is to be used after.
    comb = zeros(1,i);
    for j = 1:i
        comb(j) = j;
    end

    
    % comb == 0 means that no more combination has been found.  
    while ( comb ~= 0)
    	% See comments in the Single_Graph.m  file
    	% a Single_graph object is created, edges designated from the comb combination
    	% are deleted from a complete graph to produce graph.
        graph = Single_graph(n,comb,sphere_types, radius1, radius2,radius3);
        
        % we eliminate all the non-connected graphs of contact.
        if graph.isconnected(n)
           
            %% make sure that this graph ( of sphere contact ) represents a real sphere packing           
            
            % We give the function "contact_equation" with the argument graph
            % to be minimized with the input x
            % 3*n 
            [optOUT]=pso_Trelea_vectorized(@(x)contact_equation(x,graph),3*n);
            
            x=optOUT(1:3*n);
            % now x is a vector containing the three dimensions coordinates of the n 
            % spheres of the graph, that minimizes globally contact_equation(x,graph) .
            
            % PSO optimization is a best-effort approach, now we want to be sure that the
            % solution obtained is really a valid geometrical package.
            quality = radius1/10;
            geometrical_packing = contact_quality(x,graph,quality)
            
            % By experience, it is seen that for n <= 5  the packing is a 
            % real sphere packing if geometrical_packing == 0, given that quality = radius1/10 .
            % Thus, geometrical_packing <2 is less restrictive, some wrong package may appear.
            % we keep only real geometrical solutoins.
            
            if (geometrical_packing <2)
                P = packing([0.0,0.0,0.0],[100.0,100.0,100.0]);
                
                % we add all spheres in the container 'P';
                for k = 1:graph.length
                    R = graph.radiuses(k);
                    I = (k-1)*3;
                    C = [x(I+1),x(I+2),x(I+3)];
                    P.add(R,C);
                end
                
                % for debug : P.print3D();
                % adding the sphere package to the higher-level container : Packings.
                Packings{Packings_size + 1} = P;
                Packings_size = Packings_size + 1;
            end
            
        end
        
        prec_comb = comb;
        % we generate the next combination of edges to be removed from the 
        % complete graph for the next loop.
        comb = generate_comb(prec_comb, connected_graph_limit);
        Z = size(comb);
        
        
        % well done, you have read everything, now you can see this this video
        % 
    end
end
end

