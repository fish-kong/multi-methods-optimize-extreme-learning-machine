function [y,trace]=afforelm(inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test)
%%  ��������
fishnum=20;    %����50ֻ�˹���
MAXGEN=100;     %����������
try_number=100;%�����̽����
visual=1;      %��֪����
delta=0.618;   %ӵ��������
step=0.1;      %����
xmin=-1;
xmax=2;%Ѱ�ŷ�Χ
x=[xmin;xmax];
d=inputnum*hiddennum+hiddennum;
gen=1;
%% ��ʼ����Ⱥ
for i=1:fishnum
  X(:,i)=(xmin+(xmax-xmin).*rand(1,d));
  Y(1,i)=fun(X(:,i)',inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
end
[fit,I]=max(Y); % fim ��ʼ��ֵ
BestX=[]; 
BestY=[];   %ÿ�������ŵĺ���ֵ

besty=0;                %���ź���ֵ
%% 
while gen<=MAXGEN
    gen
    for i=1:fishnum
        [Xi1,Yi1]=AF_swarm(X,i,visual,step,delta,try_number,x,Y,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test);     %��Ⱥ��Ϊ �õ���λ�ú�����Ӧ��
        [Xi2,Yi2]=AF_follow(X,i,visual,step,delta,try_number,x,Y,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test);    %׷β��Ϊ
        if Yi1>Yi2
            X(:,i)=Xi1;
            Y(1,i)=Yi1;
        else
            X(:,i)=Xi2;
            Y(1,i)=Yi2;%���бȽϸ���
        end
    end
    [Ymax,index]=max(Y);

    if Ymax>besty
        besty=Ymax;
        bestx=X(:,index);
        BestY(gen)=Ymax;
        BestX(:,gen)=X(:,index);
    else
        BestY(gen)=BestY(gen-1);
        BestX(:,gen)=BestX(:,gen-1);
    end    
    gen=gen+1;
end
y=bestx';
trace=BestY;
end%���۸����㷨�Ż���ȼ���ѧϰ������392503054
