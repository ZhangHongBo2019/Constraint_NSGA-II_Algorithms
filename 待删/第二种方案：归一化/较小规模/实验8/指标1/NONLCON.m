function Chrom= NONLCON(X,Index,D,time,cost)
m=Index(end);
Chrom=[];
N=size(X);
for i = 1:N
    idx = floor(X(i,:));
    x = zeros(1,m+1);
    %temp = [0,3,5,7,9,12,15,18,24,27,31,33,36,39,41,43];
    temp =[0,5,10,15,19,22,24,27,30,34,37,41,45,49,53,57,60,63,68,71,74,76,81,83,86,88,91,94,99];
    x(idx(idx>0)+temp) = 1;
    if (x(57)~=x(86))&&(x(57)==1)
        x(86)=1;
        x(84)=0;
        x(85)=0;
    elseif (x(57)~=x(86))&&(x(86)==1)
        x(57)=1;
        x(54)=0;
        x(55)=0;
        x(56)=0;
    end
    if (x(30)~=x(61))&&(x(30)==1)
        x(61)=1;
        x(62)=0;
        x(63)=0;
    elseif (x(30)~=x(61))&&(x(61)==1)
        x(30)=1;
        x(28)=0;
        x(29)=0;
    end
    if (x(9)~=x(83))&&(x(9)==1)
        x(83)=1;
        x(82)=0;
    elseif (x(9)~=x(83))&&(x(83)==1)
        x(9)=1;
        x(6)=0;
        x(7)=0;
        x(8)=0;
        x(10)=0;
    end
    if (x(17)==x(23))&&(x(17)==1)
        x(23)=0;
        x(24)=1;
    elseif (x(17)==x(23))&&(x(17)==0)
        x(23)=1;
        x(24)=0;
    end
    if (x(87)==x(92))&&(x(87)==1)
        x(92)=0;
        x(93)=round(rand(1));
        x(94)=1-x(93);
    elseif (x(87)==x(92))&&(x(87)==0)
        x(92)=1;
        x(93)=0;
        x(94)=0;
    end
    if (x(42)==x(64))&&(x(42)==1)
        x(64)=0;
        x(65)=round(rand(1));
        x(66)=1-x(65);
        x(67)=0;
        x(68)=0;
    elseif (x(42)==x(64))&&(x(42)==0)
        x(64)=1;
        x(65)=0;
        x(66)=0;
        x(67)=0;
        x(68)=0;
    end
    if (x(14)==x(69))&&(x(14)==1)
        x(69)=0;
        x(70)=round(rand(1));
        x(71)=1-x(70);
    elseif (x(14)==x(69))&&(x(14)==0)
        x(69)=1;
        x(70)=0;
        x(71)=0;
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
  c1= max(ST(n1)-50,0);%约束条件1：最大的时间不能超过60
  g3=x*cost; 
  c2 = max( g3-1500,0);%约束条件2：最大的费用不能超过15
%if (c1<=0)&&(c2<=0)
    %tenp1(i,:)=x;%Chrom(i,:)=idx;
%end
%end
%[~,nu]=unique(tenp1,'rows');
%Chrom=X(nu(1:length(nu)),:);
index=cumsum([5,5,5,4,3,2,3,3,4,3,4,4,4,4,4,3,3,5,3,3,2,5,2,3,2,3,3,5,3]);
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

        
