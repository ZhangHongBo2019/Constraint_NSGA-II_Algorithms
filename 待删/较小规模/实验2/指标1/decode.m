function X1 = decode(X)
for i = 1:size(X,1)
    idx = floor(X(i,1:29));
x = zeros(1,106);
temp = [0,3,5,9,12,15,18,21,25,28,31,35,39,41,45,48,52,57,60,65,67,71,73,76,78,80,84,87,89];
x(idx(idx>0)+temp) = 1;
 X1(i,:) = x;
end