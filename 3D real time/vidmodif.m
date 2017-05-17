function realVideo()
 
NumberFrameDisplayPerSecond=10;             % Define la tasa de cuadros por segundo
 
hFigure=figure(1);                          % Abre la venta para mostar la camara
 
% Configuracion de la entrada de video de la webcam
try
   % Para Windows
   vid = videoinput('winvideo', 1);
catch
   try
      % Para Mac OS
      vid = videoinput('macvideo', 1);
   catch
      errordlg('No hay cámara web disponible. Por favor configurela.');
   end
end
 
% COnfiguracion de parametros de video

set(vid,'FramesPerTrigger',1);             % Adquiere solo un cuadro por tiempo
set(vid,'TriggerRepeat',Inf);              % Sigue infinito hasta que se detenga
set(vid,'ReturnedColorSpace','grayscale'); % Obtiene la imagen en escala a grises
triggerconfig(vid, 'Manual');              % Configura el disparo en modo "Manual" 
 
% Configura al objeto "Temporarizador"
TimerData=timer('TimerFcn', {@FrameRateDisplay,vid},'Period',1/NumberFrameDisplayPerSecond,'ExecutionMode','fixedRate','BusyMode','drop');
 
% Inicia los objetos: webcam y temporarizador
start(vid);
start(TimerData);
 
% Mantiene la ventana activa hasta que se cierre
uiwait(hFigure);
 
% Limpia los objetos
stop(TimerData);
delete(TimerData);
stop(vid);
delete(vid);

% Limpia las variables persistentes
clear functions;
 

% Esta funcion es llamada por el Temporarizador para mostrar un cuadro de
% la figura.

function FrameRateDisplay(obj, event,vid)
persistent IM;
persistent rojo;
persistent verde;
persistent azul;
persistent solo_rojo;
persistent solo_verde;
persistent solo_azul;
persistent blanco;
persistent handlesRaw;
persistent handlesRawRed;
persistent handlesRawGreen;
persistent handlesRawBlue;
trigger(vid);

IM=getdata(vid,1,'uint8');
rojo = IM(:,:,1);                                          % Canal rojo
verde = IM(:,:,2);                                         % Canal verde
azul = IM(:,:,3);                                          % Canal azul 
blanco = zeros(size(IM, 1), size(IM, 2));                  % Define a la matriz blanco

solo_rojo = cat(3, rojo, blanco, blanco);                   % Imagen/matriz del canal rojo 
solo_verde = cat(3, blanco, verde, blanco);                 % Imagen/matriz del canal verde
solo_azul = cat(3, blanco, blanco, azul);                   % Imagen/matriz del canal azul
 
if isempty(handlesRaw)
    
   % Si es la primera ejecucion, creamos la figura de los objetos
   
   subplot(2,2,1) 
   handlesRaw=imagesc(IM); title('Captura en vivo');
   subplot(2,2,2) 
   handlesRawRed=imagesc(rojo), title('Canal rojo')
   subplot(2,2,3) 
   handlesRawGreen=imagesc(verde), title('Canal verde')
   subplot(2,2,4) 
   handlesRawBlue=imagesc(azul), title('Canal azul')
   
else
    
   % Solo actualizamos lo que necesitamos
   set(handlesRaw,'CData',IM);
   set(handlesRawRed,'CData',rojo);
   set(handlesRawGreen,'CData',verde);
   set(handlesRawBlue,'CData',azul);
  
end



