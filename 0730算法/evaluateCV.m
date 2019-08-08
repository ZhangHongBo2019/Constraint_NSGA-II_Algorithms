function cv = evaluateCV(pop_cons)
    g = pop_cons;        
    for i=1:size(pop_cons,1)
        for j=1:size(pop_cons,2)
            if g(i,j)<0
                g(i, j) = 0; 
            end
        end
    end
    cv = sum(g, 2);                                                        % 按行相加，按列进行排序
end