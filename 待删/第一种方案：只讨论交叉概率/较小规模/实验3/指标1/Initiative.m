function Chrom=Initiative(Population, BaseV,Index,D,time,cost)
Chrom=[];
while size(Chrom)<Population
Chromp=crtbp(1, BaseV)+repmat([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],1,1);
temp=NONLCON_1(Chromp,Index,D,time,cost);
Chrom=[Chrom;temp];
end