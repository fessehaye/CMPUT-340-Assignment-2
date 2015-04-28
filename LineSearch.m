function [x,flag] = LineSearch(f,~,x0,dir,TOL)
flag = 0;

a = 0;
alpha = 0.0001;

c = alpha;
count = 0;
while(f(x0+ a*dir) > f(x0+ c*dir))
    a = a + 0.0001;
     c = c + 0.0001;
     count = count + 1;
     if(count > 100000000)
         flag = 1;
         x = zeros(1);
         return;
     end
end

count = 0;
alpha = alpha + 0.0001;
b = alpha;

while(f(x0+ a*dir) < f(x0+ b*dir))
    alpha = alpha + 0.0001;
     b = alpha;
     count = count + 1;
     if(count > 100000000)
         flag = 1;
         x = zeros(1);
         return;
     end
end

count = 0;
T = (sqrt(5) - 1)/2;
x1 = a + (1-T)*(b-a);
f1 = f(x0 + x1*dir);
x2 = a+T*(b-a);
f2 = f(x0 + x2*dir);

while(norm(b-a) > TOL)
     count = count + 1;
     if(count > 100000)
         flag = 1;
         x = zeros(1);
         return;
     end
    if(f1>f2)
        a = x1;
        x1 = x2;
        f1 = f2;
        x2 = a + T*(b-a);
        f2 = f(x0 + x2*dir);
    else
        b = x2;
        x2 = x1;
        f2 = f1;
        x1 = a + (1-T)*(b-a);
        f1 = f(x0 + x1*dir);
    end
    
end

x = x0 + x1*dir;



