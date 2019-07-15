function [EBSP_BG] = Simulated_EBSP(EBSPData,index)

[ EBSP_FeR ] = bReadEBSP(EBSPData,index);

%background correction settings

%gaussian flatten (removes the low frequency bg)
Settings_Cor_Fe.gfilt=4; %use a low pass filter (do you mean high pass?)
Settings_Cor_Fe.gfilt_s=1; %low pass filter sigma

%radius mask (crops to a circle)
Settings_Cor_Fe.radius=0; %use a radius mask
Settings_Cor_Fe.radius_frac=0.98; %fraction of the pattern width to use as the mask

%split BG fix (removes vertical seam)
Settings_Cor_Fe.SplitBG=1;
Settings_Cor_Fe.SquareCrop=1;

 [EBSP_BG,Settings_Cor_Out ] = EBSP_BGCor( EBSP_FeR,Settings_Cor_Fe); %Background correct the patterns
   
 %Doubling the last column to have a square
 extra_column = EBSP_BG(:,end);
 EBSP_BG = [EBSP_BG extra_column];
 
%  figure;
%  subplot(1,2,1)
%  imagesc(EBSP_BG); axis image; axis xy; colormap('gray')
%  subplot(1,2,2)
%  imagesc(EBSP_FeR); axis image; axis xy; colormap('gray')