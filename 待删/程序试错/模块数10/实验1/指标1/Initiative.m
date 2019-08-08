function Chrom=Initiative(Population, BaseV)
Chrom=[];
while size(Chrom)<Population
Chromp=crtbp(1, BaseV)+repmat([1,1,1,1,1,1,1,1,1,1,1,1],1,1);
temp=NONLCON_1(Chromp);
Chrom=[Chrom;temp];
end