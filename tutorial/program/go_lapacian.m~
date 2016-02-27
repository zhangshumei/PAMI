function go_lapacian()
    %% load image
    img  = imread('../data/face.bmp','bmp');
    figure;
    image(img);
    title('full picture plot');

    %% view individual frames
    
    figure;
    imagesc(img(:,:,1));
    title('frame1');
    
    figure;
    imagesc(img(:,:,2));
    title('frame2');
    
    
    figure;
    imagesc(img(:,:,3));
    title('frame3');
    
    %% convert to grayscale image
    I = .2989*img(:,:,1)...
     +.5870*img(:,:,2)...
     +.1140*img(:,:,3);

    min(I(:));
    max(I(:));
    
    %% cast to double and output
    I = cast(I,'double');
    
    figure; colormap(gray(256)); image(I);


    %% create laplacian filter

    laplacian = [0 -1 0; -1 4 -1; 0 -1 0];
    I_filter = conv2(I,laplacian,'same');
     
    %% subtract    
    
    figure;
    colormap(gray(256));
    imagesc(I_filter);
    %% subtract out filter

    sharp = I - I_filter;
    figure;
    colormap(gray(256));
    imagesc(sharp);
end

