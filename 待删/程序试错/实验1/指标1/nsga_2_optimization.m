function [Chromosome,V]=nsga_2_optimization(Crate,Mrate )
%非支配排序遗传算法求解服务模块组合优化问题,三个目标的装修问题
%% 设置参数
Population=600;
Generation=500;                
%Crate = 0.9;                
%Mrate = 0.1;
M=3;%三个目标函数
V=29;%16个模块
%modules=4;%模块数
%% 产生一个初始种
BaseV=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];
%Chromp=crtbp(Population, BaseV)+repmat([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],Population,1);   
%[Index,time,cost,Performance,D]=CaseStudy(modules);
%Chrom= NONLCON(Chromp,Index,D,time,cost);
Chrom=Initiative(Population, BaseV);
ObjV1=fitness(Chrom);
x=[Chrom,ObjV1];
f = non_domination_sort_mod(x, M, V);
Chrom = f(:,1:V);
gen=1;
trace=cell(Generation,1);
%% 开始迭代
while gen<=Generation
    temp=[];
    pool=round(Population/2);
    tour=2;
    Parent_Chromosome1=tournament_selection(f, pool, tour);
    Parent_Chromosome2=tournament_selection(f, pool, tour);
    Parent_Chromosome=[Parent_Chromosome1;Parent_Chromosome2];
    SelCh1=Parent_Chromosome(:,1:V);
    SelCh1=recombin('xovmp',SelCh1,Crate);%重组单点交叉
    fv=[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3]];
    SelCh1=mutbga(SelCh1, fv,Mrate);
    SelCh1=fix(SelCh1);
    SelCh2= NONLCON(SelCh1);
    Chrom=[Chrom;SelCh2];
    ObjV=fitness(Chrom);
    ObjV_1=fitness(SelCh2);
    x=[Chrom,ObjV];
    x_1=[SelCh2,ObjV_1];
    f = non_domination_sort_mod(x, M, V);
    temp=non_domination(x_1, M, V);
    %把每一代产生的非支配解放入temp中
    %temp=f_1(f_1(:,33)==1,1:32);
    trace{gen}=temp;
    f=replace_chromosome(f, M, V,Population);
    Chrom = f(:,1:V);
    %disp(['第',num2str(gen),'代']);
    gen=gen+1;
end
trace_1=cell2mat(trace);
[~,nu]=unique(trace_1(:,V+1:V+M),'rows');
Chrom_1=trace_1(nu(1:length(nu)),:);
Chromosome= non_domination(Chrom_1,M,V);
end