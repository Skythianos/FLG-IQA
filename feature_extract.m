function f= feature_extract(im)

    if(size(im,3)==3)
        im=rgb2gray(im);
    end

    [RO, GM, RM, GL1, GL2, GL3]=FGr(im);% compute the RO RM and GM map
    
    g1 = VarInformation(GL1, 2);
    
    g2 = VarInformation(GL2, 2);
    
    g3 = VarInformation(GL3, 2);

    f1=VarInformation(GM, 2);% compute the statistics variance of GM

    f2=VarInformation(RO, 1);% compute the statistics variance of RO
    
    f3=VarInformation(RM, 2);% compute the statistics variance of RM

    f=[g1, g2, g3, f1, f2, f3];
end