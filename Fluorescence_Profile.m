function [ ] = Fluorescence_Profile( Img, timeStamps )

 time_profile_Img = squeeze(mean( mean( Img ) ))';
 %handles.time_profile_Img = squeeze(median( median( handles.Img) ))';
%  timeStamps = (0:numel( time_profile_Img )-1) * str2double( get( edtFrameStep, 'String' ));
  
 % Confirm values, e.g. 'StartPoint'
 fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0, 0], 'Upper', [Inf, Inf, Inf], 'StartPoint', [1000.0, 1000.0, 100.0] );
 fit_fun = fittype( 'a*exp(-t/tau) + d0', 'independent', 't', 'options', fit_opt);
 [fit_obj, gof] = fit( timeStamps', time_profile_Img', fit_fun);
 
 a = fit_obj.a;
 d0 = fit_obj.d0;
 tau = fit_obj.tau;
 %CI = confint(fit_obj, 0.95); % returns 95% confidence bounds
  
 figure ('Name', 'Fluorescence Profile - Photobleach' ,'NumberTitle','off')
 hold on 
 plot( timeStamps, time_profile_Img, 'b' );
 plot( timeStamps, a*exp(-timeStamps/tau) + d0, 'r');
 xlabel( 'Time [ms]' );
 ylabel( 'Intensity [a.u.]' );
 title( ['Exponential decay fit (R^2 = ', num2str( gof.rsquare ), ')' ] );
 text
 
end