
function Packings = generate_graphs ( radius2, radius3, number1, number2, number3)
radius1 = 5;
radius2 = radius1*radius2;
radius3 = radius1*radius3;



% to implement :
Packings = {};
Packings_size = 0;
%

n = number1 + number2 + number3;
% here deal with the case when the total number is one.
%if
%
sphere_types = zeros(1,n);
sphere_types(1:number1) = 1;
sphere_types(number1+1:number2+number1) = 2;
sphere_types(number2+number1+1:n) = 3;

% generating all the possible connected n vertex graphs .
% first we start with the complete graph
complete =  ones(n,n) - tril(ones(n,n));
comb = [];
graph = Single_graph(n,comb,sphere_types, radius1, radius2,radius3);

[optOUT]=pso_Trelea_vectorized(@(x)contact_equation(x,graph),3*n);
x=optOUT(1:3*n);
quality = radius1/10;
%quality = 0;
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


%don't forget to compute the first complete graph here.
%
%

numberofgraphs = 0;
%connected_graph_limit = 1/2 * (n -1) * (n - 2);
connected_graph_limit = n*(n - 1)/2;
for i = 1 : connected_graph_limit
    % choose i edge among n(n-1)/2 edges
    comb = zeros(1,i);
    for j = 1:i
        comb(j) = j;
    end
    % producing the corresponding graphs
    while ( comb ~= 0)
        graph = Single_graph(n,comb,sphere_types, radius1, radius2,radius3);
        if graph.isconnected(n)
            % make sure that this graph represent a real sphere packing
            
            [optOUT]=pso_Trelea_vectorized(@(x)contact_equation(x,graph),3*n);
            x=optOUT(1:3*n);
            quality = radius1/10;
            %quality = 0;
            geometrical_packing = contact_quality(x,graph,quality)
            if (geometrical_packing <2)
                % we keep only real geometrical solutoins
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
            
        end
        %numberofgraphs =   numberofgraphs + 1;
        prec_comb = comb;
        comb = generate_comb(prec_comb, n*(n-1)/2);
        Z = size(comb);
        
    end
end
end

