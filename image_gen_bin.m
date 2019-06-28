function [Test_image] = image_gen_bin(screensize,PC, rotation_matrix, screen_int, isHex)
%IMAGE_GEN_BIN Summary of this function goes here
%   Takes inputs
%   Outputs a diffraction pattern on a square screen

%%Set the screen size
PatternInfo.ScreenWidth=screensize;
PatternInfo.ScreenHeight=screensize;

%Set up the scree in accordance with Britton 2010
[ EBSP ] = EBSP_Gnom( PatternInfo,PC );

%Rotate the screen
r = [EBSP.xpts_screen(:), EBSP.ypts_screen(:), EBSP.ypts_screen(:)*0+1].*1./sqrt((EBSP.xpts_screen(:).^2+EBSP.ypts_screen(:).^2+1));
sy=EBSP.size(1);
sx=EBSP.size(2);
r2 = r*rotation_matrix';


%%Generate an image

%sample the pattern from the interpolant
[i_data] = Cube_Sample(r2(:,1),r2(:,2),r2(:,3),screen_int,isHex);
%reshape the output
Test_image=reshape(i_data,sy,sx);

%normalise
% Test_image=Test_image-mean(Test_image(:));
% Test_image=Test_image./std(Test_image(:));

% figure;
% imagesc(Test_image); axis tight;axis square; colormap('gray');
% hold on
% plot(PC(1)*screensize,PC(2)*screensize, 'r+', 'MarkerSize', 5, 'LineWidth', 1.5); 

end