clear;
clc;
close all;

% a)
g = tf(1928, [1, 40, 559, 2966, 4818, 3856]);
poles = pole(g);
fprintf("poles =");
disp(poles);

% e)
approx = tf(1, [1, 2, 2]);
figure
step(g, approx);
title("Step Response of G(s) and Approximation");
legend("G(s)", "Approximation");

% h)
kp = 2.32;
ki = 1.728;
kd = 1.6;
pid_controller = pid(kp, ki, kd);
g_pid = feedback(pid_controller*g, 1);
approx_pid = feedback(pid_controller*approx, 1);
figure
subplot(3, 1, 1);
step(g_pid, approx_pid);
xlim([0, 10]);
ylim([0, 1.5]);
title("Step Response of G(s) and Approximation with PID Controller (poles at -1.2)");
legend("G(s)", "Approximation");

kp = 16.75;
ki = 15.6;
kd = 5.5;
pid_controller = pid(kp, ki, kd);
g_pid = feedback(pid_controller*g, 1);
approx_pid = feedback(pid_controller*approx, 1);
subplot(3, 1, 2);
step(g_pid, approx_pid);
xlim([0, 10]);
ylim([0, 1.5]);
title("Step Response of G(s) and Approximation with PID Controller (poles at -2.5)");
legend("G(s)", "Approximation");

kp = 73;
ki = 125;
kd = 13;
pid_controller = pid(kp, ki, kd);
g_pid = feedback(pid_controller*g, 1);
approx_pid = feedback(pid_controller*approx, 1);
subplot(3, 1, 3);
step(g_pid, approx_pid);
xlim([0, 10]);
ylim([0, 1.5]);
title("Step Response of G(s) and Approximation with PID Controller (poles at -5)");
legend("G(s)", "Approximation");