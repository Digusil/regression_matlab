classdef testfoo
	properties
		foo
		theta
		hypothesiscode
		hypothesisname 
	end
	methods
		function obj = testfoo(foo, theta)
			obj.foo = foo;
			obj.theta = theta;
		end
		
		function obj = saveobj(obj)
			filetmp = functions(obj.foo);
			obj.hypothesisname = filetmp.function;
			obj.hypothesiscode = fileread(filetmp.file);
		end
		
		function restorehypo(obj)
			disp(obj)
			fileID = fopen([obj.hypothesisname, '.m'],'w');
			fwrite(fileID, obj.hypothesiscode);
			fclose(fileID);
			obj.foo = str2func(obj.hypothesisname);
		end
		
		function y = calc(obj, x)
			y = obj.foo(x, obj.theta);
		end
	end
end