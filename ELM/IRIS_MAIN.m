%% ��ջ������� elm
clc
clear
close all
format compact
%% ��ȡ����
load iris_data;%3����
input=features;
output=classes;
%% ���ѡ����Լ���ѵ���� 7:3����
[~,n]=sort(rand(1,size(input,1)));
m=round(size(input,1)*0.7);

input_train=input(n(1:m),:)';
input_test=input(n(m+1:end),:)';
label_train=output(n(1:m),:)';
label_test=output(n(m+1:end),:)';

%�������ݹ�һ��
[inputn_train,inputps]=mapminmax(input_train);
[inputn_test,inputtestps]=mapminmax('apply',input_test,inputps);
%% ELM��������
inputnum=size(input_train,1);%�����ڵ�
hiddennum=5;%������ڵ�
activation='sin';%�����sin,sig  hardlim
TYPE=1;%1-���� 0-�ع�
%% û���Ż���ELM
[IW,B,LW,TF,TYPE] = elmtrain(inputn_train,label_train,hiddennum,activation,TYPE);
%% ELM�������
Tn_sim = elmpredict(inputn_test,IW,B,LW,TF,TYPE);
test_accuracy=(sum(label_test==Tn_sim))/length(label_test)
stem(label_test,'*')
hold on
plot(Tn_sim,'p')
title('û���Ż���ELM')
legend('�������','ʵ�����')
xlabel('������')
ylabel('����ǩ')
%% �ڵ����

[bestchrom,trace]=gaforelm(inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test);%�Ŵ��㷨


%% �Ż���������
figure
[r c]=size(trace);
plot(trace,'b--');
title('��Ӧ������ͼ')
xlabel('��������');ylabel('�����ȷ��');
x=bestchrom;
%% �����ų�ʼ��ֵȨֵ����ELM����ѵ����Ԥ��
TYPE=1;
if TYPE  == 1
    T1  = ind2vec(label_train);
end
w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum)';
%% train
W=reshape(w1,hiddennum,inputnum);
Q=size(inputn_train,2);
BiasMatrix = repmat(B1,1,Q);
tempH = W * inputn_train + BiasMatrix;
switch activation
    case 'sig'
        H = 1 ./ (1 + exp(-tempH));
    case 'sin'
        H = sin(tempH);
    case 'hardlim'
        H = hardlim(tempH);
end
LW = pinv(H') * T1';
%% test
Tn_sim = elmpredict(inputn_test,W,B1,LW,activation,TYPE);

youhua_test_accuracy=sum(Tn_sim==label_test)/length(label_test)
figure
stem(label_test,'*')
hold on
plot(Tn_sim,'p')
title('�Ż����ELM')
legend('�������','ʵ�����')

