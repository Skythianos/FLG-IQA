function [output] = detectLocalStatisticalFeatures(I,filtered)

    y1 = getBRISKFeatures(I,filtered); %ok
    y2 = getFASTFeatures(I,filtered);
    y3 = getHarrisFeatures(I,filtered);
    y4 = getKAZEFeatures(I,filtered);  %ok
    y5 = getMinEigenFeatures(I,filtered);
    y6 = getORBFeatures(I,filtered); %ok
    y7 = getSURFFeatures(I,filtered);%ok
    
    output = [y1, y2, y3, y4, y5, y6, y7];

end

