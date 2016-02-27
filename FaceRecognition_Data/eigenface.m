pictures = dir('ALL');
n = size(pictures);
n = n(1)-2;

im = cell(n);
X = zeros(1024,n);

for i=3:n+2
    if(strcmp(pictures(i).name,'.') || strcmp(pictures(i).name,'..'))
        continue
    end
    name = pictures(i).name;
    im{i-2} = imread(name);
    X(:,i-2) = im{i-2}(:);
end

X_mean = zeros(1024,1);

for i=1:n
    for j=1:1024
        X_mean(j) = X_mean(j) + X(j,i);
    end
end

X_mean = X_mean/n;

averageface = reshape(X_mean, 32, 32);

imagesc(averageface);
colormap('Gray');

X_cov = cov(X');

[V, D] = eig(X_cov);

d =diag(D);
reversed_V = zeros(35,35);

test = reshape(V(:,1024), 32, 32);
imagesc(test)

%for i=35:-1:1
%    reversed_V(:,36-i) = V(:,i);
%end

reversed_V;