%�����е�m0���ڵ�����翪ʼ�����������������������ӵĻ�������BA�ޱ������
%��ʼ��
m0 = 3; %δ����ǰ������ڵ����m0
m = 3; %ÿ�������½ڵ������ɵı���m          %��������m������6����������mС����3
N=100; %������������ģN
%����һ��m0�У�0,1������������������ǰm0���ڵ��������
x=N*rand(1,m0);
y=N*rand(1,m0);

A=ones(m0); %A��������������ڽӾ���m0*m0��ȫԪ��Ϊ1�ľ���
for i=1:m0
  A(i,i)=0; %��ֹ�����ӣ������4���ڵ�����Լ������3���ڵ㶼����
end

for k=m0+1:N %�������ӵĽڵ�
    M=size(A,1); %����A���������
    p=zeros(1,M);
    x0=N*rand(1,1);
    y0=N*rand(1,1);
    x(k)=x0;y(k)=y0; %Ϊ�����ӵĽڵ��������꣬���ڿ��ӻ�
    if length(find(A==1))==0 %��A��û�����ӵĽڵ㣬��ÿ�����Ȩ��һ��
        p(:)=1/M;
    else
         for i=1:M
             p(i)=length(find(A(i,:)==1))/length(find(A==1));   %����ǰ�����еĽڵ�Ȩ�أ�˭���ӵı����࣬i�Žڵ��������������нڵ���������
         end
    end
    pp=cumsum(p);          %���ۼƸ���
    for i=1:m              %���ö��ַ������еĽڵ������ѡ��m���ڵ����¼���Ľڵ�����
        random_data=rand(1,1); %ȡ�����
        aa=find(pp>=random_data);jj=aa(1); % �ڵ�jj��Ϊ�ö��ַ�ѡ��������½ڵ�ľɽڵ�
        A(k,jj)=1;A(jj,k)=1;
    end
end
plot(x,y,'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',12); %���㡣ro��ָ�ڻ�ͼʱ��ֻ����ɫ��Ȧ����x��y�Ľ��㡣��ı�ԵΪ��ɫ�����Ϊ��ɫ����СΪ8
hold on;

for i=1:N 
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'k','linewidth',0.1); 
            hold on;      %% ����BA�ޱ������ͼ������
        end
    end
end 


AA=A;
for i=1:N
  for j=i+1:N
      if AA(i,j)~=0
        %���������ϵǿ�Ƚ�С
        %AA(i,j)=normrnd(0.5,0.2,[1 1]);
        %���������ϵǿ�Ƚϴ�
        AA(i,j)=normrnd(1,0.2,[1 1]);
        if AA(i,j)<0
            AA(i,j)=0.01;
        end
        if AA(i,j)>1
            AA(i,j)=1;
        end
      AA(j,i)=AA(i,j);
      end
  end
end


