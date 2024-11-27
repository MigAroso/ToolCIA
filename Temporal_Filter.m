function [ Img_filt ] = Temporal_Filter( Img, lowb_Hz, upb_Hz, sampling_rate )
% Uses the function Apply_Filter to filter (bandpass) the given image, pixel by pixel.
% Img - image to be filtered
% lowb_Hz - lower limit of the filter in Hz (preserves the signal between both limits) 
% upb_Hz - higher limit of the filter in Hz
% sampling_rate - data acquisition frequency 

Img_filt = zeros( size(Img, 1), size(Img, 2), size(Img, 3));
 for c = 1 : size( Img, 1 )
     for r = 1 : size( Img, 2 )
        y = squeeze( Img(r, c, :) );
        [yy, t] = Apply_Filter( lowb_Hz, upb_Hz, y, sampling_rate );
        Img_filt(r, c, :) = yy;
     end
 end

 timeStamps = ( 0 : size( Img_filt, 3 ) -1 ) * (1000/sampling_rate);
 
 
%  time_profile_Img = squeeze(mean( mean( Img_filt ) ))';
 
%  figure ('Name', 'Fluorescence Profile - Filtered' ,'NumberTitle','off')
%  plot( timeStamps, time_profile_Img, 'b' );
%  xlabel( 'Time [ms]' );
%  ylabel( 'Intensity [a.u.]' );

 Fluorescence_Profile( Img_filt, timeStamps  );


end

