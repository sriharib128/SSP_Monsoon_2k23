fname = "q2_audio.wav";
[s, fs] = audioread("q2_audio.wav");
time = 0:1/fs:(length(s)-1)/fs;

subplot 411
plot(time, s);
xlabel("time");
ylabel("amplitude");
title("Original audio signal")

%% Computing x[n]

n = length(s);
x = zeros(n, 1);

for k=2:n
    x(k) = s(k) - s(k-1);
end

b = 1;
a = [1 -2 1];
%% Computing y1[n](first differentiator)

y1 = filter(b, a, x);

subplot 412
plot(time, y1/abs(max(y1)));
xlabel("time");
ylabel("amplitude");
title("Signal after first filtering");

%% Computing y2[n](second differentiator)

y2 = filter(b, a, y1);
y2 = y2/abs(max(y2));

subplot 413
plot(time, y2);
xlabel("time");
ylabel("amplitude");
title("Signal after second filtering");

%% Removing trend

tsum = 0;
N = 110;            % assuming window size=10ms
for k=1:2*N+1
    tsum = tsum + y2(k);
end

y = zeros(n, 1);

for k=111:n
    if(k+111 > n)
        y(k) = y(k-1);
    else
        y(k) = y2(k) - (tsum/221);
        tsum = tsum - y2(k-110) + y2(k+111);
    end
end

%% mean subtraction

tsum = 0;
for k=1:2*N+1
    tsum = tsum + y(k);
end

yf = zeros(n, 1);

for k=111:n
    if(k+111 > n)
        yf(k) = yf(k-1);
    else
        yf(k) = y(k) - (tsum/221);
        tsum = tsum - y(k-110) + y(k+111);
    end
end

yf = yf/abs(max(yf));

subplot 414
plot(time, yf);
xlabel("time");
ylabel("amplitude");
title("Epoch locations");

sgtitle("Epoch locations using ZFF approach")


