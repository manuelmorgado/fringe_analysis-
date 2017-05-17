% Codigo desarrollado por programador anónimo publicado en la siguiente
% direccion http://www.matlabtips.com/realtime-processing/
%% Original

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
persistent handlesRaw;
persistent handlesRawRed;
persistent handlesRawGreen;
persistent handlesRawBlue;
trigger(vid);
IM=getdata(vid,1,'uint8');
 
if isempty(handlesRaw)
    
   % Si es la primera ejecucion, creamos la figura de los objetos
   handlesRaw=image(IM); title('Captura en vivo');
 
   
   
else
    
   % Solo actualizamos lo que necesitamos
   set(handlesRaw,'CData',IM);
  
end




