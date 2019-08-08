function [Chromosome,V]=nsga_2_optimization(Px,Pc)
%% 非支配排序遗传算法求解服务模块组合优化问题
%% 设置参数
Population=1000;                                                           %种群规模
Generation=300;                                                            %迭代次数               
% Px = 0.9;                                                                 %交叉概率
% Pc = 0.1;                                                                 %变异概率
M=3;                                                                       %目标函数个数
V=29;                                                                      %模块个数-1
% l_limit=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];     %决策变量上界
% u_limit=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];     %决策变量下界
% mum=20;                                                                  %分布参数
%% 随机产生初始种群
BaseV=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];
Chrom=Initiative(Population, BaseV);                                       %产生初始种群
ObjV1=fitness(Chrom);                                                      %计算初始种群的适应度值
x=[Chrom,ObjV1];                                                              
f = non_domination_sort_mod(x, M, V);                                      %非支配排序                                                         %
gen=1;
trace=cell(Generation,1);
%% 开始迭代
while gen<=Generation
    intermediate_chromosome=[];
    Parent_Chromosome=tour_selection(f,V);                                 %二元锦标赛选择父代来进行交叉和变异                                                                     %交叉方式：多点交叉
    SelCh=recombine_tp(Parent_Chromosome,Px);                              %单点交叉
    %SelCh=Poly_mutation(SelCh,Mrate,V,mum,l_limit,u_limit);               %变异方式：多项式变异
    SelCh1=mutation(SelCh,Pc,BaseV);    
    %SelCh1=Mut(SelCh, BaseV,Pc);
    mian_pop=size(Chrom,1);
    offspring_pop=size(SelCh1,1);
    intermediate_chromosome(1:mian_pop,:) = Chrom;
    intermediate_chromosome(mian_pop+1:mian_pop+offspring_pop,:) = SelCh1; %将子代个体和父代个体放在一起
    intermediate_chromosome(:,V+1:V+M)=fitness(intermediate_chromosome);   %计算组合后的适应度值
    [~,nu]=unique(intermediate_chromosome(:,V+1:V+M),'rows');              %去掉重复的个体
    chromosome=intermediate_chromosome(nu(1:length(nu)),:);
    intermediate_chromosome = non_domination_sort_mod(chromosome, M, V);   %进行非支配排序
    Objv1=fitness(SelCh1);
    x_1=[SelCh1,Objv1];
    temp=non_domination(x_1, M, V);
    %把每一代产生的非支配解放入temp中
    trace{gen}=temp;
    f=replace_chromosome(intermediate_chromosome, M, V,Population);        %重组过程，挑选出种群规模的个体
    Chrom = f(:,1:V);
%   Popobj=f(f(:,V+M+1)==1,V+1:V+M);                                       %非支配对应的目标函数值
%     if(M<=3)
%         plot3(Popobj(:,1),Popobj(:,2),Popobj(:,3),'ro')
%         title(num2str(gen));
%         xlabel('费用');
%         ylabel('时间');
%         zlabel('服务性能');
%         drawnow
%     end
    gen=gen+1;
end
%Popobj=f(f(:,V+M+1)==1,V+1:V+M);
trace_1=cell2mat(trace);
[~,nu]=unique(trace_1(:,V+1:M+V),'rows');
Chrom_1=trace_1(nu(1:length(nu)),:);
Chromosome= non_domination(Chrom_1,M,V);
end