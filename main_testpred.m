% This is the main function of this project

%clear;
%clc;

%n: #Users
%d: #Items
%L: #Classes
%h: The rank of matrix

hyperpara.n = n;
hyperpara.d = d;
hyperpara.L = L;
hyperpara.h = h;


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

L = hyperpara.L;

para.m_b = B;
para.m_u = U;
para.m_v = V;
para.v_v = 0.01 * ones(size(V));
para.v_u = 0.01 * ones(size(U));


para.a_gmarow = 1./gam_row + 1;
para.b_gmarow = ones(size(para.a_gmarow));
para.a_gmacol = 1./gam_col + 1;
para.b_gmacol = ones(size(para.a_gmacol));


v_b = para.v_b;

pred_entry.row = [ 4, 5, 6,7];
pred_entry.col = [1, 2, 3, 9]; 

Rpred = predfun(para,hyperpara, pred_entry);