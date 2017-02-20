function [ XCorr ] = correctDistortionProjection( X, K, Rs, ts, ks )
%UNTITLED2 Summary of this function goes here
%   X:  3D points. n x 2 matrix, where n is the number of corners in a
%   checkerboard and assumes the points are on the Z=0 plane
%
%   K: a camera calibration matrix. 3 x 3 matrix.
%
%   Rs: rotation matrices. 3 x 3 matrix
%
%   ts: translation vectors. 3 x 1 matrix
%
%   ks: radial distortion parameters. 2 x 1 matrix, where ks(1) = k_1 and
%   ks(2) = k_2.
n = size(X, 1);
K(1, 2) = 0;
X = [X, zeros(n, 1), ones(n, 1)];
homX = [Rs ts] * X'; % 3 x n
homX = homX(1:2, :);
rSqr = sum(homX .^ 2, 1);%homX(1, :) .^ 2 + homX(2, :) .^ 2;
rSqr = repmat(rSqr, [2, 1]);
corrX = homX + homX .* (ks(1) * rSqr + ks(2) * (rSqr .^ 2));
corrP = K * [corrX; ones(1, n)];
XCorr = corrP(1:2, :)';


end

