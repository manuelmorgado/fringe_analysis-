%%% Universidad Simón Bolívar
%%% Laboratorio D
%%% Laboratorio Avanzado de Física II
%%% Práctica: Proyección y análisis de franjas para la medición y
%%% reconstrucción de piezas en 3D
%%% Profesor: Jesús Gonzalez
%%% Manuel Morgado. Carné: 08-10779

%%% Programa para automatización de la práctica
%%% Creado por: Manuel Morgado
%%% Fecha: 01/06/2014

%Este programa esta pensado para llevar a cabo la práctica en desarrollo de
%análisis de franjas, que le permitirá la creación y proyección de patrones
%de franjas, conteo de la franjas en dicho patrón para las técnicas de
%"Análisis de Fourier" y de "Cambio de Fase (Phase Shifting)".

%Limpieza de ventanas, variables y ventana de comando.

close all;
clear;
clc

%Código del programa

    
met=input('¿Qué método va a usar? [Análisis de Fourier (Presione "1") ; Phase Shifting (Presione "2") ; Salir (Presione otra tecla)] ');

if met==1

    %   Programa para Análisis de Fourier  

    %   Algoritmo para genera el patrón de franjas 
    
        f=0;
        tamano=1000;
        densidad=1/10;
        ancho=tamano;
        largo=tamano;
        A=zeros(ancho,largo);
        f=input('¿Qué frecuencia de franjas? Nro: ');
        fase=0;
        paso=1/tamano;
        i = [0:paso: ancho]; 

        for j=1:ancho
            for i=1:largo
                I = sind(((f*i)/3)+fase);
                A(j,i)= I;
            end
        end

        figure(1);imshow(mat2gray(A))
        title('Patrón de Franjas Para método de Fourier')
        saveas(gcf,'PatronF.png')
        xlabel ('Eje X') 
        ylabel ('Eje Y') 
    
    
    % Algoritmo para contar franjas 
    %
    % Si se tiene una imagen con las franjas en vertical obtendremos una
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
    % Programa de conteo de franjas escrito por: Vicente Torres Zúñiga
    % creacion: 20/dic/2009, última modificación: 17/feb/2010 
    % Modificaciones a posteriori y mejora por: Manuel Morgado
    % mejora: 22/mar/2014




    P = imread('PatronF.png'); % Cargando la imagen a analizar "___.jpg" (Fromatos probados PNG, JPG)
    figure(2); imshow(P); title('Imagen original'); % Ventana de imagen original
    P = imcrop(P); % Opción de selección de un área específica de la imagen

    J = rgb2gray(P); % Convierte los vectores de la imagen a color a  grises
    format short % Brinda la data en números enteros

    a = sum(J);% Compila a los vectores J en una matriz
    a = a/max(a); % Normalización de datos
 
    figure(3);plot(a); 
    %ylim([-1 1]); 
    title('Perfil de Intensidad'); %    Ventana del espectro de franjas Potencia Normalizada Vs Coordenada en Pixeles

    %C = (max(a) -min(a))/(max(a) +min(a)); % contraste de las frajas, permite establecer al contraste como parámetro de control para disminuir el error
 
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

    % Comienza el contador de franjas

    for n = 1:(length(a)-1) % Escanea al vector
        if a(n) == a(n+1) % Compara franja con la sigiente
        else contador = contador +1; % cuando dos numeros no son iguales, la transicion marca un 1 en el contador
        end
    end
  
    numero_de_franjas  =round(contador/2); % dividimos entre dos porque hace dos conteos en cada franja, cuando entra y cuando sale

    fprintf('El número de franjas es:'); disp(numero_de_franjas)

    condicion= numero_de_franjas / tamano;
    if condicion <= densidad;
        disp('Si funciona, ¡Que lindo!, que bello, que hermoso...')
    else
        disp('Prueba otra frecuencia, ¡bruto!')
    end

        %Graficación de la Transformada de Fourier del conteo de frecuencias de
        %las franjas
    
    L=640;
    Fs=640;

    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    Y = (fft(a,NFFT)/L);
    f = Fs/2*linspace(0,1,NFFT/2+1);

    % Plot single-sided amplitude spectrum.

    figure(4);plot(f,2*abs(Y(1:NFFT/2+1))) 
    title('Espectro de amplitud de frecuencias (Transformada de Fourier)')
    xlabel('Frecuencia (Hz)')
    ylabel('|Y(f)|')


    % Adquisición de imagen para análisis de Fourier

    P1=input('¿Quieres adquirir imagen? [Si (Presione "1") ; No (Presione "2")]: ');

    if P1==1

        close all
    
        figure(1);imshow(mat2gray(A))
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        title('Patrón de Franjas Para método de Fourier')
        xlabel ('Eje X') 
        ylabel ('Eje Y') 
    
        obj=videoinput('macvideo') 
        start(obj)
        %preview(obj);
     
        frame = getsnapshot(obj);
        grayframe=im2int16(frame);
        ph1=grayframe(:,:,1);
        figure(2);imshow(ph1)
        saveas(gcf,'PhF1.png');
        pause(4);
      
    else
     disp('Ok, Chao!')
    end
 

    % Envolvimiento de fase para Análisis de Fourier

    P2=input('¿Quieres envolver la fase por análisis de Fourier de la imagen? [Si (Presione "1") ; No (Presione "2")]: ');
    
    if P2==1
    
        img = imread('PhF1.png');   %importing pixel information
        figure(1); imshow(img);

        cimg = imcrop(img); %cropping the pixels
        figure(2);ff=imshow(cimg);
        set(ff,'AlphaData',0.3);
        axis on, grid on;
        imgred = cimg(:,:,1);        %just the red channel

        imggrey = (mat2gray(im2double(cimg)));    %greyscale of the cropped image
        figure(3); imshow(imgred);

        dred = double(imgred);
        dgrey = double (imggrey);
        figure(4); mesh(dred);
        
        imgfftred = fftshift(fft2(dred));
        figure(5); surf(abs(imgfftred));
        view(0,0);

        shading interp;

        imgfftgrey = fftshift(fft(dgrey));
        Ishow= mat2gray(abs(double(imgfftgrey)));
        figure(6); surf(abs(imgfftgrey));
        colormap(jet),colorbar
        figure(7);mesh(Ishow)
        view(0,0);
        shading interp;
        
        close all;
        figure(5); surf(abs(imgfftred));
        h = streamline(0,0);
        
        % Use ginput to select corner points of a rectangular
        % region by pointing and clicking the mouse twice
        fftselec= ginput(2); 

        % Get the x and y corner coordinates as integers
        sp(1) = min(floor(fftselec(1)), floor(fftselec(2))); %xmin
        sp(2) = min(floor(fftselec(3)), floor(fftselec(4))); %ymin
        sp(3) = max(ceil(fftselec(1)), ceil(fftselec(2)));   %xmax
        sp(4) = max(ceil(fftselec(3)), ceil(fftselec(4)));   %ymax

        % Index into the original image to create the new image
        MM = im(sp(2):sp(4), sp(1): sp(3),:);

        % Display the subsetted image with appropriate axis ratio
        figure(8); mesh(MM); axis image
        
    else
        disp('Ok,chao!')
    end    
    
       
    % Desenvolvimiento de fase para Análisis de Fourier
    
    P3=input('¿Quieres desenvolver la fase por análisis de Fourier de la imagen? [Si (Presione "1") ; No (Presione "2")]: ');
    if P3==1

        close all;
    
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
        N=900;
        M=1200;

        for i=1:N
          image1_unwrapped(i,:) = unwrap(image1_unwrapped(i,:));
     end
    
        % Then sequentially unwrap all the columns one at a time
    
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

    else
        disp('Ok, Chao!')
    end




elseif met==2

    % Programa para Phase Shifting

    clear all;
    close all;

    % Algoritmo para genera el patron de franjas con phase shifting

        f=0;
        f=input('¿Qué frecuencia de franjas? Nro: ');
        tamano=1000;
        densidad=1/10;
        ancho=tamano;
        largo=tamano;
        A=zeros(ancho,largo);
        B=zeros(ancho,largo);
        C=zeros(ancho,largo);
        fase0=0;
        fase=input('¿Qué fase en grados desea entre los 3 patrones? ');
        paso=1/tamano;
    
        i = [0:paso: ancho]; 
    
        for j=1:ancho
            for i=1:largo
                I1 = sind(((f*i)/3)+fase); I2 = sind(((f*i)/3)+fase0); I3 = sind(((f*i)/3)-fase);
                A(j,i)= I1; B(j,i)= I2; C(j,i)= I3;
            end
        end

    
        P1=input('¿Desea: Solo producir Patrones (Presione "1") ; Adquirir Imagen (Presione "2"); Salir (Presione otra tecla): ');
    
            if P1==1
    
            figure(1);imshow(mat2gray(A))
            title('Patrón de Franjas I1')
            saveas(gcf,'PatronI1.png')
            xlabel ('Eje X') 
            ylabel ('Eje Y') 
    
    
            figure(2);imshow(mat2gray(B))
            title('Patrón de Franjas I2')
            saveas(gcf,'PatronI2.png')
            xlabel ('Eje X') 
            ylabel ('Eje Y') 

            figure(3);imshow(mat2gray(C))
            title('Patrón de Franjas I3')
            saveas(gcf,'PatronI3.png')
            xlabel ('Eje X') 
            ylabel ('Eje Y') 
        
            elseif P1==2
         
            obj=videoinput('macvideo') 
            start(obj)
            %preview(obj);
        
        
            figure(1);imshow(mat2gray(A))
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            title('Patrón de Franjas I1')
            saveas(gcf,'PatronI1.png')
            xlabel ('Eje X') 
            ylabel ('Eje Y') 
            frame = getsnapshot(obj);
            grayframe=im2int16(frame);
            ph1=grayframe(:,:,1);
            figure(2);imshow(ph1)
            saveas(gcf,'Ph1.png');
            pause(4);
    
    
            figure(3);imshow(mat2gray(B))
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            title('Patrón de Franjas I2')
            saveas(gcf,'PatronI2.png')
            xlabel ('Eje X') 
            ylabel ('Eje Y') 
            frame = getsnapshot(obj);
            grayframe=im2int16(frame);
            ph2=grayframe(:,:,1);
            figure(4);imshow(ph2)
            saveas(gcf,'Ph2.png');
            pause(4);

            figure(5);imshow(mat2gray(C))
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            title('Patrón de Franjas I3')
            saveas(gcf,'PatronI3.png')
            xlabel ('Eje X') 
            ylabel ('Eje Y') 
            frame = getsnapshot(obj);
            grayframe=im2int16(frame);
            ph3=grayframe(:,:,1);
            figure(6);imshow(ph3)
            saveas(gcf,'Ph3.png')
            pause(4);
        
            stop(obj)
        
         
            % Algoritmos para envolver fase por Phase Shifting
        
            P2=input('¿Desea encontrar la imagen de desenvolvimiento de fase? [Si (Presione "1") ; No (Presione "2")]: ');
       
                if P2==1
            
                    I_1= imread('Ph1.png');
                    figure(7); imshow(I_1)
                    title ('Imagen de intensidad 1')
 
                    I_2= imread('Ph2.png');
                    figure(8); imshow(I_2)
                    title('Imagen de intensidad 2')
 
                    I_3= imread('Ph3.png');
                    figure(9); imshow(I_3)
                    title('Imagen de intensidad 3')
 
                    I_1=mat2gray((I_1), [0 100000]); 
                    I_2=mat2gray((I_2), [0 100000]);
                    I_3=mat2gray((I_3), [0 100000]);

                    F=(sqrt(3)*( I_1 - I_3 ));
                    G=((2*I_2)- I_1 - I_3);
 
                    K=[1:0.001:900];
                    M=[1:0.001:1200];
 
                    for K=1:900
                        for M=1:1200
                            phi(K,M)= atan((((F(K,M))/(G(K,M)))));
                            %pause(0.3)
                        end
                    end

                    figure(10);imshow(im2double(phi), 'DisplayRange', [])

                    saveas(gcf,'wraped.png')
                else
                    disp('OK, chao!')
                end 
            
            
            else
            
            disp('OK, chao!')
        
            end
        
            % Desenvolvimiento de fase para Phase Shifting

            P3=input('¿Quieres desenvolver la fase por análisis de Fourier de la imagen? [Si (Presione "1") ; No (Presione "2")]: ');

            if P2==1

    
            % Unwrap the imaage using the Itoh algorithm: the first method is performed
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
            N=900;
            M=1200;

            for i=1:N
                image1_unwrapped(i,:) = unwrap(image1_unwrapped(i,:));
            end
    
            % Then sequentially unwrap all the columns one at a time
    
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
            
            else
               disp('Ok, Chao!')
            end

else 
    
    disp('Chao!')
    pause(2)
    
end


