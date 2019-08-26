function [IW,B,LW,TF,TYPE,T] = elmtrain(P_train,T,N,TF,TYPE)
%��Ȼ�����������elmtrain����6�����������������nargin=6��������Щʡ�Ե�ʱ�򣬾�Ҫ�õ����漸��������Ĭ�ϸ�ֵ
if nargin < 2
    error('ELM:Arguments','Not enough input arguments.');
end  %�������������ڵ���2���������޷����н�ģ����Ϊ����Ҫ����������������
if nargin < 3
    N = size(P_train,2); %���ֻ�����������Ĭ����������ԪΪ������
end
if nargin < 4
    TF = 'sig';%���ֻ��������룬��������Ԫ������Ĭ�ϼ����Ϊsigmoid����
end
if nargin < 5
    TYPE = 0;%���û�ж��庯�������ã�Ĭ��Ϊ�ع����
end
% ���л����϶������������ж������Ǽ��������ģ����������⼸��һ���ò���������������������
%%%%%%%%%%%%*****************************

if size(P_train,2) ~= size(T,2)
    error('ELM:Arguments','The columns of P and T must be same.');
end
%����������������������������һ�¡�
[R,Q] = size(P_train);%
if TYPE  == 1
    T1  = ind2vec(T);
end
%���������Ƿ��࣬�ͽ�ѵ�����תΪ��������   http://blog.csdn.net/u011314012/article/details/51191006
[S,Q] = size(T1); %

% �����������Ȩ�ؾ���
IW = rand(N,R) * 2 - 1;

% �����������ƫ��
B = rand(N,1);
BiasMatrix = repmat(B,1,Q);

% �����������H
tempH = IW * P_train + BiasMatrix;
switch TF
    case 'sig'
        H = 1 ./ (1 + exp(-tempH));
    case 'sin'
        H = sin(tempH);
    case 'hardlim'
        H = hardlim(tempH);
end
% �������㵽�����֮���Ȩ��
LW = pinv(H') * T1';
TY=(H'*LW)';

if TYPE  == 1
    temp_Y=zeros(1,size(TY,2));
    for n=1:size(TY,2)
        [max_Y,index]=max(TY(:,n));
        temp_Y(n)=index;
    end
    Y_train=temp_Y;
    train_accuracy=sum(Y_train==T)/length(T);
end
if TYPE==0
    train_accuracy=mse(TY,T);
end
end
%pinv��inv������������������󣬵���inv��֪������������������õ�
%������������Ƿ�������������ʱ�����߸�������������󣬾���PINV��α�����