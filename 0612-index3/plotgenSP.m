function plotgenSP()
%-------------------MAIN LOOP----------------------------------------------  
opt.objfunction='服务组合优化算法';                                         % 对应的具体的测试函数
opt = nsga2_basic_parameters(opt);                                         % 优化算法对应的基本参数
G=2000;
opt.trace_1=zeros(1,G);
for i=1:1:G
    %Chromosome=nsga_2_optimization(i*1); 
    opt = nsga2_main(opt,i);
    opt.trace_1(1,i)= size(opt.Chromosome,1);
    i
end
xlswrite('data03.xlsx',opt.trace_1,1);
opt.fig = figure;
plot(1:1:G,opt.trace_1,'*-');
xlabel('迭代次数');
ylabel('非支配解个数');
title("实验1-非支配解的个数随迭代次数的变化");
end