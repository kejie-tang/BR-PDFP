function [G] = get_W(r, b,min_con, type)
%GET_W 此处显示有关此函数的摘要
%   此处显示详细说明
nodes = r+b;
while true
    if(type==0)
        G = rand([nodes,nodes])<0.5;
        for i=1:nodes
            G(i,i) = 0;
            for j=(i+1):nodes
                G(i,j) = G(j,i);
            end
        end
    elseif (type==1)
        G = zeros([nodes,nodes]);
        G(1,2) = 1;
        G(2,1) = 1;
        G(nodes,nodes-1) = 1;
        G(nodes-1,nodes) = 1;
        for i=2:nodes-1
            G(i,i+1) = 1;
            G(i+1,i) = 1;
            G(i,i-1) = 1;
            G(i-1,i) = 1;
        end
    elseif (type==2)
        G = zeros([nodes,nodes]);
        for i=2:nodes/2
            G(1,i) = 1;
            G(i,1) = 1;
        end
        for i=nodes/2+2:nodes
            G(nodes/2+1,i) = 1;
            G(i,nodes/2+1) = 1;
        end
        G(1,nodes/2+1) = 1;
        G(nodes/2+1,1) = 1;
    elseif (type==3)
        G = zeros([nodes,nodes]);
        p = 5;
        q = 10;
        for i=1:p
            for j=1:q-1
                idx = (i-1)*q+j;
                G(idx,idx+1) = 1;
                G(idx+1,idx) = 1;
            end
        end
        for i=1:p-1
            for j=1:q
                idx = (i-1)*q+j;
                G(idx,idx+q) = 1;
                G(idx+q,idx) = 1;
            end
        end
    elseif (type==4)
        G = zeros([nodes,nodes]);
        n = nodes/2;
        for i=2:n
            G(1,i) = 1;
            G(i,1) = 1;
        end
        for i=(n+2):nodes
            G(n+1,i) = 1;
            G(i,n+1) = 1;
        end
        G(1,n+1) = 1;
        G(n+1,1) = 1;
    end
    deg_G = sum(G,2);
    if min(deg_G)>min_con
        break
    end
end

end

