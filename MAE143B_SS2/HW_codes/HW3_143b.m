clear; close all, d=0.1; a=1; G=RR_pade(d,2,2)*RR_tf(1,[1 a]); D=16.47; L=G*D; 
figure(1), RR_rlocus(G*D)
%%
omega=16.45;
figure(2), D=1*real(RR_evaluate(-1/L,1i*omega)), RR_rlocus(G*D)
%%
G=RR_pade(d,16,12)*RR_tf(1,[1 a]);D=16.25;
figure(3); RR_rlocus(G*D)
%%
clear;clc;close all;
d=0.1; a=1; % re-type in this section because figures were messing up
D = 16.46;G=RR_pade(d,2,2)*RR_tf(1,[1 a]); 
D_half = D/2;D_twice = D*2;
L_half = G*D_half;L_twice = G*D_twice;
figure(1);RR_nyquist(L_half);
figure(2);RR_nyquist(L_twice);