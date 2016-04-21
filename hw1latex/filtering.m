function im2 = filtering (im, f)
 % work with images already casted to double
 [s1, s2] = size(f);
 hs1 = (s1-1)/2; hs2 = (s2-1)/2;
 
 im2 = im;  % copy pixels near the borders
%  im2 = zeros(size(im,1),size(im,2));  % fill borders with black
 
 for i = hs1+1 : size(im,1) - hs1
     for j = hs2+1 : size(im,2) - hs2
         im2(i,j) = sum(sum(f.*im(i-hs1:i+hs1, j-hs2:j+hs2)));
     end
 end 
end