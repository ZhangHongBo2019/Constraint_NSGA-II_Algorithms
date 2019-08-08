%% 多点交叉
function child=recombine_mp(chromosome,px)
[N,V]=size(chromosome);
child=chromosome;
i=1;
while i<N
    temp1=[];
    temp2=[];
    if rand <= px
        select=randperm(V,2);
        a=min(select);
        b=max(select);
        temp11=randperm(a,1);
        temp22=a+round((b-a)*rand);
        temp33=b+round((V-b)*rand);
        child(i,:)=[chromosome(i,1:temp11),chromosome(i+1,((temp11)+1):a),...
                     chromosome(i,(a+1):temp22),chromosome(i+1,((temp22)+1):b),...
                     chromosome(i,(b+1):temp33),chromosome(i+1,(temp33+1):V)];
        child(i+1,:)=[chromosome(i+1,1:temp11),chromosome(i,((temp11)+1):a),...
                     chromosome(i+1,(a+1):temp22),chromosome(i,((temp22)+1):b),...
                     chromosome(i+1,(b+1):temp33),chromosome(i,(temp33+1):V)];;
%         child(i,[select(1),select(2),select(3),select(4)])=chromosome(i+1,[select(1),select(2),select(3),select(4)]);
%         child(i+1,[select(1),select(2),select(3),select(4)])=chromosome(i,[select(1),select(2),select(3),select(4)]);
        temp1=NONLCON_1(child(i,:));
        temp2=NONLCON_1(child(i+1,:));
    end
    if ~isempty(temp1)&& ~isempty(temp2)                                      %如果得到的不是可行解，则重新生成
       i=i+2; 
    end
end