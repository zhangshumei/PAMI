% PCA & Eigenfaces

% 1. load all images from All directory
%    store each image as a column vector in matrix X
FILES = dir('ALL');
sizes = size(FILES);
length = sizes(1);
for i = 3:length
    name = FILES(i).name;
    IM = imread(strcat('ALL/',name));
    IM = IM(:);
    X(:,i - 2) = IM;
end
X = double(X);     % convert X to double

% 2. get the average face
mean_r = mean(X'); % calculate the mean value for each row of X
mean_v = mean_r';
colormap('gray');
Image = reshape(mean_v, 32, 32);
imagesc(Image);
title('Average Face', 'fontsize',18); % thanks to Justina Cotter

% no need to remove mean since Matlab cov() removes it for you
% MEAN = repmat(mean_v, 1, 35); % create matrix of repeated mean_v
% A = X - MEAN;
% C = A * A';

% 3. calculate eigenfaces
%    note that using eig(), the eigen values are sorted in ascending order
S = cov(X');
[V,D] = eig(S);
d = diag(D);

% get the cumulative distribution of eigen values
sum_d = sum(d);
cdf(1) = d(1) / sum_d;
for i=2:1024
    cdf(i) = cdf(i-1) + d(i) / sum_d;
end

% 4. form face space, choose k according to the distribution
%    sort eigenvectors in decreasing order of corresponding eigen values
indices = find(cdf > 0.05);
sizes = size(indices);
k = sizes(2);
W_d = V(:, (1024 - k + 1):1024); 
for i=1:k
    W(:,i) = W_d(:, k-i+1); % reverse order
end

% 5. create the learning space C (face db)
FILES = dir('FA');
sizes = size(FILES);
length = sizes(1);
for i = 3:length
    name = FILES(i).name;
    IM = imread(strcat('FA/',name));
    IM = double(IM(:));
    C(:,i - 2) = W'*(IM-mean_v);
end

% 5. test
%    load all test images, randomly choose 3 images and display the best
%    match image.
FILES = dir('FB');
sizes = size(FILES);
length = sizes(1);
for i = 3:length 
    name = FILES(i).name;
    IM = imread(strcat('FB/',name));
    IM = double(IM(:));
    T(:,i - 2) = IM;
end

% test 3 random images and print the result
times = 3; 
randoms = [11, 13, 23]; % choose three image 
figure;
colormap('gray');
for index=1:times
    random_index = randoms(index);    
    Image = T(:,random_index);
    IM = reshape(Image, 32, 32);
    subplot(times,4,(index-1)*4+1);
    imagesc(IM);
    t = W' * (Image - mean_v);
    for i=1:12
        ed(i) = norm(t-C(:,i)); % calculate the euclidean distance
    end
    min_index = find(ed==min(ed));
    [B,I] = sort(ed);
    for j=1:3
        Image = T(:,I(j));
        IM = reshape(Image, 32, 32);
        subplot(times,4,(index-1)*4+j+1);
        imagesc(IM);
    end
end






