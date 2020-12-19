%% 都考虑0-180度
function []=Test2(pm_x,pm_y,ptheta_z,ProjImg,p_z)
%% ProjImg看振幅和相位
Amp_phase(ProjImg);
%% pm_x,只有端跳，看振幅和相位
Amp_phase(pm_x);
%% pm_y,只有径跳，看振幅和相位
Amp_phase(pm_y);
%% ptheta_z只有摆动，看振幅和相位
Amp_phase(ptheta_z);
%% 三者都存在，看振幅和相位
Amp_phase(p_z);
end