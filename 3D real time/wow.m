%Programa para el desarrollo del experimento de reconstrucción en 3D
%para el analisis de franjas en tiempo real, para Didactron.
%Desarrollado por: Manuel Morgado 08-10779      
%Creación: 28/07/2014
%Ultima modificacion: 28/07/2014

%% MODULO DE COMUNICACION CON CAMARA Y ADQUISION DE IMAGEN


% Codigo desarrollado por programador anónimo publicado en la siguiente
% direccion http://www.matlabtips.com/realtime-processing/

functio realVideo()
 
% Define frame rate
NumberFrameDisplayPerSecond=10;
 
% Open figure
hFigure=figure(1);
 
% Set-up webcam video input
try
   % For windows
   vid = videoinput('winvideo', 1);
catch
   try
      % For macs.
      vid = videoinput('macvideo', 1);
   catch
      errordlg('No webcam available');
   end
end
 
% Set parameters for video
% Acquire only one frame each time
set(vid,'FramesPerTrigger',1);
% Go on forever until stopped
set(vid,'TriggerRepeat',Inf);
% Get a grayscale image
set(vid,'ReturnedColorSpace','grayscale');
triggerconfig(vid, 'Manual');
 
% set up timer object
TimerData=timer('TimerFcn', {@FrameRateDisplay,vid},'Period',1/NumberFrameDisplayPerSecond,'ExecutionMode','fixedRate','BusyMode','drop');
 
% Start video and timer object
start(vid);
start(TimerData);
 
% We go on until the figure is closed
uiwait(hFigure);
 
% Clean up everything
stop(TimerData);
delete(TimerData);
stop(vid);
delete(vid);
% clear persistent variables
clear functions;
 
% This function is called by the timer to display one frame of the figure
 
functio FrameRateDisplay(obj, event,vid)
persistent IM;
persistent handlesRaw;
persistent handlesPlot;
trigger(vid);
IM=getdata(vid,1,'uint8');
 
if isempty(handlesRaw)
   % if first execution, we create the figure objects
   subplot(2,1,1);
   handlesRaw=imagesc(IM);
   title('CurrentImage');
 
   % Plot first value
   Values=mean(IM(:));
   subplot(2,1,2);
   handlesPlot=plot(Values);
   title('Average of Frame');
   xlabel('Frame number');
   ylabel('Average value (au)');
else
   % We only update what is needed
   set(handlesRaw,'CData',IM);
   Value=mean(IM(:));
   OldValues=get(handlesPlot,'YData');
   set(handlesPlot,'YData',[OldValues Value]);
end



%close all;
%clc;

%vid=videoinput('winvideo',2);
%vid
%config=triggerconfig(vid);
%config


%preview(vid);
%set(vid,'FramesPerTrigger',500)
%start(vid); //

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

figure, imshow(img), title('Imagen Original')
figure, imshow(solo_rojo), title('Canal rojo')
figure, imshow(solo_verde), title('Canal verde')
figure, imshow(solo_azul), title('Canal azul')
figure, imshow(original_vuelta), title('Imagen Original de vuelta')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%   MODULO DE GENERADOR DE PATRON DE FRANJAS
       
f=0;                                                % Inicializa la frecuencia
tamano=1000;                                        % Define el tamano de la foto
densidad=1/10;                                      % Define la densidad de franjas
ancho=tamano;                                       % Define la forma de la imagen (cuadrado)
largo=tamano;                                       % Define la forma de la imagen (cuadrado)
R=zeros(ancho,largo);                               % Define a la matriz del patron 
G=zeros(ancho, largo);
B=zeros(ancho, largo);
W=zeros(ancho, largo);

f=input('¿Qué frecuencia de franjas? Nro: ');           % Define el número de franjas en el patron
fase_r=input('¿Qué fase de franjas? Nro: ');            % Define la fase de las franjas en el patron  
fase_g=input('¿Qué fase de franjas? Nro: ');            % Define la fase de las franjas en el patron 
fase_b=input('¿Qué fase de franjas? Nro: ');            % Define la fase de las franjas en el patron 
paso=1/tamano;                                          % Define el paso con el cual se generan los pixeles del patron
i = [0:paso: ancho];                                    % Define un contador

        for j=1:ancho
            for i=1:largo
                
                I_r = sind(((f*i)/3)+fase_r);           % Ciclo para generar patron
                R(j,i)= I_r;
               
                I_g = sind(((f*i)/3)+fase_g);           % Ciclo para generar patron
                G(j,i)= I_g;
                
                I_b = sind(((f*i)/3)+fase_b);           % Ciclo para generar patron
                B(j,i)= I_b;
            end
        end
        
patronR=cat(3, R, W, W);                                % Patron Rojo
patronG=cat(3, W, G, W);                                % Patron Verde
patronB=cat(3, W, W, B);                                % Patron Azul
PF=patronR+patronG+patronB;                             % Patron Unico RGB

figure; imshow(PF), title ('Patron RGB de Franjas')
xlabel ('Eje X'), ylabel ('Eje Y') 
saveas(gcf,'Patron.png')
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ULTIMA REVISION 31/07/2014

%%  MODULO DE ANALISIS DE PHASE SHIFFTING (PS)

I_1= imread('Ph1.png');                                                 % Lee imagen 1 de PS
%figure, imshow(I_1), title ('Imagen de intensidad 1')
 
I_2= imread('Ph2.png');                                                 % Lee imagen 2 de PS
%figure, imshow(I_2), title('Imagen de intensidad 2')
 
I_3= imread('Ph3.png');                                                 % Lee imagen 3 de PS
%figure, imshow(I_3), title('Imagen de intensidad 3')
 
I_1=mat2gray((I_1), [0 100000]);                                        % Imagen 1 en grises
I_2=mat2gray((I_2), [0 100000]);                                        % Imagen 2 en grises
I_3=mat2gray((I_3), [0 100000]);                                        % Imagen 3 en grises

%Prueba de envolver la fase con la matriz
%Ip=(I_1 + I_2 + I_3)/3;
%Ipp= (sqrt((3*((I_1 - I_3)^2)) + (((2*I_2) - I_1 - I_3)^2))/3);
%gamma= Ipp / Ip

 C=(sqrt(3)*( I_1 - I_3 ));                                             % Calculo de numerador de la tangente
 B=((2*I_2)- I_1 - I_3);                                                % Calculo de denominador de la tangente
 
 i=[1:0.001:480];                                                       % Define un contador
 j=[1:0.001:640];
 
 for i=1:480
     for j=1:640
         
         %Envolver la matriz elemento x elemento por ciclos anidados
         phi(i,j)= atan((((C(i,j))/(B(i,j)))));
         
         Ip=(I_1(i,j) + I_2(i,j) + I_3(i,j))/3;
         Ipp= (sqrt((3*((I_1(i,j) - I_3(i,j))^2)) + (((2*I_2(i,j)) - I_1(i,j) - I_3(i,j))^2))/3);
         
         ip(i,j)=(I_1(i,j) + I_2(i,j) + I_3(i,j))/3;
         ipp(i,j)= (sqrt((3*((I_1(i,j) - I_3(i,j))^2)) + (((2*I_2(i,j)) - I_1(i,j) - I_3(i,j))^2))/3);
         
         gamma(i,j)= Ipp / Ip;
         algo(i,j)=phi(i,j)+gamma(i,j);
         
         %pause(0.3)
     end
 end
 
iT=ip+ipp;

 
figure, imshow(mat2gray(im2double(gamma)))
figure(4);imshow(mat2gray(im2double(phi)), 'DisplayRange', [])         % Imagen de la fase envuelta
figura=imcrop(figure(4))
saveas(gcf,'wraped.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MODULO DE DESENVOLVIMIENTO DE FASE


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%