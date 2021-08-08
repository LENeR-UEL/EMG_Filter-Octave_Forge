%%%%%%%%%%%%%%%%%%%%%%%%
%ADAPTA��O PARA O OCTAVE
%%%%%%%%%%%%%%%%%%%%%%%%
%Modificado 29/07/2021 - Eddy Krueger

pkg load signal
%rotina para o LENeR MS gravado no opensignals (bitalino) app
close all
clear all
clc

addpath('/home/eddy/Dokumente/Processamento_Octave'); %colocar o diret�rio que est�o as suas rotinas entre as aspas.path(path,'C:\Users\acer\Google Drive\Processamento_MatLab\Rotinas_MatLab_UEL'); %colocar o diret�rio que est�o as suas rotinas entre as aspas. 
addpath('/home/herr-k/Dokumente/Processamento_Octave/CaW'); %colocar o diret�rio que est�o as suas rotinas entre as aspas. 
addpath('/home/herr-k/Dokumente/Processamento_Octave/Figures'); %colocar o diret�rio que est�o as suas rotinas entre as aspas. 
addpath('/home/herr-k/Dokumente/Processamento_Octave/Filter'); %colocar o diret�rio que est�o as suas rotinas entre as aspas. 

%%helpdlg ('Escolha o arquivo')
File_name = uigetfile ('*.txt');
Data = load(File_name);
prompt = { 'Grupo', 'Numero (Px?)', 'Membros (MI ou MS?)','Etapa (Pré, Pós...?)'};
dados= inputdlg(prompt, 'Digite')';
Id = Data(:,4); %sa�da digital 1
Contraction_1 = find(Id==1, 1);
Contraction_2 = find(Id(Contraction_1+10000:end)==1, 1);
Contraction_2 = (Contraction_2+Contraction_1+10000-1);

%Reto femoral D - Contraindo
EMG_RF_D_1 = Data((Contraction_1+2000:Contraction_1+3999),6);
EMG_RF_D_2 = Data((Contraction_2+2000:Contraction_2+3999),6);
[EMG_RF_D_1_Fi,Fmed_EMG_RF_D_1_Fi] = EMG_Filter(EMG_RF_D_1, 'EMG_RF_D_1_Fi');
[EMG_RF_D_2_Fi,Fmed_EMG_RF_D_2_Fi] = EMG_Filter(EMG_RF_D_2, 'EMG_RF_D_2_Fi');
RF_D_Fmed_mat = [Fmed_EMG_RF_D_1_Fi,Fmed_EMG_RF_D_2_Fi];
RF_D_Fmed=mean(RF_D_Fmed_mat);
RF_D_RMS_1 = rms(EMG_RF_D_1_Fi);
RF_D_RMS_2 = rms(EMG_RF_D_2_Fi);
RF_D_RMS_Contrac_mat = [RF_D_RMS_1,RF_D_RMS_2];

%Reto femoral D - Relaxado
EMG_RF_D_01 = Data((Contraction_1-4000:Contraction_1-1999),6);
EMG_RF_D_02 = Data((Contraction_2-4000:Contraction_2-1999),6);
[EMG_RF_D_01_Fi,Fmed_EMG_RF_D_01_Fi] = EMG_Filter(EMG_RF_D_01, 'EMG_RF_D_01_Fi');
[EMG_RF_D_02_Fi,Fmed_EMG_RF_D_02_Fi] = EMG_Filter(EMG_RF_D_02, 'EMG_RF_D_02_Fi');
RF_D_RMS_01 = rms(EMG_RF_D_01_Fi);
RF_D_RMS_02 = rms(EMG_RF_D_02_Fi);
RF_D_RMS_Relax_mat = [RF_D_RMS_01,RF_D_RMS_02];
RF_D_RMS=abs((mean(RF_D_RMS_Contrac_mat))-(mean(RF_D_RMS_Relax_mat)));
%-----------------------------------------------------------------------

%Vasto lateral D - Contraindo
EMG_VL_D_1 = Data((Contraction_1+2000:Contraction_1+3999),7);
EMG_VL_D_2 = Data((Contraction_2+2000:Contraction_2+3999),7);
[EMG_VL_D_1_Fi,Fmed_EMG_VL_D_1_Fi] = EMG_Filter(EMG_VL_D_1, 'EMG_VL_D_1_Fi');
[EMG_VL_D_2_Fi,Fmed_EMG_VL_D_2_Fi] = EMG_Filter(EMG_VL_D_2, 'EMG_VL_D_2_Fi');
VL_D_Fmed_mat = [Fmed_EMG_VL_D_1_Fi,Fmed_EMG_VL_D_2_Fi];
VL_D_Fmed=mean(VL_D_Fmed_mat);
VL_D_RMS_1 = rms(EMG_VL_D_1_Fi);
VL_D_RMS_2 = rms(EMG_VL_D_2_Fi);
VL_D_RMS_Contrac_mat = [VL_D_RMS_1,VL_D_RMS_2];

%Vasto lateral D - Relaxado
EMG_VL_D_01 = Data((Contraction_1-4000:Contraction_1-1999),7);
EMG_VL_D_02 = Data((Contraction_2-4000:Contraction_2-1999),7);
[EMG_VL_D_01_Fi,Fmed_EMG_VL_D_01_Fi] = EMG_Filter(EMG_VL_D_01, 'EMG_VL_D_01_Fi');
[EMG_VL_D_02_Fi,Fmed_EMG_VL_D_02_Fi] = EMG_Filter(EMG_VL_D_02, 'EMG_VL_D_02_Fi');
VL_D_RMS_01 = rms(EMG_VL_D_01_Fi);
VL_D_RMS_02 = rms(EMG_VL_D_02_Fi);
VL_D_RMS_Relax_mat = [VL_D_RMS_01,VL_D_RMS_02];
VL_D_RMS=abs((mean(VL_D_RMS_Contrac_mat))-(mean(VL_D_RMS_Relax_mat)));
%-----------------------------------------------------------------------

%Reto femoral D - Contraindo
EMG_RF_E_1 = Data((Contraction_1+2000:Contraction_1+3999),8);
EMG_RF_E_2 = Data((Contraction_2+2000:Contraction_2+3999),8);
[EMG_RF_E_1_Fi,Fmed_EMG_RF_E_1_Fi] = EMG_Filter(EMG_RF_E_1, 'EMG_RF_E_1_Fi');
[EMG_RF_E_2_Fi,Fmed_EMG_RF_E_2_Fi] = EMG_Filter(EMG_RF_E_2, 'EMG_RF_E_2_Fi');
RF_E_Fmed_mat = [Fmed_EMG_RF_E_1_Fi,Fmed_EMG_RF_E_2_Fi];
RF_E_Fmed=mean(RF_E_Fmed_mat);
RF_E_RMS_1 = rms(EMG_RF_E_1_Fi);
RF_E_RMS_2 = rms(EMG_RF_E_2_Fi);
RF_E_RMS_Contrac_mat = [RF_E_RMS_1,RF_E_RMS_2];

%Reto femoral D - Relaxado
EMG_RF_E_01 = Data((Contraction_1-4000:Contraction_1-1999),8);
EMG_RF_E_02 = Data((Contraction_2-4000:Contraction_2-1999),8);
[EMG_RF_E_01_Fi,Fmed_EMG_RF_E_01_Fi] = EMG_Filter(EMG_RF_E_01, 'EMG_RF_E_01_Fi');
[EMG_RF_E_02_Fi,Fmed_EMG_RF_E_02_Fi] = EMG_Filter(EMG_RF_E_02, 'EMG_RF_E_02_Fi');
RF_E_RMS_01 = rms(EMG_RF_E_01_Fi);
RF_E_RMS_02 = rms(EMG_RF_E_02_Fi);
RF_E_RMS_Relax_mat = [RF_E_RMS_01,RF_E_RMS_02];
RF_E_RMS=abs((mean(RF_E_RMS_Contrac_mat))-(mean(RF_E_RMS_Relax_mat)));
%-----------------------------------------------------------------------

%Vasto lateral E - Contraindo
EMG_VL_E_1 = Data((Contraction_1+2000:Contraction_1+3999),9);
EMG_VL_E_2 = Data((Contraction_2+2000:Contraction_2+3999),9);
[EMG_VL_E_1_Fi,Fmed_EMG_VL_E_1_Fi] = EMG_Filter(EMG_VL_E_1, 'EMG_VL_E_1_Fi');
[EMG_VL_E_2_Fi,Fmed_EMG_VL_E_2_Fi] = EMG_Filter(EMG_VL_E_2, 'EMG_VL_E_2_Fi');
VL_E_Fmed_mat = [Fmed_EMG_VL_E_1_Fi,Fmed_EMG_VL_E_2_Fi];
VL_E_Fmed=mean(VL_E_Fmed_mat);
VL_E_RMS_1 = rms(EMG_VL_E_1_Fi);
VL_E_RMS_2 = rms(EMG_VL_E_2_Fi);
VL_E_RMS_Contrac_mat = [VL_E_RMS_1,VL_E_RMS_2];

%Vasto lateral E - Relaxado
EMG_VL_E_01 = Data((Contraction_1-4000:Contraction_1-1999),9);
EMG_VL_E_02 = Data((Contraction_2-4000:Contraction_2-1999),9);
[EMG_VL_E_01_Fi,Fmed_EMG_VL_E_01_Fi] = EMG_Filter(EMG_VL_E_01, 'EMG_VL_E_01_Fi');
[EMG_VL_E_02_Fi,Fmed_EMG_VL_E_02_Fi] = EMG_Filter(EMG_VL_E_02, 'EMG_VL_E_02_Fi');
VL_E_RMS_01 = rms(EMG_VL_E_01_Fi);
VL_E_RMS_02 = rms(EMG_VL_E_02_Fi);
VL_E_RMS_Relax_mat = [VL_E_RMS_01,VL_E_RMS_02];
VL_E_RMS=abs((mean(VL_E_RMS_Contrac_mat))-(mean(VL_E_RMS_Relax_mat)));
%-----------------------------------------------------------------------

close all

resultados= [ 'Bruto' dados(2) dados(1) dados(3) dados(4) RF_D_Fmed RF_D_RMS VL_D_Fmed VL_D_RMS RF_E_Fmed RF_E_RMS VL_E_Fmed VL_E_RMS];

%Cauchy Wavelet
%CaW_RF_D_Fi = EMG_CaW_mod_s09(EMG_RF_D_2_Fi);
%CaW_VL_D_Fi = EMG_CaW_mod_s09(EMG_VL_D_2_Fi);
%CaW_RF_E_Fi = EMG_CaW_mod_s09(EMG_RF_E_2_Fi);
%CaW_VL_E_Fi = EMG_CaW_mod_s09(EMG_VL_E_2_Fi);

%save CaW_RF_D_Fi.mat CaW_RF_D_Fi;
%save CaW_VL_D_Fi.mat CaW_VL_D_Fi;
%save CaW_RF_E_Fi.mat CaW_RF_E_Fi;
%save CaW_VL_E_Fi.mat CaW_VL_E_Fi;

%xlswrite('Proj_02_MS.xlsx',[dados(1) dados(2) dados(3) dados(4) dados(5) RF_D_Fmed RF_D_RMS VL_D_Fmed VL_D_RMS RF_E_Fmed RF_E_RMS VL_E_Fmed VL_E_RMS],'dados', dados(6)); 
helpdlg(sprintf('acabou!!!!!!'));  



 

