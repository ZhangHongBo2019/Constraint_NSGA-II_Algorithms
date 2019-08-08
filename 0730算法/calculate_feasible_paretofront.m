function [pareto_pop, pareto_obj] = calculate_feasible_paretofront(opt, pop, pop_obj, pop_cv)

    %-------------FIND FEASIBLE PARETO FRONT-------------------------------
    
    if opt.C>0 %Feasible Pareto front of Constraint Problems
        
        index = find(pop_cv<=0);
        pareto_pop = pop(index,:);
        pareto_obj = pop_obj(index,:);
        
    else
        pareto_pop = pop; 
        pareto_obj = pop_obj;
        
    end
    
    if size(pareto_pop,1)>0

        [R,~] = bos(pareto_obj);
        index = find(R==1);%non-dominated front, first front
        %pareto_pop =  pop(index,:);
        %pareto_obj =  pop_obj(index,:);
        pareto_pop =  pareto_pop(index,:);
        pareto_obj = pareto_obj(index,:);
        
    end
                    
end