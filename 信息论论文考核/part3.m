%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����������-----��ȡά�ر���������������---�����������outtest.txt
%�����  
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
get_h = {};
get_s =[];
get_bin = [];
i=1;

%��ȡ��������
fidin=fopen('celldata.txt');
while ~feof(fidin)       %ֱ����ȡ����
      tline=fgetl(fidin);  %���ж�ȡ�ļ�
      get_h(i) = {char(tline)};
      i=i+1;
end
fclose(fidin);
get_h = get_h(:);

%��ȡ������Դ�ַ�
fidin=fopen('s.txt');
while ~feof(fidin)       %ֱ����ȡ����
      tline=fgetl(fidin);  %���ж�ȡ�ļ�
      get_s = [get_s ;char(tline)];
end
fclose(fidin);
get_s = get_s(:);

%��ȡ�����ƹ�������
fidin=fopen('vit_out.txt');
while ~feof(fidin)       %ֱ����ȡ����
      tline=fgetl(fidin);  %���ж�ȡ�ļ�
      get_bin = [get_bin char(tline)]
end

%����������
outtest=unhuffman(h,get_s,get_bin);

fileID = fopen('outtest.txt','w');
fprintf(fileID,"%s\n",outtest);
fclose(fileID);