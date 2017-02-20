function [ K ] = mySolveK( V )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Find eigenvector
[eigV, eigD] = eig(V' * V);
d = abs(diag(eigD));
[~, I] = min(d);
b = eigV(:, I);
B = [b(1), b(2), b(4); ...
     b(2), b(3), b(5); ...
     b(4), b(5), b(6)];

v = (B(1, 2) * B(1, 3) - B(1, 1) * B(2, 3)) / (B(1, 1) * B(2, 2) - B(1, 2) ^ 2);
lamda = B(3, 3) - (B(1, 3) ^ 2 + v * (B(1, 2) * B(1, 3) - B(1, 1) * B(2, 3))) / B(1, 1);
alpha = sqrt(lamda / B(1, 1));
beta = sqrt(lamda * B(1, 1) / (B(1, 1) * B(2, 2) - B(1, 2) ^ 2));
gamma = -B(1, 2) * (alpha ^ 2) * beta / lamda;
u = gamma * v / beta - B(1, 3) * (alpha ^ 2) / lamda;
 
K = zeros(3, 3);
K(1, :) = [alpha, gamma, u];
K(2, :) = [0, beta, v];
K(3, :) = [0, 0, 1];
 

end

