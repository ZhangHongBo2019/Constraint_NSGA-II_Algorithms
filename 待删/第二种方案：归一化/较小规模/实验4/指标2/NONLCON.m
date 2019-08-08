function Chrom= NONLCON(X,Index,D,time,cost)
m=Index(end);
Chrom=[];
N=size(X);
for i = 1:N
    idx = floor(X(i,:));
    x = zeros(1,m+1);
    %temp = [0,3,5,7,9,12,15,18,24,27,31,33,36,39,41,43];
    temp =[0,5,9,14,18,22,25,30,32,35,38,42,45,50,55,57,61,63,66,68,73,76,81,85,90,93,95,99,102];
    x(idx(idx>0)+temp) = 1;
    if (x(25)~=x(66))&&(x(25)==1)
        x(66)=1;
        x(64)=0;
        x(65)=0;
    elseif (x(25)~=x(66))&&(x(66)==1)
        x(25)=1;
        x(23)=0;
        x(24)=0;
    end
    if (x(75)~=x(106))&&(x(75)==1)
        x(106)=1;
        x(103)=0;
        x(104)=0;
        x(105)=0;
    elseif (x(75)~=x(106))&&(x(106)==1)
        x(75)=1;
        x(74)=0;
        x(76)=0;
    end
    if (x(9)~=x(61))&&(x(9)==1)
        x(61)=1;
        x(58)=0;
        x(59)=0;
        x(60)=0;
    elseif (x(9)~=x(61))&&(x(61)==1)
        x(9)=1;
        x(6)=0;
        x(7)=0;
        x(8)=0;
    end
    if (x(37)~=x(47))&&(x(37)==1)
        x(47)=1;
        x(46)=0;
        x(48)=0;
        x(49)=0;
        x(50)=0;
    elseif (x(37)~=x(47))&&(x(47)==1)
        x(37)=1;
        x(36)=0;
        x(38)=0;
    end
    if (x(62)==x(102))&&(x(62)==1)
        x(102)=0;
        x(100)=round(rand(1));
        x(101)=1-x(100);
    elseif (x(62)==x(102))&&(x(62)==0)
        x(102)=1;
        x(100)=0;
        x(101)=0;
    end
    x(end)=1;
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
  c1= max(ST(n1)-50,0);%约束条件1：最大的时间不能超过60
  g3=x*cost; 
  c2 = max( g3-1500,0);%约束条件2：最大的费用不能超过15
%if (c1<=0)&&(c2<=0)
    %tenp1(i,:)=x;%Chrom(i,:)=idx;
%end
%end
%[~,nu]=unique(tenp1,'rows');
%Chrom=X(nu(1:length(nu)),:);
index=cumsum([5,4,5,4,4,3,5,2,3,3,4,3,5,5,2,4,2,3,2,5,3,5,4,5,3,2,4,3,4]);
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

        
