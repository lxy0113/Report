%% ������0-180��
function []=Test2(pm_x,pm_y,ptheta_z,ProjImg,p_z)
%% ProjImg���������λ
Amp_phase(ProjImg);
%% pm_x,ֻ�ж��������������λ
Amp_phase(pm_x);
%% pm_y,ֻ�о��������������λ
Amp_phase(pm_y);
%% ptheta_zֻ�аڶ������������λ
Amp_phase(ptheta_z);
%% ���߶����ڣ����������λ
Amp_phase(p_z);
end