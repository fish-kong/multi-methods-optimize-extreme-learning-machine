function [y,trace]=antforelm(inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test);%��Ⱥ�㷨%%%%%%%%%%%%%%%%%%%%��Ⱥ�㷨������ֵ%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%��ʼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=20;                    %���ϸ���
G_max=100;               %����������
Rho=0.5;                 %��Ϣ������ϵ��
P0=0.5;                  %ת�Ƹ��ʳ���
XMAX= 1;                 %��������x���ֵ
XMIN=0;                %��������x��Сֵ
d=inputnum*hiddennum+hiddennum;;     
%%%%%%%%%%%%%%%%%����������ϳ�ʼλ��%%%%%%%%%%%%%%%%%%%%%%
for i=1:m
    X(i,:)=(XMIN+(XMAX-XMIN).*rand(1,d));
    Tau(i)=fun(X(i,:),inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
end
step=0.1;                %�ֲ���������
for NC=1:G_max
    NC
    lamda=1/NC;
    [Tau_best,BestIndex]=max(Tau);
    %%%%%%%%%%%%%%%%%%����״̬ת�Ƹ���%%%%%%%%%%%%%%%%%%%%
    for i=1:m
        P(NC,i)=(Tau(BestIndex)-Tau(i))/Tau(BestIndex);
    end
    %%%%%%%%%%%%%%%%%%%%%%λ�ø���%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:m
           %%%%%%%%%%%%%%%%%�ֲ�����%%%%%%%%%%%%%%%%%%%%%%
        if P(NC,i)<P0
            temp1=X(i,:)+(rand(1,d))*step*lamda;
           
        else
            %%%%%%%%%%%%%%%%ȫ������%%%%%%%%%%%%%%%%%%%%%%%
             temp1=X(i,:)+(XMAX-XMIN)*(rand(1,d));
        end
        %%%%%%%%%%%%%%%%%%%%%�߽紦��%%%%%%%%%%%%%%%%%%%%%%%
        if temp1<XMIN
            temp1=rand;
        end
        if temp1>XMAX
            temp1=rand;
        end
        %%%%%%%%%%%%%%%%%%�����ж��Ƿ��ƶ�%%%%%%%%%%%%%%%%%%
        if fun(temp1,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test)>fun(X(i,:),inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test)
            X(i,:)=temp1;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%������Ϣ��%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:m
        Tau(i)=(1-Rho)*Tau(i)+fun(X(i,:),inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
    end
    [value,index]=max(Tau);
    trace(NC)=fun(X(index,:),inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
    
end
[min_value,max_index]=max(Tau);
minX=X(max_index,:);                           %���ű���
minValue=fun(X(max_index,:),inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test);   %����ֵ 

y=minX;
end
%���۸����㷨�Ż���ȼ���ѧϰ������392503054