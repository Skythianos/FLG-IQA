function [C] = getMichelsonContrast(img)

    img = im2double(img);
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
    
    Cr = (max(R(:))-min(R(:))) / (max(R(:))+min(R(:)));
    Cg = (max(G(:))-min(G(:))) / (max(G(:))+min(G(:)));
    Cb = (max(B(:))-min(B(:))) / (max(B(:))+min(B(:)));

    C = Cr+Cg+Cb;
end

