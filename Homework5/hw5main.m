clear;
clc;
close all;

%% P2

g = tf(3, [1, 10]);

k1 = 3.35;
k2 = 4.71;

figure;
h = bodeplot(k1 * g, k2 * g);
legend('L1', 'L2');

figure;
step(feedback(k1 * g, 1));
hold on;
step(feedback(k2 * g, 1));
legend('L1', 'L2');


%% P3 b

g = tf(12, [3, 5]);

kp = 41.33;

figure;
h = bodeplot(g, kp * g);
legend('G', 'GK');

[GM, PM, Wcg, Wcp] = margin(kp * g);
fprintf("loop cross-over frequency: %f\n", Wcp);

G_cl = feedback(kp * g, 1);
t = 0:0.001:.1;
r = ones(size(t));
n = 0.1 * sin(200 * t);
[y, t, x] = lsim(G_cl, r + n, t);
figure;
plot(t, y, 'b', 'DisplayName', 'Motor Speed Response y(t)');
hold on;
plot(t, r, 'r--', 'DisplayName', 'Reference Command r(t)');
xlabel('Time (s)');
ylabel('Response');
title('Motor Speed Response and Reference Command');
legend;
grid on;

%% P3 c

kp = 2.1;

figure;
h = bodeplot(g, kp * g);
legend('G', 'GK');

[GM, PM, Wcg, Wcp] = margin(kp * g);
fprintf("loop cross-over frequency: %f\n", Wcp);

G_cl = feedback(kp * g, 1);
t = 0:0.001:1;
r = ones(size(t));
n = 0.1 * sin(200 * t);
[y, t, x] = lsim(G_cl, r + n, t);
figure;
plot(t, y, 'b', 'DisplayName', 'Motor Speed Response y(t)');
hold on;
plot(t, r, 'r--', 'DisplayName', 'Reference Command r(t)');
xlabel('Time (s)');
ylabel('Response');
title('Motor Speed Response and Reference Command');
legend;
grid on;

%% P4

kp = 5.02;
wi = 6.67;
wr = 60;
K = kp * tf([1, wi], [1, 0]) * tf(wr, [1, wr]);
L = K * g;
figure;
hold on;
bode(L);
bode(g);
legend('L', 'G');

[GM, PM, Wcg, Wcp] = margin(L);
fprintf("loop cross-over frequency: %f\n", Wcp);

[mag_0_1, ~] = freqresp(L, 0.1j);
[mag_200, ~] = freqresp(L, 200j);
mag_0_1 = abs(1 + mag_0_1);
mag_200 = abs(mag_200);
fprintf("At 0.1j: %f\n", mag_0_1);
fprintf("At 200j: %f\n", mag_200);

G_cl = feedback(L, 1);
t = 0:0.001:1;
r = ones(size(t));
n = 0.1 * sin(200 * t);
[y, t, x] = lsim(G_cl, r + n, t);
figure;
plot(t, y, 'b', 'DisplayName', 'Motor Speed Response y(t)');
hold on;
plot(t, r, 'r--', 'DisplayName', 'Reference Command r(t)');
xlabel('Time (s)');
ylabel('Response');
title('Motor Speed Response and Reference Command');
legend;
grid on;

%% P5

disp(K);