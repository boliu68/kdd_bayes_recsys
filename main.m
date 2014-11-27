% This is the main function of this project

clear;
clc;

%n: #Users
%d: #Items
%L: #Classes
%h: The rank of matrix
% hyperpara.n = 10;
% hyperpara.d = 5;
% hyperpara.L = 5;
% hyperpara.h = 3;
%
% %Test for syntax
% R = sparse(randi(5, hyperpara.n, hyperpara.d));
% O = sparse(randi([0,1], hyperpara.n, hyperpara.d) == 1);
% data = load('movielens1M.mat');
% R = data.X;
% O = R > 0;
% hyperpara.n = size(R,1);
% hyperpara.d = size(R,2);
% hyperpara.L = 5;
% hyperpara.h = 10;

% datagen;
% x = load('toy.mat');
% y = load('para.mat');

R = x.R;
O = x.O;
% para = y.para;
% hyperpara = y.hyperpara;
hyperpara.n = 50;
hyperpara.d = 40;
hyperpara.L = 5;
hyperpara.h = 3;
hyperpara.iv = 1000;

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
hyperpara.v0 = 1000;

max_iter = 10;   %iteration number

%% Initialization should be here

para = init_para(O, hyperpara);

for iter = 1:max_iter
    disp(['Iteration:',int2str(iter)])
%     if iter == 1
        para = update_f1(para, hyperpara);
        para = update_f2(para, hyperpara);
        para = update_f3(para, hyperpara);
        para = update_f4(para, hyperpara);
        para = update_f5(para, hyperpara);
        para = update_f6(para, hyperpara);
        para = update_f7(para, hyperpara);
%     end
    para = update_f8(para, hyperpara);
    para = update_f9(para, hyperpara);
    para = update_f10(para, hyperpara);
    para = update_f11(para, hyperpara, O, iter);
    para = update_f12(para, hyperpara, O, iter);
    para = update_f13(para, hyperpara, O, R);
end
[pred_entry.row, pred_entry.col, ~] = find(O);
%trick
para.m_b = sort(para.m_b,2);
%
[ Rpred ] = predfun( para, hyperpara, pred_entry);

tr_err = rmse(Rpred * [1:5]', R, O)
random_err = rmse(1+4*rand(nnz(O),1), R, O)
