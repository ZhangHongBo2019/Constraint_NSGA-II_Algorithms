N=10;
iter=3;
trace1=zeros(1,N); 
temp=zeros(1,N);
for k=1:1:iter
  for i=1:1:N
    [Chromosome,V]=nsga_2_optimization(k,0.01+(i-1)*0.01); 
    PopObj = Chromosome(:, V + 1 : V + 3);
   Distance = pdist2(PopObj,PopObj,'cityblock');    
   Distance(logical(eye(size(Distance,1)))) = inf;
    temp(1,i)= std(min(Distance,[],2));
  end
  xlswrite('data21.xlsx',temp,k);
  trace1=trace1+temp;
end
trace1=trace1./k;
xlswrite('data22.xlsx',trace1,1);
figure
plot(0.6:0.1:0.9,trace3','o-');
set(gca,'xtick',[0.6:0.1:0.9]);
xlabel('变异概率');
ylabel('Spcing值');
title('实验2-变异概率对Spcing值的影响');
