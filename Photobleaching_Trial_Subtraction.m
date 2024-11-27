function [ Img_Corrected ] = Photobleaching_Trial_Subtraction( Img_trial, Img, timeStamps, weights )

% image trial 
time_profile_Img = squeeze(mean( mean( Img_trial) ))';

% plot trial 
figure ('Name', 'Photobleach trial' ,'NumberTitle','off') 
plot( timeStamps, time_profile_Img, 'b' );
xlabel( 'Time [ms]' );
ylabel( 'Intensity [a.u.]' );
 
 if nargin == 3
     
     weights = ones( size( time_profile_Img ) );
     
 end
 
   
 % Confirm values, e.g. 'StartPoint'
 fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0, 0], 'Upper', [Inf, Inf, Inf], 'StartPoint', [1000.0, 1000.0, 100.0], 'Weights', weights );
 fit_fun = fittype( 'a*exp(-t/tau) + d0', 'independent', 't', 'options', fit_opt);
 [fit_obj, gof] = fit( timeStamps', time_profile_Img', fit_fun);

 
%   tau=56.0;
% fit_fun = fittype( ['a*exp(-t/', num2str(tau),') + d0'], 'independent', 't', 'options', fit_opt);

  
%  a = fit_obj.a;
%  d0 = fit_obj.d0;
 tau = fit_obj.tau;

 % Image to subtract the trial
 time_profile_Img = squeeze(mean( mean( Img) ))';
 
 
 % Confirm values, e.g. 'StartPoint'
 fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0], 'Upper', [Inf,  Inf], 'StartPoint', [1000.0, 100.0], 'Weights', weights );
 fit_fun = fittype( ['a*exp(-t/', num2str(tau),') + d0'], 'independent', 't', 'options', fit_opt);
 [fit_obj, gof] = fit( timeStamps', time_profile_Img', fit_fun);
 
  a = fit_obj.a;
  d0 = fit_obj.d0;
%   tau = fit_obj.tau;
 
 Nframes = size( Img, 3 );
 
 baseline = a*exp(-timeStamps(Nframes)/tau) + d0;
 h = waitbar(0, 'Please wait...');
 Img_Corrected = zeros( size( Img ) );
for f = 1:Nframes
    %repmat
    delta = a*exp(-timeStamps(f)/tau) + d0;
    Img_Corrected(:,:,f) = Img(:,:,f) - delta + baseline; % Update original File
    waitbar( f/Nframes, h);
 end
 close(h);
 time_profile_Img = squeeze(mean( mean( Img_Corrected) ))';
%  subplot(2, 1, 2) % add graph of the trial
 figure ('Name', 'Photobleach Correction with trial' ,'NumberTitle','off')
 plot( timeStamps, time_profile_Img, 'b' );
 title( 'Corrected' );
 xlabel( 'Time [ms]' );
 ylabel( 'Intensity [a.u.]' );

end