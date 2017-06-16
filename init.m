%% init: add needed directories to path
if ~exist('linReg.m','file')	% check if the path is already added
	[pathstr,~,~] = fileparts(mfilename('fullpath')); 		% get path of the init-file
	addpath(fullfile(pathstr, 'functions'));				% add path
	clear pathstr
end