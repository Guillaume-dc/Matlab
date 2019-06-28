function [orientation,PC_av,screensize,Test_image] = exp_EBSP_ferrite()
%Phi1,Phi,Phi2

%loading the data from the h5 file into the container test_set
test_set = data_Ben();
%test_set.keys
%test_set.values

%Extracting the experimental EBSP from the container 
exp_library = test_set('RawPatterns');

%Selecting one pattern through its index in the dataset
index = 21;
Test_image = double(exp_library(:,:,index));
PCX = test_set('PCX');
PCY = test_set('PCY');
Phi1 = test_set('phi1');
Phi = test_set('PHI');
Phi2 = test_set('phi2');
DD = test_set('DD');

%outputs
orientation = [Phi1(index) Phi(index) Phi2(index)];
screensize = length(Test_image);
PC_av = [PCX(1) PCY(1) DD(1)];

%Normalizing
Test_image=Test_image-mean(Test_image(:));
Test_image=Test_image./std(Test_image(:));

%Plotting
figure;
I = imagesc(Test_image); %axis tight;axis square
axis off;
Tight = get(gca, 'TightInset');  
NewPos = [Tight(1) Tight(2) 1-Tight(1)-Tight(3) 1-Tight(2)-Tight(4)]; %New plot position [X Y W H]
set(gca, 'Position', NewPos);
colormap('gray');
hold on
plot(PCX*screensize,PCY*screensize, 'r+', 'MarkerSize', 5, 'LineWidth', 1.5);

%Saving the image
imwrite(Test_image,join(['./Exp_EBSP/Ferrite ',char(string((Phi1(index)))),' ',char(string(Phi(index))),' ',char(string(Phi2(index))),'.png']),'png');
%saveas(I,join(['./Exp_EBSP/Ferrite',string(Phi1(index)),string(Phi(index)),string(Phi2(index)),'.bmp']))