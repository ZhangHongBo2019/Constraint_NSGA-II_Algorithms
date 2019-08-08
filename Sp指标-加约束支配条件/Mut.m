function f=Mut(Chrom, fv,Px)
global N V
%[N,M]=size(Chrom);
for i=1:1:N
    if Px>=rand
        Select=randperm(V,1);
        %mm=crtbp(1,fv(Select))+1;
        mm=randperm(fv(Select),1);
        if Chrom(i,Select)==mm
            Chrom(i,Select)=randperm(fv(Select),1);
        else
            Chrom(i,Select)=mm;
        end
%         while Chrom(i,Select(2))==mm(2)
%             Chrom(i,Select(2))=randperm(fv(Select(2)),1);
%         end
%         while Chrom(i,Select(3))==mm(3)
%             Chrom(i,Select(3))=randperm(fv(Select(3)),1);
%         end
%         while Chrom(i,Select(4))==mm(4)
%             Chrom(i,Select(4))=randperm(fv(Select(4)),1);
%         end
%         while Chrom(i,Select(5))==mm(5)
%             Chrom(i,Select(5))=randperm(fv(Select(5)),1);
%         end
%         while Chrom(i,Select(6))==mm(6)
%             Chrom(i,Select(6))=randperm(fv(Select(6)),1);
%         end
    end    
end
f=Chrom;

