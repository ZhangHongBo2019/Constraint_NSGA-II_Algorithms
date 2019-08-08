function f  = Poly_mutation(parent_chromosome,Mrate,V,mum,l_limit,u_limit)
[N,~] = size(parent_chromosome);
clear m
p = 1;
for i = 1 : N
    if rand(1) <= Mrate
        % Select at random the parent.
        parent_3 = round(N*rand(1));
        if parent_3 < 1
            parent_3 = 1;
        end
        % Get the chromosome information for the randomnly selected parent.
        child_3 = parent_chromosome(parent_3,:);
        % Perform mutation on eact element of the selected parent.
        for j = 1 : V
           r = rand(1);
           if r < 0.5
               delta = (2*r)^(1/(mum+1)) - 1;
           else
               delta = 1 - (2*(1 - r))^(1/(mum+1));
           end
           % Generate the corresponding child element.
           child_3(j) = child_3(j) + delta;
           child_3(j)=round(child_3(j));
           % Make sure that the generated element is within the decision
           % space.
           if child_3(j) > u_limit(j)
               child_3(j) = u_limit(j);
           elseif child_3(j) < l_limit(j)
               child_3(j) = l_limit(j);
           end
        end
        %child_3(:,V + 1: M + V) = evaluate_objective(child_3, M, V);
        parent_chromosome(p,:) = child_3;
    end 
        p = p + 1;
end
f = parent_chromosome;
end