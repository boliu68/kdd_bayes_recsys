

datapath = 'movielens10k.mat';
R = importdata(datapath);
R = sparse(R);
O = R > 0;

%
n = size(R,1);
d = size(R,2);
L = 5;
h = 10;

tr_fraction = 0.8;

%random split the Training data and test data
[nnz_i, nnz_j, ~] = find(O);
O_tr = sparse(zeros(n,d));
O_tst = sparse(zeros(n,d));

tr_idx = randsample(nnz(O), tr_fraction * nnz(O));
tr_id = zeros(1,nnz(O));

tr_id(tr_idx) = 1;
tr_id = tr_id == 1;
tst_id = ~tr_id;

O_tr(nnz_i(tr_id),nnz_j(tr_id)) = 1;
O_tst(nnz_i(tst_id),nnz_j(tst_id))=1;
O_tr = O_tr == 1;
O_tst = O_tst == 1;

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

max_iter = 10;   %iteration number

%% Initialization should be here
init_para

% This is the iteration of update
for iter = 1:max_iter
     disp(['Iteration:',int2str(iter)])

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
    para = update_f12(para, hyperpara, O, iter);
    para = update_f13(para, hyperpara, O, R);

end

[pred_entry.row, pred_entry.col, ~] = find(O);
[ Rpred ] = predfun( para, hyperpara, pred_entry);
%Test data

