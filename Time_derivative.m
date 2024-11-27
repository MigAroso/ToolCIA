function [ D_dt ] = Time_derivative( handles )
% Calculates the time derivative of the fractional change of fluorescence
% for each frame
% Input - handles.F_norm, the image file after calculation of DF/F0
%         handles.timeStamps, file with temporal information of frame
%         acquisition
% Output - D_dt, time derivative of DF/F0 

time_profile_Img = squeeze(mean( mean( handles.F_norm ) ));

time_profile_Img_sm = smooth( time_profile_Img, 'sgolay', 2 );

D_dt = ( diff( time_profile_Img_sm ) ./ diff( handles.timeStamps ) );

figure
subplot( 2, 1, 1)
plot( handles.timeStamps, time_profile_Img, 'b', handles.timeStamps, time_profile_Img_sm, 'r' ); 
% title( 'Intensity Profile' );
xlabel( 'Time [ms]' );
ylabel( 'Intensity [a.u.]' );
legend('raw signal', 'smooth - sgolay', 'Orientation', 'horizontal', 'Location', 'best');

subplot( 2, 1, 2)
plot ( handles.timeStamps(2:end), D_dt );
title( 'Time derivative' );
xlabel( 'Time [ms]' );
ylabel( 'Intensity [a.u.]' );



end