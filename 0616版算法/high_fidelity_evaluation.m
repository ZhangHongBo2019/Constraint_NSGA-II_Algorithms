function [f,g] = high_fidelity_evaluation(opt,X)
% ---------------------------计算目标函数值---------------------------------
m=opt.Index(end);
x = zeros(1,m+1);
x(X(X>0)+opt.temp) = 1;
if (x(10)~=x(57))&&(x(10)==1)
    x(57)=1;
    x(54)=0;
    x(55)=0;
    x(56)=0;
elseif (x(10)~=x(57))&&(x(57)==1)
    x(10)=1;
    x(11)=0;
    x(12)=0;
end
if (x(27)~=x(92))&&(x(27)==1)
    x(92)=1;
    x(91)=0;
elseif (x(27)~=x(92))&&(x(92)==1)
    x(27)=1;
    x(26)=0;
    x(28)=0;
    x(29)=0;
end
if (x(25)~=x(35))&&(x(25)==1)
    x(35)=1;
    x(33)=0;
    x(34)=0;
    x(36)=0;
elseif (x(25)~=x(35))&&(x(35)==1)
    x(25)=1;
    x(23)=0;
    x(24)=0;
end
if (x(18)~=x(74))&&(x(18)==1)
    x(74)=1;
    x(72)=0;
    x(73)=0;
elseif (x(18)~=x(74))&&(x(74)==1)
    x(18)=1;
    x(17)=0;
    x(19)=0;
end
if (x(61)==x(70))&&(x(61)==1)
    x(70)=0;
    x(67)=round(rand(1));
    x(68)=1-x(67);
    x(69)=0;
    x(71)=0;
elseif (x(61)==x(70))&&(x(61)==0)
    x(70)=1;
    x(67)=0;
    x(68)=0;
    x(69)=0;
    x(71)=0;
end
if (x(14)==x(21))&&(x(14)==1)
    x(21)=0;
    x(20)=round(rand(1));
    x(22)=1-x(20);
elseif (x(14)==x(21))&&(x(14)==0)
    x(21)=1;
    x(20)=0;
    x(22)=0;
end
x(end)=1;
%The first function
f(1)=x*opt.cost;
%The second function
nu=size(opt.D,2);
rr=x.*opt.time;
CC=rr(rr~=0)';
pp=repmat(CC,1,nu);
C=pp.*opt.D;
%C=timehandle(x,A,m);
n1=size(C,2);
ST=zeros(1,n1);
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
f(2)=ST(n1);
%The third function
%F(i,3)=-(x*Performance-26.5234)/(56.6129-26.5234);
f(3)=-x*opt.Performance;
%F(i,3)=-(x*Performance);

%----------------------------约束条件---------------------------------------
g = [];
g(1)= max(ST(n1)-50,0);%约束条件1：最大的时间不能超过60
%g3=x*opt.cost;
g(2) = max( f(1)-1500,0);%约束条件2：最大的费用不能超过15
end
