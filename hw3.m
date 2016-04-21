clear all; clc; close all;

im1 = imread('cs558s16_hw3/white-tower.png');
im2 = imread('cs558s16_hw3/wt_slic.png');

% im1 = im2double(im1);
% im2 = im2double(im2);

im1 = double(im1);
im2 = double(im2);

% k means segmentation
k = 10;
initial_clusters = rand(k,2);
initial_clusters(:,1) = round(initial_clusters(:,1).*size(im1,1))+1;
initial_clusters(:,2) = round(initial_clusters(:,2).*size(im1,2))+1;
clusters = kmeansseg(im1,k,initial_clusters);
% back to image
clusters = uint8(clusters);
figure;
imshow(clusters);
% imwrite(clusters, 'hw3latex/kmeans.png');

% SLIC
win = 50;
clusters2 = slic(im2,win);
% back to image
clusters2 = uint8(clusters2(:,:,3:5));
figure;
imshow(clusters2);

adjusttoplot(clusters2);
% imwrite(clusters2, 'hw3latex/slic1.png');
