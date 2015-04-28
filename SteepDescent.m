function [x,flag] = SteepDescent(f,g,x0,TOL)
x = x0;
flag = 0;
count = 0;
while(norm(g(x)) > TOL)
    count = count + 1;
    
    if(count > 10^5)
        flag = 1;
        x= zeros(1);
        return;
    end
    
    s = -g(x);
   alpha = 0.01;
    [x,flag2] = LineSearch(f,g,x,s,TOL);
    if(flag2 == 1)
        flag = 1;
        x= zeros(1);
        return;
    end
  
    x = x + s*(alpha);
    
end