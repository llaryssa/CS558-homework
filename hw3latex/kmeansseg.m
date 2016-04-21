function results = kmeansseg(im, k, initial_clusters)

    disp('entering kmeans...');

    [s1,s2,s3] = size(im);
    
    distances = Inf(s1,s2,k);
    
    clusters = zeros(k,s3);
    new_clusters = zeros(k,s3);
    
   for i = 1:k
      % only the rgb value
      clusters(i,1:s3) = im(initial_clusters(i,1),initial_clusters(i,2),:);
   end
   
   % main loop
   stop = 0;
   iteration = 0;
   while ~stop   
       % calculate the distances from every pixel to every cluster
       for i = 1:k
           auxdiff = [];
           for d = 1:s3
                auxdiff(:,:,d) = repmat(clusters(i,d),s1,s2);
           end
           
           % ||(pi - ci)||
           distt = im - auxdiff;
           distt = power(distt,2);
           distt = sum(distt,3);
           distt = sqrt(distt);

           distances(:,:,i) = distt;
       end
       
       % status holds which cluster each pixel is in
       [~,status] = min(distances,[],3);
       
       for i = 1:k
            % getting the RGB value of pixels in each cluster
            idx = status == i;
            qtd = sum(idx(:));   
            idxmat = repmat(idx,1,1,s3);
            rgb = im(idxmat);
            rgb = reshape(rgb,qtd,s3);
            new_clusters(i,:) = round(mean(rgb)); % rgb values are integers            
       end      
       
       if abs(norm(new_clusters) - norm(clusters)) < 0.1
           stop = 1;
       end
             
       clusters = new_clusters;
       iteration = iteration + 1;
       
   end   
   
   disp(['total iterations: ' num2str(iteration)])
   
   results = zeros(size(im));
   
   for x = 1:s1
       for y = 1:s2
           results(x,y,:) = clusters(status(x,y),:);           
       end
   end
   
end