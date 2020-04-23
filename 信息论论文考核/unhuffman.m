%输入示范
% inp={'101';  '100';  '001';  '000';  '11';  '01'};
% intchar=['a'; 'b'; 'c'; 'd'; 'e'; 'f' ];
% getchar=['0100000110110000001000011000101'];

% inp=input('输入编码后字符（输入为元胞数组，按字符长到短排列）：\n');
% intchar=input('输入编码对应符号（符号与元胞数组中字符一一对应）：\n');
% getchar=input('输入编码字符（接收端收到的数字信号，用字符串表示）：\n');

function [outchar] = unhuffman(inp,intchar,getchar)

outchar=[];
Cache_char= [];
N=size(inp,1);
K0=length(inp{N});
K1=length(inp{1});
num=0;
len=length(getchar);

while isempty(getchar)~=1
    %判断前j个字符是否匹配
    for j= K0:K1
        if  isempty(Cache_char)
            %判断前j个字母是否存在匹配
            for i=1:N
                if  strcmpi(inp{i},getchar(1:j))==1
                    Cache_char = intchar(i,:);
                    num = j;
                end
            end
        end
    end
%     if    isempty(Cache_char)
%           fprintf('input error\n');
%           break
%     else
    outchar=[outchar Cache_char];
    Cache_char= [];
    getchar = getchar(num+1:len);
    len=length(getchar);
    end
% end
outchar
end