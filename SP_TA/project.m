[aw1,fs] = audioread("hawed_1_natural.wav");
[aw2,~] = audioread("hawed_2_natural.wav");
[aw3,~] = audioread("hawed_3_natural.wav");

[ee1,~] = audioread("heed_1_natural.wav");
[ee2,~] = audioread("heed_2_natural.wav");
[ee3,~] = audioread("heed_3_natural.wav");

[i1,~] = audioread("hid_1_natural.wav");
[i2,~] = audioread("hid_2_natural.wav");
[i3,~] = audioread("hid_3_natural.wav");


figure(1);
subplot(3,1,1)
t = (0:length(aw1)-1)/fs;
plot(t, aw1);
hold on
t = (0:length(aw2)-1)/fs;
plot(t, aw2);
t = (0:length(aw3)-1)/fs;
plot(t, aw3);
hold off
legend('aw1', 'aw2', 'aw3');
title("hawed")
xlabel("time (s)")
ylabel("amplitude")

subplot(3,1,2)
t = (0:length(ee1)-1)/fs;
plot(t, ee1);
hold on
t = (0:length(ee2)-1)/fs;
plot(t, ee2);
t = (0:length(ee3)-1)/fs;
plot(t, ee3);
hold off
legend('ee1', 'ee2', 'ee3');
title("heed")
xlabel("time (s)")
ylabel("amplitude")

subplot(3,1,3)
t = (0:length(i1)-1)/fs;
plot(t, i1);
hold on
t = (0:length(i2)-1)/fs;
plot(t, i2);
t = (0:length(i3)-1)/fs;
plot(t, i3);
hold off
legend('i1', 'i2', 'i3');
title("hid")
xlabel("time (s)")
ylabel("amplitude")
sgtitle("time domain")

figure(2);
subplot(3,1,1)
faw1 = fft(aw1);
f = (0:length(faw1)-1)*fs/length(faw1);
plot(f, abs(faw1));
hold on

faw2 = fft(aw2);
f = (0:length(faw2)-1)*fs/length(faw2);
plot(f, abs(faw2));

faw3 = fft(aw3);
f = (0:length(faw3)-1)*fs/length(faw3);
plot(f, abs(faw3));
hold off
legend('aw1', 'aw2', 'aw3');
title("hawed")
xlabel("frequency(Hz)")
ylabel("Magnitude")
xlim([0 1000])

subplot(3,1,2)
fee1 = fft(ee1);
f = (0:length(fee1)-1)*fs/length(fee1);
plot(f, abs(fee1));
hold on
fee2 = fft(ee2);
f = (0:length(fee2)-1)*fs/length(fee2);
plot(f, abs(fee2));
fee3 = fft(ee3);
f = (0:length(fee3)-1)*fs/length(fee3);
plot(f, abs(fee3));
hold off
legend('ee1', 'ee2', 'ee3');
title("heed")
xlabel("frequency(Hz)")
ylabel("Magnitude")
xlim([0 1000])

subplot(3,1,3)
fi1 = fft(i1);
f = (0:length(fi1)-1)*fs/length(fi1);
plot(f, abs(fi1));
hold on
fi2 = fft(i2);
f = (0:length(fi2)-1)*fs/length(fi2);
plot(f, abs(fi2));
fi3 = fft(i3);
f = (0:length(fi3)-1)*fs/length(fi3);
plot(f, abs(fi3));
hold off
legend('i1', 'i2', 'i3');
title("hid")
xlabel("frequency(Hz)")
ylabel("Magnitude")
xlim([0 1000])
sgtitle("frequency domain")


figure(3);

subplot(3,1,1)
order = 12; % You can adjust the order as needed
aw_lp1 = lpc(aw1, order);
aw_lp2 = lpc(aw2, order);
aw_lp3 = lpc(aw3, order);

f = (0:length(aw1)-1)*fs/length(aw1);
aw_lp1_spectrum = abs(fft(aw_lp1, length(aw1)));
aw_lp2_spectrum = abs(fft(aw_lp2, length(aw2)));
aw_lp3_spectrum = abs(fft(aw_lp3, length(aw3)));

plot(f, 20*log10(aw_lp1_spectrum.^-1));
hold on
f = (0:length(aw2)-1)*fs/length(aw2);
plot(f, 20*log10(aw_lp2_spectrum.^-1));
f = (0:length(aw3)-1)*fs/length(aw3);
plot(f, 20*log10(aw_lp3_spectrum.^-1));
hold off
xlim([0 12000])

legend('aw1', 'aw2', 'aw3');
title("hawed")
xlabel("Frequency (Hz)")
ylabel("Magnitude (dB)")

subplot(3,1,2)
ee_lp1 = lpc(ee1, order);
ee_lp2 = lpc(ee2, order);
ee_lp3 = lpc(ee3, order);

f = (0:length(ee1)-1)*fs/length(ee1);
ee_lp1_spectrum = abs(fft(ee_lp1, length(ee1)));
ee_lp2_spectrum = abs(fft(ee_lp2, length(ee2)));
ee_lp3_spectrum = abs(fft(ee_lp3, length(ee3)));

plot(f, 20*log10(ee_lp1_spectrum.^-1));
hold on
f = (0:length(ee2)-1)*fs/length(ee2);
plot(f, 20*log10(ee_lp2_spectrum.^-1));
f = (0:length(ee3)-1)*fs/length(ee3);
plot(f, 20*log10(ee_lp3_spectrum.^-1));
hold off
xlim([0 12000])
legend('ee1', 'ee2', 'ee3');
title("heed")
xlabel("Frequency (Hz)")
ylabel("Magnitude (dB)")

subplot(3,1,3)
i_lp1 = lpc(i1, order);
i_lp2 = lpc(i2, order);
i_lp3 = lpc(i3, order);

f = (0:length(i1)-1)*fs/length(i1);
i_lp1_spectrum = abs(fft(i_lp1, length(i1)));
i_lp2_spectrum = abs(fft(i_lp2, length(i2)));
i_lp3_spectrum = abs(fft(i_lp3, length(i3)));

plot(f, 20*log10(i_lp1_spectrum.^-1));
hold on
f = (0:length(i2)-1)*fs/length(i2);
plot(f, 20*log10(i_lp2_spectrum.^-1));
f = (0:length(i3)-1)*fs/length(i3);
plot(f, 20*log10(i_lp3_spectrum.^-1));
hold off

legend('i1', 'i2', 'i3');
title("hid")
xlabel("Frequency (Hz)")
ylabel("Magnitude (dB)")
xlim([0 12000])
sgtitle("Linear Prediction Spectrum (FFT)");
