function f=Mut(Chrom, fv,Px)
global N V
%[N,M]=size(Chrom);
i=1;
while i<N
    if Px>=rand
        Select=randperm(V,5);
        mm=crtbp(1,fv(Select))+[1,1,1];
        %mm=randperm(fv(Select),1);
        if Chrom(i,Select(1))==mm(1)
            Chrom(i,Select(1))=randperm(fv(Select(1)),1);
        else
            Chrom(i,Select(1))=mm(1);
        end
        if Chrom(i,Select(2))==mm(2)
            Chrom(i,Select(2))=randperm(fv(Select(2)),1);
        else
            Chrom(i,Select(2))=mm(2);
        end
        if Chrom(i,Select(3))==mm(3)
            Chrom(i,Select(3))=randperm(fv(Select(3)),1);
        else
            Chrom(i,Select(3))=mm(3);
        end
       temp=NONLCON_1(Chrom(i,:));
        if ~isempty(temp)                                                       %如果得到的不是可行解，则重新生成
            i=i+1; 
        end
    else
        i=i+1;
    end    
end
f=Chrom;

