function [Xnext,Ynext]=AF_prey(Xi,ii,visual,step,try_number,LBUB,lastY,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test)
%��ʳ��Ϊ
%���룺
%Xi          ��ǰ�˹����λ��
%ii          ��ǰ�˹�������
%visual      ��֪��Χ
%step        ����ƶ�����
%try_number  ����Դ���
%LBUB        ��������������
%lastY       �ϴεĸ��˹���λ�õ�ʳ��Ũ��

%�����
%Xnext       Xi�˹������һ��λ��  
%Ynext       Xi�˹������һ��λ�õ�ʳ��Ũ��

Xnext=[];
Yi=lastY(ii);
for i=1:try_number
    Xj=Xi+(2*rand(length(Xi),1)-1)*visual;
    Yj=fun(Xj',inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
    if Yi<Yj
        Xnext=Xi+rand*step*(Xj-Xi)/norm(Xj-Xi);
        for i=1:length(Xnext)
            if  Xnext(i)>LBUB(2)
                Xnext(i)=rand;
            end
            if  Xnext(i)<LBUB(1)
                Xnext(i)=rand;
            end
        end
        Xi=Xnext;
        break;
    end
end

%�����Ϊ
if isempty(Xnext)
    Xj=Xi+(2*rand(length(Xi),1)-1)*visual;
    Xnext=Xj;
    for i=1:length(Xnext)
        if  Xnext(i)>LBUB(2)
            Xnext(i)=rand;
        end
        if  Xnext(i)<LBUB(1)
            Xnext(i)=rand;
        end
    end
end
Ynext=fun(Xnext',inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); %���۸����㷨�Ż���ȼ���ѧϰ������392503054
