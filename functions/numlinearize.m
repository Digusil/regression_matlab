function dydx = numlinearize(foo, varargin)

	alpha = 1e-6;

	n = size(foo(varargin{:}),1);

	dx = ones(n,1)*alpha*varargin{1}';
	
	for idt = 1:length(varargin{1})
		if varargin{1}(idt) == 0
			dx = alpha;
			c1 = zeros(size(varargin{1}));
			c1(idt) = alpha/2;
			c2 = zeros(size(varargin{1}));
			c2(idt) = -alpha/2;
			
			dy(:,idt) = foo(c1+varargin{1}, varargin{2:end}) - ...
						foo(c2+varargin{1}, varargin{2:end});
		else
			c1 = eye(length(varargin{1}));
			c1(idt, idt) = 1+alpha/2;
			c2 = eye(length(varargin{1}));
			c2(idt, idt) = 1-alpha/2;

			dy(:,idt) = foo(c1*varargin{1}, varargin{2:end}) - ...
						foo(c2*varargin{1}, varargin{2:end});
		end
	end
	
	dydx = dy./dx;
	
end