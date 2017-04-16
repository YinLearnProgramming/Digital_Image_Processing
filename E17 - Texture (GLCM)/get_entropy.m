function [thisEntropy] = get_entropy(G)
    sum = 0;
    E = 0;
    for i = 1:256
        for j = 1:256
            sum = sum + G(i,j);
        end
    end
    for i = 1:256
        for j = 1:256
            if(G(i,j)~=0)
                pij=G(i,j)/sum;
                E=E+pij*log2(pij);
                thisEntropy = E;
            end
        end
    end
end
