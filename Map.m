function [Map_EBSP_pixel]=Map(EBSP_BG,MapData,MicroscopeData)

% %sort already processed EBSPs into a 2D Map


% %Map the EBSD scanning coords
Map_XSample=bMapSort(MapData,MicroscopeData,MapData.XSample);
Map_YSample=bMapSort(MapData,MicroscopeData,MapData.YSample);

% Plot the map
% figure;
% imagesc(EBSP_BG(:,:,1)); axis image; axis xy; title('Click somewhere to plot the intensity of this pixel');
% colormap('gray')
%take a mouse input
%[x,y]=ginput(1);
%round to a whole pixel location
% x=round(x); y=round(y);
% %plot this location
% hold on; scatter(x,y,'m');

x0 = 41;
y0 = 32;
r = 0;
[X,Y] = getmidpointcircle(x0,y0,r);
index = 0;
for i=[X';Y']
    index = index+1;
    x = i(1);
    y = i(2);
    %extract this pixel from the EBSP data
    EBSP_pixel=EBSP_BG(y,x,:);
    %shift the dimensions from (1,1,NUMPTS) to (NUMPTS,1);
    EBSP_pixel=shiftdim(EBSP_pixel,2);
    %turn into a map
    Map_EBSP_pixels(index,:,:)=bMapSort(MapData,MicroscopeData,EBSP_pixel);
end
Map_EBSP_pixel = shiftdim(mean(Map_EBSP_pixels),1);

%plot the map
figure;
sp1=subplot(1,1,1); %creates an axis
imagesc(Map_XSample(1,:),Map_YSample(:,1)',Map_EBSP_pixel); 
axis image; axis tight; colormap('gray'); axis ij;
sp1.XDir='reverse';