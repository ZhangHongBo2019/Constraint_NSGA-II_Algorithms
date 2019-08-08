function f=non_domination(x)
global M V
temp=[];
while size(x,1)>0
      mm=x(1,V+1:V+3);
      a=[];
    for j=2:1:size(x,1)
        dom_less = 0;
        dom_equal = 0;
        dom_more = 0;
        for k = 1 : M
            if (mm(k) < x(j,V+k))
                dom_less = dom_less + 1;
            elseif (mm(k) == x(j,V+k))
                dom_equal = dom_equal + 1;
            else
                dom_more = dom_more + 1;
            end
        end
        if dom_less == 0 && dom_equal ~= M
             mm=0;
             break
        elseif dom_more == 0 && dom_equal ~= M
            a=[a;j];
        end
    end 
     if mm==0
        x([1;a],:)=[];
    else
        temp=[temp;x(1,:)];
        x([1;a],:)=[];
    end      
end
f=temp;
end