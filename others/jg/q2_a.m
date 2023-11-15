fname = "q2_audio.wav";
[x, fs] = audioread("q2_audio.wav");
%fs = 22050

[lp_coefficients, error] = lpc(x, 10);

lp_fft = fft(lp_coefficients, 256);

freq = (fs/2)*(0:1:127)/128;

plot(freq, abs(lp_fft(1:128)));
xlabel("Frequency");
ylabel("Magnitude");
xlim([0 11025]);
title("LP Spectrum of original signal")
