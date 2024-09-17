A = [-6 -25; 1 0];
B = [25; 0];
C = [1 0; 0 1];
D = [0; 0];

zeta = 0.6;

a = 50;
out = sim('lab2part3.slx');
tout1 = out.tout;
y1 = out.y1;
plot(tout1, y1);

as = [50, 5, 2.5];

hold on
for i = 1:length(as)
    a = as(i);
    out = sim('lab2part3.slx');
    tout2 = out.tout;
    y2 = out.y;
    plot(tout2, y2);
end

legend("y1", "y3a", "y3b", "y3c");
xlabel("time, s");
ylabel("Step Response");