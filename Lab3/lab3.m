clear
clc
close all

% Controller 1
K_p = 19.4;
K_d = 0;
K_r = 0;
w_r = 0;
t_d = 1;
out1 = sim("lab3controller.slx");

K_r = 1 + 3/5/K_p;
w_r = 1;
t_d = 0;
out2 = sim("lab3controller.slx");


% Controller 2
K_p = 16/15;
K_d = 0;
K_r = 0;
w_r = 0;
t_d = 1;
out3 = sim("lab3controller.slx");

K_r = 1 + 3/5/K_p;
w_r = 1;
t_d = 0;
out4 = sim("lab3controller.slx");


% Controller 3
K_p = 19.4;
K_d = 0.031;
K_r = 0; %#ok<*NASGU>
w_r = 0;
t_d = 1;
out5 = sim("lab3controller.slx");

K_r = 1 + 3/5/K_p;
w_r = 1;
t_d = 0;
out6 = sim("lab3controller.slx");

subplot(2, 1, 1)
plot(out1.tout, out1.w);
hold on
plot(out3.tout, out3.w);
plot(out5.tout, out5.w);
title("\omega_r = 0")
ylabel("step response")
xlabel("time, s")
legend("Controller 1", "Controller 2", "Controller 3");
hold off

subplot(2, 1, 2)
plot(out2.tout, out2.w);
hold on
plot(out4.tout, out4.w);
plot(out6.tout, out6.w);
title("\tau_d = 0")
ylabel("step response")
xlabel("time, s")
legend("Controller 1", "Controller 2", "Controller 3");
