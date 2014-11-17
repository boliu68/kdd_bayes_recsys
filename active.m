clc;
clear;

datapath = 'movielens10k.mat';
R = importdata(datapath);
R = randi([0,5],500,500);
R = sparse(R);
O = R > 0;
% 
% %
n = size(R,1);
d = size(R,2);
L = 5;
h = 10;

tr_fraction = 0.2;

%random split the Training data and test data

hyperpara.n = n;
hyperpara.d = d;
hyperpara.L = L;
hyperpara.h = h;
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
hyperpara.v0 = 0.1;

max_iter = 1;   %iteration number

%% Initialization should be here
tr_i = floor(0.9 * n);
O_act = O(1:tr_i, :);
R_act = R(1:tr_i, :);
hyperpara.n = size(O_act, 1);
hyperpara.d = size(O_act, 2);
hyperpara.L = L;
hyperpara.h = h;

para = init_para(O_act, hyperpara);

%Begin to Training
for iter = 1:max_iter
    disp(['Iteration:',int2str(iter)])
    if iter == 1
        para = update_f1(para, hyperpara);
        para = update_f2(para, hyperpara);
        para = update_f3(para, hyperpara);
        para = update_f4(para, hyperpara);
        para = update_f5(para, hyperpara);
        para = update_f6(para, hyperpara);
        para = update_f7(para, hyperpara);
    end
    para = update_f8(para, hyperpara);
    para = update_f9(para, hyperpara);
    para = update_f10(para, hyperpara);
    para = update_f11(para, hyperpara, O_act, iter);
    para = update_f12(para, hyperpara, O_act, iter);
    para = update_f13(para, hyperpara, O_act, R);
end
[pred_entry.row, pred_entry.col, ~] = find(O_act);
%trick
para.m_b = sort(para.m_b,2);
%
[ Rpred ] = predfun( para, hyperpara, pred_entry);

tr_err = rmse(Rpred * [1:5]', R, O_act)
random_err = rmse(1+4*rand(nnz(O_act),1), R, O_act)


%Begin to test Active learning
for user_id = (tr_i+1):n
    
    %resize para
    
    
    %ask for query item
    
    para.m_a(O) = rand(nnz(O),1);
    para.m_c(O) = rand(nnz(O),1);
    
    
    
end
