[x, fs] = audioread("Malayali.wav");

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
disp(fs);

%% Distance of F0 peak with respect to VOP

N = length(x);
q = 18;               % no of bands
p = round(4000/q);

x_fil = zeros(q, N);

x_fil(1, :) = bandpass(x(:,1),[15 p],fs);

for k = 2:q
    x_fil(k, :) = bandpass(x(:,1), [(k-1)*p, k*p], fs);     % bandpass filtering(18 bands) in the range of frequencies [15, 5000]
end

% half wave rectifier
for k = 1:q
    for j=1:N
        if x_fil(k,j)<0
            x_fil(k,j)=0;
        end
    end
end

for k=1:q
    lp(k,:)=lowpass(x_fil(k,:),28,fs,'Steepness',0.95);
end

% normalization(0-1)

for k=1:q
    x_nor(k,:)=lp(k,:)./max(lp(k,:));
end

%% fft window
ham=hamming(20);
for i=1:q

    temp=x_nor(i,:);
    temp=buffer(temp,20,19);
    
    temp=temp.*(ham*ones(1,length(temp)));
    
    temp=fft(temp,40);
    
    temp = sum(abs(temp(4:16,:)));
    
    temp1(i,:)=temp;
    
end

temp1=sum(temp1);

temp1=resample(temp1,80,fs);
temp1=resample(temp1,fs,80);
temp1=temp1/max(temp1);

%% enhancement
temp1=filtfilt(hamming(1600),1,temp1);
y1=diff(temp1);
y2=buffer(y1,160,159);

y3=sum(y2);

y4=y3;

y4(y3<0)=0;

Fogd=diff(gausswin(800));

y5=filter(Fogd,1,y4);

y5=y5./max(y5);
y5(y5<0)=0;
y5(y5<0.1)=0;

% y5=smooth(y5,320);
[pks, vop]=findpeaks(y5);


val = zeros(1,N);

j=1;

check = ceil(N/length(f));

for i = 1:N

    if mod(i,check)==0
        val(i) = f(j);
        j=j+1;
    end

end

t_ = 1:length(val);

subplot 223

scatter(t_,val/400)
hold on
stem(vop,ones(size(pks)),'*')
title('Vowel Onset points')

%% Duration of voiced region

ene = x.*x;
Energy = mean(ene);

Thres = 0.1*Energy;

k = 0;
for l=1:100:(length(ene)-100)
if((sum(ene(l:l+99)))/100 > Thres)
       dest(k + 1 : k + 100) = x(l:l+99);
       k=k+100;
end
end

t_vcd = 0:1/fs:(length(dest) - 1)/fs;

subplot 224
plot(t_vcd,dest);
xlabel("time");
title("Voiced signal");
