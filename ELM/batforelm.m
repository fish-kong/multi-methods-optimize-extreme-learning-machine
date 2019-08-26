function [y,trace]=batforelm(inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test)

para=[20 100 0.5 0.5 0 2 0 1];  
%%
n=para(1);            % Population size, typically 10 to 40 ��Ⱥ��С��һ��20ֻ����
N_gen=para(2);        % Number of generations  ������
A=para(3);            % Loudness  (constant or decreasing) ���ͳ�����������
r=para(4);            % Pulse rate (constant or decreasing)���ͳ�������ļ����������
Fmin=para(5);         % Frequency minimum ����Ƶ����Сֵ
Fmax=para(6);         % Frequency maximum����Ƶ�����ֵ
Xmin=para(7);
Xmax=para(8);         % �߽��С�������Ż���������ڵ�����Χ�߽�
N_iter=0;             % Total number of function evaluations
d=inputnum*hiddennum+hiddennum;;          % Number of dimensions ÿ��������d�����ԣ�������dά�ռ�������
F=zeros(n,1);         % ��ʼ������Ƶ�� Frequency
v=zeros(n,d);         % ��ʼ���ٶ�    Velocities
trace=[];
%% �����ʼ��ֵ�����ʼ��ֵλ��
for i=1:n
  X(i,:)=(Xmin+(Xmax-Xmin).*rand(1,d));
  Fitness(i)=fun(X,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
end
[fit,I]=max(Fitness); % fim ��ʼ��ֵ
best=X(I,:);           % ��ʼȫ�����Ž��λ��

%% ���չ�ʽ���ε���ֱ�����㾫�Ȼ��ߵ�������
%for t=1:N_gen, %1000��   Ҳ������Ƴ�����һ����ֵwhile (fmin>1e-5)....end
for  t=1:N_gen
      t
        for i=1:n  %10
          F(i)=Fmin+(Fmin-Fmax)*rand;
          v(i,:)=v(i,:)+(X(i,:)-best)*F(i);
          S(i,:)=X(i,:)+v(i,:);
          % ����λ�ã��ٶȣ�Ƶ��
          % Pulse rate
          if rand>r  %����ѽ���ѡ��һ��,Χ��ѡ��Ľ����һ���ֲ���
          sigmoid=0.001;% ��������
              S(i,:)=best+sigmoid*randn(1,d);%%�ֲ���
          end
          
          S(i,:)=boundary(S(i,:));%%��������������ֲ����Ž���û����Ѱ�ŷ�Χ��
          
     % Evaluate new solutions
             Fnew=fun(S(i,:),inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test); 
     % Update if the solution improves, or not too loud
           if (Fnew>=Fitness(i)) && (rand<A) ,
                X(i,:)=S(i,:);
                Fitness(i)=Fnew;
                %%����½���ţ���ʱ�����½⣬��������ӿ췢�������Ĵ���r���Լ���Сÿ�����������A
                %�������Ϊ�˷��㣬ʡ���˴˲���
           end

          % Update the current best solution
          if Fnew>=fit
                best=S(i,:);
                fit=Fnew;
          end%���ֲ��½���µ�ȫ�����Ž���
        end
        N_iter=N_iter+n;
        trace(t)=fit;
end
y=best;
%���۸����㷨�Ż���ȼ���ѧϰ������392503054