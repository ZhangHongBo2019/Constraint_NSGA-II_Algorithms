%Parent_Chromosome1=[1,2,1;1,2,1;3,4,5];
N=size(Parent_Chromosome,1);
M=3;
V=19;
Obj=Parent_Chromosome;
trace=zeros(N,2);
for i=1:1:N
    for j=i:1:N
        if i~=j
            if Obj(i,:)==Obj(j,:)
                trace(i,1)=1;
                trace(i,2)=i;
                break
            end
        end
    end
end
M=cumsum(trace(:,1));
M(end)