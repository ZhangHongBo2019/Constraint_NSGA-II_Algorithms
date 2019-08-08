clc;
clear;
close all
N1=5;
%N2=10;
iter=20;
trace1=zeros(N1,N1); 
temp=zeros(N1,N1);
for k=1:1:iter
  for i=1:1:N1
    %for j=1:1:N2
    PopObj=nsga_2_optimization(0.5+i*0.1,(i-1)*0.05); 
    %[Chromosome,V]=nsga_2_optimization(k,i*5000);
    %PopObj = Chromosome(:, V + 1 : V + 3);
    Distance = pdist2(PopObj,PopObj,'cityblock');    
    Distance(logical(eye(size(Distance,1)))) = inf;
    temp(i,i)= std(min(Distance,[],2));
   end
  %end
  %xlswrite('data111.xlsx',temp,k);
  trace1=trace1+temp;
end
trace1=trace1./iter;
% figure(1)
% plot(100:100:1000,trace1,'*-');
% xlabel('迭代次数');
% ylabel('非支配解个数');
% title("实验1-非支配解的个数随迭代次数的变化");
%xlswrite('data112.xlsx',trace1,1);
% figure
% bar3(trace1);
% xbins=0.5:0.05:0.95;
% ybins=0.01:0.01:0.1;
% %zbins=0:1:36;
% set(gca,'XTickLabel',xbins);
% set(gca,'YTickLabel',ybins);
% %set(gca,'ZTickLabel',zbins);
% %zlim([1,36]);
% %% 
% xlabel('交叉概率');
% ylabel('变异概率');
% zlabel('Spcing值');
% title('交叉概率和变异概率对Spcing值的影响');