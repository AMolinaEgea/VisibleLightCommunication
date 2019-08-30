dato='t';
t=serial('COM5','BaudRate',2400); 
fopen(t)  
%fprint(s,'prueba');
fclose(t)  
%delete(t) 
clear r
r=serial('COM6','BaudRate',921600); 
fopen(r);
%fclose(r)  
%recibido=fscanf(r,'%c');

r=serial('COM6','BaudRate',921600); 
fopen(r);
fclose(r)  
recibido=fscanf(r,'%c');
dato='a';
n = 0;
while n >= 0 & n<=6
    fwrite(t,dato)
    pause(1)
    n=n+1;
end

b=[0 0 0 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 0 1 1 1 0 1 1 0 0 0 0 1 0 0 0 0 0 0 0 0];
a=[0 1 1 0 0 0 0 1 0 1 1 0 0 0 0 1 0 1 1 0 0 0 0 1 0 1 1 0 0 0 0 1 0 1 1 0 0 0 0 1 0 1 1 0 0 0 0 1];
[f,k]=biterr(a,b)
