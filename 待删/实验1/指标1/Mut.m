function f=Mut(Chrom, fv,Px)
[N,M]=size(Chrom);
for i=1:1:N
    if Px>=rand
        Select=randperm(M,3);
        mm=crtbp(1,[fv(Select(1)),fv(Select(2)),fv(Select(3))])+[1,1,1];
        while Chrom(i,Select(1))==mm(1)
            Chrom(i,Select(1))=randperm(fv(Select(1)),1);
        end
        while Chrom(i,Select(2))==mm(2)
            Chrom(i,Select(2))=randperm(fv(Select(2)),1);
        end
        while Chrom(i,Select(3))==mm(3)
            Chrom(i,Select(3))=randperm(fv(Select(3)),1);
        end
%         while Chrom(i,Select(4))==mm(4)
%             Chrom(i,Select(4))=randperm(fv(Select(4)),1);
%         end
%         while Chrom(i,Select(5))==mm(5)
%             Chrom(i,Select(5))=randperm(fv(Select(5)),1);
%         end
%         while Chrom(i,Select(6))==mm(6)
%             Chrom(i,Select(6))=randperm(fv(Select(6)),1);
%         end
%         while Chrom(i,Select(7))==mm(7)
%             Chrom(i,Select(7))=randperm(fv(Select(7)),1);
%         end
%         while Chrom(i,Select(8))==mm(8)
%             Chrom(i,Select(8))=randperm(fv(Select(8)),1);
%         end
%         while Chrom(i,Select(9))==mm(9)
%             Chrom(i,Select(9))=randperm(fv(Select(9)),1);
%         end
%         while Chrom(i,Select(10))==mm(10)
%             Chrom(i,Select(10))=randperm(fv(Select(10)),1);
%         end
    end
end
f = Chrom;
end

