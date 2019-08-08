%% 随机生成大规模案例
%function [Index,time,cost,Performance,D]=CaseStudy(modules)
%% 随机数种子
rng(1);
%% 设置初始参数
modules=13;%模块数
%option=3;%可选模块的个数
%vb=2;%兼容关系
%mb=1;%排斥关系
%% 随机生成模块实例
%modules=15+round(5*rand(1));%模块数量
Instances=zeros(1,(modules-1));%选项数量
for i=1:1:(modules-1)
Instances(1,i)=2+round(3*rand(1));%模块实例2-5
end
Index=cumsum(Instances);
bb=Index(end);
%% 随机选择可选模块
option=randperm(5,1);
optonSelect=randperm((modules-1),option);
%% 时间矩阵
time=zeros(1,bb);
for i=1:1:(modules-1)
    if i==1
    time(1,1:Index(i))=2+round(8*rand(Instances(1,i),1));%2-10
    else
        time(1,(Index(i-1)+1):Index(i))=2+round(8*rand(Instances(1,i),1));%2-10
    end
end
time(1,Index(optonSelect))=0.0001;
time(1,end+1)=0;
%% 费用矩阵
cost=zeros(bb,1);
for l=1:1:(modules-1)
    if l==1
    cost(1:Index(l),1)=5+round(15*rand(Instances(1,l),1));%5-20
    else
        cost((Index(l-1)+1):Index(l),1)=5+round(15*rand(Instances(1,l),1));
    end
end
for j=1:1:bb
    if time(1,j)==0.0001
        cost(j,1)=0;
    end
end
cost(end+1)=0;
Performance=zeros(bb,1);
for p=1:1:(modules-1)
    if p==1
        Performance(1:Index(p),1)=3*rand(Instances(1,p),1);%0-3
    else
        Performance((Index(p-1)+1):Index(p),1)=3*rand(Instances(1,p),1);
    end
end
for j=1:1:bb
    if time(1,j)==0.0001
        Performance(j,1)=0;
    end
end
%temp=sum(Perfermance);
%Perfermance=Perfermance./temp;
Performance(end+1)=0;
%% 邻接矩阵的产生
 D=zeros((modules-1),modules);
 for i=1:1:(modules-1)
     for j=(i+1):1:modules
         if(round(rand(1)*6)==0)
             D(i,j)=1;
         else 
             D(i,j)=0;
         end
        % D(i,j)=round(rand(1));
     end
     D(i,round(rand(1)*(modules-i-1))+i+1)=1;
 end
%% 兼容和排斥关系
vb=1+round(2*rand(1));
mb=1+round(2*rand(1));
result=randperm((modules-1),(vb+mb)*2);
temp=[];
%% 兼容关系
for i=1:1:vb
    p=result(i*2-1);%模块
    l=randperm(Instances(result(i*2-1)),1);%模块实例
    %temp=[temp;p,l];
    m=result(i*2);%模块
    n=randperm(Instances(result(i*2)),1);%模块实例
    temp=[temp;p,l,m,n];
end
%% 排斥关系
conf=[];
for i=(vb+1):1:(vb+mb)
    k=result(i*2-1);%模块
    l=randperm(Instances(result(i*2-1)),1);%模块实例
    %conf=[conf;k,l];
    r=result(i*2);%模块
    e=randperm(Instances(result(i*2)),1);%模块实例
    conf=[conf;k,l,r,e];
end
%end
