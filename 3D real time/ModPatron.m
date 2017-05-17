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

f=input('¿Qué frecuencia de franjas? Nro: ');       % Define el número de franjas en el patron
fase_r=input('¿Qué fase de franjas? Nro: ');          % Define la fase de las franjas en el patron  
fase_g=input('¿Qué fase de franjas? Nro: ');          % Define la fase de las franjas en el patron 
fase_b=input('¿Qué fase de franjas? Nro: ');          % Define la fase de las franjas en el patron 
paso=1/tamano;                                      % Define el paso con el cual se generan los pixeles del patron
i = [0:paso: ancho];                                % Define un contador

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
patronR=cat(3, R, W, W);
patronG=cat(3, W, G, W);
patronB=cat(3, W, W, B);
PF=patronR+patronG+patronB;
%figure, imshow(mat2gray(A)), title('Patrón de Franjas')
figure; imshow(PF), title ('Patron RGB de Franjas')
xlabel ('Eje X'), ylabel ('Eje Y') 
%saveas(gcf,'Patron.png')
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
