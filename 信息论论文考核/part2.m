%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%哈夫曼编码-----哈夫曼对应字符串存放于celldata.txt-----编码结果存放于txt_to_bin.txt
%马成翀       
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
get_s = [];
get_text = [];
%读取信源概率分布
p=load('p.txt');

%读取信源符号
fidin=fopen('s.txt');
while ~feof(fidin)       %直到读取空行
      tline=fgetl(fidin);  %按行读取文件
      get_s = [get_s char(tline)]
end
fclose(fidin);
get_s = get_s(:);

%读取文本进行编码
fidin=fopen('test.txt');
while ~feof(fidin)       %直到读取空行
      tline=fgetl(fidin);  %按行读取文件
      get_text = [get_text char(tline)]
end
fclose(fidin);
for i = 1 : size(get_text,2)
        if (double(get_text(i))>=65 && double(get_text(i))<=90)
            get_text(i) = char(get_text(i)+32);
        end
end

%获取哈夫曼参数
r=2;
[h, Length] = huffman(p, r);
h=h(:);

%保存哈夫曼参数
fileID = fopen('celldata.txt','w');
fprintf(fileID,"%s\n",h{:});
fclose(fileID);

%编码输出
txt_to_bin=huffmanout(h,get_s,get_text);

fileID = fopen('txt_to_bin.txt','w');
fprintf(fileID,"%s\n",txt_to_bin);
fclose(fileID);


%outchar=unhuffman(h,get_s,txt_to_bin);