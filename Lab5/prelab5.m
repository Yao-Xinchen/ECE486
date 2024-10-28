clear;
clc;
close all;

p1 = 0.89;
p2 = 0.81;

l1 = tf(1, [0.2, 12.96*p2+1, 0]);
l2 = tf([12.96, 0], [0.2, 1, 691.2*p1]);

% rlocus
figure
rlocus(l1);
ylim([-60, 60])
title("Root Locus of P1");

figure
rlocus(l2);
title("Root Locus of P2");