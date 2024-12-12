clear;
clc;
close all;

%% 3b
figure

u_bar = 1.89;
y_bar = 4;

y = y_bar;

out = sim("hw6.slx");
plot(out.tout, out.y);

%% 3c
figure

u = u_bar;
y = 3.8;

out = sim("hw6.slx");
hold on;
plot(out.tout, out.y);

out = sim("hw6_linear.slx");
plot(out.tout, out.y);

legend("nonlinear", "linear")

%% 3d
figure

y = 8;

out = sim("hw6.slx");
hold on;
plot(out.tout, out.y);

out = sim("hw6_linear.slx");
plot(out.tout, out.y);

legend("nonlinear", "linear")