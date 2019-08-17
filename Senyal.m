

filename = 'Senyal_b.csv';
A = xlsread(filename);

Fs=77000;

t=(1/Fs:(1/Fs):1/50);

[P,Q] = rat(Fs/500e3);

B = resample(A,P,Q);

B=B/50;

plot(t,B)

D=zeros(1540,2);

D(2:end,1)=fix(t(1:(end-1))*10^9);

D(1:end,2)=B;


filename = 'Senyal_text.xlsx';
xlswrite(filename,D)

