close all
clear
clc
img = imread('vaso.bmp');%Carga la imagen pelota con patron
 img2 = imread('30.bmp'); %Carga la imagen sola del patron
 fftP = fft2(img2);  %Obtiene la FFT2D del patron   
 fftp = fft2(img);   %Obtiene la FFT2D de la pelota
 fftT = (fftp - fftP);
 inv = ifft2(fftT);  %Obtiene la IFFT2D de la imagen
 inv2 = uint8(inv);  %COnvierte la data a 8-bits
 figure;imshow(img);title('Foto Original')
 figure;imshow(fftp);  title('Transformada de Fourier');     %Gráfica
% N = imagesize(1);
 %imagefft = fftshift(fft2(rgb2gray(image), 1,1));
figure; mesh(((fftp)));title('Transformada de Fourier en 3D');