% Mean Shift

function [RESULT] = ImageSegmentation()
    directory = '/Users/jied/Documents/MATLAB/MeanShift/Segmentation_Data/GrayImage';
    Files = dir(directory);
    sizes = size(Files);
    length = sizes(1);
    for i = 3:length
        image_name = FILES(i).name;
        IM = imread(strcat(directory, '/', image_name));
        MeanShift(IM);
    end
end



