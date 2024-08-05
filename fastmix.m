function [xt] = fastmix(x0,connection, b, K)
%FASTMIX 此处显示有关此函数的摘要
%   此处显示详细说明
deg_G = sum(connection,2);
size_orig = size(x0);
nodes = size(x0,1);
x0 = reshape(x0, nodes,[]);
[nodes,p] = size(x0);
r = nodes-b;
xt = zeros([nodes,p]);
for k=1:K
    for i=1:r
        B = zeros([deg_G(i),p]);%(rand([deg_G(i),p])-0.5)*10;
        id = 1;
        for j=1:r
            if (connection(i,j)==1)
                B(id,:) = x0(j,:);
                id = id+1;
            end
        end
        xt(i,:) = trimed_mean(B,b);
    end
    x0 = xt;
end
xt = reshape(xt, size_orig);
end

