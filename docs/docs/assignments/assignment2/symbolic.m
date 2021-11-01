% declare math variable x in matlab
syms x
% define function qext
qext(x) = 12*x^2 + cos(5*x) + 100*x*sin(10*x);
disp('external heat function')
qext
% integrate qext function
Q1(x) = int(qext, 0, x);
disp('Q1 function')
Q1
% integrate Q1 function
Q2(x) = int(Q1, 0, x);
disp('Q2 function')
Q2
% get value of Q2 function at x = 1
disp('vaue of Q2 function at x = 1')
eval(Q2(1))
Q2_at_1 = eval(Q2(1));
% % define exact solution 
% T(x) = 100*x + 200*x*Q2_at_1 - 200*Q2(x);
% disp('exact temperature')
% T