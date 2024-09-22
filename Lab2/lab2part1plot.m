clear;
clc;
close all;

A = [-6 -25; 1 0];
B = [25; 0];
C = [1 0; 0 1];
D = [0; 0];

zeta = 0.6;

a = 50;
out = sim('lab2part2.slx');
tout1 = out.tout;
y1 = out.y1;
y1dot = out.y_dot;
plot(tout1, y1);
hold on
plot(tout1, y1dot);

legend("y1", "y1dot");
xlabel("time, s");
