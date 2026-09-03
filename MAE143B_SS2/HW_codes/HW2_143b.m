%% With proportional controller
close all, d=12; a0=.02; G=RR_pade(d,2,2)*RR_tf(1,[1/a0 1]); D=1; P=1/0.5;  
figure(1), RR_rlocus(G), axis([-.4 .3 -.3 .3]) 
figure(2), g.T=200; RR_step(35+10*P*G*D/(1+G*D),g); axis([0 200 32 55])
figure(3); RR_step(35+10*P*D/(1+G*D),g); axis([0 200 40 60]) 


%% With lead-lag

d = 12; a0 = .02;
G = RR_pade(d,2,2) * RR_tf(1,[1/a0 1]);

K = .5;
D_lead = RR_tf([1 0.1],[1 0.5]);
D_lag = RR_tf([1 0.05],[1 0.01]);
D = K * D_lead * D_lag;

D0 = K * (0.1/0.5) * (0.05/0.01);
P = (1+D0) / D0;

g.T = 200;
figure(2);RR_step(35+10*P*G*D/(1+G*D),g);
title('Bath temp y(t)');axis([0 200 32 55]);

figure(3);RR_step(35+10*P*D/(1+G*D),g);
title('Control input u(t)'); axis([0 200 10 55]);

G_high = RR_pade(d, 16, 13) * RR_tf(1, [1/a0 1]);
figure(4); RR_step(35 + 10*P*G_high*D / (1 + G_high*D), g);
title('Bath Temp with F_{16,13}'); grid on;