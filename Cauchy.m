function [z] = Cauchy (f, fc, s)


 eta = s*fc;
 x = f/fc;
 z = exp((1-x)*eta);
 z = (x^eta)*z;
