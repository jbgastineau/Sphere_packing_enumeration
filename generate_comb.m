function [ comb ] = generate_comb( first_comb, max_edge)
% Generate the next (1) combination of length(first_comb) elements among max_edge.
% If no combination is found, then comb=0 .

% Alternatively there is a native matlab function doing almost the same (I discovered it only after)
% I acknowledge that a recursive function doing the same would have been more understandable
% but the iterative way ask for less memory : the total number of combination is 
% length(first_comb) among max_edge.

% (1) idea to understand :
% The order of combination used is the order of leaves ( from left to right ) of a tree build by
% by a recursive enumeration of the combinations produced by the Pascal formula.
% 

% requires : length(first_comb) <= max_edge

% Usage : next_comb = generate_comb([1,2,3], 4)

% example of use : successive calls :
% b = [1,2,3]
% b = generate_comb(b,4) 
%  now b = [1,2,4]
% b = generate_comb(b,4) 
%  now b = [1,3,4]
% b = generate_comb(b,4) 
%  now b = [2,3,4]
% b = generate_comb(b,4) 
%  now b = 0    : no next combination has been found.


Z = size(first_comb);
T = Z(2);
i = Z(2);
    % look at the first element that is maximal
    while i > 0
        if i >= T
            if first_comb(i) >= max_edge
            % go to the first element that we can improve
            % (if we don't find such an element, it means that first_comb
            % is the last combination possible.
            i = i-1;
            if i == 0
                comb = 0;
                return 
            end 
            while first_comb(i)+1 == first_comb(i+1)
                i = i-1;
                if i == 0
                    comb = 0;
                    return 
                end                
            end
            
            % increment the element of this indice and
            % replace the sequence of element that follow this indice.
            comb =  first_comb;
            comb(i) = comb(i)+1;
            for j = i+1:T
                comb(j) = comb(i)+j-i;
            end
            return
                
            else
                comb = first_comb;
                comb(i) =  comb(i) +1;
                return;
            end
        end
        if first_comb(i)+1 >= first_comb(i+1)
            % go to the first element that we can improve
            % (if we don't find such an element, it means that first_comb
            % is the last combination possible.
            i = i-1;
            while first_comb(i)+1 == first_comb(i+1)
                i = i-1;
                if i == 0
                    comb = 0;
                    return 
                end                
            end
            
            % increment the element of this index and
            % replace the sequence of element that follow this index.
            comb =  first_comb;
            comb(i) = comb(i)+1;
            for j = i+1:T
                comb(j) = comb(i)+j-i;
            end
            return
        else
            comb = first_comb;
            comb(i) =  comb(i) +1;
            return;
        end
    end
end
