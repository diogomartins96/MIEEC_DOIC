x_IT = [5, 10, 25 ,50];
y_IT = [98, 78,58, 49];

x_Sig = [0.1, 0.5, 1];
y_Sig = [331, 77, 48]


xPlim = [0.5, 0.7, 0.9];
yPlim = [8821, 8263, 8000];

xLoad = [0.75, 1, 1.25];
yLoad = [6800, 8263, 8263];

figure(1)
bar(x_IT,y_IT)
title('Mean number of iterations changes with initial population');
xlabel('Number of individuals the initial population');
ylabel('Meam number of iterations');
print -depsc A2_Pop_NumberIt


figure(2)
bar(x_Sig, y_Sig)
title('Std changes with initial population');
xlabel('Number of individuals the initial population');
ylabel('Standard Deviation');
print -depsc A2_Sig_NumberIT

figure(3)
bar(xPlim, yPlim)
title('Influence of Line Limits using Load percent = 100%');
xlabel('Percentage of Line Limit');
ylabel('Cost (R)');
print -depsc A2_PLIM

figure(4)
bar(xLoad, yLoad)
title('Influence of Load percent using Line Limits = 50%');
xlabel('Load Percent');
ylabel('Cost (R)');
print -depsc A2_LOAD