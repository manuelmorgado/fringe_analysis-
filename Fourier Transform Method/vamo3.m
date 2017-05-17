close all;
clear all;
clc

imagO=imread('vaso.bmp');
imagO= imagO(1:383,1:640,1);
imagfil = imagO(:,:,1);

fft2D= fftshift(fft2(double(imagfil),100,100));

grisfft2D=fftshift(fft2(mat2gray(imagO)));

grafft= (abs((((fft2D)))));

figure;mesh(((grafft)));colormap(jet),colorbar
figure;imshow(grisfft2D)
