function [ G_array,Euler ] = SO3_rotmat_gen( cs,SO3_resolution)
%SO3_ROTMAT_GEN Summary of this function goes here

% This code is copyright Alex Foden and Ben Britton 09/04/2019
% Do not distribute.
%
% This RTI-EBSD (refined template indexing) code and its associated scripts
% may only be shared with express and direct permission of
% Alex Foden & Ben Britton
% 
% If you would like a copy or access to the repository
% Please contact b.britton@imperial.ac.uk or a.foden16@imperial.ac.uk
%
% Ben Britton has a list of authorised users of this code
% 
% Do not fork
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
% OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
% NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
% BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN 
% ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
% CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

% Requirements:
% MATLAB R2018a or above
% MTEX version 5.2.beta2 or above
% Created by Alex Foden and Ben Britton 28/03/2019
% If you are using a CIF file not in the MTEX toolbox, you will need to add
% the full file path to the cif file to the phase file you are using

S3G = equispacedSO3Grid(cs,'resolution',SO3_resolution*pi/180); %Create the euler angles that define the fundamental xone we're searching, equispacedSO3Grid is an MTEX command
G_array=S3G.matrix;
Euler = reshape([rad2deg(wrapToPi(S3G.phi1)) rad2deg(wrapToPi(S3G.Phi)) rad2deg(wrapToPi(S3G.phi2))],[length(S3G.Phi) 3]);
end