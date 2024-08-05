% Author: Shunsuke Ono (ono@sp.ce.titech.ac.jp)

function[y] = Block(x, blocksize, delta)
num = size(x,1);
n = size(x);
y = 0;
bnum = [fix(n(2)/blocksize),fix(n(3)/blocksize)];
pnum = [fix(blocksize/delta),fix(blocksize/delta)];
for shif_i = 1:pnum(1)
    for shif_j = 1:pnum(2)
        x_shift = circshift(x,[0,(shif_i-1)*delta,(shif_j-1)*delta,0]);
        for i = 1:num
            for j =1:n(4)
                for k = 1:bnum(1)
                    for l = 1:bnum(2)
                        S = svd(squeeze(x_shift(i,1+blocksize*(k-1):blocksize*k,1+blocksize*(l-1):blocksize*l,j)));
                        y = y + sum(S,"all");
                    end
                end
            end
        end
    end
end
