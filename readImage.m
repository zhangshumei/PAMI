function [ output_args ] = readImage( image_name, scale )
% Class exercise2
% read a color image, display color & gray images in one figure
IM = imread(image_name);
figure;
subplot(2,2,1);
imagesc(IM);
GIM = rgb2gray(IM);
colormap('gray');
subplot(2,2,2);
imagesc(GIM);

% display image statistics in the gigure
SIM = imresize(IM,scale);
IM = double(GIM);
meanIM = mean(IM);
stdIM = std(IM);
subplot(2,2,3);
plot(meanIM);
subplot(2,2,4);
plot(stdIM);

savefig('ImageFigure');

end

