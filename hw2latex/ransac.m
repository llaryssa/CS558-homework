function [bestline, bestinliers] = ransac (pts,t,p,s)

    N = Inf;
    count = 0;
    it = 0;
    bestnuminliers = 0;
    bestline = [];
    bestinliers = [];

    if size(pts,1) == 1
        pts = pts';
    end
    npoints = length(pts);
    
    while N > count      
        % pick 2 points and form a line
        p1 = 0; p2 = 0;
        while(p1 == p2 || p1 == 0 || p2 == 0)
            p1 = round(rand*npoints);
            p2 = round(rand*npoints);
        end
        [a,b,d] = linefrompoints(pts(p1,:), pts(p2,:));
        
        % pick the closests points to the line
        dist = distpointtoline(pts, [a b d]);
        inliers = find(dist <= t);

        if length(inliers) > bestnuminliers
            bestnuminliers = length(inliers);
            bestline = [a b d];
            bestinliers = inliers;
        end
        
        % update parameters
        e = 1 - length(inliers)/length(pts);
        N = log(1-p)/log(1 - power((1-e),s));
        count = count + 1;

        it = it + 1;
    end
    
%     bestinlierspts = pts(bestinliers,:);
%     xx = min(bestinlierspts(:,1)):max(bestinlierspts(:,1));
%     f2 = figure; scatter(pts(:,1),pts(:,2), 'r'), hold on;
%     figure(f2);
%     plot(xx,(bestline(3)-bestline(1).*xx)./bestline(2),'b');
%     scatter(bestinlierspts(:,1),bestinlierspts(:,2),'*','b');
    [it bestnuminliers]
end