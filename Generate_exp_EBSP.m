function [Euler,EBSPs] = Generate_exp_EBSP(EBSPData,MapData)

Euler = [MapData.phi1 MapData.PHI MapData.phi2];

X = 1:1:EBSPData.numpats;
h = @(x) Simulated_EBSP(EBSPData,x);
EBSPs = arrayfun(h,X,'UniformOutput',false);
EBSPs = cell2mat(EBSPs);
size_EBSP = size(EBSPs);
length_EBSP = size_EBSP(1);
EBSPs = reshape(EBSPs,[length_EBSP length_EBSP length(X)]);