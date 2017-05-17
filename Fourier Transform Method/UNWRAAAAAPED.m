%This program is to simulate a continuous phase distribution to act as a dataset
%for use in the 2D phase unwrapping problem
clc; close all; clear

%N = 512;
%[x,y]=meshgrid(1:N);
%image1 = 2*peaks(N) + 0.1*x + 0.01*y;
image1= imread('wrapeed.bmp');
figure(1), colormap(gray(256)), imagesc(image1)
title('Continuous phase image displayed as a visual intensity array')
xlabel('Pixels'), ylabel('Pixels')
figure(2);surf(image1,'FaceColor','interp', 'EdgeColor','none', 'FaceLighting','phong')
%view(-30,30), camlight left, axis tight
title(' Continuous phase map image displayed as a surface plot')
xlabel('Pixels'), ylabel('Pixels'), zlabel('Phase in radians')
figure(3);plot(image1(410,:,3))
title('Row 410 of the continuous phase image')
xlabel('Pixels'), ylabel('Phase in radians')



%wrap the 2D image
image1_wrapped = atan2(sin(image1), cos(image1));
figure(4); colormap(gray(256)), imagesc(image1_wrapped)
title('Wrapped phase image displayed as a visual intensity array')
xlabel('Pixels'), ylabel('Pixels')
figure(5);surf(image1_wrapped,'FaceColor','interp', 'EdgeColor','none', 'FaceLighting','phong')
view(-30,70), camlight left, axis tight
title('Wrapped phase image plotted as a surface')
xlabel('Pixels'), ylabel('Pixels'), zlabel('Phase in radians')
figure(6), plot(image1_wrapped(410,:))
title('Row 410 of the wrapped phase image')
xlabel('Pixels'), ylabel('Phase in radians')




