function m=viterbi_de(x)
a=size(x);
s=a(2)/2;        %������m���г���Ϊx��һ��
m=zeros(1,s);     %���ս�����
ma=zeros(1,s+1);  %���Fa·����
mb=zeros(1,s+1);  %���Fb·����
mc=zeros(1,s+1);  %���Fc·����
md=zeros(1,s+1);  %���Fd·����
tempma=zeros(1,s+1);%ÿ��ʱ�̵���С·��ֵ
tempmb=zeros(1,s+1);%ÿ��ʱ�̵���С·��ֵ
tempmc=zeros(1,s+1);%ÿ��ʱ�̵���С·��ֵ
tempmd=zeros(1,s+1);%ÿ��ʱ�̵���С·��ֵ
Fa=0;Fb=0;Fc=0;Fd=0;
for i=1:s
% for i=1:3
    if i==1 %���յ�������Ϊ11
        d0=dis(x(1),x(2),0,0);%0-->00-->00 ���������00 0+0+0=0 0+0=0
        d3=dis(x(1),x(2),1,1);%1-->10-->00 ���������00 1+0+0=1 1+0=1
        
        Fa=Fa+d0;
        Fb=Fb+d3;
        
        ma(i)=0;
        mb(i)=0;
        mc(i)=0;
        md(i)=0;
        continue;
    elseif i==2 %���յ�������Ϊ10
        d0=dis(x(3),x(4),0,0);%d0=1
        d1=dis(x(3),x(4),0,1);%d1=2
        d2=dis(x(3),x(4),1,0);%d2=0
        d3=dis(x(3),x(4),1,1);%d3=1
        %ע�������˳�򣬲��ܴ���������������أ�Ҫô���м������
        Fc=Fb+d2;   %0-->10-->01 0+1+0=1(��λ) 0+0=0����λ�� ���������Ϊ��10
        Fd=Fb+d1;   %1-->10-->11 1+1+0=0 1+0=1 ����������Ϊ��01
        Fb=Fa+d3;
        Fa=Fa+d0;   
        
        ma(i)=0;
        mb(i)=0;
        mc(i)=2;
        md(i)=2;
        continue; 
    elseif i>2
        d0=dis(x(2*i-1),x(2*i),0,0);
        d1=dis(x(2*i-1),x(2*i),0,1);
        d2=dis(x(2*i-1),x(2*i),1,0);
        d3=dis(x(2*i-1),x(2*i),1,1);
        %���濪ʼ���мӱȽ�ѡ��ѡFֵС��·��
        tempa=Fa;tempb=Fb;tempc=Fc;tempd=Fd;
        if Fa+d0<Fc+d3 %����00״̬������·���Ƚϴ�С
            tempa=Fa+d0; %0-->00-->00 ���������00 0+0+0=0 0+0=0
            tempma=ma;
            tempma(i)=0;
        else
            tempa=Fc+d3;%0-->01-->00 ���������11  0+0+1=1 0+1=1
            tempma=mc;
            tempma(i)=1;
        end
        
        if Fa+d3<Fc+d0 %����10״̬������·���Ƚϴ�С
            tempb=Fa+d3;%1-->00-->10 ���������11  1+0+0=1 1+0=1
            tempmb=ma;
            tempmb(i)=0;
        else
            tempb=Fc+d0;%1-->01-->10 ���������00  1+0+1=0 1+1=0
            tempmb=mc;
            tempmb(i)=1;
        end
        
        if Fb+d2<Fd+d1 %����01״̬������·���Ƚϴ�С
            tempc=Fb+d2;%0-->10-->01  ���������10  0+1+0=1 0+0=0  
            tempmc=mb;
            tempmc(i)=2;
        else
            tempc=Fd+d1;%0-->11-->01  ���������01  0+1+1=0 0+1=1
            tempmc=md;
            tempmc(i)=3;
        end
        
        if Fb+d1<Fd+d2 %����11״̬������·���Ƚϴ�С
            tempd=Fb+d1;%1-->10-->11 ���������01  1+1+0=0 1+0=1
            tempmd=mb;
            tempmd(i)=2;
        else
            tempd=Fd+d2;%1-->11-->11 ���������10  1+1+1=1 1+1=0
            tempmd=md;
            tempmd(i)=3;
        end
        Fa=tempa;Fb=tempb;Fc=tempc;Fd=tempd;
        
        ma=tempma;mb=tempmb;mc=tempmc;md=tempmd;
    end
end
%============================================================================%
%���Fȡ��Сֵ������·��Ϊ����·����
%ͬʱ����Ǹ���������һ��Ԫ��Ϊ��Ӧ������
%��������·�������
%============================================================================%
temp=min([Fa,Fb,Fc,Fd]);
    if Fa==temp
        ma(s+1)=0;
        for t=1:s
            if ma(t)<ma(t+1)
                m(t)=1;
            elseif (ma(t)==ma(t+1)) && (ma(t)==3)
                m(t)=1;
            else
                m(t)=0;
            end
        end
    elseif Fb==temp
        mb(s+1)=2;
        for t=1:s
            if mb(t)<mb(t+1)
                m(t)=1;
            elseif (mb(t)==mb(t+1)) && (mb(t)==3)
                m(t)=1;
            else
                m(t)=0;
            end
        end
    elseif Fc==temp
        mc(s+1)=1;
        for t=1:s
            if mc(t)<mc(t+1)
                m(t)=1;
            elseif (mc(t)==mc(t+1)) && (mc(t)==3)
                m(t)=1;
            else
                m(t)=0;
            end
        end
    elseif Fd==temp
        md(s+1)=3;
        for t=1:s
            if md(t)<md(t+1)
                m(t)=1;
            elseif (md(t)==md(t+1)) && (md(t)==3)
                m(t)=1;
            else
                m(t)=0;
            end
        end
    end
end