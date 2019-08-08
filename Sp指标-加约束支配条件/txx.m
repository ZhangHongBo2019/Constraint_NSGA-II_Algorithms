function [f]=txx(Chrom)
global M V
ConV=NONLCON(Chrom);
Chrom_feasile=Chrom(ConV==0,:);
ObjV_feasile=fitness(Chrom_feasile);
x=[Chrom_feasile,ObjV_feasile]; 
f_feasile = non_domination_sort_mod(x); 
f_feasile(:,V+M+3)=0;
Chrom_infeasile=Chrom(ConV>0,:);
%f1=zeros(N,m);
Chrom_infeasile(:,V+1:V+M)=0;
%Chrom_infeasile(:,V+M+1)=repmat(max(f_feasile(:,V+M+1))+1,N,1);
Chrom_infeasile(:,V+M+1)=max(f_feasile(:,V+M+1))+1;
Chrom_infeasile(:,V+M+2)=0;
Chrom_infeasile(:,V+M+3)=ConV(ConV>0);
f=[f_feasile;Chrom_infeasile];
%f(:,V+M+3)=ConV;

