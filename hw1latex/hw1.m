clear all; clc;

im = imread('cs558s16_hw1/kangaroo.pgm');
% im = imread('cs558s16_hw1/plane.pgm');
% im = imread('cs558s16_hw1/red.pgm');
% im = [zeros(10,10) ones(10,10); ones(10,10) zeros(10,10)];

im = im2double(im);

% gaussian params
sigma = 1;
% after sobel filter
isedge_thresh = 100;


%% 1. gaussian filter
if sigma ~= 0
    % wingauss = 5;
    % halfgauss = (wingauss-1)/2;
    halfgauss = 3*sigma - 1;

    [x,y] = meshgrid(-halfgauss:halfgauss, -halfgauss:halfgauss);
    G = exp(-(x.^2 + y.^2)/(2*sigma^2));  % no need to compute the const part
    G = G./sum(G(:));  % sum has to be 1

    im1 = filtering(im, G);
else
    im1 = im;
end

%% 2. gradient with sobel filter
Sx = [-1 0 1; -2 0 2; -1 0 1];
Sy = [1 2 1; 0 0 0; -1 -2 -1];

im1x = filtering(im1, Sx);  % has neg values
im1y = filtering(im1, Sy);

strength = sqrt(im1x.^2 + im1y.^2);
direction = atand(im1y./im1x);

strength(im2uint8(strength) < isedge_thresh) = 0;  % binary

%% 3. non-maximum suppression
im2 = nonmaxsup(strength,direction);
edges = im2;
edges(edges > 0) = 1;

imshow(im);
figure, imshow(strength);
figure, imshow(edges);





