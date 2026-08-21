%% 3a
format longE;clc;close all;clear;
hold on;
%F1=RR_LPF_butterworth(4); % normalized butterworth polynomial -> denominator
F_design = RR_LPF_butterworth(4,299.324);RR_bode(F_design)
%% 3b
% F2=RR_LPF_inv_chebyshev(4,0.001);
F2_design = RR_LPF_inv_chebyshev(4,0.001,978.4765);RR_bode(F2_design)
hold off;

