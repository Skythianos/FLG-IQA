function [output] = getAbsEntropy(features)
    output = zeros(size(features,1), 1);
    for i=1:size(features,1)
        tmp = features(i,:);
        output(i) = abs(-sum(tmp.*log2(tmp)));
    end
end