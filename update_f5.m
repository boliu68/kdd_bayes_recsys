function para = update_f5(para, hyperpara)
    
    %k = 1 to d
    para.h_a_gmacol5(:) = hyperpara.a0;
    para.h_b_gmacol5(:) = hyperpara.b0;
    
    para.a_gmacol(:) = hyperpara.a0;
    para.b_gmacol(:) = hyperpara.b0;

end