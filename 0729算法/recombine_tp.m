%% Á½µã½»²æ
function [pop_crossover]=recombine_tp(pop_selection,px)
[N, nreal] = size(pop_selection); % Population size & Number of variables
pop_crossover = zeros( size(pop_selection) );%Child population
if mod(N,2) ~= 0 %check if N is odd
    pop_crossover(N,:) = pop_selection(randi(N),:);%pick a random element for last solution if N is odd
    N = N - 1;
end

p = randperm(N);
for ind=1:2:N 
    p1 = p(ind);
    p2 = p(ind+1);
    parent1 = pop_selection(p1,:);
    parent2 = pop_selection(p2,:);
%     child1 = zeros(1, nreal);
%     child2 = zeros(1, nreal);
    if rand <= px
        temp=randperm(nreal,1);
%         site1=min(temp);
%         site2=max(temp);
%         child1=[parent1(1:site1),parent2((site1+1):site2),parent1((site2+1):nreal)];
%         child2=[parent2(1:site1),parent1((site1+1):site2),parent2((site2+1):nreal)];
        child1=horzcat(parent1(1:temp),parent2((temp+1):nreal));
        child2=horzcat(parent2(1:temp),parent1((temp+1):nreal));
    else
        child1 = parent1;
        child2 = parent2;
    end
    pop_crossover(ind,:) = child1;
    pop_crossover(ind+1,:) = child2;
end