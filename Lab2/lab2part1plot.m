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

yss = y1(end);
ymax = max(y1);
mp = (ymax - yss) / yss * 100;
t10_index = find(y1 > 0.1 * ymax, 1, "first");
t90_index = find(y1 > 0.9 * ymax, 1, "first");
tr = tout1(t90_index) - tout1(t10_index);
x = length(y1);
while y1(x) < 1.05 * yss && y1(x) > 0.95 * yss
    x = x - 1;
end
ts = tout1(x);
fprintf("no zero: M_p=%.2f%%, t_r=%.2fs, t_s=%.2fs\n", mp, tr, ts);