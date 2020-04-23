function[h, Length] = huffman(p, r)
%����p��ʾ���ų��ָ�������ɵĸ�������
%����ֵh��ʾ����Huffman�����㷨��������ı�����
%����ֵLength��ʾ����Huffman�����õ��������ֳ���
%p=[0.35 0.1 0.2 0.2 0.15];
%r=2;
if ( length(find(p < 0)) ~= 0)
error('Not a prob.vector, negative component(s)');
end
%�жϸ����������Ƿ���0Ԫ�أ���0Ԫ�س�����ʾ������ֹ����

if (sum(p, 2) > 1)
error('Not a prob.vector, components do not add up to 1');
end
%�ж����з��ų��ָ���֮���Ƿ����1���������1������ʾ������ֹ����

a = length(p); %�ⶨ�����������ȣ�������ֵ��ֵ������n
k = fix((a - 1) / (r - 1));
L1 = a - k * r + k;
q = zeros(1, a);
m = zeros(k + 1, a);
mp = m;
q = p;
[m(1, :), mp(1, :)] = sort(q);
if(L1 > 1)
s = sum(m(1, 1:L1), 2);
q = [s, m(1, (L1 + 1) : a), ones(1, L1 - 1)];
[m(2, :), mp(2, :)] = sort(q);
else
m(2, :) = m(1, :);
mp(2, :) = 1 : 1 : a;
end

for i = 3: k + 1;
s = sum(m(i - 1, 1:r), 2);
q = [s, m(i - 1, r + 1:a), ones(1, r - 1)];
[m(i, :), mp(i, :)] = sort(q);
end

n1 = m;
n2 = mp;
for i = 1: k + 1;
n1(i, :) = m(k + 2 - i, :);
n2(i, :) = mp(k + 2 - i, :);
[m(i, :), mp(i, :)] = sort(q);
end

m = n1;
mp = n2;
c = cell(k + 1,a);
for j = 1 : r
c{1, j} = num2str(j - 1);
end

for i = 2 : k
p1 = find(mp(i - 1, :) == 1);
for j = 1 : r
c{i, j} = strcat(c{i - 1, p1}, int2str(j - 1));
end
for j = (r + 1) : (p1 + r - 1)
c{i, j} = c{i - 1, j - r};
end
for j = (p1 + r) : a
c{i, j} = c{i -1, j - r + 1};
end
end

if L1 == 1
for j = 1 : a
c{k + 1, j} = c{k, j};
end
else
p1 = find(mp(k, :) == 1);
for j = 1 : L1
c{k + 1, j} = strcat(c(k, p1), int2str(j - 1));
end
for j = (L1 + 1) : (p1 + L1)
c{k + 1, j} = c{k, mp(1, j - L1)};
end
for j = (p1(1) + L1 + 1) : a
c{k + 1, j} = c{k, mp(1, j - L1 + 1)};
end
end

for j = 1 : a
L(j) = length(c{k + 1, j});
end

h = cell(1, a);
for j = 1 : a
h{1, j} = c{k + 1, j};
end

%Length = sum(L.*m(k + 1, :));  %��ƽ���볤
Length = sum(L.*sort(p));