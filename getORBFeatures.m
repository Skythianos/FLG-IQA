function [output] = getORBFeatures(I,filtered)

    if(size(I,3)==3)
        I = rgb2gray(I);
    end
    
    if(filtered)
        I = imgradient(I,'prewitt');
        I = mat2gray(I, [0 sqrt(765*765+765*765)]);
    end

    points = detectORBFeatures(I);
    if(size(points,1)<250)
        points = detectORBFeatures(I,'ScaleFactor',1.001);
    end
    if(size(points,1)==0)
        y1=0;
        y2=0;
        y3=0;
        y4=0;
        y5=0;
    else
        selected_points = points.selectStrongest(250);
        [features, ~] = extractFeatures(I, selected_points, 'Method', 'ORB');
    
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
       
    end
    
    output = [y1, y2, y3, y4, y5];

end


