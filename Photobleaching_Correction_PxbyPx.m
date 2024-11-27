function [ Img_corrected ] = Photobleaching_Correction_PxbyPx( Img, timeStamps )


tic
Nframes = size(Img, 3); % Number of frames of the sampled stack


 yy = zeros( size(Img,3), size(Img,1)*size(Img,2) ); %fluorescence intensity over time per pixel(700 time points + 104 pixels per frame)

time_profile_Img = squeeze(mean( mean(Img) ))'; % Average fluorescence of every frame
 
% Reshape the 3D matrix into a 2D matrix where rows = timestamps and
% columns = each pixel. Change of pixel fluorescence over time
    for r = 1 : size( Img, 3 )
        yy( r, : ) = reshape(Img(:,:,r), [], (size(Img,1)*size(Img,2)) );
    end

%Calculate tau for the pixel average of every frame
weights = ones( size( time_profile_Img ) );
 fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0, 0], 'Upper', [Inf, Inf, Inf], 'StartPoint', [1000.0, 1000.0, 100.0], 'Weights', weights );
 fit_fun = fittype( 'a*exp(-t/tau) + d0', 'independent', 't', 'options', fit_opt);
 
 [fit_obj, gof] = fit( timeStamps', time_profile_Img', fit_fun);
 
 a = fit_obj.a;
 tau_avrg = fit_obj.tau;
 d0 = fit_obj.d0;
 
 tt = timeStamps';
 
A_D0 = zeros( size( yy, 2 ), 2 ); % a = xx(:,1); d0 = xx(:,2) -> p(1) = xx(:,1); p(2) = xx(:,2)
% fun = @(p,timeStamps)p(1)*exp(-t/tau_avrg)+p(2);
fun = @(p,timeStamps)p(1)*exp(-tt/tau_avrg)+p(2);
p0 = [1, 1];
toc

figure ('Name', 'Photobleach Correction Pixel by Pixel' ,'NumberTitle','off')
 subplot(2, 1, 1)
 hold on 
 plot( timeStamps, time_profile_Img, 'b' );
 plot( timeStamps, a*exp(-timeStamps/tau_avrg) + d0, 'r');
 xlabel( 'Time [ms]' );
 ylabel( 'Intensity [a.u.]' );
 title( ['Exponential decay fit (R^2 = ', num2str( gof.rsquare ), ')' ] );

 tic
 
 D = parallel.pool.DataQueue;
 h = waitbar( 0, 'Correcting Photobleach. Please Wait...');
 afterEach(D, @nUpdateWaitbar);
  
 N = size( yy, 2 );
 counter = r + 1;
 waitbar(counter/N, h);
%  counter = 1;
%  N = size( yy, 2 );
 parfor r = 1 : size( yy, 2 ) % total number of pixels
 
 A_D0(r,:) = lsqcurvefit( fun, p0, tt, yy(:,r) );
 send(D, r);
%  waitbar(counter/N, h);
%  counter = counter + 1;

 end
    function nUpdateWaitbar(~)
         waitbar(counter/N, h);
        counter = counter + 1;
    end
delete(h);
 toc


  a_px_avrg = A_D0( :, 1 );
 d0_px_avrg = A_D0( :, 2 );

% baseline = xx(104,1)*exp(-t(700)/tau)+xx(104,2);

% baseline = a_px_avrg(end)*exp(-t(end)/tau_avrg)+d0_px_avrg(end);
% baseline_all = [];
% delta_all = [];
% yy_corrected = yy;
yy_corrected = zeros(size(timeStamps, 2), size(yy,2));
for p = 1 : size(yy_corrected,2) % total number of pixels
    
      baseline = a_px_avrg(p)*exp(-timeStamps(Nframes)/tau_avrg)+d0_px_avrg(p);
%       baseline_all = [baseline_all, baseline];
      
    for time = 1 : size(yy_corrected,1) % time stamps
        delta = a_px_avrg(p)*exp(-timeStamps(time)/tau_avrg) + d0_px_avrg(p);
%         delta_all = [delta_all, delta];
%         pixel_time = p*time;
%         yy_corrected(pixel_time) = yy(pixel_time) - delta + baseline; % Update original File
        yy_corrected(time, p) = yy(time, p) - delta + baseline;
    end
    
end

yy_corrected = permute( yy_corrected, [2,1] );

for f = 1 : size( Img, 3)
    
   Img_corrected = reshape( yy_corrected, size(Img, 1), size(Img, 2), size(Img, 3) ); 

end


time_profile_Img = squeeze(mean( mean( Img_corrected ) ))';
 subplot(2, 1, 2)
 plot( timeStamps, time_profile_Img, 'b' );
 title( 'Corrected' );
 xlabel( 'Time [ms]' );
 ylabel( 'Intensity [a.u.]' )



% time_profile_yy = mean(yy,2);
% time_profile_yy_corrected = mean(yy_corrected,2);
% figure
% plot(timeStamps',time_profile_yy_corrected)
% figure
% plot(timeStamps',time_profile_yy)
% figure
% plot(timeStamps', yy(:, 50))
% figure
% plot(timeStamps', yy_corrected(:, 50))


end