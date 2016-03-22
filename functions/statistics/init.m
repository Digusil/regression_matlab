%% init: add needed directories to path
if ~exist('linReg.m','file')	% check if the path is already added
	addpath('functions');
end

if ~exist('tcdf.m','file')
	addpath(['functions', filesep, 'statistics'])
end