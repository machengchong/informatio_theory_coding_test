%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2ASK���----���������'demode.txt'----ά�ر����������vit_out.txt
%�����  
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ȡ���ŵ��������
out_awgn_5 = load('out_awgn_5.txt');
N10=length(out_awgn_5);
N=N10/100;
t=0.01:0.01:N;
plot(t,out_awgn_5);
axis([0 N -2.5 2.5]);

%�ز�
carrier_wave = sin(20*pi*t);

figure(1)
plot(t,out_awgn_5.*carrier_wave);
axis([0 N -3.5 3.5]);

%��ͨ�˲���
figure(2)
y=lowp(out_awgn_5.*carrier_wave,1.2,2,0.1,20,100);
plot(t,y);
axis([0 N -3.5 3.5]);

%�����о�
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

%ά�ر�����
 vit_out=viterbi_de(get_awgn);
 fileID = fopen('vit_out.txt','w');
fprintf(fileID,"%d",vit_out);
fclose(fileID);