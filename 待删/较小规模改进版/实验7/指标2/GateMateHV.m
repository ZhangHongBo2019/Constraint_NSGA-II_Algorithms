clear;close all
NN=10;
iter=20;
trace2=zeros(NN,NN); 
temp=zeros(NN,NN);
for kk=1:1:iter
  for b1=1:1:NN
    for b2=1:1:NN
[Chromosome,V]=nsga_2_optimization(kk,0.5+(b1-1)*0.05,0.01+(b2-1)*0.01); 
ObjV= Chromosome(:, V+1 : V+3);
[N,M]    = size(ObjV);
PopObj=zeros(N,M);
PopObj(:,1:2)=ObjV(:,1:2);
PopObj(:,3)=-ObjV(:,3);
%STEP 1. Obtain the maximum and minimum values of the Pareto front
    
    maxVals = max(PopObj);
    minVals = min(PopObj);

%STEP 2. Get the normalized front
    normalizedPF = (PopObj - repmat(minVals, N, 1)) ./ repmat(maxVals - minVals, N, 1);
    PopObj=normalizedPF;
    %RefPoint = max(PF,[],1)*1.1;
    RefPoint=[1,1,1];
    PopObj(any(PopObj>repmat(RefPoint,N,1),2),:) = [];
    if isempty(PopObj)
        Score = 0;
    elseif M < 5
        pl = sortrows(PopObj);
        S  = {1,pl};
        for k = 1 : M-1
            S_ = {};
            for i = 1 : size(S,1)
                Stemp = Slice(cell2mat(S(i,2)),k,RefPoint);
                for j = 1 : size(Stemp,1)
                    temp(1) = {cell2mat(Stemp(j,1))*cell2mat(S(i,1))};
                    temp(2) = Stemp(j,2);
                    S_      = Add(temp,S_);
                end
            end
            S = S_;
        end
        Score = 0;
        for i = 1 : size(S,1)
            p     = Head(cell2mat(S(i,2)));
            Score = Score + cell2mat(S(i,1))*abs(p(M)-RefPoint(M));
        end
    else
        SampleNum = 1000000;
        MaxValue  = RefPoint;
        MinValue  = min(PopObj,[],1);
        Samples   = repmat(MinValue,SampleNum,1) + rand(SampleNum,M).*repmat((MaxValue-MinValue),SampleNum,1);
        Domi      = false(1,SampleNum);
        for i = 1 : size(PopObj,1)
            drawnow();
            Domi(all(repmat(PopObj(i,:),SampleNum,1)<=Samples,2)) = true;
        end
        Score = prod(MaxValue-MinValue)*sum(Domi)/SampleNum;
    end
    temp(i,j)= Score;
    end
  end
  xlswrite('data721.xls',temp,k);
  trace2=trace2+temp;
end
trace1=trace2./iter;
xlswrite('data722.xls',trace2,1);
%disp(['Score=',num2str(Score)]);
function S = Slice(pl,k,RefPoint)
    p  = Head(pl);
    pl = Tail(pl);
    ql = [];
    S  = {};
    while ~isempty(pl)
        ql  = Insert(p,k+1,ql);
        p_  = Head(pl);
        cell_(1,1) = {abs(p(k)-p_(k))};
        cell_(1,2) = {ql};
        S   = Add(cell_,S);
        p   = p_;
        pl  = Tail(pl);
    end
    ql = Insert(p,k+1,ql);
    cell_(1,1) = {abs(p(k)-RefPoint(k))};
    cell_(1,2) = {ql};
    S  = Add(cell_,S);
end

function ql = Insert(p,k,pl)
    flag1 = 0;
    flag2 = 0;
    ql    = [];
    hp    = Head(pl);
    while ~isempty(pl) && hp(k) < p(k)
        ql = [ql;hp];
        pl = Tail(pl);
        hp = Head(pl);
    end
    ql = [ql;p];
    m  = length(p);
    while ~isempty(pl)
        q = Head(pl);
        for i = k : m
            if p(i) < q(i)
                flag1 = 1;
            else
                if p(i) > q(i)
                    flag2 = 1;
                end
            end
        end
        if ~(flag1 == 1 && flag2 == 0)
            ql = [ql;Head(pl)];
        end
        pl = Tail(pl);
    end  
end

function p = Head(pl)
    if isempty(pl)
        p = [];
    else
        p = pl(1,:);
    end
end

function ql = Tail(pl)
    if size(pl,1) < 2
        ql = [];
    else
        ql = pl(2:end,:);
    end
end

function S_ = Add(cell_,S)
    n = size(S,1);
    m = 0;
    for k = 1 : n
        if isequal(cell_(1,2),S(k,2))
            S(k,1) = {cell2mat(S(k,1))+cell2mat(cell_(1,1))};
            m = 1;
            break;
        end
    end
    if m == 0
        S(n+1,:) = cell_(1,:);
    end
    S_ = S;     
end