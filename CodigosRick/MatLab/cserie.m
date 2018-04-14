%%Circuito Serie
function [w0,L,C,BW]=cserie
w0=2*pi*(0:0.1e6:4e6);
Q=10;
R=50;
Ri=50;
L=zeros(41,1);
C=zeros(41,1);
BW=zeros(41,1);
for i=1:1:41
L(i)=(Q*(R+Ri))/w0(i);
end
for i=1:1:41
C(i)=1/(w0(i)^2*L(i));
end
for i=1:1:41
BW(i)=(R+Ri)/L(i);
end
subplot(3,1,1);
plot(w0,C);
subplot(3,1,2);
plot(w0,L);
subplot(3,1,3);
plot(w0,BW);
end 