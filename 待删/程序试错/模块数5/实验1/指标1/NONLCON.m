function Chrom= NONLCON(X)
Index=[3,6,8,11];
time=[3,3,0.000100000000000000,8,3,10,1,8,5,7,2,0];
cost=[12;18;0;13;17;19;19;11;10;12;19;0];
D=[0,0,1,0,0;0,0,1,0,0;0,0,0,1,0;0,0,0,0,1];
m=Index(end);
Chrom=[];
N=size(X);
for i = 1:N
    idx = floor(X(i,:));
    x = zeros(1,m+1);
    %temp = [0,5,8,12,14,16,20,24,27,30,34,37,41,45,49,53,58,62,65,70,74,76,80,84,88,92,96,98,103];
    temp = [0,3,6,8];
    x(idx(idx>0)+temp) = 1;
    if (x(9)~=x(7))&&(x(9)==1)
        x(7)=1;
        x(8)=0;
    elseif (x(9)~=x(7))&&(x(7)==1)
        x(9)=1;
        x(10)=0;
        x(11)=0;
    end
    if (x(3)==x(4))&&(x(3)==1)
        x(4)=0;
        x(5)=round(rand(1));
        x(6)=1-x(5);
    elseif (x(3)==x(4))&&(x(3)==0)
         x(4)=0;
         x(5)=round(rand(1));
         x(6)=1-x(5);
    end
    x(end)=1;
%cost=[20;60;90;12;6;50;46;60;120;25;12;5;88;74;160;9.7;32;68;91.5;192;457;330;10;32;95;0;34;22;9.3;13;6;8;0;70;96;82;94;12;63;60;190;120;250;0;10;60;0];
%time=[4,5,7,2,3,5,4,5,8,2,1,1,4,5,8,2,3,3,5,6,8,9,2,3,4,0.0001,1,1,2,2,2,2,0.0001,22,17,18,5,2,3,1,3,2,1,0.0001,2,7,0];
nu=size(D,2);
rr=x.*time;
CC=rr(rr~=0)';
pp=repmat(CC,1,nu);
C=pp.*D;
%C=timehandle(x,A,m);
n1=size(C,2);
ST=zeros(1,n1);%每一个模块的开始时间初始化为0
  for k=2:n1
      tt=0;
      for l=1:(k-1)
          if (C(l,k)>0)&&(C(l,k))~=0.0001
              tt=[tt,C(l,k)+ST(l)];
          elseif C(l,k)==0.0001
              C(l,k)=0;
              tt=[tt,C(l,k)+ST(l)];
          end
      end
      ST(k)=max(tt);
  end
  c1= max(ST(n1)-15,0);%约束条件1：最大的时间不能超过60
  g3=x*cost; 
  c2 = max( g3-500,0);%约束条件2：最大的费用不能超过15
%if (c1<=0)&&(c2<=0)
    %tenp1(i,:)=x;%Chrom(i,:)=idx;
%end
%end
%[~,nu]=unique(tenp1,'rows');
%Chrom=X(nu(1:length(nu)),:);
index=cumsum([3,3,2,3]);
nb=size(index,2);
CH=zeros(1,nb);
 if (c1==0)&&(c2==0)
       a=x(1:end-1);
        for j=1:nb
           if j==1
            temp=a(1:index(j));
            CH(j)=find(temp~=0);
           else
             temp=a(index(j-1)+1:index(j));
             CH(j)=find(temp~=0);
           end
        end
 end
Chrom=[Chrom;CH];
end
[~,nu]=unique(Chrom,'rows');
Chrom=Chrom(nu(1:length(nu)),:);
Chrom(all(Chrom==0,2),:)=[];
end

        
