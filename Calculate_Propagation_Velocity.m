function [velocity_um_per_ms] = Calculate_Propagation_Velocity(t, y1, y2, frame_rate_Hz, distance_um)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    % distance is the distance between the centers of the 2 ROI

    y1 = y1 - mean( y1 );
    y2 = y2 - mean( y2 );

    figure
    subplot( 2, 1, 1 )
    hold on
    plot( t, y1, 'b' )
    plot( t, y2, 'r' )
    hold off

    [cross, lags] = xcorr( y1, y2, 'coeff' );
    
    subplot( 2, 1, 2 )
    plot( lags, cross, 'k' )
    
    [~, delay_ind] = max( cross );
    
    velocity_um_per_ms = distance_um / ( delay_ind * 1.0e-3 / frame_rate_Hz );
    
end

