clear;
clc;
close all;


% elect

rs = 2.5;
ra = 3.3;
vss = rs / (rs + ra);

load('prelab4.mat');
time = Elect(:,1);
voltage = Elect(:,2);

i_05 = find(time == 0.0005);

ln = log(vss - voltage);

figure;
hold on;

plot(time(1:i_05), ln(1:i_05));

coeffs = polyfit(time(1:i_05), ln(1:i_05), 1);

tau = -1 / coeffs(1);

fprintf("tau = %f\n", tau);

plot(time(1:i_05), polyval(coeffs, time(1:i_05)));

xlabel("time, s");
ylabel("ln(v_{ss} - v)");
title("ln(v_{ss} - v) vs time");
legend("ln(v_{ss} - v)", "Linear fit");

la = (ra + rs) * tau;
fprintf("La = %f\n", la);

% iner

c = 1.12E-2;
b = 3.58E-5;

figure;
time = Iner(:,1);
omega = Iner(:,2);
omega_0 = omega(1);
ln = log((omega + c/b)/(omega_0 + c/b));

i = find(time == 0.45);

hold on;
plot(time(1:i), ln(1:i));

coeffs = polyfit(time(1:i), ln(1:i), 1);

fprintf("-b/J = %f\n", coeffs(1));

j = -b / coeffs(1);

fprintf("J = %f\n", j);

plot(time(1:i), polyval(coeffs, time(1:i)));

xlabel("time, s");
ylabel("ln((\omega + c/b)/(\omega_0 + c/b))");
title("ln((\omega + c/b)/(\omega_0 + c/b)) vs time");
legend("ln((\omega + c/b)/(\omega_0 + c/b))", "Linear fit");

% inductance

second = tf(5.47E-2, [4E-8, 1.32E-4, 3.1E-3]);
first = tf(5.47E-2, [1.32E-4, 3.1E-3]);
sr_second = step(second);
sr_first = step(first);

figure;
hold on;
plot(sr_second);
plot(sr_first);
title("Step response of the first and second order systems");
legend("Second order", "First order");
xlabel("time, s");
ylabel("step response");

% bode plot

figure;
hold on;
bode(second);
bode(first);
title("Bode plot of the first and second order systems");
legend("Second order", "First order");