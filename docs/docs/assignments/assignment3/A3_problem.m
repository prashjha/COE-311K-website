t = 0:0.1:10;

% characteristics solution 1
u11 = @(t) -sin(sqrt(2)*t);
u12 = @(t) 0*t;
u13 = @(t) 2*sin(sqrt(2)*t);

% characteristics solution 2
u21 = @(t) sin(t);
u22 = @(t) sin(t);
u23 = @(t) sin(t);

% characteristics solution 3
u31 = @(t) sin(sqrt(7/2)*t);
u32 = @(t) -(3/2)*sin(sqrt(7/2)*t);
u33 = @(t) sin(sqrt(7/2)*t);

% complete solution
A = [-sqrt(2), 1, 1; 0, 1, -3/2; 2*sqrt(2), 1, 1];
b = [1; 2; -1];
x = A\b;
u_comp1 = @(t) x(1)*u11(t) + x(2) * u21(t) + x(3) * u31(t);
u_comp2 = @(t) x(1)*u12(t) + x(2) * u22(t) + x(3) * u32(t);
u_comp3 = @(t) x(1)*u13(t) + x(2) * u23(t) + x(3) * u33(t);
x

subplot(2,2,1)
plot(t, u11(t), 'r+', 'DisplayName', 'displacement m1', 'LineWidth',2)
hold on
plot(t, u12(t), 'bo', 'DisplayName', 'displacement m2', 'LineWidth',2)
hold on
plot(t, u13(t), 'gs', 'DisplayName', 'displacement m3', 'LineWidth',2)
legend()
title('Characteristics solution 1')

subplot(2,2,2)
plot(t, u21(t), 'r+', 'DisplayName', 'displacement m1', 'LineWidth',2)
hold on
plot(t, u22(t), 'bo', 'DisplayName', 'displacement m2', 'LineWidth',2)
hold on
plot(t, u23(t), 'gs', 'DisplayName', 'displacement m3', 'LineWidth',2)
legend()
title('Characteristics solution 2')

subplot(2,2,3)
plot(t, u31(t), 'r+', 'DisplayName', 'displacement m1', 'LineWidth',2)
hold on
plot(t, u32(t), 'bo', 'DisplayName', 'displacement m2', 'LineWidth',2)
hold on
plot(t, u33(t), 'gs', 'DisplayName', 'displacement m3', 'LineWidth',2)
legend()
title('Characteristics solution 3')

subplot(2,2,4)
plot(t, u_comp1(t), 'r+', 'DisplayName', 'displacement m1', 'LineWidth',2)
hold on
plot(t, u_comp2(t), 'bo', 'DisplayName', 'displacement m2', 'LineWidth',2)
hold on
plot(t, u_comp3(t), 'gs', 'DisplayName', 'displacement m3', 'LineWidth',2)
legend()
title('Complete solution')