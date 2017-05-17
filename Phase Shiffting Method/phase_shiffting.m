% Algoritmos para Phase Shifting

clear all;
close all;
clc

I_1= imread('Ph1.bmp');
 %figure(1); imshow(I_1)
 %title ('Imagen de intensidad 1')
 
I_2= imread('Ph2.bmp');
 %figure(2); imshow(I_2)
 %title('Imagen de intensidad 2')
 
I_3= imread('Ph3.bmp');
 %figure(3); imshow(I_3)
 %title('Imagen de intensidad 3')
 
I_1=mat2gray((I_1), [0 100000]); 
I_2=mat2gray((I_2), [0 100000]);
I_3=mat2gray((I_3), [0 100000]);


%Ip=(I_1 + I_2 + I_3)/3;
%Ipp= (sqrt((3*((I_1 - I_3)^2)) + (((2*I_2) - I_1 - I_3)^2))/3);
%gamma= Ipp / Ip

 A=(sqrt(3)*( I_1 - I_3 ));
 B=((2*I_2)- I_1 - I_3);
 
 i=[1:0.001:480];
 j=[1:0.001:640];
 
 for i=1:480
     for j=1:640
         phi(i,j)= atan((((A(i,j))/(B(i,j)))));
         
         Ip=(I_1(i,j) + I_2(i,j) + I_3(i,j))/3;
         Ipp= (sqrt((3*((I_1(i,j) - I_3(i,j))^2)) + (((2*I_2(i,j)) - I_1(i,j) - I_3(i,j))^2))/3);
         
         ip(i,j)=(I_1(i,j) + I_2(i,j) + I_3(i,j))/3;
         ipp(i,j)= (sqrt((3*((I_1(i,j) - I_3(i,j))^2)) + (((2*I_2(i,j)) - I_1(i,j) - I_3(i,j))^2))/3);
         
         gamma(i,j)= Ipp / Ip;
         chupa(i,j)=phi(i,j)+gamma(i,j);
         
         %pause(0.3)
     end
 end
 
iT=ip+ipp;

 
figure(102);imshow(mat2gray(im2double(gamma)))
figure(4);imshow(mat2gray(im2double(phi)), 'DisplayRange', [])
figura=imcrop(figure(4))
saveas(gcf,'wraped.png')
 
 
%Unwrap the imaage using the Itoh algorithm: the first method is performed
%by first sequentially unwrapping the all rows, one at a time.

%cut=imread('wraped.png');
%cut = imcrop(imshow(im2double(phi)));
%image1_unwrapped = cut(:,:);
%cutsize=size(cut);
%l=0;
%p=0;
%l=cutsize(1,1);
%p=cutsize(1,2);
%N=l;
%M=p;

image1_unwrapped = phi;
N=480;
M=640;

for i=1:N
image1_unwrapped(i,:) = unwrap(image1_unwrapped(i,:));
end
%Then sequentially unwrap all the columns one at a time
for i=1:M
image1_unwrapped(:,i) = unwrap(image1_unwrapped(:,i));
end

figure(5); colormap(gray(256)), imagesc(image1_unwrapped)
title('Unwrapped phase image using the Itoh algorithm: the first method')
xlabel('Pixels'), ylabel('Pixels')

figure(6);mesh(image1_unwrapped,'FaceColor','interp', 'EdgeColor','none', 'FaceLighting','phong')
view(-30,30), camlight left, axis tight
title('Unwrapped phase image using the Itoh algorithm: the first method')
xlabel('Pixels'), ylabel('Pixels'), zlabel('Phase in radians')