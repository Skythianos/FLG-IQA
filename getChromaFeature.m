function [mu] = getChromaFeature(img)

    lab = rgb2lab(img);
    a = lab(:,:,2);
    b = lab(:,:,3);
    
    chroma = sqrt(a.*a+b.*b);

    mu = mean(chroma(:));
end

