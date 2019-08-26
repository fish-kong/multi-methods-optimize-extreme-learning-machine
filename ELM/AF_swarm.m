function [Xnext,Ynext]=AF_swarm(X,i,visual,step,deta,try_number,LBUB,lastY,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test)
% ��Ⱥ��Ϊ
%���룺
%X           �����˹����λ��
%i           ��ǰ�˹�������
%visual      ��֪��Χ
%step        ����ƶ�����
%deta        ӵ����
%try_number  ����Դ���
%LBUB        ��������������
%lastY       �ϴεĸ��˹���λ�õ�ʳ��Ũ��

%�����
%Xnext       Xi�˹������һ��λ��  
%Ynext       Xi�˹������һ��λ�õ�ʳ��Ũ��
Xi=X(:,i);
D=dist(Xi,X);
index=find(D>0 & D<visual);
nf=length(index);
if nf>0
    for j=1:size(X,1)
        Xc(j,1)=mean(X(j,index));
    end
    Yc=fun(Xc',inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
    Yi=lastY(i);
    if Yc/nf>deta*Yi
        Xnext=Xi+rand*step*(Xc-Xi)/norm(Xc-Xi);
        for i=1:length(Xnext)
            if  Xnext(i)>LBUB(2)
                Xnext(i)=rand;
            end
            if  Xnext(i)<LBUB(1)
                Xnext(i)=rand;
            end
        end
        Ynext=fun(Xnext',inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
    else
        [Xnext,Ynext]=AF_prey(Xi,i,visual,step,try_number,LBUB,lastY,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test);
    end
else
    [Xnext,Ynext]=AF_prey(Xi,i,visual,step,try_number,LBUB,lastY,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test);
end%���۸����㷨�Ż���ȼ���ѧϰ������392503054