function [error, f] = GeoError(x, X, ks, K, Rs, ts)
% Measure a geometric error
%
%   x:  2D points. n x 2 x N matrix, where n is the number of corners in
%   a checkerboard and N is the number of calibration images
%       
%   X:  3D points. n x 2 matrix, where n is the number of corners in a
%   checkerboard and assumes the points are on the Z=0 plane
%
%   K: a camera calibration matrix. 3 x 3 matrix.
%
%   Rs: rotation matrices. 3 x 3 x N matrix, where N is the number of calibration images. 
%
%   ts: translation vectors. 3 x 1 x N matrix, where N is the number of calibration images. 
%
%   ks: radial distortion parameters. 2 x 1 matrix, where ks(1) = k_1 and
%   ks(2) = k_2.
%

%% Your code goes here
[n, ~, imgNum] = size(x);
f = zeros(2, imgNum, n);
for i = 1:imgNum
    corrX = correctDistortionProjection(X, K, Rs(:, :, i), ts(:, :, i), ks);
    err = x(:, :, i) - corrX; % n x 2
    f(:, i, :) = reshape(err', 2, 1, []); % 2 x 1 x n
end
err = f .^ 2;
error = sum(err(:));

end
