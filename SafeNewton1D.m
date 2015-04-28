function [x,flag] = SafeNewton1D(f,g,x0,TOL)
b=x0;x=x0;
a=x0;
flag=0;

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

for j = 1:10000
    if(b-a < TOL)
       flag = 0;
       break;
    end
        x =  x - f(x)/g(x);
        if(x >= b || x <= a)
            x = a + (b-a)/2;
        end
        if (sign(f(a)) == sign(f(x)))
            a = x;
        else
            b = x;
        end
end
