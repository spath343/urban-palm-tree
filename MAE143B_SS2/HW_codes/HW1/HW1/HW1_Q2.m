%% 2a
clc;
format longg
syms p;

eqn1 = tand(-5) == -(9.9*p)/(p^2+1);
p_sol = solve(eqn1,p);
z_sol = 100*p_sol;

sys = zpk(-0.8838,-0.008838,1);
hold on;
bode(sys);
%% 2b
clc;
format longg;
syms p;

eqn2 = tand(-2.5) == -(9*p)/(p^2+10);
p_sol2 = solve(eqn2, p);
z_sol2 = 10 * p_sol2;

sys2 = zpk(-0.4852,-0.04852,1);
bode(sys2);
hold off;
