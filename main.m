% This is the main function of this project

clear;
clc;

%n: #Users
%d: #Items
%L: #Classes
%h: The rank of matrix
hyperpara.n = 10;
hyperpara.d = 5;
hyperpara.L = 5;
hyperpara.h = 3;

%Test for syntax
R = randi(5, hyperpara.n, hyperpara.d);
O = randi([0,1], hyperpara.n, hyperpara.d) == 1;

%% Setting hyperparameters
hyperpara.m_mu = 0;
hyperpara.m_mv = 0;
hyperpara.v_mu = 1;
hyperpara.v_mv = 1;

hyperpara.a0d = 10/2;
hyperpara.b0d = 10/2;

hyperpara.a0 = 10/2;
hyperpara.b0 = 10*sqrt(10) /2;

hyperpara.m_b0 = [-6 -2 2 6];
hyperpara.v0 = 0.1;

max_iter = 3;   %iteration number

%% Initialization should be here
init_para
% a_gamcol = a0 * zeros(d,1);
% b_gamcol = b0 * zeros(d,1);
% 
% a_gamrow = a0 * zeros(n,1);
% b_gamrow = b0 * zeros(n,1);
% 
% m_b = zeros(d, L-1);
% v_b = 10 * ones(d,L-1);
% 
% m_a = zeros(n, d);
% v_a = 10 * ones(n, d);
% 
% m_c = zeros(n, d);
% v_c = 10 * ones(n, d);
% 
% m_u = zeros(n, h);
% v_u = 10 * ones(n. h);
% 
% m_v = zeros(d, h);
% v_v = 10 * ones(d, h);
% 
% m_mu = m_mu * ones(h, 1);
% v_mu = v_mu * ones(h, 1);
% 
% m_mv = m_mv * ones(h, 1);
% v_mu = v_mu * ones(h, 1);
% 
% a_vu = ones(h, 1);
% b_vu = ones(h, 1);
% 
% a_vv = ones(h, 1);
% b_vv = ones(h, 1);


% This is the iteration of update
for iter = 1:max_iter
    
    para = update_f1(para, hyperpara);
    para = update_f2(para, hyperpara);
    para = update_f3(para, hyperpara);
    para = update_f4(para, hyperpara);
    para = update_f5(para, hyperpara);
    para = update_f6(para, hyperpara);
    para = update_f7(para, hyperpara);
    para = update_f8(para, hyperpara);
    para = update_f9(para, hyperpara);
    para = update_f10(para, hyperpara);
    para = update_f11(para, hyperpara, O);
    para = update_f12(para, hyperpara, O);
    para = update_f13(para, hyperpara, O, R);
    
end

para.v_b
para.m_b
para.v_a
para.m_a
