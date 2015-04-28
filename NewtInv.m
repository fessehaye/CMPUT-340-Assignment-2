function [Ainv] = NewtInv(A)

x = transpose(A) / (norm(A,1)*norm(A,Inf));
TOL = 10^-6;
f = @(x)(eye(length(A)) - A*x);

while (norm(f(x)) > TOL)
        x =  x + x*(eye(length(A)) - A*x);
end

Ainv = x;
