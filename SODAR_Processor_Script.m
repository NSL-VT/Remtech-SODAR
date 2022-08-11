% SODAR File Processor 
% From Flight Data
%
% (C) 2022 Mekonen Haileselassie Halefom <hmeko13@vt.edu>
%
% This code runs the function sodar2mat.mat file to convert the SODAR's
% .dat file to .mat file.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear 
clc


% Enter the path for the desired ulog file
txt = '../../20220613_WindQuad/20220613_SODAR_S0827_E0917.dat';

% Get timetable
[sodarA, sodarB] = sodar2mat(txt);

% Save file
% save('20220622_SODAR_s1215_e1243_matA','sodarA')
% save('20220622_SODAR_s1215_e1243_matB','sodarB')
