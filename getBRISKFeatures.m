function [output] = getBRISKFeatures(I,filtered)

    if(size(I,3)==3)
        I = rgb2gray(I);
    end
    
    if(filtered)
        I = imgradient(I,'prewitt');
        I = mat2gray(I, [0 sqrt(765*765+765*765)]);
    end

    points = detectBRISKFeatures(I);
    if(size(points,1)<250)
        points = detectBRISKFeatures(I,'MinQuality',0,'MinContrast',0.001);
    end
    selected_points = points.selectStrongest(250);
    [features, ~] = extractFeatures(I, selected_points, 'Method', 'BRISK');
    
    features = double(features.Features);
    
    y1 = mean(mean(features,2));
    y2 = mean(median(features,2));
    y3 = mean(std(features,0,2));
    tmp = skewness(features,1,2);
    tmp2= isnan(tmp);
    tmp(tmp2)=1000;
    y4  = mean(tmp);
    tmp = kurtosis(features,1,2);
    tmp2= isnan(tmp);
    tmp(tmp2)=1000;
    y5  = mean(tmp);
        
    output = [y1, y2, y3, y4, y5];

end

