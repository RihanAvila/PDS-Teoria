% imaqhwinfo('winvideo',1)

%ARCHIVO PARA CONFIGURAR CAMARA EN MATLAB
imaqhwinfo
disp('Pausa para inicializar camara');
pause;
%Encender la c�mara y adquirir im�genes
vid = videoinput('winvideo',1,'MJPG_1280x720');%depende de tu camara
start(vid);
disp('Pausa para visualizar imagen');
pause;
%Mostrar lo que se esta visualizando por la c�mara
preview(vid);
%Para tomar una imagen
disp('Pausa para capturar imagen');
pause;
img = getsnapshot(vid);
%Para apagar la c�mara
disp('Pausa para apagar');
pause;
closepreview(vid);
Para ver la imagen:(ventanas de comandos)
% <<imshow(img)
