clear;
clc;
close all;

%% 2

figure
A = [0, 1; -2, -2];
B = [0; 1];
C = [1, 1];
D = 0;

K = [98, 27];

obs_poles = [-25, -30];
L = place(A', C', obs_poles)'

s = tf('s');

k_r = 100;
tf = C*inv(eye(2)*s - (A - B*K))*B*k_r
step(tf)

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