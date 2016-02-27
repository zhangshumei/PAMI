% 1. load all images

FILES = dir('Female');
sizes = size(FILES);
female_length = sizes(1) - 2;
for i = 3:female_length + 2
    name = FILES(i).name;
    IM = imread(strcat('Female/',name));
    IM = IM(:);
    X(:,i-2) = IM;
end
FILES = dir('Male');
sizes = size(FILES);
male_length = sizes(1) - 2;
total_length = male_length + female_length;
for i = 3:male_length + 2
    name = FILES(i).name;
    IM = imread(strcat('Male/',name));
    IM = IM(:);
    X(:,i -2 + female_length) = IM;
end
X = double(X);

% 2. do PCA
mean_r = mean(X'); % calculate the mean value for each row of X
mean_v = mean_r';
S = cov(X');
[V,D] = eig(S);

% 3. find top i PCs
diags = diag(D);
diags_desc = sort(diags, 'descend');
sum_d = sum(diags_desc);
cdf(1) = diags_desc(1) / sum_d;
for i=2:1024
    cdf(i) = cdf(i-1) + diags_desc(i) / sum_d;
    if cdf(i) > 0.95
        break;
    end
end

% 4. form PCA model W
nPC = i; % number of priciple components
W_d = V(:, (1024 - nPC + 1):1024); 
for j=1:nPC
    W(:,j) = W_d(:, nPC-j+1); % reverse order
end
W = W'; % rows are eigenvectors

% 5. project all the data points
MEAN = repmat(mean_v, 1, 99); % create matrix of repeated mean_v
A = X - MEAN;
Y = W * A; % projects image space

PF = Y(:, 1:female_length);
PM = Y(:, female_length+1:male_length + female_length);

% 6. compute Sw and Sb
MF = female_length;
MM = male_length;
MiuF = mean(PF')';
MiuM = mean(PM')';
Miu = mean(Y')';
K = 2;

x = PF(:,1);
t = x - MiuF;
Sw = t * t';
for i = 2:MF
    x = PF(:,i);
    t = x - MiuF;
    Sw = Sw + t * t';
end

for i = 1:MM
    x = PM(:,i);
    t = x - MiuM;
    Sw = Sw + t * t';
end

t = MiuF - Miu;
Sb = MF * t * t';
t = MiuM - Miu;
Sb = Sb + MM * t * t';

% 7. solve eigen-value problem
S = inv(Sw) * Sb;
[vLDA dLDA] = eigs(S,1); % TODO: find the non-zero eigenvector

% 8. compute discriminant slope and intercept
w = vLDA' * W;
b = vLDA' * (MiuF + MiuM) /2;

% 9. test
ERROR = [];
for i = 1:female_length
    y = X(:,i);
    result = w * (y - mean_v)-b;
    if result > 0
        ERROR = [ERROR,i];
    end
end
for i = female_length+1:total_length
    y = X(:,i);
    result = w * (y - mean_v) - b;
    if result < 0
        ERROR = [ERROR, i];
    end
end
    
% 10. display misclassified images
length = size(ERROR);
length = length(2);
colormap('gray');
for i = 1:length
    Image = X(:, ERROR(i));
    IM = reshape(Image, 32, 32);
    subplot(1, length, i);
    imagesc(IM);
end

