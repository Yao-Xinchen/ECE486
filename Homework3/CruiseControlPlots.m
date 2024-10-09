%% Cruise Control Problem
clear;
clc;
close all;

%% Vehicle Parameters
m = 2085;       % mass, kg
k = 40;         % throttle force constant, N/deg
b0 = -336.4;    % wind drag b0+b1*v where b0 is in N
b1 = 23.2;      % wind drag b0+b1*v where b1 is in N/(m/sec)
Froll = 228;    % Rolling resistance, N

%% A) Open-Loop Input
% Assume Fgrav=0 and compute the constant input required to 
% maintain vdes=29m/sec
v0 = 0;
Fgrav = 0;
ubar = (b1 * 29 + (Froll + b0)) / k;
fprintf("ubar = %f\n", ubar);

%% B) Simulation with open-loop input and disturbance

% Simulation Parameters
v0 = 29;        % Initial condition for velocity, m/sec
Tf = 50;        % Final simulation time, sec
Fgrav = 350;

% Simulate System
out = sim('CruiseControlSim.slx');

% Generate Plot
figure
plot(out.tout, out.v);
ylim([20, 30]);
title("Velocity vs Time with Open-Loop Input and Disturbance");
ylabel("Velocity (m/s)");
xlabel("Time (s)");

%% C) Selection of PI gains

kp = 30.7;
ki = 4.69;

%% D) Simulation with PI and disturbance
Fgrav = 1400;
v_des = 29;

out = sim('CruiseControlSimClose.slx');
figure
subplot(2, 1, 1);
plot(out.tout, out.v_cl);
title("Velocity vs Time with PI Controller and Disturbance");
ylim([28, 30]);
ylabel("Velocity (m/s)");
xlabel("Time (s)");

subplot(2, 1, 2);
plot(out.tout, out.u);
title("Control Input vs Time with PI Controller and Disturbance");
ylabel("Throttle input (deg)");
xlabel("Time (s)");