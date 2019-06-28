function [image] = theo_EBSP(G,screen_int,screensize,PC_av,isHex)

% This function takes as input the index of an EBSP in the library and the
% library itself with several parameters

% It returns an array of the intensities of the pixels

image = image_gen_bin(screensize,PC_av, G, screen_int, isHex);