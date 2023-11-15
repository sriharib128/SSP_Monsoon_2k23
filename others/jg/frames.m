function [frames_num] = frames(file, frameSize, frameShift)
[x, fs] = audioread(file);

FSize = round(fs*frameSize);
SSize = round(fs*frameShift);

temp = 0;

for n=0:length(x)
    if(FSize + n*SSize <= length(x))
        temp = n;
    else
        frames_num = temp;
        break
    end
end
end