function opt = nsga2_selection(opt)
    

    [n, ~] = size(opt.totalpopObj);                                        % 子代和父代的总个数
    %opt.R = zeros(size(opt.totalpopObj,1),1);   
    opt.R = zeros(n,1);                                                    % 存放每个个体的非支配序
     
    selectedPopIndex = [];
    index = opt.totalpopCV<=0;                                             % 判断约束值是否是0，若是，则为1，否则为0
    FeasiblePopIndex = find(index == 1);                                   % 逻辑值为1的，约束值为0，则为可行解
    InfeasiblePopIndex = find(index == 0);                                 % 逻辑值为0的，约束值>=0，则为不可行解

    %---------------Find Non-dominated Sorting of Feasible Solutions-------
    R = zeros(n,1);                                                        % 初始化每个个体的非支配序
    F = cell(n,1);                                                         % 
    opt.R = zeros(n,1);
    if ~isempty(FeasiblePopIndex)                                          % 如果有可行解存在
                
        [R,~] = bos(opt.totalpopObj(FeasiblePopIndex,:));                  % 计算可行解的非支配序
        
        for i=1:size(FeasiblePopIndex,1)
            F{R(i)} = horzcat(F{R(i)}, FeasiblePopIndex(i));
        end
        %---------------Store Ranking of Feasible Solutions--------------------
        opt.R(FeasiblePopIndex) = R;
    end 
    
    
    
    
    
    %--------------Rank the Infeasible Solutions---------------------------
    
    if ~isempty(InfeasiblePopIndex)
        
        CV = opt.totalpopCV(InfeasiblePopIndex);

        [~,index] = sort(CV,'ascend');
        c = max(R) + 1;

        for i = 1: size(index,1)
            if i>1 && (CV(index(i))==CV(index(i-1)))%If both CV are same, they are in same front
                opt.R(InfeasiblePopIndex(index(i))) = opt.R(InfeasiblePopIndex(index(i-1)));
                b = opt.R(InfeasiblePopIndex(index(i)));
                F{b} = horzcat(F{b}, InfeasiblePopIndex(index(i)));
            else
                opt.R(InfeasiblePopIndex(index(i))) = c ;
                F{c} = horzcat(F{c}, InfeasiblePopIndex(index(i)));
                c = c + 1;
            end
        end
    
    end
    

    %----------------Select High Rank Solutions----------------------------
    count = zeros(n,1);
    for i=1:n
        count(i) = size(F{i},2);
    end

    cd = cumsum(count);
    p1 = find(opt.N<cd);
    lastfront = p1(1);
            
    opt.pop = zeros(size(opt.pop));
    
      
    
    for i=1:lastfront-1
        selectedPopIndex = horzcat(selectedPopIndex, F{i});
    end
    
    
    %------------CROWDING DISTANCE PART------------------------------------
    
    opt.CD = zeros(size(opt.totalpopObj,1),1);
    for i=1:max(R)
        front = F{i};
        front_cd = crowdingDistance(opt, front, opt.totalpopObj(front,:));
        opt.CD(front) = front_cd;
    end
    
   
    if size(selectedPopIndex,2)<opt.N
        index = F{lastfront};
        CDlastfront = opt.CD(index);

        [~,I] = sort(CDlastfront,'descend');

        j = 1;
        for i = size(selectedPopIndex,2)+1: opt.N
            selectedPopIndex = horzcat(selectedPopIndex, index(I(j)));
            j = j + 1;
        end
    end
    
    %---------------Select for Next Generation-----------------------------
    
    opt.pop =  opt.totalpop(selectedPopIndex,:);
    opt.popObj = opt.totalpopObj(selectedPopIndex,:);
    opt.popCV = opt.totalpopCV(selectedPopIndex,:);
    opt.popCons = opt.totalpopCons(selectedPopIndex,:);
    opt.CD = opt.CD(selectedPopIndex,:);      
end