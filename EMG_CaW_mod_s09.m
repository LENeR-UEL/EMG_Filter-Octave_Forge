%Adaptado para o OCTAVE
%Atualizado 08/04/2020 - Eddy Krueger

function [S] = EMG_CaW_mod_s09(V0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    WAVELET DE CAUCHY  MMG-EMG   %%%%%%%%%%%%%%%%%%%%%%%5%%%%%%%%%%%%%%
Fc_MMG_s4_Roh = [round((1/4)*((0+1.45)^1.959)) round((1/4)*((1+1.45)^1.959)) round((1/4)*((2+1.45)^1.959)) round((1/4)*((3+1.45)^1.959)) round((1/4)*((4+1.45)^1.959)) round((1/4)*((5+1.45)^1.959)) round((1/4)*((6+1.45)^1.959)) round((1/4)*((7+1.45)^1.959)) round((1/4)*((8+1.45)^1.959)) round((1/4)*((9+1.45)^1.959)) round((1/4)*((10+1.45)^1.959)) round((1/4)*((11+1.45)^1.959)) floor((1/4)*((12+1.45)^1.959)) round((1/4)*((13+1.45)^1.959)) round((1/4)*((14+1.45)^1.959)) round((1/4)*((15+1.45)^1.959)) round((1/4)*((16+1.45)^1.959)) round((1/4)*((17+1.45)^1.959)) round((1/4)*((18+1.45)^1.959)) round((1/4)*((19+1.45)^1.959)) round((1/4)*((20+1.45)^1.959))];    
Fc_EMG_s09_Roh = [((1/0.9)*((0+1.45)^1.959)) ((1/0.9)*((1+1.45)^1.959)) floor((1/0.9)*((2+1.45)^1.959)) floor((1/0.9)*((3+1.45)^1.959)) floor((1/0.9)*((4+1.45)^1.959)) floor((1/0.9)*((5+1.45)^1.959)) floor((1/0.9)*((6+1.45)^1.959)) floor((1/0.9)*((7+1.45)^1.959)) floor((1/0.9)*((8+1.45)^1.959)) floor((1/0.9)*((9+1.45)^1.959)) floor((1/0.9)*((10+1.45)^1.959)) floor((1/0.9)*((11+1.45)^1.959)) floor((1/0.9)*((12+1.45)^1.959)) floor((1/0.9)*((13+1.45)^1.959)) floor((1/0.9)*((14+1.45)^1.959)) floor((1/0.9)*((15+1.45)^1.959)) floor((1/0.9)*((16+1.45)^1.959)) floor((1/0.9)*((17+1.45)^1.959)) floor((1/0.9)*((18+1.45)^1.959)) floor((1/0.9)*((19+1.45)^1.959)) floor((1/0.9)*((20+1.45)^1.959))];

Fc_EMG_s09= Fc_EMG_s09_Roh(4:end);
Fc_MMG_s4 = Fc_MMG_s4_Roh(4:end);
% Definição dos Parâmetros
    fs = 1000; % Frequência de Amostragem
    
    T = 1/fs; % Período de Amostragem
    %t = (0:n-1)*T; % Definição do vetor tempo 
    J = 21; % Número de níveis (escalas) da transformada wavelet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Entradas:
% V - Sinal
% fs - Frequ�ncia de Amostragem 
% J - N�mero de n�veis (escalas) da transformada wavelet

% Sa�das:
% S - sinal no dom�nio wavelet (J n�veis x n amostras)
% amp_sqr_wave - RMS calculado no dom�nio wavelet - (1 x n amostras)

V=V0';
r_ = 1.959;
q_ = 1.45;
scale_ = 0.9;

n = length(V);
n_ = ceil(n);
T_ = n_/fs;

if(rem(n_,2) == 1) 
    n2_ = (n_ - 1)/2;
    fq = (1:1:n2_)/T_;
    fq = [0  fq  -1*(fliplr(fq))];
end

if(rem(n_,2) == 0) 
   n2_ = n_/2;
    fq = (1:1:n2_)/T_;
   fq = [0  fq  -1*(fliplr(fq(1:n2_-1)))];
end

I_ = 0:1:J-1;
Fc = (q_ + I_).^r_/scale_; 

FX = fft(V - mean(V));

Q = zeros(1, n_);
amp_sqr_wave = zeros(1, n_);
Q1 = zeros(n_, J);

for j = 1:J
   for k = 1:n_
        Q1(k,j) = Cauchy(fq(k), Fc(j), scale_);
   end
end


for j = 1:J
    for k = 1:n_
        Q(k) = Cauchy(fq(k), Fc(j), scale_);
        for s = 1:(J-2)
             if((fq(k) > (Fc(s)+Fc(s+1))/2) && (fq(k) <= (Fc(s+1)+Fc(s+2))/2))
                 Q(k) = Q(k)/sqrt(Q1(k,s)^2 + Q1(k,s+1)^2 + Q1(k,s+2)^2);
             end
             
        end
    end
    Q(n_/2:n) = 0;
    S(j,:) = ifft(FX.*Q);

end

S=abs(S);
S = [S(4:21,:)]';
%for a1=1:n
 %   amp_sqr_wave(a1) = (sum(abs(S(:,a1)))); % Rms using wavelet end
%end

end

