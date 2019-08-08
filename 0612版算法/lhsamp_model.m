%LHSAMP  Latin hypercube distributed random numbers
%
% Call:    S = lhsamp
%          S = lhsamp(m)
%          S = lhsamp(m, n)
%
% m : number of sample points to generate, if unspecified m = 1
% n : number of dimensions, if unspecified n = m
%
% S : the generated n dimensional m sample points chosen from
%     uniform distributions on m subdivions of the interval (0.0, 1.0)

function S = lhsamp_model(init_pop, opt)

m = init_pop;                                                              %种群的规模
n = opt.V;                                                                 %决策变量的个数

%S = zeros(m,n);                                                            %初始化种群
S=crtbp(m, opt.BaseV)+repmat(ones(1,n),m,1); 
% for i = 1 : n
%   S(:, i) = (rand(1, m) + (randperm(m) - 1))' / m;
% end
% 
% %generate each point
% for i=1:m
%     S(i,:) = opt.bound(1,:) + (opt.bound(2,:)-opt.bound(1,:)).*S(i,:); %low + difference*rand(0,1)
% end
