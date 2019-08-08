function [opt] = survival_selection(opt)

    switch(opt.survivalselectionOption)
        
        case 1 %------------------NSGA-II----------------------------------
            
            opt = nsga2_selection(opt);
            
        otherwise

            disp('Survival Selection is not defined');
            
    end

end