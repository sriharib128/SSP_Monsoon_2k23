[x, fs] = audioread("q2_audio.wav");

t = (0:length(x)-1)/fs;

subplot 221
plot(t, x);
title("Original signal");

%% Pitch Contour
Fsize = round(0.04*fs);
Ssize = round(0.02*fs);

[f,idx] = pitch(x, fs, Method="SRH", WindowLength=Fsize, OverlapLength=Ssize);
tf = idx/fs;

hr = harmonicRatio(x,fs,Window=hamming(Fsize,"periodic"),OverlapLength=Ssize);
threshold = 0.9;
f0(hr < threshold) = nan;

subplot 222
scatter(tf,f)
xlabel("Time (s)")
ylabel("Pitch (Hz)")
title("Pitch Contour")

avg_val = mean(f);

disp(avg_val);

%% Distance of F0 peak with respect to VOP

