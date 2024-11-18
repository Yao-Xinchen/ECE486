%% DC Motor Control

%% DC Motor Model:
%    J*ydot + b*y = k*V
J = 3;    % Inertia, N*m*sec^2/deg^2
b = 5;    % Damping, N*m*sec/deg
c = 12;   % Torque gain, N*m/Volts
G = tf(c,[J b]);

%% Part B:
% Design a proportional controller: K(s) = Kp
% Choose Kp to satisfy:  |ess|<=0.01 for a unit step reference cmd
Kp = 1;    % <-----FILL IN YOUR GAIN HERE

% Bode plot of Loop Transfer function
L = G*Kp;
figure(1);
bode(G,'b',L,'r',{1e-1,200});
grid on;
title('Loop TF, G*K');

% Simulate
Tf = 1;
sim('DCMotor',Tf);
figure(2);
plot(t,y,'b',t,r,'r');
xlabel('Time (sec)');
ylabel('Response (deg/sec)');
legend('y','r');
title('Step Response with Kp');
