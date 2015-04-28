function [x,flag] = SafeSecant1D(f,x0,TOL)
b=x0;
a=x0;
flag=1;

b1=b;
b2=b;
while(sign(f(a)) == sign(f(b)))
    b1 = b1 + 1;
    b2 = b2 - 1;
    
    if(sign(f(b1)) ~= sign(f(b)))
        b=b1;
        break;
    elseif(sign(f(b2)) ~= sign(f(b)))
        b=b2;
        break;
    end
end

if(a > b)
    temp = a;
    a = b;
    b = temp;
end

prev = a;
x = b;
xk_1 = 0;

for j = 1:10000
    if(b-a < TOL)
       flag = 0;
       break;
    end
    
        xk_1 =  x - (f(x)*(x - prev)) / (f(x)-f(prev));
        if(xk_1 >= b || xk_1 <= a)
            xk_1 = a + (b-a)/2;
        end
        if (sign(f(a)) == sign(f(xk_1)))
            a = xk_1;
        else
            b = xk_1;
        end
        prev = x;
        x = xk_1;
end
x = xk_1;