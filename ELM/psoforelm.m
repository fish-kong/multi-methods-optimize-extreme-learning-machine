function [y ,trace]=psoforelm(inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test)
ger = 200; %种群迭代次数
N = 50;  %种群数
d=inputnum*hiddennum+hiddennum;
hid=d;
hmin=-1;
hmax=1;;
wmax = 0.9;  wmin=0.5;
cmax = 0.9;  cmin=0.5;
for i=1:hid
    xlim(i,1:2)=[hmin,hmax];
    vlim(i,1:2)=[-1,1];
end
xlimit = xlim(:,1:2);  
vlimit =vlim(:,1:2);  
%% 种群初始化  
x1 = repmat(xlimit(:,1)',N,1)+repmat(diff(xlimit'),N,1).*rand(N,d);  
x=boundary(x1);
v = repmat(vlimit(:,1)',N,1)+repmat(diff(vlimit'),N,1).*rand(N,d);  

xm = x;  
fxm = -inf*ones(N,1);  
ym = xlimit(:,1)'+diff(xlimit').*rand(1,d);  
fym = -inf;  
%% 开始搜索  
for i = 1 : ger  
    t=i
    for j = 1 : N  
        % 适应度函数 
        x=boundary(x);
       y(j)=fun(x,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
        if y(j)>fxm(j)  
                 fxm(j)=y(j);  
                xm(j,:) = x(j,:);     %个体极值最优位置
        end  
         if y(j)>fym  
                fym = y(j);  
                ym = x(j,:); %群体极值最优位置
         end  
    end  
    fit(i)=fym;
    w=wmax-(wmax-wmin)*i./ger;
    c1=cmax-(cmax-cmin)*i./ger;
    c2=cmin+(cmax-cmin)*i./ger;
    v = w*v+c1*rand*(xm-x)+c2*rand*(repmat(ym,N,1)-x);  
    x = x+v;  
    
    x = min(x,repmat(xlimit(:,2)',N,1));  
    x = max(x,repmat(xlimit(:,1)',N,1));  
    v = min(v,repmat(vlimit(:,2)',N,1));  
    v = max(v,repmat(vlimit(:,1)',N,1));  
end  
trace=fit;
y=xm;
end%出售各类算法优化深度极限学习机代码392503054