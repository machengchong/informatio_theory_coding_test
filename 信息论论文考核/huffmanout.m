%  ‰»Î æ∑∂
% inp={'101';  '100';  '001';  '000';  '11';  '01'};
% intchar=['a'; 'b'; 'c'; 'd'; 'e'; ' ' ];
% getchar=['   abcgzd defg'];

function [Cache_char] = huffmanout(inp,intchar,getchar)
Cache_char= [];
len = length(getchar);
for i=1:len
    Cache_char= [Cache_char,inp{find(intchar==getchar(i))}];
end
Cache_char
end