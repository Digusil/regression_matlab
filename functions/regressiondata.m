classdef regressiondata
	properties
		theta
		lambda
		data
		df
		R2
		adjR2
		ase
		rms
		pvalue
		wald
		options
	end
	properties(SetAccess = private)%, Hidden = true)
		hypothesis
		hypothesiscode
		hypothesisname
		regtype
	end
	methods
		function obj = regressiondata(hypothesis, theta, lambda, data, regtype, varargin)
			p = inputParser; 

			addRequired(p, 'hypothesis', @(x) isa(x,'function_handle'));
			addRequired(p, 'theta', @(x)validateattributes(x,{'numeric'},{'column'}));
			addRequired(p, 'lambda', @isnumeric);
			addRequired(p, 'data', @isstruct);
			addRequired(p, 'regtype', @ischar);

			addOptional(p, 'regoptions', [], @isstruct);

			parse(p, hypothesis, theta, lambda, data, regtype, varargin{:});

			obj.hypothesis = p.Results.hypothesis;
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
			obj.ase = standardError(obj.data.inputs.test, obj.data.targets.test, obj.theta, obj.hypothesis, reglin);
			obj.pvalue = (1-tcdf(abs(obj.theta./obj.ase), obj.df))*2;

			if strcmp(obj.regtype, 'logit')
				obj.wald = 1-chi2cdf((obj.theta./obj.ase).^2, 1);
			end
		end
		
		function obj = saveobj(obj)
			filetmp = functions(obj.hypothesis);
			obj.hypothesisname = filetmp.function;
			obj.hypothesiscode = fileread(filetmp.file);
		end
		
		function restorehypo(obj)
			fileID = fopen([obj.hypothesisname, '.m'],'w');
			fwrite(fileID, obj.hypothesiscode);
			fclose(fileID);
			obj.hypothesis = str2func(obj.hypothesisname);
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