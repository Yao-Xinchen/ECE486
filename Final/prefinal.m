clear;
clc;
close all;

% x_dot = Ax + Bu
A = [-18 16 8; -29 27 13; 10 -10 -4];
B = [1; -3; -2];

poles = eig(A);
fprintf('The poles of the system are: \n');
disp(poles);

R = ctrb(A,B);
fprintf('The controllability matrix is: \n');
disp(R);
rankR = rank(R);
fprintf('The rank of the controllability matrix is: %d\n', rankR);

poles = [-2 -19 -38];
K = place(A,B,poles);
fprintf('\nThe K matrix is:');
disp(K);

% x_dot = (A - BK)x
poles = eig(A - B*K);
fprintf('\nThe poles of the system with the controller are:');
disp(poles);

