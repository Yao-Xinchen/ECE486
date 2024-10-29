clear

out = sim("part2sima.slx");

plot(out.tout, out.w);

v_goals = [-200 -150 -100 -50 0 50 100 150 200];
ss_efforts = [-3.1084 -2.4416 -1.8491 -1.2324 0 1.2477 1.8917 2.4654 3.1688];

plot(v_goals, ss_efforts)

coeff = polyfit(v_goals(1:4), ss_efforts(1:4), 1);
disp(coeff)
coeff = polyfit(v_goals(6:9), ss_efforts(6:9), 1);
disp(coeff)
