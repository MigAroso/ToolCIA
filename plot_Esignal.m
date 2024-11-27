function plot_Esignal( handles )
% Plots the electrophysiological signal associated with the VSDi, recorded
% by Patch Clamp
% A: a 5 elements array containing information on the recording:
%   A(1): number of frames
%   A(2): number of columns
%   A(3): number of rows
%   A(4): frame interval
%   A(5): ratio between frame interval and electrical sampling time
% y: electrical signal

if isfield ( handles, 'A' ) % only the .mat files from dual_CCD have the 'A' array
    
    timeStamps = ( 0 : handles.A(1) * handles.A(5) - 1 ) * (handles.A(4) / handles.A(5));

    handles.y = handles.y';

figure
plot( timeStamps, handles.y );
title( 'Electrophysiological signal' );
xlabel( 'Time [ms]' );
ylabel( 'Voltage [mV]' );

else 
    % the files from the DaVinci2K camera have the electrophysiology data
    % on a different file (usually with the same name as the image data but
    % without the 'm' letter.
    [filename,PathName] = uigetfile('*.tif;*.tiff;*.mat','Select the file');
    load( filename );
    Nframes = size(handles.Img, 3);
    % the acquisition rate of the electrophysiological data is different
    % from the imaging. This is to convert the timeStamps from the imaging
    % to the electrophysiological data by recalculating the time steps
    % between recordings by dividing the total time of the experiment by 
    % the total number of data points of the electrophysiological
    % recordings.
    timeStep = Nframes * str2double( get(handles.edtFrameStep, 'String' )) / numel(Y1);
    timeStamps = ( 0 : timeStep : (Nframes * str2double( get(handles.edtFrameStep, 'String' ))) - timeStep); 

figure
plot( timeStamps, Y1 );
title( 'Electrophysiological signal' );
xlabel( 'Time [ms]' );
ylabel( 'Voltage [mV]' );

end


end