clear;
clc;
close all;

%% II

s = tf("s");

K_dsa = 26.18;
z1 = -1.878;
p1 = -17.47;
p2 = -0.843;

% V_tach / V_in
tach_in = K_dsa*(s/(2*pi)-z1)/((s/(2*pi)-p1)*(s/(2*pi)-p2));

dc_gain = dcgain(tach_in);

disp("DC gain: " + dc_gain);

%% III

K_pot = 10/(2*pi);
K = 18;
tau_m = 2/10;
K_amp = 2.4;
tau_z = 0.07;
tau_p = 0.007;
K_c = 2;

G = K_c * (tau_z*s + 1)/(tau_p*s + 1);
M = K_pot * K_amp * K / (tau_m * s + 1);

T = feedback(G*M, 1);

info = stepinfo(T);

disp("Rise Time: " + info.RiseTime);
disp("Settling Time: " + info.SettlingTime);
disp("Overshoot: " + info.Overshoot);
disp("Peak: " + info.Peak);
disp("Peak Time: " + info.PeakTime);

fprintf("\n");

G = 0.4 * (s/2.3 + 1)/(s/92 + 1);

T = feedback(G*M, 1);

info = stepinfo(T);

disp("Rise Time: " + info.RiseTime);
disp("Settling Time: " + info.SettlingTime);
disp("Overshoot: " + info.Overshoot);
disp("Peak: " + info.Peak);
disp("Peak Time: " + info.PeakTime);

%% IV

% from DSA
[mag_bode, phase_bode, omega_bode] = bode(tach_in);
mag_bode = squeeze(20*log10(mag_bode)); % Convert to dB
phase_bode = squeeze(phase_bode); % Convert to degrees
figure;
subplot(2,1,1);
semilogx(omega_bode, mag_bode, 'b'); % Bode plot magnitude
hold on;

% from fresp
fresp;
omega = dsa(:,1);
data = dsa(:,2) + 1i*dsa(:,3);
mag = 20*log10(abs(data)); % dB
phase = angle(data) * 180/pi; % degrees

semilogx(omega, mag, 'r'); % fresp magnitude
xlabel("Frequency (rad/s)");
ylabel("Magnitude (dB)");
legend("Bode plot", "fresp data");

subplot(2,1,2);
semilogx(omega_bode, phase_bode, 'b'); % Bode plot phase
hold on;
semilogx(omega, phase, 'r'); % fresp phase
xlabel("Frequency (rad/s)");
ylabel("Phase (degrees)");
legend("Bode plot", "fresp data");

%% V

K_tach = 3.33;
scale = 1 / K_tach * K_pot;

% from DSA
theta_in = tach_in / s * scale;
[mag_bode, phase_bode, omega_bode] = bode(theta_in);
mag_bode = squeeze(20*log10(mag_bode)); % Convert to dB
phase_bode = squeeze(phase_bode); % Convert to degrees


% from fresp
fresp;
omega = dsa(:,1);
data = dsa(:,2) + 1i*dsa(:,3);
mag = 20*log10(abs(data)); % dB
phase = angle(data) * 180/pi; % degrees

for i = 1:length(omega)
    if omega(i) > 1
        mag(i) = mag(i) - 20 * (log10(omega(i)) - log10(1));
    end
end
mag = mag - 20*log10(scale);
phase = phase - 90;

figure;
subplot(2,1,1);
semilogx(omega_bode, mag_bode, 'b'); % Bode plot magnitude
hold on;
semilogx(omega, mag, 'r'); % fresp magnitude
xlabel("Frequency (rad/s)");
ylabel("Magnitude (dB)");
legend("Bode plot", "fresp data");

subplot(2,1,2);
semilogx(omega_bode, phase_bode, 'b'); % Bode plot phase
hold on;
semilogx(omega, phase, 'r'); % fresp phase
xlabel("Frequency (rad/s)");
ylabel("Phase (degrees)");
legend("Bode plot", "fresp data");

%% VI

% closed loop bode plot for theta_in
cl = feedback(theta_in, 1);
[mag_bode, phase_bode, omega_bode] = bode(cl);
mag_bode = squeeze(20*log10(mag_bode)); % Convert to dB
phase_bode = squeeze(phase_bode); % Convert to degrees

% cl = frd(data, omega);
% [mag, phase, omega] = bode(cl);
% mag = squeeze(20*log10(mag)); % dB
% phase = squeeze(phase * 180/pi); % degrees

figure;
subplot(2,1,1);
semilogx(omega_bode, mag_bode, 'b'); % Bode plot magnitude
hold on;
% semilogx(omega, mag, 'r'); % fresp magnitude
xlabel("Frequency (rad/s)");
ylabel("Magnitude (dB)");
legend("Bode plot", "fresp data");

subplot(2,1,2);
semilogx(omega_bode, phase_bode, 'b'); % Bode plot phase
hold on;
% semilogx(omega, phase, 'r'); % fresp phase
xlabel("Frequency (rad/s)");
ylabel("Phase (degrees)");
legend("Bode plot", "fresp data");

% Find the low-frequency magnitude
low_freq_mag = mag_bode(1);

% Find the -3 dB point
bandwidth_idx = find(mag_bode <= (low_freq_mag - 3), 1);

% Get the corresponding frequency
if ~isempty(bandwidth_idx)
    bandwidth = omega_bode(bandwidth_idx);
else
    bandwidth = NaN; % If no -3 dB point is found
end

% Display the bandwidth
disp(['Closed-loop bandwidth: ', num2str(bandwidth), ' rad/s']);