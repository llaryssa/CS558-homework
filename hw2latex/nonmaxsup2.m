function im1 = nonmaxsup2(im, half_win) 
    if nargin < 2
        half_win = 1;
    end
    
    [s1, s2] = size(im);
    im1 = zeros(s1, s2);

    for i = half_win+1:s1-half_win
        for j = half_win+1:s2-half_win
             win = im(i-half_win:i+half_win, j-half_win:j+half_win);
             if max(win(:)) == im(i,j)
                im1(i,j) = im(i,j);
             end
         end
    end   
end