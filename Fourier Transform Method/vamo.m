close all;
clear all;
clc
img = imread('vaso.bmp');   %importing pixel information
figure(1); imshow(img);

cimg = imcrop(img); %cropping the pixels
figure(2);ff=imshow(cimg);
set(ff,'AlphaData',0.3);
axis on, grid on;
close all;
imgred = cimg(:,:,1);        %just the red channel

imggrey = (mat2gray(im2double(cimg)));    %greyscale of the cropped image
%figure(3); imshow(imgred);

dred = double(imgred);
dgrey = double (imggrey);
%figure(4); mesh(dred);

imgfftred = fftshift(fft2(dred));
figure(5); surf(abs(imgfftred));
view(0,0);

shading interp;

imgfftgrey = fftshift(fft(dgrey));
Ishow= mat2gray(abs(double(imgfftgrey)));
figure(6); surf(abs(imgfftgrey));
colormap(jet),colorbar
figure(7);mesh(Ishow)
view(0,0);
shading interp;