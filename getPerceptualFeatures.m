function [output] = getPerceptualFeatures(img)

    output = [blurMetric(img), getColorfulness(img), getChromaFeature(img),...
        getColorGradientFeatures(img), getDarkChannelFeature(img), getMichelsonContrast(img),...
        getRMSContrast(img), getGlobalContrastFactor(img), entropy(img)];

end

