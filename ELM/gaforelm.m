function [bestchrom ,trace]=gaforelm(inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test)
%% �Ŵ��㷨������ʼ��
maxgen=100;                         %��������������������
sizepop=20;                        %��Ⱥ��ģ
pcross=[0.7];                       %�������ѡ��0��1֮��
pmutation=[0.05];                    %�������ѡ��0��1֮��
%�ڵ�����
numsum=inputnum*hiddennum+hiddennum;
lenchrom=ones(1,numsum);       
bound=[-1*ones(numsum,1) 1*ones(numsum,1)];    %���ݷ�Χ
%------------------------------------------------------��Ⱥ��ʼ��------------------------------%------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %����Ⱥ��Ϣ����Ϊһ���ṹ��
avgfitness=[];                      %ÿһ����Ⱥ��ƽ����Ӧ��
bestfitness=[];                     %ÿһ����Ⱥ�������Ӧ��
bestchrom=[];                       %��Ӧ����õ�Ⱦɫ��
trace=0;
%��ʼ����Ⱥ
for i=1:sizepop
    %�������һ����Ⱥ
    individuals.chrom(i,:)=Code(lenchrom,bound);    %����
    x=individuals.chrom(i,:);
    %������Ӧ��
    individuals.fitness(i)=fun(x,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test);   %Ⱦɫ�����Ӧ��
end

%����õ�Ⱦɫ��
[bestfitness bestindex]=max(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);  %��õ�Ⱦɫ��
%% ���������ѳ�ʼ��ֵ��Ȩֵ
% ������ʼ
for i=1:maxgen
    
    %ѡ��
    individuals=select(individuals,sizepop);
    %����
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    %����
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    % ������Ӧ��
    for j=1:sizepop
        x=individuals.chrom(j,:); %����
        individuals.fitness(j)=fun(x,inputnum,hiddennum,TYPE,activation,inputn_train,label_train,inputn_test,label_test);
    end
  %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=max(individuals.fitness);
    [worestfitness,worestindex]=min(individuals.fitness);
    % ������һ�ν�������õ�Ⱦɫ��
    if bestfitness<newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(bestindex,:)=bestchrom;
    individuals.fitness(bestindex)=bestfitness;
    trace(i)=bestfitness ;%��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
    
end

end