clear all
clc

%	Analogic to Digital Converter (ADC)
%	Conversor Analogico Digital

A=4; %Amplitud de +/- 4V
f0=input('Ingrese la frecuencia: '); %Frecuency
p=input('Ingrese la fase: ');	%Phase
n=input('Ingrese el número de muestras por periodo: ');	%Sampling

T=1/f0; %Periodo
Tm=T/n;%Tiempo de muestra

fprintf('\nNo    T(s)      V      Bin  \n')

valorBin=[];
valorDig=[];
Tiempo=[];

for x=1:1:n
	t=Tm*x;
    Y=A*sin(2*pi*f0*t+p);
    y=abs(Y);
    
    if y>=0 && y<(A/(7*2))
    	vd = 0;
        vb = dec2bin(0,3);
        
    elseif y>=(A/(7*2)) && y<(3*A/(7*2))
    	vd = 1;
        vb = dec2bin(1,3);
        
    elseif y>=(3*A/(7*2)) && y<(5*A/(7*2))
    	vd = 2;
        vb = dec2bin(2,3);
        
    elseif y>=(5*A/(7*2)) && y<(7*A/(7*2))
    	vd = 3;
        vb = dec2bin(3,3);
        
    elseif y>=(7*A/(7*2)) && y<(9*A/(7*2))
    	vd = 4;
        vb = dec2bin(4,3);
        
    elseif y>=(9*A/(7*2)) && y<(11*A/(7*2))
    	vd = 5;
        vb = dec2bin(5,3);
        
    elseif y>=(11*A/(7*2)) && y<(13*A/(7*2))
    	vd = 6;
        vb = dec2bin(6,3);
        
    elseif y>=(13*A/(7*2)) && (y<=A)
    	vd = 7; 
        vb = dec2bin(7,3);
    end

if(Y>=0 || vd==0) %Número positivo
    signoB = '0';
    signoD = 1;
    
elseif(Y<0) %Número negativo
    signoB = '1';
    signoD = -1;
end

vb = strcat(signoB,vb);
vd = signoD*vd;
Tiempo = [Tiempo t];

fprintf('%g  %f  %f  %s  \n\n', x,t,Y,vb)
    
valorBin=[valorBin vb];
valorDig=[valorDig vd];
end                  

t=0:T/n:T;
y=A*sin(2*pi*f0*t+p);
%Gráficas

figure(1)
plot(t,y,'r')
grid on
title('Señal original') %Título
xlabel('Tiempo'); %Eje horizontal
ylabel('Volts'); %Eje vertical

figure(2)
stem(t,y)
grid on
title('Señal digitalizada') %Título
xlabel('Tiempo'); %Eje horizontal
ylabel('Volts'); %Eje vertical

figure(3)
plot(Tiempo,valorDig,'-o')
grid on
title('Señal reconstruida en BITS') %Título
xlabel('Tiempo'); %Eje horizontal

%Interpolacion de valores para ajustar al rango de la amplitud +/-4
YY=[];
tamanio=size(valorDig);
TAMANIO=tamanio(2);

for i=1:TAMANIO
    yy= ((valorDig(i)-(-7))/((7)-(-7)))*((4)-(-4))+(-4);
    YY=[YY yy];
end

figure(4)
plot(Tiempo,YY,'--o')
grid on
title('Señal reconstruida en Voltaje') %Título
xlabel('Tiempo'); %Eje horizontal
ylabel('Volts'); %Eje vertical

figure(5)
plot(t,y,'r')
hold
plot(Tiempo,YY,':o')
grid on
title('Señal original y señal reconstruida') %Título
xlabel('Tiempo(Seg)'); %Eje horizontal
ylabel('Volts'); %Eje vertical
legend('Original','Reconstruida')
