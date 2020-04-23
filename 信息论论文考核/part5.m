%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2ASK解调----解调结果存放'demode.txt'----维特比译码结果存放vit_out.txt
%马成翀  
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%取出信道输出波信
out_awgn_5 = load('out_awgn_5.txt');
N10=length(out_awgn_5);
N=N10/100;
t=0.01:0.01:N;
plot(t,out_awgn_5);
axis([0 N -2.5 2.5]);

%载波
carrier_wave = sin(20*pi*t);

figure(1)
plot(t,out_awgn_5.*carrier_wave);
axis([0 N -3.5 3.5]);

%低通滤波器
figure(2)
y=lowp(out_awgn_5.*carrier_wave,1.2,2,0.1,20,100);
plot(t,y);
axis([0 N -3.5 3.5]);

%抽样判决
j=1;
for i=100:100:N10
    if y(i)>=0.3
        get_awgn(j)=1;
    else
        get_awgn(j)=0;
    end
    j=j+1;
end
fileID = fopen('demode.txt','w');
fprintf(fileID,"%d",get_awgn);
fclose(fileID);

%维特比译码
 vit_out=viterbi_de(get_awgn);
 fileID = fopen('vit_out.txt','w');
fprintf(fileID,"%d",vit_out);
fclose(fileID);