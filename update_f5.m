function para = update_f5(para, hyperpara)
    
    %k = 1 to d
    para.h_a_jgmacol5(:) = hyperpara.a0;
    para.h_b_jgmacol5(:) = hyperpara.b0;
    
    para.a_jgmacol(:) = hyperpara.a0;
    para.b_jgmacol(:) = hyperpara.b0;

end