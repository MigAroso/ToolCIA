%% generate data
t = (0:0.01:1)';
y = 2.2 * exp(-t/0.3) + 1.7;
y = y + 0.5*randn( size(t) );
plot( t, y, '.' )


%% fit

fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0, 0], 'Upper', [Inf, Inf, Inf,], 'StartPoint', [0.0, 1.0, 10.0] );
fit_fun  = fittype('a*exp(-t/tau)+d0', 'independent', 't', 'options', fit_opt);

% fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0], 'Upper', [Inf, Inf,], 'StartPoint', [1.0, 1.0] );
% fit_fun  = fittype('a*exp(-t/0.2670)+d0', 'independent', 't', 'options', fit_opt);

tic
[fit_obj, gof]  = fit( t, y, fit_fun );
toc

R2 = gof.rsquare;
a = fit_obj.a;
d0 = fit_obj.d0;
tau = fit_obj.tau;


%% lsqcurvefit

%fun = @(p,t)p(1)*exp(-t/p(2))+p(3);
%p0 = [1, 1, 1];

fun = @(p,t)p(1)*exp(-t/0.2671)+p(2);
p0 = [1, 1];

tic
x = lsqcurvefit(fun, p0, t, y, 'Display', 'off');
toc


%% Final
% first combine all pixels to produce estimate of the photobleaching tau
tau = 0.2671;

% paralel
N = 512*40; % 40 sec
tt = repmat(t,1,N);
yy = repmat(y,1,N);
xx = zeros(N,2);

fun = @(p,t)p(1)*exp(-t/0.2671)+p(2);
p0 = [1, 1];
tic
parfor r = 1:N
    xx(r,:) = lsqcurvefit(fun, p0, tt( :, r ), yy_1( :, r ));
%     xx(r,:) = lsqcurvefit(fun, p0, t, y);
end
toc


