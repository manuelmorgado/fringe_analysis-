%% MODULO DE SEPARACION DE COLORES  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img = imread('filename.png');                               % Asigna la imagen a la variable img

rojo = img(:,:,1);                                          % Canal rojo
verde = img(:,:,2);                                         % Canal verde
azul = img(:,:,3);                                          % Canal azul 
blanco = zeros(size(img, 1), size(img, 2));                 % Define a la matriz blanco

solo_rojo = cat(3, rojo, blanco, blanco);                   % Imagen/matriz del canal rojo 
solo_verde = cat(3, blanco, verde, blanco);                 % Imagen/matriz del canal verde
solo_azul = cat(3, blanco, blanco, azul);                   % Imagen/matriz del canal azul

original_vuelta = cat(3, rojo, verde, azul);                % Imagen original    

figure
subplot(2,2,1) 
imshow(img), title('Imagen Original')
subplot(2,2,2) 
imshow(solo_rojo), title('Canal rojo')
subplot(2,2,3) 
imshow(solo_verde), title('Canal verde')
subplot(2,2,4) 
imshow(solo_azul), title('Canal azul')

figure, imshow(original_vuelta), title('Imagen Original de vuelta')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%