clear all
close all

addpath(genpath('../netalign/'))
addpath('../setup/')

% this is a script to run the multimodal network alignment on all the modes
% in the airports dataset

% load the data
load openflight-EU.mat % output from createT_Europe (openflights data)
M = T;

load nicosia-EU.mat % output from createT_Nicosia
N = T;

input_modes = 1:175;