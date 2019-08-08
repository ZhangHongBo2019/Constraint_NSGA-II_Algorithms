N=100;
trace_1=zeros(1,N); 
for i=1:1:N
    [Chromosome,V]=nsga_2_optimization(i,i*50); 
    trace_1(1,i)= size(Chromosome,1);
end
xlswrite('data31.xls',trace_1,1);
figure
plot(50:50:5000,trace_1,'*-');
