function para = update_f2(para, hyperpara)
    %update f2 and hat f2
    %1 to h
    para.h_a_vU2(:) = hyperpara.a0d;
    para.h_b_vU2(:) = hyperpara.b0d;
    
    para.a_vU(:) = hyperpara.a0d;
    para.b_vU(:) = hyperpara.b0d;

end