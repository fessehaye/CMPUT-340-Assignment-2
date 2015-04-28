function [x,flag] = Bisection(f,x0,TOL)
b=x0;m=0;
a=x0;
flag = 1;

b1=b;b2=b;
while(sign(f(a)) == sign(f(b)))
    b1 = b1 + 1;
    b2 = b2 - 1;
    
    if(sign(f(b1)) ~= sign(f(a)))
        b=b1;
        break;
    elseif(sign(f(b2)) ~= sign(f(a)))
        b=b2;
        break;
    end
end

if(a > b)
    temp = a;
    a = b;
    b = temp;
end

for j = 1:10000
    if(b-a < TOL)
        flag = 0;
        break;
    end
    m = a + (b-a)/2;
    if (sign(f(a)) == sign(f(m)))
        a = m;
    else
        b = m;
    end
end

x = m;