%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��213�������----2ASK����----5��������ŵ�ģ��
%�����  
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
get_bin=[];
%��ȡ���������������
fidin=fopen('txt_to_bin.txt');
while ~feof(fidin)       %ֱ����ȡ����
      tline=fgetl(fidin);  %���ж�ȡ�ļ�
      get_bin = [get_bin char(tline)];
end
%ת��Ϊ�������
get_bin_num=[];
for i = 1 : size(get_bin,2) 
      get_bin_num(i) = str2double(get_bin(i));
end
get_bin_num = get_bin_num(:);

res = conv213(get_bin_num);
%������д��txt
fileID = fopen('out213.txt','w');
fprintf(fileID,"%d",res);
fclose(fileID);


N = length(res);
%��Դ����
res_wave=[];
for i=1:N
        res_wave=[res_wave res(i).*ones(1,100)];
end

figure(1)
t=0.01:0.01:N;
subplot(411)
plot(t,res_wave);
axis([0 N -0.5 1.5]);
title('�����ź�');xlabel('ʱ�䵥λt');

%�ز�
carrier_wave = sin(20*pi*t);
subplot(412)
plot(t,carrier_wave);
axis([0 N -1.5 1.5]);
title('�ز��ź�');xlabel('ʱ�䵥λt');

%2ASK����
ASK_OUT= carrier_wave.*res_wave;
subplot(413)
plot(t,ASK_OUT);
axis([0 N -1.5 1.5]);
title('�����ź�');xlabel('ʱ�䵥λt');

%δ������Ƶ��
ask_fft  = abs(fft(ASK_OUT));
fy = 20*log10(ask_fft);
fy = fy(1:length(fy));
subplot(414)
plot(fy);
title('2ASK����Ƶ��');xlabel('Ƶ��');ylabel('dB');
axis([0 N+10 -60 60]);


SNR =[ 5 10 15 20 35];
%�����10db
for i=SNR
figure
ASK_OUT_SNR = awgn(ASK_OUT,i);
subplot(211)
plot(t,ASK_OUT_SNR);
axis([0 N -2.5 2.5]);
title(['�����ź�SNR=', int2str(i), 'db']);xlabel('ʱ��');

file_name=['out_awgn_',int2str(i),'.txt']
fp = fopen(file_name,'w');
fprintf(fp,' %f',ASK_OUT_SNR);
fclose(fp);

ask_fft  = abs(fft(ASK_OUT_SNR));
fy = 20*log10(ask_fft);
fy = fy(1:length(fy));
subplot(212)
plot(fy);
title(['ASK����Ƶ��SNR=', int2str(i), 'db']);xlabel('Ƶ��');ylabel('dB');
axis([0 N+10 -60 60]);
end
