function [pop_mut] = pol_mut(pop_crossover, pmut,BaseV)

[N, V] = size( pop_crossover); % Population size & Number of variables
%pop_mut =  pop_mut;% Child before mutation
pop_mut =  pop_crossover;
for i = 1:N
        if rand <= pmut
            Select=randperm(V,3);
            mm=crtbp(1,BaseV(Select))+[1,1,1];
            %mm=randperm(fv(Select),1);
            if pop_mut(i,Select(1))==mm(1)
               pop_mut(i,Select(1))=randperm(BaseV(Select(1)),1);
            else
                pop_mut(i,Select(1))=mm(1);
            end
            if pop_mut(i,Select(2))==mm(2)
                pop_mut(i,Select(2))=randperm(BaseV(Select(2)),1);
            else
                pop_mut(i,Select(2))=mm(2);
            end
            if pop_mut(i,Select(3))==mm(3)
                pop_mut(i,Select(3))=randperm(BaseV(Select(3)),1);
            else
                pop_mut(i,Select(3))=mm(3);
            end
        end
end

