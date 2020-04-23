%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%（213）卷积码----2ASK调制----5种信噪比信道模拟
%马成翀  
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
get_bin=[];
%读取哈夫曼编码后数据
fidin=fopen('txt_to_bin.txt');
while ~feof(fidin)       %直到读取空行
      tline=fgetl(fidin);  %按行读取文件
      get_bin = [get_bin char(tline)];
end
%转换为数组矩阵
get_bin_num=[];
for i = 1 : size(get_bin,2) 
      get_bin_num(i) = str2double(get_bin(i));
end
get_bin_num = get_bin_num(:);

res = conv213(get_bin_num);
%编码结果写入txt
fileID = fopen('out213.txt','w');
fprintf(fileID,"%d",res);
fclose(fileID);


N = length(res);
%信源波信
res_wave=[];
for i=1:N
        res_wave=[res_wave res(i).*ones(1,100)];
end

figure(1)
t=0.01:0.01:N;
subplot(411)
plot(t,res_wave);
axis([0 N -0.5 1.5]);
title('数字信号');xlabel('时间单位t');

%载波
carrier_wave = sin(20*pi*t);
subplot(412)
plot(t,carrier_wave);
axis([0 N -1.5 1.5]);
title('载波信号');xlabel('时间单位t');

%2ASK调制
ASK_OUT= carrier_wave.*res_wave;
subplot(413)
plot(t,ASK_OUT);
axis([0 N -1.5 1.5]);
title('调制信号');xlabel('时间单位t');

%未加噪声频谱
ask_fft  = abs(fft(ASK_OUT));
fy = 20*log10(ask_fft);
fy = fy(1:length(fy));
subplot(414)
plot(fy);
title('2ASK调制频谱');xlabel('频谱');ylabel('dB');
axis([0 N+10 -60 60]);


SNR =[ 5 10 15 20 35];
%信噪比10db
for i=SNR
figure
ASK_OUT_SNR = awgn(ASK_OUT,i);
subplot(211)
plot(t,ASK_OUT_SNR);
axis([0 N -2.5 2.5]);
title(['调制信号SNR=', int2str(i), 'db']);xlabel('时域');

file_name=['out_awgn_',int2str(i),'.txt']
fp = fopen(file_name,'w');
fprintf(fp,' %f',ASK_OUT_SNR);
fclose(fp);

ask_fft  = abs(fft(ASK_OUT_SNR));
fy = 20*log10(ask_fft);
fy = fy(1:length(fy));
subplot(212)
plot(fy);
title(['ASK调制频谱SNR=', int2str(i), 'db']);xlabel('频谱');ylabel('dB');
axis([0 N+10 -60 60]);
end
