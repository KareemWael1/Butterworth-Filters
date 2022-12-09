%Step 1

f0 = 440;
alpha = 2^(1/12);
fDO = f0*(alpha^-9)
fRE = f0*(alpha^-7)
fMI = f0*(alpha^-5)
fFA = f0*(alpha^-4)

fs = round(10 * max([fDO, fRE, fMI, fFA]))

frmsz=round(0.5*fs);
t=(0:1:frmsz-1)*(1/fs);
x1t=cos(2*pi*fDO*t);
x2t=cos(2*pi*fRE*t);
x3t=cos(2*pi*fMI*t);
x4t=cos(2*pi*fFA*t);


% Step 2
xt=[x1t,x2t,x3t,x4t];
audiowrite("signal.wav",xt,fs);
sound(xt, fs)


% Step 3
frmsz=frmsz*4;
t=(0:1:frmsz-1)*(1/fs);
plot(t,xt)


% Step 4
E_xt = sum(abs(xt).^2)*(1/frmsz)


% Step 5
Xf = fftshift(fft(xt,frmsz)) / frmsz;


% Step 6
f = (-(frmsz/2):1:(frmsz/2)-1)*(fs/frmsz);
figure;
plot(f, abs(Xf))


% Step 7
E_Xf = sum((abs(Xf).^2))



%%% Low-Pass Filter %%%



% Step 8
a = 0;
b = 0;
order = 20;
fc = (fRE + fMI) / 2                % cut-off frequency = 311.65 Hz
[b,a]= butter(order, fc / (fs/2));


% Step 9
figure;
freqz(b,a,[],fs)
subplot(2,1,1)
xlim([0 1000])
ylim([-100 10])


% Step 10
y1t = filter(b,a,xt);


% Step 11
audiowrite("lowpassfiltered.wav", y1t, fs)
sound(y1t, fs)


% Step 12
figure;
plot(t, y1t)


% Step 13
E_y1t = sum((abs(y1t).^2)) * (1/frmsz)


% Step 14
Y1f = fftshift(fft(y1t,frmsz)) / frmsz;


% Step 15
figure;
plot(f, Y1f)


% Step 16
E_Y1f = sum((abs(Y1f).^2))

