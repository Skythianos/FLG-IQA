function [C] = getRMSContrast(img)

    if(size(img,3)==3)
        img = rgb2gray(img);
    end
    
    img = im2double(img);
    
    avg = mean(img(:));
    img = img(:);
    N   = size(img,1);
    
    sum = 0;
    for i=1:N
        sum = sum + (img(i)-avg)*(img(i)-avg);
    end

    C = sqrt(sum/N);
end

