clc;clear 
close all
N=10;
iter=1;
trace1=zeros(1,N); 
temp=zeros(1,N);
for k=1:1:iter
  for i=1:1:N
    %for j=1:1:N
    [Chromosome,V]=nsga_2_optimization(i*100); 
    PopObj = Chromosome(:, V + 1 : V + 3);
    xlswrite('data113.xlsx', PopObj,i);
    Distance = pdist2(PopObj,PopObj,'cityblock');    
    Distance(logical(eye(size(Distance,1)))) = inf;
    temp(1,i)= std(min(Distance,[],2));
    temp(1,i)
 end
  xlswrite('data111.xlsx',temp,k);
  trace1=trace1+temp;
end
trace1=trace1./iter;
xlswrite('data112.xlsx',trace1,1);