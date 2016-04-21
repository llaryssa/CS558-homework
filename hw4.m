folder_path1 = 'cs558s16_hw4/ImClass/';
folder_path2 = 'cs558s16_hw4/sky/';

%% FIRST PROBLEM
bins = 8;
train_label = zeros(12,1);
train_data = zeros(12,bins*3);
test_label = zeros(12,1);
test_data = zeros(12,bins*3);

for i = 1:4
    % prepare training data
    im1 = imread([folder_path1 'coast_train' num2str(i) '.jpg']);
    im2 = imread([folder_path1 'forest_train' num2str(i) '.jpg']);
    im3 = imread([folder_path1 'insidecity_train' num2str(i) '.jpg']);
    
    train_label(i) = 1;
    train_data(i,:) = [make_histogram(im1(:,:,1),bins) ...
                     make_histogram(im1(:,:,2),bins) ...
                     make_histogram(im1(:,:,3),bins)];
    
    train_label(4+i) = 2;
    train_data(4+i,:) = [make_histogram(im2(:,:,1),bins) ...
                     make_histogram(im2(:,:,2),bins) ...
                     make_histogram(im2(:,:,3),bins)];
                 
    train_label(8+i) = 3;
    train_data(8+i,:) = [make_histogram(im3(:,:,1),bins) ...
                     make_histogram(im3(:,:,2),bins) ...
                     make_histogram(im3(:,:,3),bins)];  
    
    % prepare testing data
    im4 = imread([folder_path1 'coast_test' num2str(i) '.jpg']);
    im5 = imread([folder_path1 'forest_test' num2str(i) '.jpg']);
    im6 = imread([folder_path1 'insidecity_test' num2str(i) '.jpg']);
     
    test_label(i) = 1;
    test_data(i,:) = [make_histogram(im4(:,:,1),bins) ...
                     make_histogram(im4(:,:,2),bins) ...
                     make_histogram(im4(:,:,3),bins)];
    
    test_label(4+i) = 2;
    test_data(4+i,:) = [make_histogram(im5(:,:,1),bins) ...
                     make_histogram(im5(:,:,2),bins) ...
                     make_histogram(im5(:,:,3),bins)];
    
    test_label(8+i) = 3;
    test_data(8+i,:) = [make_histogram(im6(:,:,1),bins) ...
                     make_histogram(im6(:,:,2),bins) ...
                     make_histogram(im6(:,:,3),bins)];     
end

% testing
correct = 0;
idx = knnsearch(train_data, test_data,'k',1,'Distance','euclidean');

for i = 1:size(test_data,1)
    if train_label(idx(i)) == test_label(i)
        correct = correct + 1;
    end
    disp(['Test image ' num2str(i) ' of class ' num2str(test_label(i)) ...
          ' has been assigned to class ' num2str(test_label(idx(i)))]);
end

disp(['Accuracy: ' num2str(correct*100/size(test_data,1)) '%'])


%% SECOND PROBLEM

% training
train_image = imread([folder_path2 'sky_train.jpg']);
sky_mask = imread([folder_path2 'sky_train_mask.jpg']);
train_image = double(train_image);
sky_mask = double(sky_mask);

[s1,s2,s3] = size(train_image);

sky = [];
non_sky = [];
sky_color = [];
sky_color(1,1,1) = 254;
sky_color(1,1,2) = 0;
sky_color(1,1,3) = 0;

skyidx = 1;
nonskyidx = 1;
for x = 1:s1
    for y = 1:s2
        if sky_mask(x,y,:) == sky_color
            sky(skyidx,:) = train_image(x,y,:);
            skyidx = skyidx + 1;
        else
            non_sky(nonskyidx,:) = train_image(x,y,:);
            nonskyidx = nonskyidx + 1;  
        end
    end
end

k = 10;
[~,skywords] = kmeans(sky, k, 'EmptyAction', 'singleton');
[~,nonskywords] = kmeans(non_sky, k, 'EmptyAction', 'singleton');
% words :: [label r g b]
words = [ones(k,1) skywords; zeros(k,1) nonskywords];


% testing
for tt = 1:4
    test_image = imread([folder_path2 'sky_test' num2str(tt) '.jpg']);
    [s1,s2,s3] = size(test_image);
    % making it a s1*s2-by-s3 matrix
    test_pixels = double(reshape(test_image,s1*s2,s3,1));

    % search for the closest word
    idx = knnsearch(words(:,2:end),test_pixels,'k',1,'Distance','euclidean');
    test_estimate = words(idx,1);
    
    % getting 2D indices for pixel vector
    [xx,yy] = ind2sub([s1 s2],1:s1*s2);

    for i = 1:s1*s2
        % if the pixel was classified as sky, we paint it
        if test_estimate(i) == 1
            test_image(xx(i),yy(i),:) = sky_color;
        end
    end
    figure('Name', ['sky_test' num2str(tt)]), imshow(test_image);
end