function Chrom=Initiative(Population, u_limit,Index,D,time,cost)
Chrom=[];
while size(Chrom)<Population
Chromp=crtbp(1, u_limit)+repmat([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],1,1);
temp=NONLCON_1(Chromp,Index,D,time,cost);
Chrom=[Chrom;temp];
end