function y=sinwave
y=zeros(1,3);
for i=1:1:3
    j=(2*pi*i*(6000/16000));
    y(i)=sin(j);
end
