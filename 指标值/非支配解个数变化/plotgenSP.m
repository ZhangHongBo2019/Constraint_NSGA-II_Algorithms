clc;close all
N=300;
trace_1=zeros(1,N); 
for i=1:1:N
    Chromosome=nsga_2_optimization(i*1); 
    trace_1(1,i)= size(Chromosome,1);
    i
end
%xlswrite('data131.xlsx',trace_1,1);
figure(1)
plot(1:1:300,trace_1,'*-');
xlabel('迭代次数');
ylabel('非支配解个数');
title("实验1-非支配解的个数随迭代次数的变化");