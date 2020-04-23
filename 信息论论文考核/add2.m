function [ res2 ] = add2( bit1,bit2)
%ADD2 是一个二位模2加法器
    res2 = bit1+bit2;
    res2 = mod(res2,2);
end

