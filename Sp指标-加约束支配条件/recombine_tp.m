%% 两点交叉
function child=recombine_tp(chromosome,px)
global N V
%[N,V]=size(chromosome);
child=zeros(N,V);
for i=1:2:(N-1)
    if rand <= px
        select=randperm(V,2);
        site1=min(select);
        site2=max(select);
        child(i,:)=[chromosome(i,1:site1),chromosome(i+1,(site1+1):site2),chromosome(i,(site2+1):V)];
        child(i+1,:)=[chromosome(i+1,1:site1),chromosome(i,(site1+1):site2),chromosome(i+1,(site2+1):V)];
%         temp1=NONLCON_1(child(i,:));
%         temp2=NONLCON_1(child(i+1,:));
%         if ~isempty(temp1)&& ~isempty(temp2)                                      %如果得到的不是可行解，则重新生成
%             i=i+2; 
%         end
    else
        child(i,:)=chromosome(i,:);
        child(i+1,:)=chromosome(i+1,:);
    end
end