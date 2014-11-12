function para = update_f2(para, hyperpara)
    %update f2 and hat f2
    %1 to h
    para.h_a_kvU2(:) = hyperpara.a0d;
    para.h_b_kvU2(:) = hyperpara.b0d;
    
    para.a_kvU(:) = hyperpara.a0d;
    para.b_kvU(:) = hyperpara.b0d;

end