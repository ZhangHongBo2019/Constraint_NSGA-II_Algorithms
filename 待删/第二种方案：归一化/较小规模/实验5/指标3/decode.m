function X1 = decode(X)
for i = 1:size(X,1)
    idx = floor(X(i,1:29));
x = zeros(1,106);
temp = [0,5,8,12,14,16,20,24,27,30,34,37,41,45,49,53,58,62,65,70,74,76,80,84,88,92,96,98,103];
x(idx(idx>0)+temp) = 1;
 X1(i,:) = x;
end