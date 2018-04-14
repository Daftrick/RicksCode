function filtrofir

[x,fs]=audioread('Encendido0.wav');
sound(x);
plot(x);

yn=zeros(length(x),1);
fn=fs/2;
n=100;
b=fir1(n,[300 3800]/fn,'bandpass');
yf=filter(b,1,x);
M=length(b);

for i=1:1:length(x)
    for k=1:1:M
        if (i-k<=0)
        yn(i)=yn(i);
        else
        yn(i)= yn(i)+(b(k)*(x(i-k)));
        end
    end
end
       
figure(1);
subplot(2,1,1);
plot(x);
subplot(2,1,2);
plot(yn);


figure(2);
subplot(2,1,1);
plot(abs(fft(x)));
subplot(2,1,2);
plot(abs(fft(yn)));


figure(3);
subplot(2,1,1);
plot(yn);
subplot(2,1,2);
plot(yf);


figure(4);
subplot(2,1,1);
plot(abs(fft(yn)));
subplot(2,1,2);
plot(abs(fft(yf)));


sound(yn);


end
