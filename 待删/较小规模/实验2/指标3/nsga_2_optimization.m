function [Chromosome,V]=nsga_2_optimization(qq,Generation)
%非支配排序遗传算法求解服务模块组合优化问题,三个目标的装修问题
rng(qq);
%% 设置参数
Population=100;
%Generation=5000;                 
Crate = 0.8;                
Mrate = 0.05;
M=3;%三个目标函数
V=29;%16个模块
%trace=zeros(Generation,M);
%ave=zeros(Generation,M);
%modules=30;%模块数
%% 产生一个初始种
BaseV=[3,2,4,3,3,3,3,4,3,3,4,4,2,4,3,4,5,3,5,2,4,2,3,2,2,4,3,2,3];
%Chromp=crtbp(Population, BaseV)+repmat([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],Population,1);   
%[Index,time,cost,Performance,D]=CaseStudy(modules);
%Chrom= NONLCON(Chromp,Index,D,time,cost);
Chrom=Initiative(Population, BaseV);
ObjV1=fitness(Chrom);
x=[Chrom,ObjV1];
%% 初始种群的
%figure(1)
%plot3(ObjV1(:,1),ObjV1(:,2),-ObjV1(:,3),'*');
%xlabel('Service cost'); ylabel('Response time');zlabel('Service performance');
%title('Initial population');
f = non_domination_sort_mod(x, 3, 29);
Chrom = f(:,1:29);
gen=1;
trace=cell(Generation,1);
%% 开始迭代
while gen<=Generation
    pool=round(Population/2);
    tour=2;
    Parent_Chromosome=tournament_selection(f, pool, tour);
    SelCh=Parent_Chromosome(:,1:29);
    SelCh=recombin('xovmp',SelCh,Crate);%重组单点交叉
    fv=[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];[3,2,4,3,3,3,3,4,3,3,4,4,2,4,3,4,5,3,5,2,4,2,3,2,2,4,3,2,3]];
    SelCh=mutbga(SelCh, fv,Mrate);
    SelCh=fix(SelCh);%变异
    SelCh1= NONLCON(SelCh);
    Chrom = [Chrom;SelCh1];
    %Chrom= NONLCON(Chrom,Index,D,time,cost);
    ObjV=fitness(Chrom);
    ObjV_1=fitness(SelCh1);
    x=[Chrom,ObjV];
    x_1=[SelCh1,ObjV_1];
    f = non_domination_sort_mod(x, 3, 29);
    temp=non_domination(x_1, 3, 29) ;
    %把每一代产生的非支配解放入temp中
    %temp=f_1(f_1(:,33)==1,1:32);
    trace{gen}=temp;
    f=replace_chromosome(f, M, V,Population);
    Chrom = f(:,1:29);
    disp(['第',num2str(gen),'代']);
    gen=gen+1;
end
trace_1=cell2mat(trace);
[~,nu]=unique(trace_1,'rows');
Chrom_1=trace_1(nu(1:length(nu)),:);
Chromosome= non_domination(Chrom_1,M,V);
end