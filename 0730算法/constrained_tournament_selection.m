function [selected_pop]= constrained_tournament_selection(opt, pop, popObj, popCV)

    
    N = opt.N;                                                             % 种群规模

    %----TOURNAMENT CANDIDATES-------------------------------------------------

    tour1 = randperm(N);                                                   % 竞赛的一方
    tour2 = randperm(N);                                                   % 竞赛的另一方


    %----START TOURNAMENT SELECTION--------------------------------------------


    selected_pop = zeros(N, opt.V);                                        % 被选择的个体，100×6
    for i = 1:N
        p1 = tour1(i);
        p2 = tour2(i);

        if (popCV(p1)<=0 && popCV(p2)<=0)%both are feasible                % 如果这两个个体都是可行解

            obj1 = popObj(p1,:);
            obj2 = popObj(p2,:);
            d = lex_dominate(obj1, obj2);                                  

            if d == 1                                                      % p1 dominates p2
                selected_pop(i, :) = pop(p1,1:opt.V);
            elseif d == 3                                                  % p2 dominates p1
                selected_pop(i, :) = pop(p2,1:opt.V); 
            else                                                           % d == 2，说明 a 和 b 相等或非支配
                % check crowding distance，比较拥挤度距离
                if(opt.CD(p1)>opt.CD(p2))                                   
                    selected_pop(i, :) = pop(p1,1:opt.V);
                elseif (opt.CD(p1)<opt.CD(p2))
                    selected_pop(i, :) = pop(p2,1:opt.V);
                else                                                       %randomly pick any solution
                    if(rand <= 0.5) 
                        pick = p1; 
                    else
                        pick = p2; 
                    end
                    selected_pop(i, :) = pop(pick,1:opt.V);
                end
            end
        else                                                               % 如果都不是可行解
              if(popCV(p1) < popCV(p2))                                      % 如果p1对应的约束值更小          
                      selected_pop(i, :) = pop(p1,1:opt.V);                      
              elseif (popCV(p2) < popCV(p1))                                 % 否则，选择p2
                    selected_pop(i, :) = pop(p2,1:opt.V);                  % p2 has less constraint violation
              else                                                           % randomly pick any solution                          
                    if(rand <= 0.5)                                        % 如果 p1=p2,随机选择一个父代进行交叉和变异
                        pick = p1; 
                    else
                        pick = p2; 
                    end
                selected_pop(i, :) = pop(pick,1:opt.V);                
             end
        end
    end
end 