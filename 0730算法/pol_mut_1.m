%% µ•µ„±‰“Ï
function [pop_crossover]=pol_mut_1(pop_crossover, pmut)
[N, nreal] = size(pop_crossover); % Population size & Number of variables
pop_mut = zeros( size(pop_crossover));%Child population
if mod(N,2) ~= 0 %check if N is odd
    pop_mut(N,:) = pop_crossover(randi(N),:);%pick a random element for last solution if N is odd
    N = N - 1;
end

p = randperm(N);
for ind=1:2:N 
    p1 = p(ind);
    p2 = p(ind+1);
    parent1 = pop_crossover(p1,:);
    parent2 = pop_crossover(p2,:);
%     child1 = zeros(1, nreal);
%     child2 = zeros(1, nreal);
    if rand <= pmut
        temp=randperm(nreal,1);
%         site1=min(temp);
%         site2=max(temp);
%         child1=[parent1(1:site1),parent2((site1+1):site2),parent1((site2+1):nreal)];
%         child2=[parent2(1:site1),parent1((site1+1):site2),parent2((site2+1):nreal)];
%         inter=parent1(temp);
%         parent1(temp)=parent2(temp);
%         parent2(temp)=inter;
        child1=horzcat(parent1(1:(temp-1)),parent2(temp),parent1((temp+1):nreal));
        child2=horzcat(parent2(1:(temp-1)),parent1(temp),parent2((temp+1):nreal));
    else
        child1 = parent1;
        child2 = parent2;
    end
    pop_mut(ind,:) = child1;
    pop_mut(ind+1,:) = child2;
end