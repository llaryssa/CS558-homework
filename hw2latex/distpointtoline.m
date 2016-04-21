function d = distpointtoline(pts,line)
    % line = [a b d]
    % pts = [x y]
    d = Inf(size(pts,1),1);
    for i = 1:length(pts)
       d(i) = abs(line(1)*pts(i,1) + line(2)*pts(i,2) - line(3)) ...
              / sqrt(line(1)*line(1) + line(2)*line(2));
    end
end