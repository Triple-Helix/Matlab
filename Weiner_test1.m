cam = im2double(imread('cameraman.tif'));

figure (1)
imshow(cam)
colormap(gray(256))
title('cameraman')

cf = abs(fft2(cam)).^2;
figure(2);
surf([-127:128]/128,[-127:128]/128,log(fftshift(cf)+1e-6))
shading interp, colormap gray
title('cameraman power spectrum')

h = fspecial('disk',4);
cam_blur = imfilter(cam,h,'circular');
% 40 dB PSNR
sigma_u = 10^(-40/20)*abs(1-0);
cam_blur_noise = cam_blur + sigma_u*randn(size(cam_blur));
cam_wnr = deconvwnr(cam_blur_noise,h,numel(cam)*sigma_u^2./cf);
figure(3)
subplot(1,1,1)
imshow(cam_wnr)
colormap(gray(256))
title('restored image with exact spectrum');