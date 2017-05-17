close all;
clear all;
clc
i1 = imread('vaso.bmp');
I1=fft2(double(i1)); % Transformada
Ilog = log(abs(I1)); % Escala logarítmica
Ishow = mat2gray(fftshift((Ilog)));
% Centrar y reescalar
figure;imshow((abs(Ishow))) % Mostrarla como imagen
colormap(jet),colorbar
% Representar en color
figure;mesh(abs(Ishow))
% Representación en 3D