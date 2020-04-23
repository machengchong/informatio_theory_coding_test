%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%哈夫曼译码-----读取维特比译码结果进行译码---译码结果存放于outtest.txt
%马成翀  
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
get_h = {};
get_s =[];
get_bin = [];
i=1;

%读取编码数据
fidin=fopen('celldata.txt');
while ~feof(fidin)       %直到读取空行
      tline=fgetl(fidin);  %按行读取文件
      get_h(i) = {char(tline)};
      i=i+1;
end
fclose(fidin);
get_h = get_h(:);

%读取编码信源字符
fidin=fopen('s.txt');
while ~feof(fidin)       %直到读取空行
      tline=fgetl(fidin);  %按行读取文件
      get_s = [get_s ;char(tline)];
end
fclose(fidin);
get_s = get_s(:);

%读取二进制哈夫曼码
fidin=fopen('vit_out.txt');
while ~feof(fidin)       %直到读取空行
      tline=fgetl(fidin);  %按行读取文件
      get_bin = [get_bin char(tline)]
end

%哈夫曼译码
outtest=unhuffman(h,get_s,get_bin);

fileID = fopen('outtest.txt','w');
fprintf(fileID,"%s\n",outtest);
fclose(fileID);