%����ʾ��
% inp={'101';  '100';  '001';  '000';  '11';  '01'};
% intchar=['a'; 'b'; 'c'; 'd'; 'e'; 'f' ];
% getchar=['0100000110110000001000011000101'];

% inp=input('���������ַ�������ΪԪ�����飬���ַ����������У���\n');
% intchar=input('��������Ӧ���ţ�������Ԫ���������ַ�һһ��Ӧ����\n');
% getchar=input('��������ַ������ն��յ��������źţ����ַ�����ʾ����\n');

function [outchar] = unhuffman(inp,intchar,getchar)

outchar=[];
Cache_char= [];
N=size(inp,1);
K0=length(inp{N});
K1=length(inp{1});
num=0;
len=length(getchar);

while isempty(getchar)~=1
    %�ж�ǰj���ַ��Ƿ�ƥ��
    for j= K0:K1
        if  isempty(Cache_char)
            %�ж�ǰj����ĸ�Ƿ����ƥ��
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