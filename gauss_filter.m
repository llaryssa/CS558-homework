function im1 = gauss_filter(im,sigma)
    if sigma ~= 0
        halfgauss = 3*sigma - 1;

        [x,y] = meshgrid(-halfgauss:halfgauss, -halfgauss:halfgauss);
        G = exp(-(x.^2 + y.^2)/(2*sigma^2));  % no need to compute the const part
        G = G./sum(G(:));  % sum has to be 1

        im1 = filtering(im, G);
    else
        im1 = im;
    end
end