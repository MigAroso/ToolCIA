function [ frames_with_spikes ] = SpikesFromMAD( Iprofile )

% Assumes spikes as outliers of the data and uses median absolute
% deviations (MAD) to detect them

[Spike_logical, lower, upper, center] = isoutlier(Iprofile, 'median');

frames_with_spikes = 1 + find( diff( Spike_logical ) == 1 );

base = ones( size( Iprofile ) );

figure

subplot(2,1,1)
hold on
plot( lower * base, 'r' )
plot( upper * base, 'r' )
plot( center * base, 'b' )
plot( Iprofile, 'k' )
hold off

subplot(2,1,2)
plot( Spike_logical )


end

