clear;close all
N=7;
iter=10;
trace1=zeros(1,N); 
temp=zeros(1,N);
for k=1:1:iter
  for i=1:1:N
    [Chromosome,V]=nsga_2_optimization(k,0.6+(i-1)*0.05); 
    PopObj = Chromosome(:, V + 1 : V + 3);
    Distance = pdist2(PopObj,PopObj,'cityblock');    
    Distance(logical(eye(size(Distance,1)))) = inf;
    temp(1,i)= std(min(Distance,[],2));
  end
  %xlswrite('data11.xlsx',temp,k);
  trace1=trace1+temp;
 end
trace1=trace1./iter;
%xlswrite('data12.xlsx',trace1,1);
figure
bar(trace1);
title('交叉概率和变异概率对Spcing值的影响');