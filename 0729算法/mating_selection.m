function [opt] = mating_selection(opt)

    switch(opt.matingselectionOption)
        case 1
            
            opt.popChild = constrained_tournament_selection(opt, opt.pop, opt.popObj, opt.popCV);
            
       otherwise
            
            opt.popChild = constrained_tournament_selection(opt, opt.pop, opt.popObj, opt.popCV);
    end

end