clc;
clear all;
close all;
num=9;
%% audioread
[y,fs]=audioread("./project/wav_files/telugu_para"+string(num)+".wav");
%[y,fs]=audioread('na.wav');
N = length(y);
q=18;
display("audio read done"+num);
%% filtfilting
p=4000/q;
x(1,:)=bandpass(y(:,1),[15 p],fs);
for i=2:q
    x(i,:)=bandpass(y(:,1),[(i-1)*p i*p],fs);
end
display("band pass filtering done"+num)
%% half wave rectifier
for i=1:q
    for j=1:N
        if x(i,j)<0
            a(i,j)=0;
        else
            a(i,j)=x(i,j);
        end
    end
end
display("half wave rectifier done"+num)
%% Lowpass filtfilt
for i=1:q
    lp(i,:)=lowpass(a(i,:),28,fs,'Steepness',0.95);
%     lp(i,:)=smooth(lp(i,:),50*fs/1000);
end
display("lowpass done"+num)
%% normalise
for i=1:q
    dw(i,:)=lp(i,:)./max(lp(i,:));
end
display("normalizing done"+num)

%% fft window
ham=hamming(20);
for i=1:q

    temp=dw(i,:);
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
display("fft windowing done"+num)
%% enhancement
temp1=filtfilt(hamming(1600),1,temp1);
y1=diff(temp1);
y2=buffer(y1,160,159);

y3=sum(y2);

y4=y3;

y4(y3<0)=0;

Fogd=diff(gausswin(800));

y5=filter(Fogd,1,y4);

%{
subplot(311)
plot(y4);
subplot(312)
plot(Fogd); 
subplot(313); 
plot(y5);
%}
display("enhancement done"+num)
%% Enhancing the VOP and removing close peaks and ploting it with speech signal

y5=y5./max(y5);
y5(y5<0)=0;
y5(y5<0.1)=0;

y5=smooth(y5,320);
[pks, vop]=findpeaks(y5);
%{
time_axis = (0:length(y) - 1)/fs;
time_axis1 = (0:length(y5) - 1)/fs;

subplot(211)
plot(time_axis1, y5);
title('VOP evidence plot');

subplot(212)
plot(time_axis, y-mean(y));
hold on
stem(vop/fs,ones(size(pks)),'*')
title('VOP in speech signal')
%}
display("vops done"+num)
%% data entry to csv

fileName = 'para_'+string(num)+'.csv';      % check with audio file name before running
csvwrite(fileName, vop/fs);
display(fileName+" done");
%end