clear;
clc;
close all;

K_pot = 10/2/pi;
K = 18;
tau_m = 2/10;
K_amp = 2.4;

tau_z = 0.068;
tau_p = 0.0073;
K_c = 2;

upper = inf;
lower = -inf;

V_i = 0.5;
out = sim("lab6model.slx");
V05 = out.V;
time05 = out.tout;


V_i = 5;
out = sim("lab6model.slx");
V5 = out.V;
time5 = out.tout;
subplot(3,2,1)

V_i = 50;
out = sim("lab6model.slx");
V50 = out.V;
time50 = out.tout;

upper = 10;
lower = -10;

V_i = 0.5;
out = sim("lab6model.slx");
V05sat = out.V;
time05sat = out.tout;


V_i = 5;
out = sim("lab6model.slx");
V5sat = out.V;
time5sat = out.tout;
subplot(3,2,1)

V_i = 50;
out = sim("lab6model.slx");
V50sat = out.V;
time50sat = out.tout;


subplot(3,1,1);
hold on;
plot(time05, V05);
plot(time05sat, V05sat);
title("V_i = 0.5V")
xlabel("time, s")
ylabel("Step Response")
legend("Unsaturated", "Saturaed");

subplot(3,1,2);
plot(time5, V5);
hold on;
plot(time5sat, V5sat);
title("V_i = 5V")
xlabel("time, s")
ylabel("Step Response")
legend("Unsaturated", "Saturaed");

subplot(3,1,3);
plot(time50, V50);
hold on;
plot(time50sat, V50sat);
title("V_i = 50V")
xlabel("time, s")
ylabel("Step Response")
legend("Unsaturated", "Saturaed");

fresp;
omega=dsa(:,1);
data=dsa(:,2)+1i*dsa(:,3);
mag = abs(data);
phase = angle(data);

figure()
subplot(2,1,2)
plot(log10(omega/2/pi), 20*log10(mag))
title("Magnitude")
xlabel("log frequency")
ylabel("dB magnitude")

subplot(2,1,1)
plot(log10(omega/2/pi), 180/pi*phase)
title("Phase")
xlabel("log frequency")
ylabel("phase (degrees)")
