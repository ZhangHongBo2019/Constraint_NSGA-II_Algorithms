function [pop_crossover, nrealcross] = sbx(pop_selection, p_cross, nrealcross, eta_c, Xmin, Xmax, epsilon)

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
    child1 = zeros(1, nreal);
    child2 = zeros(1, nreal);
    if rand <= p_cross
        nrealcross = nrealcross+1;
        for i=1:nreal
            if rand <= 0.5
                if abs( parent1(i)-parent2(i) ) > epsilon
                    if parent1(i) < parent2(i)
                        y1 = parent1(i);
                        y2 = parent2(i);
                    else
                        y1 = parent2(i);
                        y2 = parent1(i);
                    end
                    yl = Xmin(i);
                    yu = Xmax(i);
                    beta = 1.0 + (2.0*(y1-yl)/(y2-y1));
                    alpha = 2.0 - beta^(-(eta_c+1.0));
                    rand_var = rand;
                    if rand_var <= (1.0/alpha)
                        betaq = (rand_var*alpha)^(1.0/(eta_c+1.0));
                    else
                        betaq = (1.0/(2.0 - rand_var*alpha))^(1.0/(eta_c+1.0));
                    end
                    c1 = 0.5*((y1+y2) - betaq*(y2-y1));
                    beta = 1.0 + (2.0*(yu-y2)/(y2-y1));
                    alpha = 2.0 - beta^(-(eta_c+1.0));
                    if rand_var <= (1.0/alpha)
                        betaq = (rand_var*alpha)^(1.0/(eta_c+1.0));
                    else
                        betaq = (1.0/(2.0 - rand_var*alpha))^(1.0/(eta_c+1.0));
                    end
                    c2 = 0.5*((y1+y2)+betaq*(y2-y1));
                    if (c1 < yl), c1 = yl; end
                    if (c2 < yl), c2 = yl; end
                    if (c1 > yu), c1 = yu; end
                    if (c2 > yu), c2 = yu; end
                    if rand <= 0.5
                        child1(i) = c2;
                        child2(i) = c1;
                    else
                        child1(i) = c1;
                        child2(i) = c2;
                    end
                else
                    child1(i) = parent1(i);
                    child2(i) = parent2(i);
                end
            else
                child1(i) = parent1(i);
                child2(i) = parent2(i);
            end
        end
    else
        child1 = parent1;
        child2 = parent2;
    end
    pop_crossover(ind,:) = child1;
    pop_crossover(ind+1,:) = child2;
end