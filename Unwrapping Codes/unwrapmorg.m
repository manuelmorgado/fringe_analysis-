clear all; close all; clc;
wrp=imread('wraped.png');
unw=zeros(174,228);
dif=zeros(1174,228);

for j=1:228
    for i=1:174
        dif(i,j)=wrp(i+1,j+1)-wrp(i,j);
        if dif>=0
            unw(i,j)=dif(i+1,j+1)+unw(i,j);
        else
            unw(i,j)=unw(i,j)-dif(i+1,j+1);
        end
    end
end
