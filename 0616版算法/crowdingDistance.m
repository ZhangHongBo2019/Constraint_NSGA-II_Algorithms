%This function calculates crowding distance for front-f
function [CDF] = crowdingDistance(opt, f, objective)

    if size(f,2)==1
        CDF = opt.Inf;
    elseif size(f,2)==2
        CDF(1) = opt.Inf;
        CDF(2) = opt.Inf;
    else
        
        [M1, I1] = min(objective);
        [M2, I2] = max(objective);
        
        I = horzcat(I1, I2);
        I = unique(I);
        
        
        CDF = zeros(size(f,2),1);
        for i = 1:size(objective,2)
            
            [~,index] = sort(objective(:,i));
            for j = 2:size(index,1)-1
                if (abs(M2(i)-M1(i)) > opt.Epsilon)
                    CDF(index(j)) = CDF(index(j))+ ((objective(index(j+1),i)-objective(index(j-1),i))/(M2(i)-M1(i)))  ;
                end
            end
        end
        CDF(2:end-1) = CDF(2:end-1)/ size(objective,2);      
        CDF(I) = opt.Inf;

    end

end