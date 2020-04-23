function m=viterbi_de(x)
a=size(x);
s=a(2)/2;        %译码后的m序列长度为x的一半
m=zeros(1,s);     %最终结果存放
ma=zeros(1,s+1);  %存放Fa路径的
mb=zeros(1,s+1);  %存放Fb路径的
mc=zeros(1,s+1);  %存放Fc路径的
md=zeros(1,s+1);  %存放Fd路径的
tempma=zeros(1,s+1);%每个时刻的最小路径值
tempmb=zeros(1,s+1);%每个时刻的最小路径值
tempmc=zeros(1,s+1);%每个时刻的最小路径值
tempmd=zeros(1,s+1);%每个时刻的最小路径值
Fa=0;Fb=0;Fc=0;Fd=0;
for i=1:s
% for i=1:3
    if i==1 %接收到的序列为11
        d0=dis(x(1),x(2),0,0);%0-->00-->00 编码器输出00 0+0+0=0 0+0=0
        d3=dis(x(1),x(2),1,1);%1-->10-->00 编码器输出00 1+0+0=1 1+0=1
        
        Fa=Fa+d0;
        Fb=Fb+d3;
        
        ma(i)=0;
        mb(i)=0;
        mc(i)=0;
        md(i)=0;
        continue;
    elseif i==2 %接收到的序列为10
        d0=dis(x(3),x(4),0,0);%d0=1
        d1=dis(x(3),x(4),0,1);%d1=2
        d2=dis(x(3),x(4),1,0);%d2=0
        d3=dis(x(3),x(4),1,1);%d3=1
        %注意下面的顺序，不能错，否则会产生数据相关，要么加中间变量。
        Fc=Fb+d2;   %0-->10-->01 0+1+0=1(高位) 0+0=0（低位） 编码器输出为：10
        Fd=Fb+d1;   %1-->10-->11 1+1+0=0 1+0=1 编码器出书为：01
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
        %下面开始进行加比较选，选F值小的路径
        tempa=Fa;tempb=Fb;tempc=Fc;tempd=Fd;
        if Fa+d0<Fc+d3 %到达00状态的两条路径比较大小
            tempa=Fa+d0; %0-->00-->00 编码器输出00 0+0+0=0 0+0=0
            tempma=ma;
            tempma(i)=0;
        else
            tempa=Fc+d3;%0-->01-->00 编码器输出11  0+0+1=1 0+1=1
            tempma=mc;
            tempma(i)=1;
        end
        
        if Fa+d3<Fc+d0 %到达10状态的两条路径比较大小
            tempb=Fa+d3;%1-->00-->10 编码器输出11  1+0+0=1 1+0=1
            tempmb=ma;
            tempmb(i)=0;
        else
            tempb=Fc+d0;%1-->01-->10 编码器输出00  1+0+1=0 1+1=0
            tempmb=mc;
            tempmb(i)=1;
        end
        
        if Fb+d2<Fd+d1 %到达01状态的两条路径比较大小
            tempc=Fb+d2;%0-->10-->01  编码器输出10  0+1+0=1 0+0=0  
            tempmc=mb;
            tempmc(i)=2;
        else
            tempc=Fd+d1;%0-->11-->01  编码器输出01  0+1+1=0 0+1=1
            tempmc=md;
            tempmc(i)=3;
        end
        
        if Fb+d1<Fd+d2 %到达11状态的两条路径比较大小
            tempd=Fb+d1;%1-->10-->11 编码器输出01  1+1+0=0 1+0=1
            tempmd=mb;
            tempmd(i)=2;
        else
            tempd=Fd+d2;%1-->11-->11 编码器输出10  1+1+1=1 1+1=0
            tempmd=md;
            tempmd(i)=3;
        end
        Fa=tempa;Fb=tempb;Fc=tempc;Fd=tempd;
        
        ma=tempma;mb=tempmb;mc=tempmc;md=tempmd;
    end
end
%============================================================================%
%最后F取最小值的那条路径为最优路径，
%同时标记那个数组的最后一个元素为相应的数字
%并将最后的路径算出来
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