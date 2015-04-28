function [x,flag] = ConjGradient(f,g,x0,TOL)
x = x0;
newg = g(x);
s = -newg;
count = 0;
flag = 0;
while(norm(g(x)) > TOL)
    count = count + 1;
    
    if(count > 10^5)
        flag = 1;
        x= zeros(1);
        return;
    end
    
   alpha = 0.01;
    [x,flag2] = LineSearch(f,g,x,s,TOL);
    if(flag2 == 1)
        flag = 1;
        x= zeros(1);
        return;
    end
  
    x = x + s*alpha;
    gprev = newg;
    newg = g(x);
    beta = (newg' * newg) / (gprev' * gprev);
    sprev = s;
    s = -newg + beta*sprev;
end