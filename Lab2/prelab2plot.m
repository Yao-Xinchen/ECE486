clear
clc
close all

out = sim('prelab2sim.slx');

subplot(2,1,1);
plot(out.tout, out.y)
title("y")
ylabel("y(t)")
xlabel("t")
   
subplot(2,1,2); 
plot(out.tout, out.y_dot)
title("y'(t)")
ylabel("y'(t)")
xlabel("t")