%% 5a
clear;clc;close all;

s = tf('s');
G = 100/(s^2-100); % cart on a hill unbstable plant

t_r = 0.18;
M_p = 0.15;

w_n = 1.8/t_r;
zeta = 0.5;

theta = asind(zeta);
sigma = zeta*w_n;
w_d = w_n*sqrt(1-zeta^2);
%% 5b
clear;clc;close all;
s = tf('s');
G = 100/(s^2-100);

D_simple = 3*(s+10)/(s+20);

K = 7.47;
w_c = 978.48;

D_lead = (s + 2.673) / (s + 37.417);
D_double_lag = ((s + 0.4852) / (s + 0.04852))^2;

num_lpf = 9.99e-4*(s/w_c)^4 + 7.659e3*(s/w_c)^2 + 7.333e9;
den_lpf = (s/w_c)^4 + 757.75*(s/w_c)^3 + 2.871*(s/w_c)^2 + 6.4019e7*(s/w_c) + 7.333e9;
D_lpf = num_lpf / den_lpf;

D_ls = K * D_lead * D_double_lag * D_lpf;

T_simple = feedback(G*D_simple,1);
T_ls = feedback(G*D_ls,1);

figure;step(T_simple,T_ls);legend('Simple','Loop sharing');
figure;rlocus(G*D_simple);legend('Simple','Loop sharing');
figure;rlocus(G*D_ls);legend('Simple','Loop sharing');
figure;bode(G*D_simple,G*D_ls);