function para = update_f1(para, hyperpara)
%update hat f1 and f1 with respect to a0dot and b0dot
%1 to h where h is dimension of latent space.
para.h_a_kvV1(:) = hyperpara.a0d
para.h_b_kvV1(:) = hyperpara.b0d

para.a_kvV(:) = hyperpara.a0d
para.a_bvV(:) = hyperpara.b0d

end