clc;
F1=100;
F2=25;
F3=150;
Fm=500; Tm=1/Fm;
N=8000;
n=0:Tm:(N-1)*Tm;
y=2*cos(2*pi*F1*n)+cos(2*pi*F2*n)-10*sin(2*pi*F3*n);
subplot(5,1,1),plot(n,y,'r');
title('Señal con Fm=500Hz');
xlabel('t(s)'), grid;
axis([0 0.2 -12 12]);
%============Transformada de Fourier============
Pf=fft(y)/N;
ModPf=abs(Pf);
df=Fm/N;%defino intervalo 
F=0:df:(N-1)*df;
subplot(5,1,2);
plot(F,ModPf,'b'); title('Señal en en frecuencia'); grid;%espectro de la señal
xlabel('f(Hz)');
axis([-2 250 0 6]);
%============FILTRO FIR============
FN1=80/(Fm/2);%frec. corte 80 y 130
FN2=130/(Fm/2);
B=fir1(50,[FN1 FN2]);
[H,f]=freqz(B,1,100,Fm);
A=filter(B,1,y);
Pf1=fft(A)/N;
ModPf1=abs(Pf1);

subplot(5,1,3),plot(n,A,'r');
axis([0 0.2 -12 12]);
subplot(5,1,4);plot(F,ModPf1,'b');
axis([-2 250 0 6]);
subplot(5,1,5), plot(f,abs(H));
