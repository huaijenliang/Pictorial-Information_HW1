function [ output_args ] = plotCorners( path, pos )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

imgNames = dir(sprintf('%s/*.jpg', path));
imgs = arrayfun(@(x) imread(sprintf('%s/%s', path, x.name)), imgNames, 'UniformOutput', false);

for i = 1:length(imgs)
    imshow(imgs{i});
    hold on
    plot(pos(:, 1, i), pos(:, 2, i), 'ro')
    hold off
end

end

