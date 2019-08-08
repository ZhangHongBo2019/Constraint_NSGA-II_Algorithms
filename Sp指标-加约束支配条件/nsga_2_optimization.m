%function [Popobj]=nsga_2_optimization(Px,Pc)
%% 非支配排序遗传算法求解服务模块组合优化问题
%% 设置参数
global Population Generation M V BaseV N
Population=1000;                                                           %种群规模
Generation=300;                                                            %迭代次数               
Px=0.9;
Pc=0.01;
%变异概率
M=3;                                                                       %目标函数个数
V=29;                                                                      %模块个数-1
N=1000;
%% 随机产生初始种群
BaseV=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];
Chrom=crtbp(Population, BaseV)+repmat([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,...%产生初始种群
      1,1,1,1,1,1,1,1,1,1,1,1],Population,1);
gen=1;
trace=cell(Generation,1);
%% 开始迭代
while gen<=Generation
    intermediate_chromosome=[];
    fixChrom=txx(Chrom);%费时
    Parent_Chromosome=constrained_tournament_selection(fixChrom);
    %Parent_Chromosome=tour_selection(Chrom,ObjV,ConV);                     %二元锦标赛选择父代来进行交叉和变异                                                                     %交叉方式：多点交叉
    SelCh=recombine_tp(Parent_Chromosome,Px);  %单点交叉
    %SelCh=Poly_mutation(SelCh,Mrate,V,mum,l_limit,u_limit);               %变异方式：多项式变异
    SelCh1=mutation(SelCh,Pc); 
    %SelCh1=Mut(SelCh,BaseV ,Pc);
    mian_pop=size(Chrom,1);
    offspring_pop=size(SelCh1,1);
    intermediate_chromosome(1:mian_pop,:) = Chrom;
    intermediate_chromosome(mian_pop+1:mian_pop+offspring_pop,:) = SelCh1; %将子代个体和父代个体放在一起
    %intermediate_chromosome(:,V+1:V+M)=fitness(intermediate_chromosome);   %计算组合后的适应度值
    %[~,nu]=unique(intermediate_chromosome(:,V+1:V+M),'rows');              %去掉重复的个体
    %chromosome=intermediate_chromosome(nu(1:length(nu)),:);
    %intermediate_chromosome = non_domination_sort_mod(chromosome);   %进行非支配排序
    intermediate_chromosome=txx(intermediate_chromosome);
%     Objv1=fitness(SelCh1);
%     x_1=[SelCh1,Objv1];
%     temp=non_domination(x_1);
%     %把每一代产生的非支配解放入temp中
%     trace{gen}=temp;
f=replace_chromosome(intermediate_chromosome); %重组过程，挑选出种群规模的个体
Chrom = f(:,1:V);
  Popobj=f(f(:,V+M+1)==1,V+1:V+M);                                       %非支配对应的目标函数值
    if(M<=3)
        plot3(Popobj(:,1),Popobj(:,2),Popobj(:,3),'ro')
        title(num2str(gen));
        xlabel('费用');
        ylabel('时间');
        zlabel('服务性能');
        drawnow
    end
    gen=gen+1;
end
Popobj=f(f(:,V+M+1)==1,V+1:V+M);
% trace_1=cell2mat(trace);
% [~,nu]=unique(trace_1(:,V+1:M+V),'rows');
% Chrom_1=trace_1(nu(1:length(nu)),:);
% Chromosome= non_domination(Chrom_1);
%end