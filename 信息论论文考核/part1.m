%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%统计信源概率并排序---信源字符存放于s.txt---信源概率存放于p.txt
%马成翀  
%2020.4.16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

num(1:27) = 0;           %各个字母频数
p_num(1:27) = 0;       %各个字母概率
get_text = [];              %获取的txt文本
result = 0;                   %存放信源熵

%读取文件
fidin=fopen('test.txt');
while ~feof(fidin)       %直到读取空行
      tline=fgetl(fidin);  %按行读取文件
      get_text = [get_text char(tline)]
end
fclose(fidin);

%计算各个字母出现频数（不区分大小写）
for i = 1 : size(get_text,2)
        if double(get_text(i))==32
           num(27) = num(27)+1;
        elseif (double(get_text(i))>=65 && double(get_text(i))<=90)
            num(double(get_text(i))-64) = num(double(get_text(i))-64)+1;
        elseif (double(get_text(i))>=97 && double(get_text(i))<=122)
           num(double(get_text(i))-96) = num(double(get_text(i))-96)+1;
        end
end

%计算各个字母出现的频率
for i = 1:27
    p_num(i) = num(i)/size(get_text,2);
end

%输出
% for i = 1:26
%     fprintf("%s : %f\n",char(i+64),p_num(i));
% end
% fprintf("空格 ：%f\n",p_num(27));

[B,I] = sort(p_num);

for i = 1:27
    if I(i)==27
    fprintf("%s : %f\n",char(32),B(i));
    else
    fprintf("%s : %f\n",char(I(i)+96),B(i));
    end
end
%fprintf("空格 ：%f\n",p_num(27));
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
fprintf("信源熵为 ：%f\n",result);

%保存信源字符，按概率顺序
fp=fopen('s.txt','w');
fprintf(fp,"%s\n",out);
fclose(fp);

%保存概率数据
fp=fopen('p.txt','w');
fprintf(fp,"%f ",B);
fclose(fp);