%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%*周维君
%*conv213.m
%*2019-5-12
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ mres ] = conv213( code )
%CONV213 卷积器
    bit1=0;
    bit2=0;
    bit3=0;
    len=length(code);
    i=0;
    res = [];%存放结果
    for i = 1:len
        bit3 = bit2;
        bit2 = bit1;
        bit1 = code(i);
        x = add3(bit1,bit2,bit3);
        y = add2(bit1,bit3);
        res = [res x y];
    end
    mres = res;
end

