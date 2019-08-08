function [parent_selected] = tour_selection(pool)
%% Description

% 1. Parents are selected from the population pool for reproduction by using binary tournament selection
%    based on the rank and crowding distance. 
% 2. An individual is selected if the rank is lesser than the other or if
%    crowding distance is greater than the other.
% 3. Input and output are of same size [pop_size, V+M+3].


%% Binary Tournament Selection
global M N V
%[pop_size, distance]=size(pool);
rank=V+M+1;
candidate=[randperm(N);randperm(N)]';
parent_selected=zeros(N,V);
for i = 1: N
    parent=candidate(i,:);                                  % Two parents indexes are randomly selected
 if pool(parent(1),rank)~=pool(parent(2),rank)              % For parents with different ranks
    if pool(parent(1),rank)<pool(parent(2),rank)            % Checking the rank of two individuals
        mincandidate=pool(parent(1),:);
    else
        mincandidate=pool(parent(2),:);
    end
parent_selected(i,:)=mincandidate(1:V);                          % Minimum rank individual is selected finally
 else                                                       % for parents with same ranks  
    if pool(parent(1),V+M+2)>pool(parent(2),V+M+2)    % Checking the distance of two parents
        maxcandidate=pool(parent(1),:);
    elseif pool(parent(1),V+M+2)<pool(parent(2),V+M+2)
        maxcandidate=pool(parent(2),:);
    else
        temp=randperm(2);
        maxcandidate=pool(parent(temp(1)),:);
    end 
parent_selected(i,:)=maxcandidate(1:V);                          % Maximum distance individual is selected finally
end
end


    
    
    
    
    
    
    
    
    