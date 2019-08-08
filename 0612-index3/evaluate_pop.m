function [popObj, popCons] = evaluate_pop(opt, pop)

    popObj = zeros(size(pop,1),opt.M);                                     % 100×2           
    if opt.C>0                                                             % opt.C显示约束条件的个数，此时为6
        popCons = zeros(size(pop,1),opt.C);                                % 100×6
    else
        popCons = zeros(size(pop,1), 1);                                   % 无约束，100×1
    end
    sz = size(pop,1);                                                      % 种群规模
    for i = 1:sz                                                        
        [f, g] = high_fidelity_evaluation(opt, pop(i,:));                  % 计算目标函数值和约束值
        popObj(i, 1:opt.M) = f;                                            % 将目标函数值赋值给popObj
        if opt.C>0                                                         % 存在约束的话，将约束值赋值给popCons
            popCons(i,:) = g;
        else
            popCons(i,1) = 0;                                              % 没有，则为0
        end
    end

end