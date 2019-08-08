function child=mutation(chromosome,pc,fv)
[N,V]=size(chromosome);
i=1;
while i<N
    for j=1:1:V
        if rand<=pc
            chromosome(i,j)=randperm(fv(j),1);
        end
    end
    temp=NONLCON_1(chromosome(i,:));
    if ~isempty(temp)                                                       %如果得到的不是可行解，则重新生成
       i=i+1; 
    end
end
 child=chromosome;