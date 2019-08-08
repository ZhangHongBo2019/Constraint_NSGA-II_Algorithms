%% 单点交叉
function Selch=recombine_sp(chromosome,px)
global N V
%[N,V]=size(chromosome);
Selch=zeros(N,V);
i=1;
while i<N
    if rand <= px
        index=1+randperm(V-2,1);
        Selch(i,:)=[chromosome(i,1:index),chromosome(i+1,(index+1):V)];
        Selch(i+1,:)=[chromosome(i+1,1:index),chromosome(i,(index+1):V)];
        temp1=NONLCON_1(Selch(i,:));
        temp2=NONLCON_1(Selch(i+1,:));
        if ~isempty(temp1)&& ~isempty(temp2)                                      %如果得到的不是可行解，则重新生成
            i=i+2; 
        end
    else
        Selch(i,:)=chromosome(i,:);
        Selch(i+1,:)=chromosome(i+1,:);
        i=i+2; 
    end
end