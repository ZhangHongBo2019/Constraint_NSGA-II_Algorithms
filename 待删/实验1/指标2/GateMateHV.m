clear;close all
NN=10;
iter=1;
trace2=zeros(1,NN); 
tempp=zeros(1,NN);
for kk=1:1:iter
  for b1=1:1:NN
    %for b2=1:1:NN
PopObj=nsga_2_optimization(i*10); 
%ObjV= Chromosome(:, V+1 : V+3);
[N,M]    = size(PopObj);
%PopObj=zeros(N,M);
%PopObj(:,1:2)=ObjV(:,1:2);
%PopObj(:,3)=-ObjV(:,3);
%STEP 1. Obtain the maximum and minimum values of the Pareto front
    
%     maxVals = max(PopObj);
%     minVals = min(PopObj);
minVals=min(min(PopObj,[],1),zeros(1,M));
maxVals=[1500,50,-22.0355]*1.1;
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
    tempp(1,b1)= Score;
    b1
  end
%   xlswrite('data121.xlsx',tempp,kk);
%   trace2=trace2+tempp;
end
% trace2=trace2./iter;
% xlswrite('data122.xlsx',trace2,1);
% %disp(['Score=',num2str(Score)]);
plot(10:10:100,tempp,"ro");
title("HV的值随迭代次数的变化");







