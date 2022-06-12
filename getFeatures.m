function [output] = getFeatures(img)

    output = [detectLocalStatisticalFeatures(img,false), detectLocalStatisticalFeatures(img,true),...
        feature_vec(edge(rgb2gray(img),'Sobel'))', getPerceptualFeatures(img), feature_extract(img)];

end

