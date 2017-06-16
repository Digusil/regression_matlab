%% init: add needed directories to path
if ~exist('linReg.m','file')	% check if the path is already added
	[pathstr,name,ext] = fileparts(mfilename('fullpath')); 	% get path of the init-file
	addpath(fullfile(pathstr, 'functions'));				% add path
end

if ~exist('tcdf.m','file')
	[pathstr,name,ext] = fileparts(mfilename('fullpath')); 	% get path of the init-file
	addpath(fullfile(pathstr, 'functions', 'statistics'));	% add path
end