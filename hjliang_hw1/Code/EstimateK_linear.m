function [K, Hs] = EstimateK_linear(x, X)
% Linear parameter estimation of K
%
%   x:  2D points. n x 2 x N matrix, where n is the number of corners in
%   a checkerboard and N is the number of calibration images
%       
%   X:  3D points. n x 2 matrix, where n is the number of corners in a
%   checkerboard and assumes the points are on the Z=0 plane
%
%   imgs: calibration images. N x 1 cell, where N is the number of calibration images
%
%   K: a camera calibration matrix. 3 x 3 matrix.
%
%   Hs: a homography from the world to images. 3 x 3 x N matrix, where N is 
%   the number of calibration images. You can use est_homography.m to
%   estimate homographies.
%

%% Your code goes here
[corNum, ~, imgNum] = size(x);
Hs = zeros(3, 3, imgNum);
worldX = X(:, 1);
worldY = X(:, 2);
V = zeros(2 * imgNum, 6);
for i = 1:imgNum
    imgX = x(:, 1, i);
    imgY = x(:, 2, i);
    ht = est_homography(imgX, imgY, worldX, worldY);
    h = ht';
    v11 = [h(1, 1) .^ 2, h(1, 1) * h(1, 2) * 2, h(1, 2) .^ 2, h(1, 3) * h(1, 1) * 2, h(1, 3) * h(1, 2) * 2, h(1, 3) .^ 2];
    v12 = [h(1, 1) * h(2, 1), h(1, 1) * h(2, 2) + h(1, 2) * h(2, 1), h(1, 2) * h(2, 2), ...
        h(1, 3) * h(2, 1) + h(1, 1) * h(2, 3), h(1, 3) * h(2, 2) + h(1, 2) * h(2, 3), h(1, 3) * h(2, 3)];
    v22 = [h(2, 1) .^ 2, h(2, 1) * h(2, 2) * 2, h(2, 2) .^ 2, h(2, 3) * h(2, 1) * 2, h(2, 3) * h(2, 2) * 2, h(2, 3) .^ 2];
    V((i - 1) * 2 + 1, :) = v12;
    V(i * 2, :) = v11 - v22;
    Hs(:, :, i) = ht;
end

if imgNum == 2
    V(end + 1, :) = [0, 1, 0, 0, 0, 0];
end

K = mySolveK(V);

end