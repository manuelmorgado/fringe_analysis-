clc
clear
A=zeros(2000,2000);

i = [-20: 0.01: 20]; 
%I = sind(10*pi*i)

for j=1:2000
    for i=1:2000
        I = sind(10*pi*i);
    A(j,i)= I;
    end
end

imshow(A)
%xlim([0 2]); 
%ylim([-1 1]); 

xlabel ('Eje X') 

ylabel ('Eje Y') 


