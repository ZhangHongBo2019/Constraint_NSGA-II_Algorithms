%% This is main function that runs NSGA-II procedure
function opt = nsga2_main(opt,px,pm)

    %% ------------INITIALIZE------------------------------------------------
    opt.pop = lhsamp_model(opt.N, opt);                                    % 产生初始种群
    
    %% ------------EVALUATE--------------------------------------------------
    [opt.popObj, opt.popCons] = evaluate_pop(opt, opt.pop);                % 计算种群的目标函数值和约束值
    %opt.popCV = evaluateCV(opt.popCons);  
    opt.popCV = sum(opt.popCons, 2);                                       % 计算计算所有约束值的总和
    %opt.archiveObj = opt.popObj;                                           % to save all objectives
    
    %% -------------------PLOT INITIAL SOLUTIONS-----------------------------
%     opt.fig = figure;
%     plot_population(opt, opt.popObj);                                      % 迭代前的解集
    
    
    %% --------------- OPTIMIZATION -----------------------------------------
    
    gen = 1;
    while gen < opt.G                                                      % opt.G =200，迭代次数

        opt = mating_selection(opt);%--------Mating Parent Selection-------% 二元竞标赛选择
        opt = crossover(opt,px);%-------------------Crossover-----------------% 交叉
        opt = mutation(opt,pm);%--------------------Mutation------------------% 变异
        
        
        %---------------EVALUATION-----------------------------------------
        [opt.popChildObj, opt.popChildCons] = evaluate_pop(opt, opt.popChild);% 计算子代对应的目标函数和约束值
        %opt.popCV = evaluateCV(opt.popCons);                               % 计算父代对应的约束值
        opt.popCV = sum(opt.popCons, 2);
        %opt.popChildCV = evaluateCV(popChildCV);                          % 计算子代对应的约束值
        opt.popChildCV = sum(opt.popChildCons, 2);
        
        
        
        %---------------MERGE PARENT AND CHILDREN--------------------------% horzcat()水平串联数组
        opt.totalpopObj = vertcat(opt.popChildObj, opt.popObj);            % vertcat()垂直串联数组，将子代和父代的目标函数垂直串联
        opt.totalpop = vertcat(opt.popChild, opt.pop);                     % 将子代个体和父代个体垂直串联
        opt.totalpopCV = vertcat(opt.popChildCV, opt.popCV);               % 将每个子代和父代的约束条件的值相加垂直串联
        opt.totalpopCons = vertcat(opt.popChildCons, opt.popCons);         % 将子代和父代的约束条件值垂直串联
        %-----------------把每一代的非支配解储存起来-------------------------
        [opt.tracepop, opt.tracepopObj] = calculate_feasible_paretofront(opt, opt.totalpop, opt.totalpopObj, opt.totalpopCV);
        opt.trace{gen}=horzcat(opt.tracepop, opt.tracepopObj);
        %-----------------SURVIVAL SELECTION-------------------------------
        opt = survival_selection(opt);                                      %重组过程，从父代和子代挑选出N个个体
        gen = gen + 1;
        
        %opt.popCV = evaluateCV(opt.popCons);
        opt.popCV = sum(opt.popCons, 2);
        %opt.archiveObj = vertcat(opt.archiveObj,opt.popObj);
        
        
        %-------------------PLOT NEW SOLUTIONS----------------------------- 
%         if mod(gen,100)==0
%             disp(gen);
%             plot_population(opt, opt.tracepopObj);
%         end
    end
    
%----------------------RETURN VALUE----------------------------------------
     %[opt.pop, opt.popObj] = calculate_feasible_paretofront(opt, opt.pop, opt.popObj, opt.popCV);
%     opt.fig = figure;
%     plot_population(opt, opt.popObj);
V=opt.V;
M=opt.M;
opt.totaltrace=cell2mat(opt.trace);
[~,nu]=unique(opt.totaltrace(:,V+1:M+V),'rows');
Chrom=opt.totaltrace(nu(1:length(nu)),:);
opt.Chromosome= non_domination(opt,Chrom);
end                                                                        
%------------------------------END OF -FILE--------------------------------