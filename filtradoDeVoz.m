close all;
recObj = audiorecorder; %SE CREA EL OBJETO recObj
pause(5);
disp('Start speaking.')% Indica inicio de grabaci�n
recordblocking(recObj, 8); %Se ejecuta la grabaci�n por 5 segundos
disp('End of Recording.'); %Indica fin de la grabaci�n
pause(5);
% Play back the recording.
play(recObj); % Se reproduce la grabaci�n

% Store data in double-precision array.
myRecording = getaudiodata(recObj);% recObj se traduce en una variable
x=myRecording;
% Plot the waveform.
% plot(myRecording); % Se gr�fica la grabaci�n mediante my Recording
N=length(x);
k=0:N-1;
subplot(5,1,1),plot(k*1/8000,x);% Gr�fica de la se�al
title('Se�al de entrada');
%=======================================================
X=abs(fft(x));

hertz=k.*(8000/N);
subplot(5,1,2),plot(hertz(1:N/2),X(1:N/2));
title('Espectro de frecuencia de la se�al de entrada');
xlabel('Hertz');
%=========================================
[B,A]= butter(12,1500/(8000/2),'high'); % CALCULANDO LOS COEFICIENTES
y=filter(B,A,x);
subplot(5,1,3),plot(k*1/8000,y);
title('Se�al de salida');
%==========================================
Y=abs(fft(y));
% N=lenght(y);
% k=0:N-1;
% hertz=k.*(8000/N);
subplot(5,1,4),plot(hertz(1:N/2),Y(1:N/2));
title('Espectro de frecuencia de la se�al de salida');
xlabel('Hertz');
%===========================================
[H,f]=freqz(B,A,N/2,8000);
subplot(5,1,5),plot(f,abs(H));
title('Respuesta en frecuencia del filtro');
pause(5);
player=audioplayer(y,8000);
play(player);
