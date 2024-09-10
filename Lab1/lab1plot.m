clc
clear
close all

lab1
hold on
plot(y1(:,1),y1(:,2));
plot(y2(:,1),y2(:,2));
plot(y3(:,1),y3(:,2));
plot(y4(:,1),y4(:,2));
plot(y5(:,1),y5(:,2));
plot(y6(:,1),y6(:,2));
plot(y7(:,1),y7(:,2));
plot(y8(:,1),y8(:,2));

legend('\zeta = 2','\zeta = 1.5', '\zeta = 1.0', '\zeta = 0.8', ...
        '\zeta = 0.7', '\zeta = 0.5', '\zeta = 0.3', '\zeta = 0.2')
title('Lab 1');
xlabel("\tau, s")
ylabel("Step Response")

zetas = [2, 1.5, 1, 0.8, 0.7, 0.5, 0.3, 0.2];

fprintf("Experiment\n");
ys = {y1, y2, y3, y4, y5, y6, y7, y8};
for i = 1:length(ys)
    zeta = zetas(i);
    yn = ys{i};
    t = yn(:,1);
    y = yn(:,2);
    yss = y(end);
    ymax = max(y);
    mp = (ymax - yss) / yss * 100;
    t10_index = find(y > 0.1 * ymax, 1, "first");
    t90_index = find(y > 0.9 * ymax, 1, "first");
    tr = t(t90_index) - t(t10_index);
    x = length(y);
    while y(x) < 1.05 * yss && y(x) > 0.95 * yss
        x = x - 1;
    end
    ts = t(x) - 2; % start at 2 seconds
    fprintf("zeta=%.1f: M_p=%.2f%%, t_r=%.2fs, t_s=%.2fs\n", zeta, mp, tr, ts);
end

fprintf("\nTheory");
omega = 1;
for i = 1:length(zetas)
    zeta = zetas(i);
    if zeta < 1
        mp = 100 * exp(-pi * zeta / sqrt(1 - zeta^2));
    else
        mp = 0;
    end
    if zeta < 1.2
        tr = (1.2 - 0.45 * zeta + 2.6 * zeta^2) / omega;
    else
        tr = (4.7 * zeta - 1.2) / omega;
    end
    if zeta < 0.69
        ts = -0.5 / (zeta * omega) * log((1 - zeta^2) / 400);
    else
        ts = (6.6 * zeta - 1.6) / omega;
    end
    fprintf("zeta=%.1f: M_p=%.2f%%, t_r=%.2fs, t_s=%.2fs\n", zeta, mp, tr, ts);
end
