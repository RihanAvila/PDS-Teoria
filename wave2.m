
function haar_wt(image_name,delta) 
% 'image_name' es el nombre de la imagen de color gris con la extensi�n de archivo
% 'delta' debe ser un valor entre 0 y 1
% El valor del 'delta' es una medida de la relaci�n de compresi�n
% cuando el valor 'delta' es alto, la compresi�n ser� alta

image_name='chicasfiee.jpeg';  % imagen en formato .jpeg asignado a una variable.
delta=input('Ingrese el valor de relacion de compresion (debe ser un valor entre 0 y 1):  ');% Medida de la relacion de la compresion

figure;
imshow(image_name);
title('IMAGEN ORIGINAL'); 512*512
% Verifique el n�mero de entradas.
if nargin > 2 %Devuelve el numero de argumentos de entrada de la funcion
    error('harr_wt:TooManyInputs', ...
        'maximo 2 entradas en la variable');
end
%Si no se asigna valor a delta por defecto este valor es asignado en 0.01
if (nargin==1)
    delta=0.01;
end
if (delta>1 || delta<0)
    error('Delta debe ser un valor entre 0 y 1');
end
%H1, H2, H3 son las matrices de las transformadas de wavelet de Haar

H1=[0.5 0 0 0 0.5 0 0 0;0.5 0 0 0 -0.5 0 0 0;0 0.5 0 0 0 0.5 0 0 ;0 0.5 0 0 0 -0.5 0 0 ;0 0 0.5 0 0 0 0.5 0;0 0 0.5 0 0 0 -0.5 0;0 0 0 0.5 0 0 0 0.5;0 0 0 0.5 0 0 0 -0.5;];
H2=[0.5 0 0.5 0 0 0 0 0;0.5 0 -0.5 0 0 0 0 0;0 0.5 0 0.5 0 0 0 0;0 0.5 0 -0.5 0 0 0 0;0 0 0 0 1 0 0 0;0 0 0 0 0 1 0 0;0 0 0 0 0 0 1 0;0 0 0 0 0 0 0 1;];
H3=[0.5 0.5 0 0 0 0 0 0;0.5 -0.5 0 0 0 0 0 0;0 0 1 0 0 0 0 0;0 0 0 1 0 0 0 0;0 0 0 0 1 0 0 0;0 0 0 0 0 1 0 0;0 0 0 0 0 0 1 0;0 0 0 0 0 0 0 1;];

% Normalizacion de cada matriz H1, H2, H3  (Esto da como resultado columnas ortonormales de cada matriz)
H1=normc(H1);
H2=normc(H2);
H3=normc(H3);
H=H1*H2*H3; %Multiplicacion de matrices ortogonales resultantes
%***************************************************************************
x=double(imread(image_name));%double usa 8 Bytes %imread lee la imagen del archivo especificado por filename, infiriendo el formato del archivo a partir de su contenido. 
len=length(size(x)); % length(X) devuelve la longitud de la dimensi�n de matriz m�s grande en X. %size(A) devuelve un vector de fila cuyos elementos contienen la longitud de la dimensi�n correspondiente de A. Por ejemplo, si A es una matriz de 3 por 4, size(A) devuelve el vector [3 4]
if len~=2
    error('harr_wt: La imagen ingresada debe estar en escala de grises y/o la matriz no es simetrica');
end
y=zeros(size(x));
[r,c]=size(x);
%Por encima de la matriz de transformaci�n 8x8 (H) se multiplica por cada bloque de 8x8 en la imagen
for i=0:8:r-8
    for j=0:8:c-8
        p=i+1;
        q=j+1;
        y(p:p+7,q:q+7)=(H')*x(p:p+7,q:q+7)*H;   %Ahora que la matriz de ceros ya esta formada se puede asignar un valor a cada una de las posiciones
    end
end

n1=nnz(y);             % N�mero de elementos distintos de cero en 'y'
z=y;
m=max(max(y));         % M = max(y) devuelve los elementos m�ximos de un array.
y=y/m;                 % Se reducen los valores haciendo que el maximo valor sea 1 
y(abs(y)<delta)=0;     % Los valores dentro de + delta y -delta en 'y' se reemplazan por ceros (este es el comando que produce compresi�n)
y=y*m;                 % Devolvemos los valores originales a y 
n2=nnz(y);             % N�mero de elementos distintos de cero en actualizado 'y'
%DWT inversa de la imagen
for i=0:8:r-8
    for j=0:8:c-8
        p=i+1;
        q=j+1;
        z(p:p+7,q:q+7)=H*y(p:p+7,q:q+7)*H';   %Descompresion
    end
end
figure;
imshow(z/255);                          % Muestra la imagen descomprimida
imwrite(x/255,'orginal.tif')           %Guarda para observar la diferencia de tama�o de las dos im�genes para ver la compresi�n
imwrite(z/255,'compressed.tif')
% Below value is a measure of compression ratio, not the exact ratio
%compression_ratio=n1/n2
title('IMAGEN COMPRIMIDA CON PERDIDAS')
figure;                     %figure crea una nueva ventana de figura mediante valores de propiedades predeterminados. La figura resultante es la figura actual.
imshow(x/255);              % muestra la imagen en escala de grises en una figura. utiliza el rango de visualizaci�n predeterminado para el tipo de datos de imagen 
% El porcentaje de compresi�n depende del valor delta que seleccione
% Mayor el valor 'delta', la relaci�n de compresi�n ser� mayor
title('IMAGEN DESCOMPRIMIDA')
