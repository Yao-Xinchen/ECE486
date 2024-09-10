clc
clear

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

