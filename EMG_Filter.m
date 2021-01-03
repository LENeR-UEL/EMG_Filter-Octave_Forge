%%%%%%%%%%%%%%%%%%%%%%%%
%Processing electromyographic signals using OCTAVE
%%%%%%%%%%%%%%%%%%%%%%%%
%Updated 03/01/2021 - Eddy Krueger


function [EMG_Fi,Fmedian_EMG_Fi] = EMG_Filter(file, name)
Fs = 1000; 
T = 1/Fs;                     % Sample time
n1 = 1000; 
delt = T; % 1/1000
n=4;      % order to butterworth filter 
fnq=1/(2*delt);  % Nyquist frequency 

                  
% 
%Notch filters 

Fnotch = 60; %Notch frequency
Wn=[(Fnotch-1)/fnq (Fnotch+1)/fnq];  
[b, a] = butter(n, Wn, 'stop');
File_Fi_60 = filtfilt(b,a,file);

Fnotch = 120; %Notch frequency
Wn=[(Fnotch-1)/fnq (Fnotch+1)/fnq];  
[b, a] = butter(n, Wn, 'stop');
File_Fi_120 = filtfilt(b,a,File_Fi_60);

Fnotch = 180; %Notch frequency
Wn=[(Fnotch-1)/fnq (Fnotch+1)/fnq];  
[b, a] = butter(n, Wn, 'stop');
File_Fi_180 = filtfilt(b,a,File_Fi_120);

Fnotch = 240; %Notch frequency
Wn=[(Fnotch-1)/fnq (Fnotch+1)/fnq];  
[b, a] = butter(n, Wn, 'stop');
File_Fi_240 = filtfilt(b,a,File_Fi_180);
 
Fnotch = 300; %Notch frequency 
Wn=[(Fnotch-1)/fnq (Fnotch+1)/fnq];  
[b, a] = butter(n, Wn, 'stop');
File_Fi_300 = filtfilt(b,a,File_Fi_240);

Fnotch = 360; %Notch frequency 
Wn=[(Fnotch-1)/fnq (Fnotch+1)/fnq];  
[b, a] = butter(n, Wn, 'stop');
File_Fi_360 = filtfilt(b,a,File_Fi_300);

Fnotch = 420; %Notch frequency 
Wn=[(Fnotch-1)/fnq (Fnotch+1)/fnq];  
[b, a] = butter(n, Wn, 'stop');
File_Fi_420 = filtfilt(b,a,File_Fi_360);

%Band-pass filter
flp = 10; %Low
fhi = 450; %High
Wn=[flp/fnq fhi/fnq];    % butterworth bandpass non-dimensional frequency 
[b,a]=butter(n,Wn); % construct the filter 
NFFT = 2^nextpow2(n1); % Next power of 2 from length of y
%fvtool(Wn,'Fs',Fs,'Color','White')

 
EMG_Fi = filtfilt(b,a,File_Fi_420);



Fs = 1000;
T = 1/Fs;                     % Sample time
n1 = 1000;
NFFT = 2^nextpow2(n1); % Next power of 2 from length of y
%%%%%%%%%%%%%%%%%%%%%%%
%create a graph
%red color = raw data
%green color = filtered data

figure('Name',name,'Color',[1 1 1]);
hold on
EMG_BRUTO_FFT = fft(file,NFFT)/n1;
f = Fs/2*linspace(0,1,NFFT/2+1);
plot(f,2*abs(EMG_BRUTO_FFT(1:NFFT/2+1)),'r',"linewidth", 4);
EMG_BRUTO_FFT_ABS_INI = 2*abs(EMG_BRUTO_FFT(1:NFFT/2+1));
normcumsumpsd = cumsum(EMG_BRUTO_FFT_ABS_INI)./sum(EMG_BRUTO_FFT_ABS_INI);
Fmedian_EMG_Bruto = find(normcumsumpsd <=0.5,1,'last');

hold on

 
%FFT and median frequency
EMG_Fi_FFT = fft(EMG_Fi,NFFT)/n1;
f = Fs/2*linspace(0,1,NFFT/2+1);
plot(f,2*abs(EMG_Fi_FFT(1:NFFT/2+1)),'g',"linewidth", 4);
title('Single-Sided Amplitude Spectrum of y(t)');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
EMG_Fi_FFT_ABS_INI = 2*abs(EMG_Fi_FFT(1:NFFT/2+1));
normcumsumpsd = cumsum(EMG_Fi_FFT_ABS_INI)./sum(EMG_Fi_FFT_ABS_INI);
Fmedian_EMG_Fi = find(normcumsumpsd <=0.5,1,'last');
Fmedian_EMG_Fi = Fmedian_EMG_Fi; %creates median frequency
set(gca, "linewidth", 2, "fontsize", 30)


title('FFT','fontsize',12,'color','k');
xlabel('Frequency (Hz)','fontsize',40,'color','k')
ylabel('|Y(f)|','fontsize',40,'color','k')
legend ('raw', 'Fi')

%end


