function [ res3 ] = add3( bit1,bit2,bit3 )
%ADD3 是一个三位模2加法器
    res3 = bit1+bit2+bit3;
    res3 = mod(res3,2);
end

