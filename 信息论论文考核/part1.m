%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ͳ����Դ���ʲ�����---��Դ�ַ������s.txt---��Դ���ʴ����p.txt
%�����  
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

num(1:27) = 0;           %������ĸƵ��
p_num(1:27) = 0;       %������ĸ����
get_text = [];              %��ȡ��txt�ı�
result = 0;                   %�����Դ��

%��ȡ�ļ�
fidin=fopen('test.txt');
while ~feof(fidin)       %ֱ����ȡ����
      tline=fgetl(fidin);  %���ж�ȡ�ļ�
      get_text = [get_text char(tline)]
end
fclose(fidin);

%���������ĸ����Ƶ���������ִ�Сд��
for i = 1 : size(get_text,2)
        if double(get_text(i))==32
           num(27) = num(27)+1;
        elseif (double(get_text(i))>=65 && double(get_text(i))<=90)
            num(double(get_text(i))-64) = num(double(get_text(i))-64)+1;
        elseif (double(get_text(i))>=97 && double(get_text(i))<=122)
           num(double(get_text(i))-96) = num(double(get_text(i))-96)+1;
        end
end

%���������ĸ���ֵ�Ƶ��
for i = 1:27
    p_num(i) = num(i)/size(get_text,2);
end

%���
% for i = 1:26
%     fprintf("%s : %f\n",char(i+64),p_num(i));
% end
% fprintf("�ո� ��%f\n",p_num(27));

[B,I] = sort(p_num);

for i = 1:27
    if I(i)==27
    fprintf("%s : %f\n",char(32),B(i));
    else
    fprintf("%s : %f\n",char(I(i)+96),B(i));
    end
end
%fprintf("�ո� ��%f\n",p_num(27));
out=[];
for i = 1:27
    if I(i)==27
    out=[out char(32)];
    else
    out=[out char(I(i)+96)];
    end
end
out
B
for i = 1:27
    if p_num(i) ~= 0
    result = result + p_num(i) *log( 1/p_num(i) );
    end
end
%result = -result;
fprintf("��Դ��Ϊ ��%f\n",result);

%������Դ�ַ���������˳��
fp=fopen('s.txt','w');
fprintf(fp,"%s\n",out);
fclose(fp);

%�����������
fp=fopen('p.txt','w');
fprintf(fp,"%f ",B);
fclose(fp);