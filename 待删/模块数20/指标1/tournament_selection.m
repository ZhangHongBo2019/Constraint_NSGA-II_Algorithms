function f = tournament_selection(chromosome, pool_size, tour_size)
[pop, variables] = size(chromosome);
rank = variables - 1;
distance = variables;
for i = 1 : pool_size
    candidate = zeros(1,2);
    for j = 1 : tour_size
        candidate(j) = round(pop*rand(1));
        if candidate(j) == 0
            candidate(j) = 1;
        end
        if j > 1
            while candidate(1) == candidate(2)
                candidate(j) = round(pop*rand(1));
                if candidate(j) == 0
                    candidate(j) = 1;
                end
            end
        end
    end
    %temp1=[candidate(1) candidate(2)];
    %temp2=[temp2;temp1]
    for j = 1 : tour_size
        c_obj_rank(j) = chromosome(candidate(j),rank);
        c_obj_distance(j) = chromosome(candidate(j),distance);
    end
    min_candidate = find(c_obj_rank == min(c_obj_rank));
    if length(min_candidate) ~= 1
        max_candidate = find(c_obj_distance(min_candidate) == max(c_obj_distance(min_candidate)));
        if length(max_candidate) ~= 1
            max_candidate = max_candidate(1);
        end
        f(i,:) = chromosome(candidate(min_candidate(max_candidate)),:);
    else
        f(i,:) = chromosome(candidate(min_candidate(1)),:);
    end


%f
%display('********************************************************************');

end