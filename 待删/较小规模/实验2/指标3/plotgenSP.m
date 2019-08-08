clc;close all
N=500;
trace_1=zeros(1,N); 
for i=1:1:N
    [Chromosome,V]=nsga_2_optimization(i,i*10); 
    trace_1(1,i)= size(Chromosome,1);
end
xlswrite('data231.xlsx',trace_1,1);
figure
plot(10:10:5000,trace_1,'*-');
xlabel('迭代次数');
ylabel('非支配解个数');
title("实验6-非支配解的个数随迭代次数的变化");
