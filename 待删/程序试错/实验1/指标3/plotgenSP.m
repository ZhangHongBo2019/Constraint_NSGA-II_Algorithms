clc;close all
N=10;
trace_1=zeros(1,N); 
% for i=1:1:N
%     [Chromosome,V]=nsga_2_optimization(i*100); 
%     trace_1(1,i)= size(Chromosome,1);
% end
for i=1:1:N
    %for j=1:1:N2
    [Chromosome,V]=nsga_2_optimization(i*100); 
    %[Chromosome,V]=nsga_2_optimization(k,i*5000);
    PopObj = Chromosome(:, V + 1 : V + 3);
    Distance = pdist2(PopObj,PopObj,'cityblock');    
    Distance(logical(eye(size(Distance,1)))) = inf;
    trace_1(1,i)= std(min(Distance,[],2));
    i
    %temp(1,i)
end
xlswrite('data131.xlsx',trace_1,1);
figure
plot(100:100:1000,trace_1,'*-');
xlabel('迭代次数');
ylabel('非支配解个数');
title("实验1-非支配解的个数随迭代次数的变化");
