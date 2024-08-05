

function[y] = ProxBlock(x, gamma, blocksize, delta)
num = size(x,1);
n = size(x);
y = zeros(n);
bnum = [fix(n(2)/blocksize),fix(n(3)/blocksize)];
pnum = [fix(blocksize/delta),fix(blocksize/delta)];

for shif_i = 1:pnum(1)
    for shif_j = 1:pnum(2)
        x_shift = circshift(x,[0,(shif_i-1)*delta,(shif_j-1)*delta,0]);
        y_add = zeros(n);
        for i =1:num
            for j=1:n(4)
                for k = 1:bnum(1)
                    for l = 1:bnum(2)
                        [U, S, V] = svd(squeeze(x_shift(i,1+blocksize*(k-1):blocksize*k,1+blocksize*(l-1):blocksize*l,j)));
                        y_add(i,1+blocksize*(k-1):blocksize*k,1+blocksize*(l-1):blocksize*l,j)= U*max(S-gamma*blocksize/delta,0)*V';
                    end
                end
            end
        end
        y = y + circshift(y_add,[0,-(shif_i-1)*delta,-(shif_j-1)*delta,0]);
    end
end
y = y*delta^2/blocksize^2;
