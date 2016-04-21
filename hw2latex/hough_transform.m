function [H,rho,theta] = hough_transform (pts,bintheta,binrho,imagesize)    
    if nargin == 1
        bintheta = 0.01;
        binrho = 1;
        imagesize = [407 548];
    end
    
    if size(pts,1) == 1
        pts = pts';
    end

    npoints = size(pts,1);
    maxrho = norm(imagesize);
    rho = -maxrho:binrho:maxrho;
    theta = 0:bintheta:pi;
    tidx = 1:numel(theta);
    H = zeros(numel(theta), numel(rho));
    
    % filling H
    for i = 1:npoints
        x = pts(i,1); y = pts(i,2);
        r = x.*cos(theta) + y.*sin(theta);
        ridx = round(r + numel(rho)/2);
        idx = sub2ind(size(H),tidx,ridx);
        H(idx) = H(idx) + 1;
    end

end