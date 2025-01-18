clearvars;
lang = "telugu";
[x, fs] = audioread("../wavs/"+lang+".wav");

t = 0:1/fs:(length(x)-1)/fs;

%% 1. Change in F0 (Pitch Contour)

[f,idx] = pitch(x, fs, Method="SRH", WindowLength=fs*0.04, OverlapLength=fs*0.02);
tf = idx/fs;

figure(1)
subplot(2,2,1)
plot(t, x);
title("Original signal");
xlabel("Time (s)")
ylabel("Amplitude")
subplot(2,2,2)
plot(tf,f)
xlabel("Time (s)")
ylabel("Pitch (Hz)")
title("1. Change in F0")
display(lang)
display("1.avg f0 = "+num2str(mean(f))+"Hz");
%% 2.Duration of voiced region
energy = x.*x;
threshold_enegy = 2.5*mean(energy);
k = 0;
v_uv = zeros(length(x),1);
%frame_length = 100;shift = 50;
for i = 1:100:(length(x)-100)
    frame_cur = sum(energy(i:i+100));
    if frame_cur>threshold_enegy
        v_uv(i:i+100)=0.6;
    end
end

%figure(2);
subplot(2,2,3)
plot(t, x);
title("2.Voiced region Duration = "+sum(v_uv)/fs+"s");
xlabel("Time (s)");
ylabel("Amplitude");
hold on;
plot(t, v_uv);
hold off;
ylim([-0.6, 0.6]);

display("2.Voiced region Duration = "+sum(v_uv)/fs+"s");

%% 3. Change in Log energy of voiced region
log_energy = log(energy);

l_v_uv = (-40)*v_uv;
for i = 1:length(x)
    if(v_uv(i)==0)
        log_energy(i) = 0;
    end
end

%figure(3)
subplot(2,2,4)
plot(t,log_energy);
xlabel("Time (s)")
title("3.change in log energy of only voiced regions")
sgtitle(lang)
%% VOP Calculation
idx_up = zeros(length(idx), 1);
idx_low = zeros(length(idx), 1);
idx_up_one = zeros(length(idx), 1);
idx_low_one = zeros(length(idx), 1);
a_low=1;
a_high =1;
for i = 2:(length(idx) - 1)
    if f(i - 1) <= f(i) && f(i) >= f(i + 1)
        idx_up(i) = f(i);
        idx_up_idx(a_high) = idx(i);
        a_high=a_high+1;
        idx_up_one(i) = 1;
        %display(idx(i));
    end
    if f(i - 1) >= f(i) && f(i) <= f(i + 1)
        idx_low(i) = f(i);
        idx_low_idx(a_low) = idx(i);
        a_low=a_low+1;
        idx_low_one(i) = 1;
        %display(idx(i));
    end
end  

figure(4)
stem(tf, f)
xlabel("Time (s)")
ylabel("Pitch (Hz)")
title("Change in F0")
hold on
scatter(tf, idx_low, 'r', 'filled')  % Scatter points for idx_low in red
scatter(tf, idx_up, 'b', 'filled')   % Scatter points for idx_up in blue
hold off
legend('Pitch', 'Low Points', 'Up Points')

figure (5)
stem(tf,idx_low_one)
title("Vowel onset points")
xlabel("time(s)")
ylim([-0.1,1.2])
%% 4.Distance between sucessive VOPs

for i =2:a_low-1
    dist(i-1) = idx_low_idx(i)-idx_low_idx(i-1);
end
display("4.avg duration between sucessive VOPs = "+mean(dist)/fs+" s");
%% 5.Dist of F0 peak and VOP
for i =1:a_high-1
    dur(i) = idx_up_idx(i) - idx_low_idx(i);
    if(dur(i)<=0)
        dur(i) = 0;
    end
end
display("5.avg duration between F0 and VOP = "+mean(dur)/fs+" s");

%% 6.Duration Tilt
for i =1:a_high-2
    dr = idx_up_idx(i) - idx_low_idx(i);
    df = idx_low_idx(i+1) - idx_up_idx(i);
    dt(i) = (dr-df)/(dr+df);
end
display("6.Avg Duration Tilt = "+mean(dt));
%% 7.Amplitude Tilt
for i =1:a_high-2
    fl1 = f(find(idx==idx_low_idx(i)));
    fl2 = f(find(idx==idx_low_idx(i+1)));
    fh = f(find(idx == idx_up_idx(i)));
    ar = abs(fh-fl1);
    af = abs(fh-fl2);
    at(i) = (ar-af)/(ar+af);
end
display("7.Avg Amplitude Tilt = "+mean(at));
%% Done