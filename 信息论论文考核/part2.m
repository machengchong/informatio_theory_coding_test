%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����������-----��������Ӧ�ַ��������celldata.txt-----�����������txt_to_bin.txt
%�����       
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
get_s = [];
get_text = [];
%��ȡ��Դ���ʷֲ�
p=load('p.txt');

%��ȡ��Դ����
fidin=fopen('s.txt');
while ~feof(fidin)       %ֱ����ȡ����
      tline=fgetl(fidin);  %���ж�ȡ�ļ�
      get_s = [get_s char(tline)]
end
fclose(fidin);
get_s = get_s(:);

%��ȡ�ı����б���
fidin=fopen('test.txt');
while ~feof(fidin)       %ֱ����ȡ����
      tline=fgetl(fidin);  %���ж�ȡ�ļ�
      get_text = [get_text char(tline)]
end
fclose(fidin);
for i = 1 : size(get_text,2)
        if (double(get_text(i))>=65 && double(get_text(i))<=90)
            get_text(i) = char(get_text(i)+32);
        end
end

%��ȡ����������
r=2;
[h, Length] = huffman(p, r);
h=h(:);

%�������������
fileID = fopen('celldata.txt','w');
fprintf(fileID,"%s\n",h{:});
fclose(fileID);

%�������
txt_to_bin=huffmanout(h,get_s,get_text);

fileID = fopen('txt_to_bin.txt','w');
fprintf(fileID,"%s\n",txt_to_bin);
fclose(fileID);


%outchar=unhuffman(h,get_s,txt_to_bin);