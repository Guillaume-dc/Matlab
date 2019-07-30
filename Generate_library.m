function [Euler,EBSPs] = Generate_library(PC_av,screensize,SF)

% This function returns an array of Euler angles with the corresponding
% EBSPs

%Adding paths
addpath(genpath('mtex_git\mtex_git')) 
addpath(genpath('AstroEBSD_20190326\AstroEBSD')) 
addpath(genpath('EBSD2019_workshops_ mtex\upload'))

%Loading the CIF file
cs = loadCIF('Fe-Iron-alpha.cif');

%Generating the orientation matrices
Sampling_Freq = SF; %10 gives ~ 900 patterns, 7 gives~1500 patterns and 2.5 gives ~ 40000 patterns
[ library_G,Euler ] = SO3_rotmat_gen(cs,Sampling_Freq);

%The parameters to choose are:
%- Orientation matrix
%- Pattern center ie PC_av which is a list of the 3 coordinates
%- Screen size eg 100 for 100x100
BinFile = 'Ferrite_1024.bin';
isHex = 0;
[screen_int] = Cube_Generate(BinFile,isHex);

%Storing the EBSP data in the EBSP array

X = 1:1:length(library_G);
f = @(x) theo_EBSP(library_G(:,:,x),screen_int,screensize,PC_av,isHex);
EBSPs = arrayfun(f,X,'UniformOutput',false);
EBSPs = cell2mat(EBSPs);
size_EBSP = size(EBSPs);
length_EBSP = size_EBSP(1);
EBSPs = reshape(EBSPs,[length_EBSP length_EBSP length(X)]);

