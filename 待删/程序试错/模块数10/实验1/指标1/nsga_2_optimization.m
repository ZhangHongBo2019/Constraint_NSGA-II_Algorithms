function [Chromosome,V]=nsga_2_optimization(Generation)
%非支配排序遗传算法求解服务模块组合优化问题,三个目标的装修问题
%% 设置参数
Population=100;
%Generation=1000;                
Crate = 0.9;                
Mrate = 0.1;
M=3;%三个目标函数
V=12;%16个模块
%modules=30;%模块数
%% 产生一个初始种
BaseV=[3,4,2,3,2,2,3,3,3,4,3,4];
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
    Parent_Chromosome=tournament_selection(f, pool, tour);
    SelCh1=Parent_Chromosome(:,1:V);
    SelCh_2=recombin('xovmp',SelCh1,Crate);%重组多点交叉
    fv=[[1,1,1,1,1,1,1,1,1,1,1,1];[3,4,2,3,2,2,3,3,3,4,3,4]];
    SelCh_2=mutbga(SelCh_2, fv,Mrate);
    SelCh_2=fix(SelCh_2);
    SelCh_3= NONLCON(SelCh_2);
    Selch_Chrom = [SelCh1;SelCh_3];
    Chrom=[Chrom;Selch_Chrom];
    ObjV=fitness(Chrom);
    ObjV_1=fitness(Selch_Chrom);
    x=[Chrom,ObjV];
    x_1=[Selch_Chrom,ObjV_1];
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
[~,nu]=unique(trace_1,'rows');
Chrom_1=trace_1(nu(1:length(nu)),:);
Chromosome= non_domination(Chrom_1,M,V);
end