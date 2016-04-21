%% problem 1

im = rgb2gray(imread('lena.png'));
[s1,s2] = size(im);
h1 = imshow(im);

% blue line
p1x = round(rand(1)*s1); p1y = round(rand(1)*s2);
p2x = round(rand(1)*s1); p2y = round(rand(1)*s2);

hold on;
lin = line([p1x p2x], [p1y p2y], 'Color', 'b', 'LineWidth', 1.0);

% red square
p3x = round(rand(1)*s1); p3y = round(rand(1)*s2);
halfwin = 1;

[xx,yy] = meshgrid(p3x-halfwin:p3x+halfwin, p3x-halfwin:p3x+halfwin);
hold on;
sq = scatter(xx(:),yy(:),'filled','square','r');

clear all;

%% problem 2

p0x = rand(1); p0y = rand(1);
a = rand(1);
b = sqrt(1 - a.*a);
d = rand(1);

dist = abs(a*p0x + b*p0y - d);
disp(['distance from P = [' num2str(p0x) ',' num2str(p0y) ...
    '] to the line ' num2str(a) 'x + ' num2str(b) 'y = ' num2str(d) ...
    ': ' num2str(dist)]);

clear all;

%% problem 3

% p1x = rand(1)*100; p1y = rand(1)*100;
% p2x = rand(1)*100; p2y = rand(1)*100;

th = atan((p1x-p2x)/(p2y-p1y));
rho = p1x*cos(th) + p1y*sin(th);

disp(['the line defined by P1 = [' num2str(p1x) ',' num2str(p1y) ...
    '], and P2 = [' num2str(p2x) ',' num2str(p2y) '] is parameterized by ' ... 
    '[rho,theta] = [' num2str(rho) ', ' num2str(th) ']']);






