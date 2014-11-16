function [ m_u, m_v ] = f11_gradient_update( para, hyperpara,local_para, option,O  )
%F11_GRADIENT_UPDATE Summary of this function goes here
%   Detailed explanation goes here
stepsize = option.stepsize;
maxIter = option.maxiter;
eps = option.eps;

m_u = para.m_u;
m_v = para.m_v;

stop_update = 0;
for iter = 1: maxIter
    
 

[ g_m_u, g_m_v ] = compute_f11_gradent(hyperpara,  para,O, local_para );
m_u = m_u - stepsize * g_m_u;
m_v = m_v - stepsize * g_m_v;


%check stop condition
objvalue =   objective_func(para, O, local_para );
if(iter > 1)
     stop_update = ((old_objvalue - objvalue) < eps);
end
old_objvalue = objvalue;

if stop_update ==1
    break;    
end



end


end
