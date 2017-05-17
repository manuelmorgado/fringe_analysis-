% Algoritmo para contar franjas 
%
% Si se tiene una imagen con las franajas en vertical obtendremos una
% gaussiana que nos permite ver las franjas. Por el contrario, si tenemos a
% las franjas verticales mediremos una gaussiana completa que mide la
% intensidad de la envolvente del espectro.
%
% Para evitar error de medición, se recomienda dejar las franjas
% proyectadas en la pared lo más verticales posibles. Utilizar programas de
% edición de imagen para eliminar el ruido de la imagen (desenfoque, brillo
% no uniforme de la imagen etc) así como también convertirla en una imagen
% de escala a grises o blanco y negro para aumentar la definición de las
% franjas.
% 
% Para seleccionar un área específica de la imagen, hay que activar la
% opción de imcrop(I) eliminando el signo %. Después de seleccionar el área
% se establece con el botón derecho "Crop Image"
% 
% Programa escrito por: Vicente Torres Zúñiga
% creacion: 20/dic/2009, última modificación: 17/feb/2010 
% Modificaciones a posteriori y mejora por: Manuel Morgado
% mejora: 22/mar/2014

%clear
%close all
%clc


I = imread('file.png'); % Cargando la imagen a analizar "___.jpg" (Fromatos probados BMP, PNG, JPG)
figure; imshow(I); title('Imagen original'); % Ventana de imagen original
I = imcrop(I); % Opción de selección de un área específica de la imagen
I=I(:,:,1);
J = mat2gray(im2double(I)); % Convierte los vectores de la imagen a color a  grises
format short % Brinda la data en números enteros

 a = sum(J);% Compila a los vectores J en una matriz
 a = a/max(a); % Normalización de datos
 figure; plot(a); title('Curva de la imagen seleccionada'); %Ventana del espectro de franjas Potencia Normalizada Vs Coordenada en Pixeles
 C = (max(a) -min(a))/(max(a) +min(a)); % contraste de las frajas, permite establecer al contraste como parámetro de control para disminuir el error
 
  contador = 0; % Inicia a la variable del contador de franjas

 % Toma a la matriz "a" previamente definida y compara todos los elementos
 % de la matriz con el promedio de ellos, de forma que los modifica de
 % manera de definir las franjas de forma binaria.
 
 %NOTA: el promedio es una buena primera aproximación, probar con el valor
 %RMS o según sea la capacidad de la cámara.
 
for n = 1:length(a) 
    if a(n) >= mean(a) % el promedio de a es el umbral.
       a(n) = 1;
    else a(n) = 0;
    end
end

% Comeienza el contador de franjas

  for n = 1:(length(a)-1) % Escanea al vector
      if a(n) == a(n+1) % Compara franja con la sigiente
      else contador = contador +1; % cuando dos numeros no son iguales, la transicion marca un 1 en el contador
      end
 end
         
 numero_de_franjas  =contador/2 % dividimos entre dos porque hace dos conteos en cada franja, cuando entra y cuando sale
L=640
Fs=640
 NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(a,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
%figure;plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
 
 