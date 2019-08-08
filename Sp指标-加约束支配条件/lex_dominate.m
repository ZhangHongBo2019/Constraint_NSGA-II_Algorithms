function [d] = lex_dominate(obj1, obj2)
    
    a_dom_b = 0;
    b_dom_a = 0;
    
    
    sz = size(obj1,2);
    for i = 1:sz	
        if obj1(i) > obj2(i)
            b_dom_a = 1;
        elseif(obj1(i) < obj2(i))
			a_dom_b = 1;
        end
        
    end
    
    if(a_dom_b==0 && b_dom_a==0)
        d = 2;
    elseif(a_dom_b==1 && b_dom_a==1)
       d = 2; 
    else
        if a_dom_b==1
            d = 1;
        else
            d = 3;
        end
    end
        
end