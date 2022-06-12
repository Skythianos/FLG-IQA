function [RO, GM, RM, GL1, GL2, GL3] = FGr(im)
% compute the RO RM and GM map
%   Detailed explanation goes here

im = double(im);

sigma = 0.5;
[im_Dx,im_Dy] = gaussian_derivative(im,sigma);% compute the basic gradient maps in the horizontal x and vertical y directions

GL1 = fgl_deriv_maxtrix_norm(0.3, im, 80);
GL2 = fgl_deriv_maxtrix_norm(0.6, im, 80);
GL3 = fgl_deriv_maxtrix_norm(0.9, im, 80);

aveKernel = fspecial('average', 3);
eim_Dx = conv2(im_Dx, aveKernel,'same');
eim_Dy = conv2(im_Dy, aveKernel,'same');% compute the average directional derivative

im_D=atan(eim_Dx./(eim_Dy));
im_D(eim_Dy==0)=pi/2;

RO=atan(im_Dx./(im_Dy));
RO(im_Dy==0)=pi/2;
RO=RO-im_D; % compute RO

GM=sqrt(im_Dx.^2+im_Dy.^2); % compute GM

RM=sqrt((im_Dx-eim_Dx).^2+(im_Dy-eim_Dy).^2); %compute RM

end


function [gx,gy] = gaussian_derivative(imd,sigma) % comput the gaussian derivative
window1 = fspecial('gaussian',2*ceil(3*sigma)+1+2, sigma);
winx = window1(2:end-1,2:end-1)-window1(2:end-1,3:end);winx = winx/sum(abs(winx(:)));
% winy = window1(2:end-1,2:end-1)-window1(3:end,2:end-1);winy = winy/sum(abs(winy(:)));
winy=winx';
gx = filter2(winx,imd,'valid');
gy = filter2(winy,imd,'valid');
end

function DM = fgl_deriv_maxtrix_norm( a, Y, h )
%%     'horizon'
        [m,n]  = size(Y);
        J  = 0:(n-1);
        G1 = gamma( J+1 );
        G2 = gamma( a+1-J );
        s  = (-1) .^ J;
        M  = tril( ones(n) );
        T  = meshgrid( (gamma(a+1)/(h^a)) * s ./ (G1.*G2) );
        tt1=(gamma(a+1)/(h^a)) * s ./ (G1.*G2);
        for row=1:m
            R  = toeplitz( Y(row,:)' );
            Dx(row,:) = reshape(sum( R .* M .* T, 2 ), [1,n]);
        end
%%  vertical
        Y=Y';
        [m,n]  = size(Y);
        J  = 0:(n-1);
        G1 = gamma( J+1 );
        G2 = gamma( a+1-J );
        s  = (-1) .^ J;
        M  = tril( ones(n) );
        T  = meshgrid( (gamma(a+1)/(h^a)) * s ./ (G1.*G2) );
        tt2=(gamma(a+1)/(h^a)) * s ./ (G1.*G2);
        
        for row=1:m
            R  = toeplitz( Y(row,:)' );
            Dy(row,:) = reshape(sum( R .* M .* T, 2 ), [1,n]);
        end
        Dy=Dy';
        
        DM=sqrt(Dx.^2+Dy.^2);
end
