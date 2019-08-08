function Chromosome=nsga_2_optimization(Generation)
%非支配排序遗传算法求解服务模块组合优化问题,三个目标的装修问题
%% 设置参数
%rng(qq);
Population=1500;
%Generation=400;                
Crate = 0.9;                
Mrate = 0.1;
M=3;%三个目标函数
V=29;%16个模块
%% 产生一个初始种
BaseV=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];
Chrom=Initiative(Population, BaseV);
ObjV1=fitness(Chrom);
x=[Chrom,ObjV1];
f = non_domination_sort_mod(x, M, V);
Chrom = f(:,1:V);
gen=1;
trace=cell(Generation,1);
%% 开始迭代
while gen<=Generation
    intermediate_chromosome=[];
    Parent_Chromosome=tour_selection(f);
    SelCh1=Parent_Chromosome(:,1:V);
    SelCh2=recombin('xovmp',SelCh1,Crate);%重组单点交叉
    fv=[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3]];
    SelCh2=Mut(SelCh2,fv(2,:),Mrate);
    SelCh3= NONLCON(SelCh2);
    mian_pop=size(Chrom,1);
    offspring_pop=size(SelCh3,1);
    intermediate_chromosome(1:mian_pop,:) = Chrom;
    intermediate_chromosome(mian_pop+1:mian_pop+offspring_pop,:) = SelCh3;
    intermediate_chromosome(:,V+1:V+M)=fitness(intermediate_chromosome);
    intermediate_chromosome = non_domination_sort_mod(intermediate_chromosome, M, V);
    %temp=non_domination(x_1, M, V);
    %把每一代产生的非支配解放入temp中
    trace{gen}=intermediate_chromosome(intermediate_chromosome(:,V+M+1)==1,:);
    f=replace_chromosome(intermediate_chromosome, M, V,Population);
    Chrom = f(:,1:V);
    %Popobj=f(f(:,V+M+1)==1,V+1:V+M);
%     if(M<=3)
%         plot3(Popobj(:,1),Popobj(:,2),Popobj(:,3),'ro')
%         title(num2str(gen));
%         drawnow
%     end
    gen=gen+1;
end
%Popobj=f(f(:,V+M+1)==1,V+1:V+M);
trace_1=cell2mat(trace);
[~,nu]=unique(trace_1(:,V+1:V+M),'rows');
Chrom_1=trace_1(nu(1:length(nu)),:);
Chromosome= non_domination(Chrom_1,M,V);
end