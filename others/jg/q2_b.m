fname = "q2_audio.wav";
[x, fs] = audioread("q2_audio.wav");
%fs = 22050
freq = (fs/2)*(0:1:127)/128;

[lp_coefficients, e1] = lpc(x, 10);
lp_fft1 = fft(lp_coefficients, 256);

subplot 211
plot(freq, abs(lp_fft1(1:128)));
xlabel("Frequency");
ylabel("Magnitude");
xlim([0 11025]);
title("LP Spectrum of original signal")

error_signal = filter(lp_coefficients, 1, x) - x;
[lp_error, e2] = lpc(abs(error_signal), 10);
lp_fft2 = fft(lp_error, 256);

subplot 212
plot(freq, abs(lp_fft2(1:128)));
xlabel("Frequency");
xlim([0 11025]);
ylabel("Magnitude");
title("LP Spectrum of LP Residual signal")