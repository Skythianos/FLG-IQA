function [feat] = getColorGradientFeatures(img)

    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
    
    [GmagR, ~] = imgradient(R,'sobel');
    [GmagG, ~] = imgradient(G,'sobel');
    [GmagB, ~] = imgradient(B,'sobel');

    GmagC = GmagR + GmagG + GmagB;
    
    mu = mean(GmagC(:));
    sd = std(GmagC(:));
    
    feat = [mu,sd];
end

