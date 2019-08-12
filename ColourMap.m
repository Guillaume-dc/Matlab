function ColourMap()

% Generating an indexed 2D EBSPs map based on the csv file created with the
% python script

% Loading the parameters of the experimental EBSPs
location_astro='C:\Users\33643\Desktop\Materials Science\Project\AstroEBSD\';
run(fullfile(location_astro,'start_AstroEBSD.m'));
location_mtex='C:\Users\33643\Desktop\Materials Science\Project\Matlab\mtex\'; %Change this to where you keep your MTEX folder
run(fullfile(location_mtex,'startup_mtex.m'));
InputUser.HDF5_folder='C:\Users\33643\Desktop\Materials Science\Project\Data'; %Change this to the file location in whch you have saved the example data
InputUser.HDF5_file='Demo_Ben_16bin.h5';
InputUser.Phase_Input  = {'Ferrite'};
Settings_PCin.start=[0.5010 0.4510 0.5870]; %Fe
[ MapData,MicroscopeData,PhaseData,EBSPData ] = bReadHDF5( InputUser );

%Loading the CIF file
cs = loadCIF('Fe-Iron-alpha.cif');

%% Use the Bruker data
Map_B_phi1=bMapSort(MapData,MicroscopeData,MapData.phi1);
Map_B_phi2=bMapSort(MapData,MicroscopeData,MapData.phi2);
Map_B_Phi=bMapSort(MapData,MicroscopeData,MapData.PHI);

ori_Bruker = ...
  rotation('Euler',Map_B_phi1*degree,Map_B_Phi*degree,Map_B_phi2*degree);

prop_b.x = double(bMapSort(MapData,MicroscopeData,MapData.XSample));
prop_b.y = double(bMapSort(MapData,MicroscopeData,MapData.YSample));

ebsd_b = EBSD(ori_Bruker, ones(size(ori_Bruker)),{'notIndexed',cs},'options',prop_b);

figure;
colorKey = ipfHSVKey(cs);
colorKey.inversePoleFigureDirection = xvector;
color = colorKey.orientation2color(ebsd_b('indexed').orientations);

plot(ebsd_b,colorKey.orientation2color(ebsd_b.orientations))
title('Bruker')
camroll(90)
%plot(colorKey)
%% Calculate the 2D map with the PCA-based method

filename = 'Euler_angles.csv';
M = csvread(filename);
MapData.phi1 = M(:,3);
MapData.PHI = M(:,2);
MapData.phi2 = M(:,1);

Map_phi1=bMapSort(MapData,MicroscopeData,MapData.phi1);
Map_phi2=bMapSort(MapData,MicroscopeData,MapData.phi2);
Map_Phi=bMapSort(MapData,MicroscopeData,MapData.PHI);

ori = ...
  rotation('Euler',Map_phi1*degree,Map_Phi*degree,Map_phi2*degree);

prop.x = double(bMapSort(MapData,MicroscopeData,MapData.XSample));
prop.y = double(bMapSort(MapData,MicroscopeData,MapData.YSample));

ebsd = EBSD(ori, ones(size(ori)),{'notIndexed',cs},'options',prop);

figure;
% colorKey = ipfHSVKey(cs);
% colorKey.inversePoleFigureDirection = xvector;
% color = colorKey.orientation2color(ebsd('indexed').orientations);

plot(ebsd,colorKey.orientation2color(ebsd.orientations))
title('PCA-based method')
camroll(90)


%% calculate the misorientation between Astro and Bruker
% mis_twodata=angle(ebsd_b.orientations,ebsd.orientations)
% figure; 
% imagesc(mis_twodata);
% caxis([0 1]); %0.1