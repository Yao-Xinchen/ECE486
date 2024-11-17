clear;
clc;
close all;

%% part2

ia = [0.26; 0.26; 0.27; 0.28; 0.29; 0.31; 0.33; 0.35;
    -0.26; -0.27; -0.28; -0.28; -0.29; -0.30; -0.31; -0.33];

w = [68.37; 86.69; 104.36; 122.03; 139.37; 156.7; 174.05; 190.73;
    -66.74; -85.06; -103.056; -120.722; -137.735; -154.747; -171.759; -189.1];

vi = [5; 6; 7; 8; 9; 10; 11; 12;
    -5; -6; -7; -8; -9; -10; -11; -12];

x = [ia, w]\vi;
ra = x(1);
kv = x(2);

fprintf("ra = %f\n", ra);
fprintf("kv = %f\n", kv);

%% part3

torque = ia * kv;

coeffs = polyfit(w(1:8), torque(1:8), 1);
b_pos = coeffs(1);
c_pos = coeffs(2);
figure
plot(w(1:8), torque(1:8), 'o');
title("Torque vs Speed");
xlabel("Speed (rad/s)");
ylabel("Torque (N*m)");

coeffs = polyfit(w(9:16), torque(9:16), 1);
b_neg = coeffs(1);
c_neg = coeffs(2);
figure
plot(w(9:16), torque(9:16), 'o');
title("Torque vs Speed");
xlabel("Speed (rad/s)");
ylabel("Torque (N*m)");

fprintf("b_pos = %f\n", b_pos);
fprintf("c_pos = %f\n", c_pos);
fprintf("b_neg = %f\n", b_neg);
fprintf("c_neg = %f\n", c_neg);

%% part4

rs = 2.538;

lab4part4;

Elects = {Elect1; Elect2; Elect3; Elect4; Elect5; Elect6};
% vis = {5, 6, 7, 8, 9, 10};

vss = rs / (rs + ra);

las = zeros(1, 6);
taus = zeros(1, 6);

figure
hold on;

for i = 1:6
    time = Elects{i}(:,1);
    voltage = Elects{i}(:,2);
    index = find(voltage > 0.2);
    index = index(1);
    vss = max(voltage);
    ln = log(vss - voltage);
    plot(time(index:800), ln(index:800));
    coeffs = polyfit(time(index:800), ln(index:800), 1);
    tau = -1 / coeffs(1);
    la = (ra + rs) * tau;
    taus(i) = tau;
    las(i) = la;
end

title("ln(v_{ss} - v) vs time");
xlabel("time, s");
ylabel("ln(v_{ss} - v)");
legend("5V", "6V", "7V", "8V", "9V", "10V");

fprintf("taus = [");
for i = 1:6
    fprintf("%f, ", taus(i));
end
fprintf("]\n");

tau = mean(taus);
fprintf("average tau = %f\n", tau);

fprintf("las = [");
for i = 1:6
    fprintf("%f, ", las(i));
end
fprintf("]\n");

la = mean(las);
fprintf("average la = %f\n", la);

figure
time = Elect4(:,1);
voltage = Elect4(:,2);
index = find(voltage > 0.2);
index = index(1);
vss = max(voltage);
ln = log(vss - voltage);
plot(time(index:800), ln(index:800));
title("ln(v_{ss} - v) vs time for 8V");
xlabel("time, s");
ylabel("ln(v_{ss} - v)");

%% part5

lab4part5;

Iners = {Iner1; Iner2; Iner3; Iner4; Iner5; Iner6};
% vis = {10, 11, 12, 13, 14, 15};

js = zeros(1, 6);

figure
hold on;

for i = 1:6
    time = Iners{i}(:,1);
    vtach = Iners{i}(:,2);
    omega = vtach / kv;
    omega_0 = omega(1);
    ln = log(omega + c_pos/b_pos);
    plot(time(50:200), ln(50:200));
    coeffs = polyfit(time(50:200), ln(50:200), 1);
    j = -b_pos / coeffs(1);
    js(i) = j;
end

title("ln((\omega + c/b)/(\omega_0 + c/b)) vs time");
xlabel("time, s");
ylabel("ln((\omega + c/b)/(\omega_0 + c/b))");
legend("10V", "11V", "12V", "13V", "14V", "15V");

fprintf("js = [");
for i = 1:6
    fprintf("%f, ", js(i));
end
fprintf("]\n");

j = mean(js);
fprintf("average J = %f\n", j);

figure
time = Iner4(:,1);
vtach = Iner4(:,2);
omega = vtach / kv;
omega_0 = omega(1);
ln = log(omega + c_pos/b_pos);
plot(time(50:200), ln(50:200));
title("ln((\omega + c/b)/(\omega_0 + c/b)) vs time for 13V");
xlabel("time, s");
ylabel("ln((\omega + c/b)/(\omega_0 + c/b)");
