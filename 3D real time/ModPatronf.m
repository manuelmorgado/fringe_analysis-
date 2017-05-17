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
RR= zeros(ancho, largo);
GG= zeros(ancho, largo);
BB= zeros(ancho, largo);
N= zeros(ancho, largo);

f=input('¿Qué frecuencia de franjas? Nro: ');                       % Define el número de franjas en el patron
fase_r=input('¿Qué fase de franjas para el rojo? Nro: ');           % Define la fase de las franjas en el patron  
fase_g=input('¿Qué fase de franjas para el azul? Nro: ');           % Define la fase de las franjas en el patron 
fase_b=input('¿Qué fase de franjas para el verde? Nro: ');          % Define la fase de las franjas en el patron 
paso=1/tamano;                                                      % Define el paso con el cual se generan los pixeles del patron
i = [0:paso: ancho];                                                % Define un contador

        for j=1:ancho
            for i=1:largo
                
                RR(j,i)=1;
                GG(j,i)=1;
                BB(j,i)=1;
                
                I_n= sind(((f*i)/3));                   % Ciclo para generar patron
                N(j,i)= I_n;
                
                I_r= sind(((f*i)/3)+fase_r);            % Ciclo para generar patron
                R(j,i)= I_r;
               
                I_g = sind(((f*i)/3)+fase_g);           % Ciclo para generar patron
                G(j,i)= I_g;
                
                I_b = sind(((f*i)/3)+fase_b);           % Ciclo para generar patron
                B(j,i)= I_b;
            end
        end
pRR=cat(3,RR, W, W);  
pGG=cat(3,W, GG, W);
pBB=cat(3,W, W, BB);

patronR=cat(3, R, W, W);
patronG=cat(3, W, G, W);
patronB=cat(3, W, W, B);

PF=patronR+patronG+patronB;
PN=cat(3,N,N,N);

sp1=PF + pRR;
sp2=PF + pGG;
sp3=PF + pBB;

SPF= sp1+ sp2+ sp3;

figure
subplot(4,3,1)
imshow(pRR)
subplot(4,3,2)
imshow(pGG)
subplot(4,3,3)
imshow(pBB)
subplot(4,3,4)
imshow(patronR)
subplot(4,3,5)
imshow(patronG)
subplot(4,3,6)
imshow(patronB)
subplot(4,3,7)
imshow(PF)
subplot(4,3,8)
imshow(PN)
subplot(4,3,9)
imshow(sp1)
subplot(4,3,10)
imshow(sp2)
subplot(4,3,11)
imshow(sp3)
subplot(4,3,12)
imshow(SPF)

%figure, imshow(mat2gray(A)), title('Patrón de Franjas')
%figure; imshow(PF), title ('Patron RGB de Franjas')
%xlabel ('Eje X'), ylabel ('Eje Y') 
%saveas(gcf,'Patron.png')
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
