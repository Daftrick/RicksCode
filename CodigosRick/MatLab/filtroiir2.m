function filtroiir2

[x,fs]=audioread('Encendido0.wav');
h=fdesign.bandpass(200,300,3800,3900,10,1,10,fs);
hd=design(h,'butter','MatchExactly','stopband');
[b,a]=tf(hd);
yf=filter(b,a,x);
M=length(b);
N=length(a);
yn=zeros(length(x),1);
w=zeros(length(x),1);

for n=1:1:length(x)
    for k=2:1:N
        if (n-k<=0)
             w(n)=x(n)-(a(k)*0);
        else
            w(n)=x(n)-(a(k)*w(n-k));
        end
    end
end

for n=1:1:length(x)
    for k=1:1:M
          if (n-k<=0)
             yn(n)=(b(k)*0);
          else
              yn(n)=(b(k)*w(n-k));
          end
    end
end

figure(1);
subplot(2,1,1);
plot(x);
subplot(2,1,2);
plot(yn);
pause;

figure(2);
subplot(2,1,1);
plot(abs(fft(x)));
subplot(2,1,2);
plot(abs(fft(yn)));
pause;

figure(1);
subplot(2,1,1);
plot(yn);
subplot(2,1,2);
plot(yf);
pause;

figure(2);
subplot(2,1,1);
plot(abs(fft(yn)));
subplot(2,1,2);
plot(abs(fft(yf)));
pause;
end
