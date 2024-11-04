clear;
clc;
close all;

k_pot = 10/2/pi;
k = 18;
tao_m = 2/10;
k_amp = 2.4;

% --------------------------- b ---------------------------

% for k_c = 1
k_c = 1;
trans = tf([k_c*k_pot*k_amp*k], [tao_m, 1, 0]);
figure
bode(trans)
title("Bode Plot for K_c = 1")
[g_m, p_m, w_cg, w_cp] = margin(trans);
fprintf("Gain Margin: %f\n", g_m)
fprintf("Phase Margin: %f\n", p_m)
fprintf("Gain Crossover Frequency: %f\n", w_cg)
fprintf("Phase Crossover Frequency: %f\n", w_cp)

% for w_c = 55
desired_wc = 55;
k_c = 1;
tolerance = 0.01;
max_iterations = 1000;
iteration = 0;
k_cs = [];
while iteration < max_iterations
    trans = tf([k_c*k_pot*k_amp*k], [tao_m, 1, 0]);
    [~, ~, ~, w_c] = margin(trans);
    if abs(w_c - desired_wc) < tolerance
        break;
    end
    k_c = k_c * (desired_wc / w_c);
    iteration = iteration + 1;
end
fprintf("K_c for desired w_c = %f: %f\n", desired_wc, k_c)
figure;
bode(trans)
title("Bode Plot for Desired w_c = 55")

% --------------------------- c ---------------------------
k_c = 1;
trans = tf([0.1*k_c, k_c], [0.01, 1]);
figure;
bode(trans)
title("Bode Plot for G_c, with K_c = 1")

% --------------------------- d ---------------------------
zeta = 0.5169;
w_n = 55.4049;
trans = tf([w_n^2], [1, 2*zeta*w_n, 0]);
[~, p_m, ~, w_cp] = margin(trans);
fprintf("G(s) = %f/(s^2 + %f*s)\n", w_n^2, 2*zeta*w_n)
fprintf("Phase Margin: %f\n", p_m)
fprintf("Phase Crossover Frequency: %f\n", w_cp)

k_pot = 10/2/pi;
k = 18;
tao_m = 2/10;
k_amp = 2.4;

tao_z = 0.068;
tao_p = 0.0073;
k_c = 2;
g_c = tf([tao_z, 1], [tao_p, 1]);
g = tf([k_c*k_pot*k_amp*k], [tao_m, 1, 0]);

trans = g_c * g;
figure;
bode(trans);
title("Bode Plot for G_c * G")
[~, p_m, ~, w_cp] = margin(trans);
fprintf("Phase Margin: %f\n", p_m)
fprintf("Phase Crossover Frequency: %f\n", w_cp)

trans = trans / (1 + trans);
figure;
step(trans)

info = stepinfo(trans);
fprintf("Rise Time: %f\n", info.RiseTime)
fprintf("Overshoot: %f%%\n", info.Overshoot)

figure;
rlocus(g_c * g);
title("Root Locus of G_c * G");

% --------------------------- e ---------------------------
g_c = 0.4 * tf([1/2.3, 1], [1/92, 1]);
figure;
bode(g_c * g);
title("Bode Plot with new G_c");

figure;
step(g_c * g / (1 + g_c * g));
title("Step Response with new G_c");

info = stepinfo(g_c * g / (1 + g_c * g));
fprintf("Rise Time: %f\n", info.RiseTime)
fprintf("Overshoot: %f%%\n", info.Overshoot)