function [ Img_corrected ] = Photobleaching_Correction( Img, timeStamps, weights )

      
 time_profile_Img = squeeze(mean( mean( Img) ))';
 
 
 if nargin == 2
     
     weights = ones( size( time_profile_Img ) );
     
 end
 
 Nframes = size( Img, 3 );
  
 % Confirm values, e.g. 'StartPoint'

%  weights = weights(1:30:end);
%  timeStamps = timeStamps(1:30:end);
%  time_profile_Img = time_profile_Img(1:30:end);
 
 fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0, 0], 'Upper', [Inf, Inf, Inf], 'StartPoint', [1000.0, 1000.0, 100.0], 'Weights', weights );
 fit_fun = fittype( 'a*exp(-t/tau) + d0', 'independent', 't', 'options', fit_opt);
%  tic
% %  for paulo=1:50
 [fit_obj, gof] = fit( timeStamps', time_profile_Img', fit_fun);
% %  end
%  toc
 
 a = fit_obj.a;
 d0 = fit_obj.d0;
 tau = fit_obj.tau;
 %CI = confint(fit_obj, 0.95); % returns 95% confidence bounds
 %a_CI = a - CI(1,1);
 %d0_CI = d0 - CI(1,2); 
 %tau_CI = tau - CI(1,3);
  
 figure ('Name', 'Photobleach Correction' ,'NumberTitle','off')
 subplot(2, 1, 1)
 hold on 
 plot( timeStamps, time_profile_Img, 'b' );
 plot( timeStamps, a*exp(-timeStamps/tau) + d0, 'r');
 xlabel( 'Time [ms]' );
 ylabel( 'Intensity [a.u.]' );
 title( ['Exponential decay fit (R^2 = ', num2str( gof.rsquare ), ')' ] );
 
 % insert comments...
 % Apply correction to all pixels of each frame for entire movie
 baseline = a*exp(-timeStamps(Nframes)/tau) + d0;
 h = waitbar(0, 'Please wait...');
 for f = 1:Nframes
    %repmat
    delta = a*exp(-timeStamps(f)/tau) + d0;
    Img_corrected(:,:,f) = Img(:,:,f) - delta + baseline; % Update original File
    waitbar( f/Nframes, h);
 end
close(h);
 time_profile_Img = squeeze(mean( mean( Img_corrected) ))';
 subplot(2, 1, 2)
 plot( timeStamps, time_profile_Img, 'b' );
 title( 'Corrected' );
 xlabel( 'Time [ms]' );
 ylabel( 'Intensity [a.u.]' );
 
end