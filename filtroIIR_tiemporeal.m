%PROGRAMA DE GRAFICACIÓN DE UNA SEÑAL EN TIEMPO REAL
recObj = audiorecorder(44100, 16, 1); %ESTEREO, FS=44100HZ b=16bits
get(recObj);% velocidad de muestreo = 44100 muestras/seg.
%==========================================================
%recObj = audiorecorder; %SE CREA EL OBJETO recObj fs=8000 Hz
%=========================================================
Fs=44100;
fc=2500;
p=6;
fN=fc/(Fs/2);
rs=0.001;
Rs=-20*log10(rs);
%Diseñando el filtro digital pasa bajo IIR Cheby2
% [B,A]=cheby2(p,Rs,fN,'high');
%-----------------
fc1=2000;
fc2=3000;
fN1=fc1/(Fs/2);
fN2=fc2/(Fs/2);
Wn=[fN1,fN2];
[B,A]=cheby2(p,Rs,Wn);
 %=================================================bs
 [H,F]=freqz(B,A,100,Fs);
 subplot(5,1,5),plot(F,abs(H));
 title('Respuesta en frecuencia del Filtro Pasa bajo');
%=========================================================
for x=1:100 % fs= 44100 muestras/s     
    
    recordblocking(recObj, 1/44.1);%Indirectamente calculamos el Numero de samples
    y = getaudiodata(recObj);
    N=length(y);

    Y=abs(fft(y));
    k=0:N-1;
    h=k*(44100/1000);% k* fs/N
   
    subplot(5,1,1),plot(k*1/44100,y);
    title('Graficacion de una señal');
    xlabel('Segundos');
    grid;
    
    subplot(5,1,2),plot(h(1:N/2),Y(1:N/2))
    title('Espectro de frecuencia');
    xlabel('Frecuencia en Hz');
    ylabel('|y(f)| w/hertz');
    grid;
    %=============================================
    yy=filter(B,A,y);
    subplot(5,1,3),plot(k*1/Fs,yy);
    title('Señal de salida graficada');
    %=============================================
    YY=abs(fft(yy));
    h=k*(44100/1000);% k* fs/N
    subplot(5,1,4),plot(h(1:N/2),YY(1:N/2))
    title('Espectro de frecuencia de la señal de salida');
   
        
%   pause(0.01);
end


