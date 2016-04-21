function results = slic(im,win)

    [s1,s2,~] = size(im);

    % centroids
    centr = zeros(s1, s2);
    half = round((win+1)/2);

    centr(half,half) = 1;
    for i = half:win:s1
        for j = half:win:s2
            centr(i,j) = 1;
        end
    end
    
    qtd = sum(centr(:));
    
    % gradient magnitude
    Sx = [-1 0 1; -2 0 2; -1 0 1];
    Sy = [1 2 1; 0 0 0; -1 -2 -1];

    gradient(:,:,1) = filtering(im(:,:,1), Sx);
    gradient(:,:,2) = filtering(im(:,:,2), Sx);
    gradient(:,:,3) = filtering(im(:,:,3), Sx);
    gradient(:,:,4) = filtering(im(:,:,1), Sy);
    gradient(:,:,5) = filtering(im(:,:,2), Sy);
    gradient(:,:,6) = filtering(im(:,:,3), Sy);
    
    gradient = power(gradient,2);
    gradient = sum(gradient,3);
    gradient = sqrt(gradient);
       
    centridx = find(centr==1);
    for i = 1:qtd
        [x,y] = ind2sub(size(im),centridx(i));
        window = gradient(x-1:x+1,y-1:y+1);
        [~,ii] = min(window(:));
        [xf,yf] = ind2sub(size(window),ii);
        xf = xf - 2;
        yf = yf - 2;
        centr(x,y) = 0;
        centr(x+xf,y+yf) = 1;
        initial_clusters(i,:) = [x+xf y+yf];
    end
    
    
    [xx,yy] = meshgrid(1:s1,1:s2);
    xx = xx';
    yy = yy';
    
    input(:,:,1) = xx./2;
    input(:,:,2) = yy./2;
    input(:,:,3:5) = im;  
    
    results = kmeansseg(input,qtd,initial_clusters);
      
end