function [ Rs, ts ] = EstimateRt_linear( Hs, K )
% Linear parameter estimation of R and t
%
%   K: a camera calibration matrix. 3 x 3 matrix.
%
%   Hs: a homography from the world to images. 3 x 3 x N matrix, where N is 
%   the number of calibration images. 
%
%   Rs: rotation matrices. 3 x 3 x N matrix, where N is the number of calibration images. 
%
%   ts: translation vectors. 3 x 1 x N matrix, where N is the number of calibration images. 
%

%% Your code goes here.
imgNum = size(Hs, 3);
Rs = zeros(3, 3, imgNum);
ts = zeros(3, 1, imgNum);
invK = inv(K);

for i = 1:imgNum
    r1 = invK * Hs(:, 1, i);
    lamda = norm(r1);
    r1 = r1 ./ lamda;
    r2 = invK * Hs(:, 2, i);
    r2 = r2 ./ lamda;
    r3 = cross(r1, r2);
    Rs(:, :, i) = [r1, r2, r3];
    ts(:, 1, i) = invK * Hs(:, 3, i);
    ts(:, 1, i) = ts(:, 1, i) ./ lamda;
    % estimate the best R
%     [U, ~, V] = svd(Rs(:, :, i));
%     Rs(:, :, i) = U * V';
end

end

