function [output] = getHistogramVariation(features)
    output = zeros(size(features,1), 1);
    for i=1:size(features,1)
        tmp = features(i,:);
        output(i) = VarInformation(tmp,2);
    end
end

