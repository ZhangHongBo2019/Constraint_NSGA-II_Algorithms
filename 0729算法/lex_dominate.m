function [d] = lex_dominate(obj1, obj2)
    a_dom_b = 0;
    b_dom_a = 0;
    
    
    sz = size(obj1,2);
    for i = 1:sz	                                                       % 判断每个目标函数的每个维度
        if obj1(i) > obj2(i)                                               % 如果目标1在某一个维度大于目标2
            b_dom_a = 1;                                                   % b_dom_a = 1
        elseif(obj1(i) < obj2(i))                                          % 如果目标1在某一个维度小于目标2
			a_dom_b = 1;                                                   % a_dom_b = 1;  
        end
        
    end
    
    if(a_dom_b==0 && b_dom_a==0)                                           % 如果a_dom_b==0 && b_dom_a==0 ，说明两个解相等
        d = 2;                                                             % 如果a_dom_b==1 && b_dom_a==1，说明两个解为非支配
    elseif(a_dom_b==1 && b_dom_a==1)
       d = 2; 
    else
        if a_dom_b==1                                                      % a 支配 b
            d = 1;
        else
            d = 3;                                                         % b 支配 a
        end
    end        
end