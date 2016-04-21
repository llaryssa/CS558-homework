im = imread('road.png');
im = im2double(im);

% gaussian 
sigma = 1;
im1 = gauss_filter(im,sigma);

% derivatives with sobel filter
Sx = [-1 0 1; -2 0 2; -1 0 1];
Sy = [1 2 1; 0 0 0; -1 -2 -1];
 
im1x = filtering(im1, Sx);
im1y = filtering(im1, Sy);
im1xx = filtering(im1x, Sx);
im1yy = filtering(im1y, Sy);
im1xy = filtering(im1x, Sy);

% hessian
thresh = 2.5;
hessian = im1xx.*im1yy - im1xy.*im1xy;
hessian(hessian < thresh) = 0;

% non maximum suppresion
half_win_hess = 1;
hess = nonmaxsup2(hessian, half_win_hess);

f0 = figure; imshow(hess);

[y,x] = find(hess > 0);

t = 1;  % distance threshold / 1px
s = 2;  % minimum number needed to fit the model
p = 0.95;  % probability at least one sample is free from outliers
numofanswers = 4;

f1 = figure; imshow(im), hold on;

pts = [x y];

% ransac
for answ = 1:numofanswers
    [line, inliersidx] = ransac(pts, t, p, s);
    inliers = pts(inliersidx,:);
    [~,idx1] = min(inliers(:,1));
    [~,idx2] = max(inliers(:,1));
    
    figure(f1);
    plot(inliers([idx1 idx2],1), inliers([idx1 idx2],2), 'LineWidth', 1.2);

    xx = inliers(idx1,1):inliers(idx2,1);
    plot(xx,(line(3)-line(1).*xx)./line(2),'b');
    
    halfwin = 1;
    for i = 1:size(inliers,1)
        px = inliers(i,1); py = inliers(i,2);
        [xx,yy] = meshgrid(px-halfwin:px+halfwin, py-halfwin:py+halfwin);
        hold on;
        sq = scatter(xx(:),yy(:),'filled','square','r');
    end
    
    pts(inliersidx,:) = [];
end

% rough transform
[H,rhos,thetas] = hough_transform([x y],0.01,1,size(im));
f2 = figure;
imagesc(H), colormap('gray'), hold on;
f3 = figure;
imshow(im); hold on;

tempH = H;

for answ = 1:numofanswers
    [maxx,tempidx] = max(tempH(:));
    [ith,irho] = ind2sub(size(H),tempidx);
    
    rho = rhos(irho);
    th = thetas(ith);

    figure(f2); scatter(irho,ith,'r');

    xx = 1:size(im,2);
    yy = (rho - xx.*cos(th))/sin(th);
    figure(f3); plot(xx,yy,'LineWidth',1.3);
    
    tempH(ith,irho) = 0;
end