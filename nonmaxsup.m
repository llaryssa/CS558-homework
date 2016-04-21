function im2 = nonmaxsup(grad, dir)
 % input: gradient, directions
 
 [s1, s2] = size(grad);
 im2 = zeros(size(grad,1), size(grad,2));
 
 for i = 2:s1-1
     for j = 2:s2-1
         if grad(i,j) ~= 0
             x1 = 0; y1 = 0;
             x2 = 0; y2 = 0;
             if dir(i,j) > 67.5 || dir(i,j) <= -67.5 % 90 degrees
                 x1 = -1; y1 = 0;
                 x2 = 1; y2 = 0;
             elseif dir(i,j) <= 67.5 && dir(i,j) > 22.5 % 45 degrees
                 x1 = -1; y1 = 1;
                 x2 = 1; y2 = -1;
             elseif dir(i,j) <= 22.5 && dir(i,j) > -22.5 % 0 degrees
                 x1 = 0; y1 = -1;
                 x2 = 0; y2 = 1;
             elseif dir(i,j) <= -22.5 && dir(i,j) > -67.5 % -45 degrees
                 x1 = -1; y1 = -1;
                 x2 = 1; y2 = 1;
             else
                 disp('wrong');
             end
             
             temp = [grad(i,j) grad(i+x1,j+y1) grad(i+x2,j+y2)];
             if max(temp) == grad(i,j)
                im2(i,j) = grad(i,j);
             end
         end
     end
 end
 
end