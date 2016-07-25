classdef regressiondata
	properties
		hypothesis
		theta
		lambda
		data 
	end
	properties(SetAccess = private)
		hypothesis
		hypothesiscode
		hypothesisname
		regtype
	end
	methods
		function obj = regressiondata(hypothesis, theta, lambda, data, regtype, varargin)
			p = inputParser;

			addRequired(p, 'hypothesis', @(x) isa(x,'function_handle'));
			addRequired(p, 'theta', @(x)validateattributes(x,{'numeric'},{'row'}));
			addRequired(p, 'data', @isstruct);
			addRequired(p, 'regtype', @ischar);

			parse(p, inputs, targets, varargin{:});

			obj.hypothesis = p.results.hypothesis;
			obj.theta = p.Results.theta;
			obj.data = p.Results.data;
			obj.regtype = p.Results.regtype;

			obj.df = size(obj.data.targets.train, 1) - length(obj.theta) -1;
			obj.R2 = getR2(obj.theta, obj.hypothesis, obj.data);
			obj.adjR2 = 1-(1-obj.R2)*(size(obj.data.targets.train, 1)-1)/obj.df;

			reglin = regLinearize(obj.data.inputs.test, obj.theta, obj.hypothesis);
			obj.ase = standardError(obj.data.inputs.test, obj.data.targets.test, obj..theta, obj.hypothesis, reglin);
			obj.pvalue = (1-tcdf(abs(obj.theta./obj.ase), obj.df))*2;

			if strcomp(obj.regtype, 'logit')
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
			m = size(inputs,1);
			x = (inputs - ones(m,1)*obj.data.inputs.mu)./(ones(m,1)*obj.data.inputs.sigma);

			h = obj.hypothesis(x, obj.theta);

			h = h.*(ones(m,1)*obj.data.targets.sigma) + ones(m,1)*obj.data.targets.mu;
		end
	end
end