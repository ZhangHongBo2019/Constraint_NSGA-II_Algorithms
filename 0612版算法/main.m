function main()
%-------------------MAIN LOOP----------------------------------------------  
    opt.objfunction='服务组合优化算法';                                     % 对应的具体的测试函数
    opt = nsga2_basic_parameters(opt);                                     % 优化算法对应的基本参数
    opt.parater=zeros(opt.N1,opt.N2);
    temp=zeros(opt.N1,opt.N2);
    for k=1:1:opt.iter
        for i=1:1:opt.N1
            for j=1:1:opt.N2
                opt = nsga2_main(opt,0.5+0.1*(i-1),(j-1)*0.01);
                Distance = pdist2(opt.Chromosome,opt.Chromosome,'cityblock');
                Distance(logical(eye(size(Distance,1)))) = inf;
                temp(i,j)= std(min(Distance,[],2));
            end
        end
        k
        %xlswrite('data111.xlsx',temp,k);
        opt.parater=opt.parater+temp;
    end
    opt.parater=opt.parater./opt.iter;
    xlswrite('data01.xlsx',opt.parater,1);
    %------------------------可视化----------------------------------------
    opt.fig = figure;
    bar3(opt.parater');
    xbins=0.5:0.1:1;
    ybins=0:0.01:0.1;
    %zbins=0:1:36;
    set(gca,'XTickLabel',xbins);
    set(gca,'YTickLabel',ybins);
    %set(gca,'ZTickLabel',zbins);
    %zlim([1,36]);
    %%
    xlabel('交叉概率');
    ylabel('变异概率');
    zlabel('Spcing值');
    title('交叉概率和变异概率对Spcing值的影响');
end
%------------------------------END OF -FILE--------------------------------