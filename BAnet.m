%从已有的m0个节点的网络开始，采用增长机制与优先连接的机制生成BA无标度网络
%初始化
m0 = 3; %未增长前的网络节点个数m0
m = 3; %每次引入新节点新生成的边数m          %线上网络m大例如6，线下网络m小例如3
N=100; %增长后的网络规模N
%产生一行m0列（0,1）间的随机数，即产生前m0个节点的坐标数
x=N*rand(1,m0);
y=N*rand(1,m0);

A=ones(m0); %A返回生成网络的邻接矩阵，m0*m0的全元素为1的矩阵
for i=1:m0
  A(i,i)=0; %防止自连接，即最初4个节点与除自己以外的3个节点都相连
end

for k=m0+1:N %对新增加的节点
    M=size(A,1); %返回A矩阵的行数
    p=zeros(1,M);
    x0=N*rand(1,1);
    y0=N*rand(1,1);
    x(k)=x0;y(k)=y0; %为新增加的节点设置坐标，用于可视化
    if length(find(A==1))==0 %若A中没有连接的节点，则每个结点权重一样
        p(:)=1/M;
    else
         for i=1:M
             p(i)=length(find(A(i,:)==1))/length(find(A==1));   %计算前面已有的节点权重（谁连接的边数多，i号节点连接数除以所有节点连接数）
         end
    end
    pp=cumsum(p);          %求累计概率
    for i=1:m              %利用赌轮法从已有的节点中随机选择m个节点与新加入的节点相连
        random_data=rand(1,1); %取随机数
        aa=find(pp>=random_data);jj=aa(1); % 节点jj即为用赌轮法选择的连接新节点的旧节点
        A(k,jj)=1;A(jj,k)=1;
    end
end
plot(x,y,'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',12); %画点。ro是指在绘图时，只画红色的圈，即x和y的交点。点的边缘为绿色，填充为红色，大小为8
hold on;

for i=1:N 
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'k','linewidth',0.1); 
            hold on;      %% 画出BA无标度网络图，画线
        end
    end
end 


AA=A;
for i=1:N
  for j=i+1:N
      if AA(i,j)~=0
        %线上网络关系强度较小
        %AA(i,j)=normrnd(0.5,0.2,[1 1]);
        %线下网络关系强度较大
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


