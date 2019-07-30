function Main()

% Loading the parameters of the experimental EBSP
%Adding paths
% addpath(genpath('mtex_git\mtex_git')) 
% addpath(genpath('AstroEBSD_20190326\AstroEBSD')) 
% addpath(genpath('LoadPatterns')) 
% addpath(genpath('EBSD2019_workshops_ mtex\upload'))
location_astro='C:\Users\33643\Desktop\Materials Science\Project\AstroEBSD\';
run(fullfile(location_astro,'start_AstroEBSD.m'));
location_mtex='C:\Users\33643\Desktop\Materials Science\Project\Matlab\mtex\'; %Change this to where you keep your MTEX folder
run(fullfile(location_mtex,'startup_mtex.m'));
InputUser.HDF5_folder='C:\Users\33643\Desktop\Materials Science\Project\Data'; %Change this to the file location in whch you have saved the example data
InputUser.HDF5_file='Demo_Ben_16bin.h5';
InputUser.Phase_Input  = {'Ferrite'};
Settings_PCin.start=[0.5010 0.4510 0.5870]; %Fe
SF = 4;
[ MapData,MicroscopeData,PhaseData,EBSPData ] = bReadHDF5( InputUser );

addpath(genpath('LoadPatterns')) 
[EBSP_BG] = Simulated_EBSP(EBSPData,1);
screensize = length(EBSP_BG);
PC_av = [0.5010 0.4510 0.5870];

% Creating a file of experimental EBSPs if there is no file 'exp_EBSP.h5'

if isfile('exp_EBSP.h5')
    fid = H5F.open('exp_EBSP.h5');
    h5disp('exp_EBSP.h5');
    H5F.close(fid); 
else
    [Euler,EBSPs] = Generate_exp_EBSP(EBSPData,MapData);
    [Map_EBSP_pixel]=Map(EBSPs,MapData,MicroscopeData);
    h5create('exp_EBSP.h5','/EBSP',size(EBSPs))
    h5write('exp_EBSP.h5','/EBSP',reshape(EBSPs,size(EBSPs)))
    h5create('exp_EBSP.h5','/Euler_Angles',[length(Euler) 3])
    h5write('exp_EBSP.h5','/Euler_Angles',reshape(Euler,[length(Euler) 3]))
    h5create('exp_EBSP.h5','/Map',size(Map_EBSP_pixel))
    h5write('exp_EBSP.h5','/Map',Map_EBSP_pixel)
    fid = H5F.open('exp_EBSP.h5');
    h5disp('exp_EBSP.h5');
    H5F.close(fid); 
end

% Generating the library if there is no file 'library.h5'

if isfile('library.h5')
    fid = H5F.open('library.h5');
    h5disp('library.h5');
    H5F.close(fid); 
else
    [Euler,EBSPs] = Generate_library(PC_av,screensize,SF);
    h5create('library.h5','/EBSP',size(EBSPs))
    size(EBSPs)
    size(Euler)
    h5write('library.h5','/EBSP',reshape(EBSPs,size(EBSPs)))
    h5create('library.h5','/Euler_Angles',[length(Euler) 3])
    h5write('library.h5','/Euler_Angles',reshape(Euler,[length(Euler) 3]))
    h5create('library.h5','/PatternCenter',[length(PC_av) 1])
    h5write('library.h5','/PatternCenter',reshape(PC_av,[length(PC_av) 1]))
    fid = H5F.open('library.h5');
    h5disp('library.h5');
    H5F.close(fid); 
end
