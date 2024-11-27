function [ SE ] = GetSpikeEvents_IVConversion( handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % ESTE VALOR E' ESTIMADO DA DISTRIBUICAO NO PATCH-CLAMP
    CONV_FACTOR = 10.0;  
%       CONV_FACTOR = 3.0;  
    
    
    % !!! ESTE CODIGO E' PARA TIRAR !!! --
%     Img_MIP = max( handles.Img, [], 3 );
%     Img_MIP = Img_MIP / max( Img_MIP(:) );
%     figure
%     imagesc( Img_MIP )
%     axis 'image'
%     handles.ROI = imfreehand();
%     wait(handles.ROI);
%     handles.timeStamps = 1:5000;
    % ------------------------------------

    handles.timeStamps = (0: handles.Nframes -1) * str2double( get(handles.edtFrameStep, 'String'));

% % !!! Specifically for the videos from MCanepari - Cul060910... !!!
% handles.timeStamps = (16: handles.Nframes -1) * str2double( get(handles.edtFrameStep, 'String'));
    
%     mask = createMask( handles.ROI );
%       mask = createMask( handles.h );

     % Creates mask according to selected ROI
 if isfield (handles, 'load_ROI') % indicates that a ROI was loaded and the mask already exists as handles.BW.   
     mask = handles.BW;
%      handles = rmfield(handles, 'load_ROI'); % removes the field, so nest time this function analysis drawn ROIs
  else
        n =  numel(handles.h); % n is the ROI number 
        mask = createMask( handles.h(n) );
 end
      
           
    % preallocate container to hold intensity profile
    if get(handles.rbt_SD_None, 'Value' ) == 1
        Iprofile = zeros( sum( mask(:) ), handles.Nframes  ); 
    else
        Iprofile = zeros( 1, handles.Nframes ); 
    end
    
    for f = 1:handles.Nframes  
        frame = handles.Img(:,:,f);
        px_val = frame( mask == 1 );

        % Check for selected math function
        % mean
        if get(handles.rbt_SD_Mean, 'Value' ) == 1
            Iprofile(f) = mean( px_val );
        end
        % median
        if get(handles.rbt_SD_Median, 'Value' ) == 1
            Iprofile(f) = median( px_val );
        end
        % maximum
        if get(handles.rbt_SD_Maximum, 'Value' ) == 1
            Iprofile(f) = maximum( px_val );
        end
        % none
        if get(handles.rbt_SD_None, 'Value' ) == 1
            Iprofile(:,f) = px_val;
        end        
    end
    
    if get(handles.rbt_SD_None, 'Value' ) == 1
        % !!! NOT IMPLEMENTED YET !!!
        % ...code here...
    else
        % mixture of 2 Gaussians (sub- and supra-threshold)
        fitobj = fitgmdist( Iprofile', 2 );
        mu = sort( fitobj.mu );
        
        if ( mu(2) - mu(1) ) / mu(2) < 0.01
            h = warndlg('This ROI have a very low probability of having spikes!');
            uiwait(h);
        end
        
        Imin = min( Iprofile );
        Imax = max( Iprofile );
        Ivals = Imin:0.1:Imax;
        distrib = pdf( fitobj, Ivals'); % Probability density function
        s = FWHM( Ivals, distrib ); % Full Width at Half Maximum
        m = Ivals( distrib == max(distrib) );
        
        spikes = zeros( size( handles.timeStamps ) );
        spikes( Iprofile > ( m + CONV_FACTOR * s ) ) = 1; 
     
       if isfield(handles, 'load_ROI')
            label = 'Loaded';
        else
            label = num2str(handles.n); % add number of ROI to figure title
        end 
        
        figure( 'Name',[ 'Spike Events - Gaussian Misture Model, ROI nº ', label ] ,'NumberTitle','off' )
        set(gcf, 'Units', 'normalized', 'Position', [0.25, 0.25, 0.5, 0.5] );
        subplot(3,1,1)        
        histogram( Iprofile(:), 100 );
        title( 'Histogram' );
                
        subplot(3,1,2)
        hold on
        plot( handles.timeStamps, Iprofile, 'b' );
        plot( handles.timeStamps, m*ones(size(Iprofile)), 'c');
        plot( handles.timeStamps, (m+CONV_FACTOR*s)*ones(size(Iprofile)), 'r');
        title( 'Intensity Profile' );
        xlabel( 'Time [ms]' );
        ylabel( 'Intensity [a.u.]' );
        legend('intensity', 'median', '0mV<->intensity', 'Orientation', 'horizontal', 'Location', 'best');
        
        subplot(3,1,3)
        plot( handles.timeStamps, spikes, 'b' );  
        title( 'Number of Spikes' );
        xlabel( 'Time [ms]' );
        ylabel( 'Spikes [1]' );
    end   
    
    SE = spikes;
end

 % For analysis of RhoVR 1 voltage responses in neurons, regions of interest
 % encompassing cell bodies (all of approximately the same size) were drawn 
 % in ImageJ and the mean fluorescence intensity for each frame extracted.
 %
 % ?F/F values were calculated by first subtracting a mean background value
 % from all raw fluorescence frames, bypassing the noise amplification which
 % arises from subtracting background for each frame, to give a background 
 % subtracted trace (bkgsub). A baseline fluorescence value (Fbase) is 
 % calculated either from the first several (10-20) frames of the experiment 
 % for evoked activity, or from the median for spontaneous activity, and 
 % was subtracted from each timepoint of the bkgsub trace to yield a ?F trace.
 % The ?F was then divided by Fbase to give ?F/F traces.
 % No averaging has been applied to any voltage traces. 