function im2 = adjusttoplot(im)

    [s1,s2,~] = size(im);
    
    im2 = im;
    
    for i = 2:s1-1
        for j = 2:s2-1            
            iff(1,:) = im(i-1,j-1,:) == im(i,j,:);
            iff(2,:) = im(i-1,j,:) == im(i,j,:);
            iff(3,:) = im(i-1,j+1,:) == im(i,j,:);
            iff(4,:) = im(i,j-1,:) == im(i,j,:);
            iff(5,:) = im(i,j+1,:) == im(i,j,:);
            iff(6,:) = im(i+1,j-1,:) == im(i,j,:);
            iff(7,:) = im(i+1,j,:) == im(i,j,:);
            iff(8,:) = im(i+1,j+1,:) == im(i,j,:);
            if sum(iff(:)) ~= 24
                im2(i,j,:) = [0 0 0];
            end            
        end
    end

    imshow(im2);
    
end