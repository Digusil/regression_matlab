classdef regressiondata
	properties
		theta
		lambda
		data
		df
		R2
		adjR2
		sigma
		ase
		rms
		pvalue
		wald
		options
	end
	properties(SetAccess = private)%, Hidden = true)
		hypoarg
		hypothesis
		hypothesiscode
		hypothesisname
		regtype
		userhypothesis
	end
	methods
		function obj = regressiondata(hypothesis, theta, lambda, data, regtype, varargin)
			p = inputParser; 

			addRequired(p, 'hypothesis', @(x) isa(x,'function_handle'));
			addRequired(p, 'theta', @(x) size(x,2) == 1);
			addRequired(p, 'lambda', @isnumeric);
			addRequired(p, 'data', @isstruct);
			addRequired(p, 'regtype', @ischar);

			addOptional(p, 'regoptions', [], @(x) isempty(x) | isstruct(x));

			if exist('OCTAVE_VERSION', 'builtin') ~= 0
				addParamValue(p, 'hypoarg', cell(0), @iscell);
			elseif verLessThan('matlab', '8.2')
				addParamValue(p, 'hypoarg', cell(0), @iscell);
			else
				addParameter(p, 'hypoarg', cell(0), @iscell)
			end

			parse(p, hypothesis, theta, lambda, data, regtype, varargin{:});

			obj.hypoarg = p.Results.hypoarg;
			obj.userhypothesis = p.Results.hypothesis;
			obj.hypothesis = @(x, theta) p.Results.hypothesis(x, theta, obj.hypoarg{:}); %p.Results.hypothesis;
			obj.theta = p.Results.theta;
			obj.lambda = p.Results.lambda;
			obj.data = p.Results.data;
			obj.regtype = p.Results.regtype;
			obj.options = p.Results.regoptions;

			if ~strcmp(obj.regtype, 'logit')
				obj.rms = getRMS(obj.theta, obj.hypothesis, obj.data);
			end

			obj.df = size(obj.data.targets.train, 1) - length(obj.theta);% -1;
			obj.R2 = getR2(obj.theta, obj.hypothesis, obj.data);
			if ~strcmp(obj.regtype, 'kernel')
				obj.adjR2 = 1-(1-obj.R2)*(size(obj.data.targets.train, 1)-1)/obj.df;
			end

			reglin = regLinearize(obj.data.inputs.test, obj.theta, obj.hypothesis);
			[obj.sigma, obj.ase] = standardError(obj.data.inputs.test, obj.data.targets.test, obj.theta, obj.hypothesis, reglin);
			obj.pvalue = (1-tcdf(abs(obj.theta./obj.ase), obj.df))*2;

			if strcmp(obj.regtype, 'logit')
				obj.wald = 1-chi2cdf((obj.theta./obj.ase).^2, 1);
			end
		end
		
		function obj = saveobj(obj)
			if strcmp(obj.regtype, 'common')
				filetmp = functions(obj.userhypothesis);
				obj.hypothesisname = filetmp.function;
				obj.hypothesiscode = fileread(filetmp.file);
			end
		end
		
		function restorehypo(obj)
			if ~isempty(obj.hypothesisname)
				fileID = fopen([obj.hypothesisname, '.m'],'w');
				fwrite(fileID, obj.hypothesiscode);
				fclose(fileID);
				obj.hypothesis = str2func(obj.hypothesisname);
			else
				warning('None hypothesis code is saved!')
			end
		end

		function [h] = eval(obj, inputs)
			m = size(inputs, 1);

			if strcmp(obj.regtype, 'logit') | strcmp(obj.regtype, 'linear')
				inputs = [ones(m, 1), inputs];
			end

			x = (inputs - ones(m,1)*obj.data.inputs.mu)./(ones(m,1)*obj.data.inputs.sigma);

			h = obj.hypothesis(x, obj.theta);

			h = h.*(ones(m,1)*obj.data.targets.sigma) + ones(m,1)*obj.data.targets.mu;
		end
	end
end