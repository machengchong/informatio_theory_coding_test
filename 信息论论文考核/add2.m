function [ res2 ] = add2( bit1,bit2)
%ADD2 ��һ����λģ2�ӷ���
    res2 = bit1+bit2;
    res2 = mod(res2,2);
end

