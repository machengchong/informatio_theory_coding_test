function [ res3 ] = add3( bit1,bit2,bit3 )
%ADD3 ��һ����λģ2�ӷ���
    res3 = bit1+bit2+bit3;
    res3 = mod(res3,2);
end

