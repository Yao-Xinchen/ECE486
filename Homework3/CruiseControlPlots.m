%% Cruise Control Problem

%% Vehicle Parameters
m = 2085;       % mass, kg
k = 40;         % throttle force constant, N/deg
b0 = -336.4;    % wind drag b0+b1*v where b0 is in N
b1 = 23.2;      % wind drag b0+b1*v where b1 is in N/(m/sec)
Froll = 228;    % Rolling resistance, N

%% A) Open-Loop Input
% Assume Fgrav=0 and compute the constant input required to 
% maintain vdes=29m/sec
ubar=29;

%% B) Simulation with open-loop input and disturbance

% Simulation Parameters
v0 = 29;        % Initial condition for velocity, m/sec
Tf = 50;        % Final simulation time, sec

% Simulate System

% Generate Plot

%% C) Selection of PI gains


%% D) Simulation with PI and disturbance

