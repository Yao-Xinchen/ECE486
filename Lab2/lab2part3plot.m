clear
clc
close all

A = [-6 -25; 1 0];
B = [25; 0];
C = [1 0; 0 1];
D = [0; 0];

zeta = 0.6;

a = 50;
out = sim('lab2part3.slx');
tout1 = out.tout;
y1 = out.y1;
plot(tout1, y1);

as = [50, 5, 2.5];

hold on
for i = 1:length(as)
    a = as(i);
    out = sim('lab2part3.slx');
    tout2 = out.tout;
    y2 = out.y;
    plot(tout2, y2);

    zero = -a * zeta;
    yss = y2(end);
    ymax = max(y2);
    mp = (ymax - yss) / yss * 100;
    t10_index = find(y2 > 0.1 * ymax, 1, "first");
    t90_index = find(y2 > 0.9 * ymax, 1, "first");
    tr = tout2(t90_index) - tout2(t10_index);
    x = length(y2);
    while y2(x) < 1.05 * yss && y2(x) > 0.95 * yss
        x = x - 1;
    end
    ts = tout2(x);
    fprintf("zero=%.1f: M_p=%.2f%%, t_r=%.2fs, t_s=%.2fs\n", zero, mp, tr, ts);
end

legend("y1", "y3a", "y3b", "y3c");
xlabel("time, s");
ylabel("Step Response");