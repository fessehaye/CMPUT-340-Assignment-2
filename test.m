function [] = test()

% initialize input variables
f = 0;
g = 0;
TOL = 0;
x0 = 0;
dir = 0;
expected = 0;
A = 0;
x = 0;
stop = 0;

n_max = 15;
for n = 1 : n_max
    set_input(n);
    for m = mode_id_list
        if (stop)
            return
        end
        run_function(m);
    end
end


function [] = set_input(input_id)
    
    TOL = 1e-8;
    x0 = 1;
    dir = -1 + rand(3,1)*(2);
    
    if input_id == 1
        mode_id_list = [1, 2, 3];
        f = @(x)x;
        g = @(x)1;
    elseif input_id == 2
        mode_id_list = [1, 2, 3];
        f = @(x)sin(x-pi/3);
        g = @(x)cos(x-pi/3);
    elseif input_id == 3
        mode_id_list = [1, 2, 3];
        f = @(x)x+1;
        g = @(x)1;
    elseif input_id == 4
        mode_id_list = [1, 2, 3];
        f = @(x)3*x(1)^3-x(1)+3;
        g = @(x)9*x(1)^2-1;
    elseif input_id == 5
        mode_id_list = [  5, 6];
        f = @(x)(power(x(1),7) + 2*power(x(1),4) - 5)*3*x(1);
        g = @(x)24*power(x(1),7) + 30*power(x(1),4) - 15;
        x0 = -1;
        dir = 1;
        expected = .77659;
    elseif input_id == 6
        mode_id_list = [5, 6];
        f = @(x)power(x(1),2);
        g = @(x)2*x(1);
        x0 = 10;
        dir = -1;
        expected = 0;
    elseif input_id == 7
        mode_id_list = [1, 2, 3];
        f = @(x)exp(x)-1;
        g = @(x)exp(x);
    elseif input_id == 8
        mode_id_list = [];
        
    elseif input_id == 9
        mode_id_list = [4];
        A = round(100*rand(4));
    elseif input_id == 10
        mode_id_list = [5, 6];
        f = @(x) 0.5 - x(1) * exp(-power(x(1), 2));
        g = @(x) (2 * power(x(1), 2) - 1) * exp(-power(x(1),2));
        x0 = 1;
        dir = -1;
        expected = 1/sqrt(2);
    elseif input_id == 11
        mode_id_list = [5, 6];
        expected = 0;
        f = @(x) power(x(1),2);
        g = @(x) 2*x(1);
        x0 = 1;
        dir = -1;
    elseif input_id == 12
        mode_id_list = [5, 6];
        expected = [0; 1];
        f = @(x) power(x(1),2) + power(x(2)-1,2) - 2;
        g = @(x) [2 * x(1); 2*(x(2)-1)];
        x0 = [-30;4];
        dir = [10;-1];
    elseif input_id == 13
        mode_id_list = [5, 6];
        expected = -1/power(2,2/3);
        f = @(x) power(x(1),4) + x(1);
        g = @(x) 4*power(x(1),3) + 1;
        x0 = 5;
        dir = -1;
    elseif input_id == 14
        mode_id_list = [6];
        f = @(x) 0.5 * power(x(1),2) + 2.5 * power(x(2), 2);
        g = @(x) [x(1); 5*x(2)];
        x0 = [5; 1];
        expected = [0; 0];
    elseif input_id == 15
        mode_id_list = [5];
        f = @(x) 0.5 * power(x(1),2) + 2.5 * power(x(2), 2);
        g = @(x) [x(1); 5*x(2)];
        dir = [-3.333333344083775;3.333333279581124];
        x0 = [3.333333344083775;-0.666666655916225];
        expected = [2.2222; 0.4444];
    end
    
end

function [] = run_function(mode_id)
    
    TOL2 = 1e-4;
    pass = 0;

    if mode_id == 1
        [x,flag] = Bisection(f,x0,TOL);
        pass = flag == 0 && f(x) < TOL;

    elseif mode_id == 2
        [x,flag] = SafeNewton1D(f,g,x0,TOL);
        pass = (flag == 0 && f(x) < TOL);
        
    elseif mode_id == 3
        [x,flag] = SafeSecant1D(f,x0,TOL);
        pass = (flag == 0 && f(x) < TOL);
    elseif mode_id == 4
        Ainv = NewtInv(A);
        pass = all(all(Ainv - inv(A) < TOL) == 1);
    elseif mode_id == 5
        [x,flag] = LineSearch(f,g,x0,dir,TOL);
        pass = flag == 0 && all(abs(x-expected) < TOL2);
    elseif mode_id == 6
        [x,flag] = SteepDescent(f,g,x0,TOL);
        pass = flag == 0 && all(abs(x-expected) < TOL2);
    elseif mode_id == 7
        
    end
    
    fprintf('input %02i on mode %i: ', n, m);
    if (pass == 1)
        fprintf('pass\n');
    else
        fprintf('fail\n');
        x, expected
        stop = 1;
    end
end



end
