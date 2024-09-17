clear
clc
close all

% omega = 1;
zetas = [1.5, 5, 40];
t = 0:0.01:10;

figure
hold on
color = lines(length(zetas));

for i = 1:length(zetas)
    sys_2nd = tf(1, [1, 2*zetas(i), 1]);
    poles = pole(sys_2nd);
    fprintf("Zeta=%.1f: Poles=%s\n", zetas(i), mat2str(poles));
    pole_closer = max(poles);
    pole_further = min(poles);
    ratio = -1/pole_further;
    sys_1st = tf(ratio, [1, -pole_closer]);
    [y_2nd, t_2nd] = step(sys_2nd, t);
    [y_1st, t_1st] = step(sys_1st, t);

    plot(t_2nd, y_2nd, 'DisplayName', sprintf('2nd Order, \\zeta=%.1f', zetas(i)), 'Color', color(i, :));
    plot(t_1st, y_1st, 'DisplayName', sprintf('1st Order, \\zeta=%.1f', zetas(i)), 'LineStyle', '--', 'Color', color(i, :));
end

legend
title('Step Response of 1st and 2nd Order Systems');
xlabel("Time, s")
ylabel("Step Response")
