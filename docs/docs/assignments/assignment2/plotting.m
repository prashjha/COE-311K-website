% get discrete points to plot functions
x = 0:0.01:1; 
qext = @(x) 12*x.^2 + cos(5*x) + 100*x.*sin(10*x); 
Q2 = @(x) x.^4 - x.*sin(10*x) -2*cos(5*x).*cos(5*x)/5 - cos(5*x)/25 + 11/25 ;
% exact solution
T = @(x) 100*x + 200*x.*Q2(1) - 200*Q2(x);
% use 'DisplayName' to assign label to curve
plot(x, qext(x), 'r+', 'DisplayName', 'External heat') 
hold on
plot(x, T(x), 'bo', 'DisplayName', 'Temperature')
hold on
y1 = 0*x + 80; % line y = 80 
y2 = 0*x + 40; % line y = 40
plot(x, y1, 'g', 'DisplayName', 'Line y = 80')
hold on
plot(x, y2, 'k', 'DisplayName', 'Line y = 40')
legend() % this line tells matlab to add labels to the curve