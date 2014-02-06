function [ comb ] = generate_comb( first_comb, max_edge)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
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
            % replace the seqence of element that follow this indice.
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
            
            % increment the element of this indice and
            % replace the seqence of element that follow this indice.
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
    %comb = 0;
end
