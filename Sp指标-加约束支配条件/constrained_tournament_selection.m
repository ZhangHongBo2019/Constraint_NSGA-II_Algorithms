function selected_pop = constrained_tournament_selection(f)
global N V M
    %----TOURNAMENT CANDIDATES-------------------------------------------------
    tour1 = randperm(N);
    tour2 = randperm(N);
    %----START TOURNAMENT SELECTION--------------------------------------------
    selected_pop = zeros(N, V); % Only the design variables of the selected members
    pop=f(:,1:V);
    for i = 1:N
        p1 = tour1(i);
        p2 = tour2(i);

        if (f(p1,V+M+3)==0 && f(p2,V+M+3)==0)%both are feasible 
            if f(p1,V+M+1)~=f(p2,V+M+1)
                if f(p1,V+M+1)<f(p2,V+M+1)
                    selected_pop(i,:)=pop(p1,:);
                else
                    selected_pop(i,:)=pop(p2,:);
                end
            else
                if f(p1,V+M+2)>f(p2,V+M+2)
                    selected_pop(i,:)=pop(p1,:);
                else
                    selected_pop(i,:)=pop(p2,:);
                end
            end
        else
            if(f(p1,end) < f(p2,end)) %p1 less constraint violation          
                selected_pop(i, :) = pop(p1,:);
            else 
                if (f(p1,end) < f(p2,end))
                    selected_pop(i, :) = pop(p2,:); %p2 has less constraint violation
                else %randomly pick any solution
                    if(rand <= 0.5) 
                        pick = p1; 
                    else
                        pick = p2; 
                    end
                    selected_pop(i, :) = pop(pick,:);%initially p1 was randomly choosen
                end
            end
        end

    end
end