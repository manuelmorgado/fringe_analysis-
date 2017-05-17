IFT=ifft(FT);
IFT2=ifft2(FT);
tamano=size(IFT)
filas=tamano(1,1);
columna=tamano(1,2);
size(IFT2)
f=[1:1:filas];
c=[1:1:columna];
imaginario=imag(IFT);
rea=real(IFT);
phi=zeros(filas,columna);
for c=1:columna
for f=1:filas
phi(f,c)=atan(imaginario(f,c)/rea(f,c));
end
end
figure;mesh(phi)
figure;imshow(phi)
figure;surf(phi)
figure;colormap(gray(256));
imagesc(phi)