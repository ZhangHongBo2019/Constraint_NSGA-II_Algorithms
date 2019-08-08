%This function plots population of each generation with different color
function plot_population(opt, popObj)

    figure(opt.fig);
    %hold all; %uncomment if screen should not be cleared
    if opt.M==2
        plot(popObj(:,1),popObj(:,2),'o','MarkerEdgeColor',opt.Color{randi(size(opt.Color,2))},'MarkerFaceColor',opt.Color{randi(size(opt.Color,2))});         
    elseif opt.M==3
        plot3(popObj(:,1),popObj(:,2),popObj(:,3),'o','MarkerEdgeColor',opt.Color{randi(size(opt.Color,2))},'MarkerFaceColor',opt.Color{randi(size(opt.Color,2))}); 
    end
    
    %xlim([0 1])
    %ylim([0 2])
    drawnow;


end