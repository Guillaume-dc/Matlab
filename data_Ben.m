function [test_set] = data_Ben()

% Ferrite 
% This function is used to read the data from the file 'Demo_Ben_16bin.h5'

% Opening and reading the datasets
fid = H5F.open('Demo_Ben_16bin.h5');
%h5disp('Demo_Ben_16bin.h5');
info = h5info('Demo_Ben_16bin.h5','/Demo_Ben/EBSD/Data');

% Creating a list of the names of the datasets
for i = 1:1:length(info.Datasets)
    N(i) = string(info.Datasets(i).Name);
end

% Creating a container test_set whoses keys are names of datasets and
% values are data in the datasets

test_set = containers.Map;
for i = 1:1:length(info.Datasets)
    data = h5read('Demo_Ben_16bin.h5',join(['/Demo_Ben/EBSD/Data/',char(N(i))]));
    test_set(char(N(i))) = data;
end

H5F.close(fid); 
end
