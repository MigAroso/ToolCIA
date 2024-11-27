function [ SE ] = GetSpikeEvents_NSigma( handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

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
 
   handles.timeStamps = (0: handles.Nframes - 1) * str2double( get(handles.edtFrameStep, 'String'));  
    
%     mask = createMask( handles.ROI );

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
        Iprofile = zeros( sum( mask(:) ), handles.Nframes );
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
        
    n_sigma = str2double( get(handles.edt_SD_Sigma, 'String' ) );

% Calcutales spike events for each pixel individually
    if get(handles.rbt_SD_None, 'Value' ) == 1
        m = median( Iprofile, 2 );
        s = std(    Iprofile, 0, 2 );

        spikes = zeros( size( Iprofile, 1 ), size(Iprofile, 2) );
        
        for f = 1 : size( Iprofile, 2 )
            
            frame = Iprofile( :, f); 
            spikes( frame > ( m + n_sigma*s ), f ) = 1;
        
        end
        
        Img_spk = handles.Img;
        
        for f = 1:handles.Nframes  
            frame = handles.Img(:,:,f);
            frame( mask == 0 ) = 0;
            frame( mask == 1 ) = spikes( :, f );
            Img_spk( :, :, f ) = frame;
        end
        
       Visualize_Tiff_Stack( Img_spk );
       
       MIP( Img_spk );
       
       cm = implay( Img_spk );
       
       
    cm.Parent.Position = [450 450 700 350];
    cm.Visual.ColorMap.Map = jet(256);
    cm.Visual.setPropertyValue('DataRangeMin', min( Img_spk(:) ));
    cm.Visual.setPropertyValue('DataRangeMax', max( Img_spk(:) ));
    cm.Visual.ColorMap.UserRange = 1;
        
    [r,c,f] = ind2sub(size(Img_spk),find(Img_spk == 1));
    
    f = num2str(unique(f)');
    
    helpdlg( ['spikes found on frames: '  f ],  'Detected Spikes' );
    
%         figure ( 'Name', ['Spike Events - Sigma = ' get(handles.edt_SD_Sigma, 'String')] ,'NumberTitle','off' )
%         set(gcf, 'Units', 'normalized', 'Position', [0.25, 0.25, 0.5, 0.5] );
%         
%          subplot(2,1,1)
%         hold on
%         plot( handles.timeStamps, Iprofile, 'b' );
%         plot( handles.timeStamps, m*ones(size(Iprofile)), 'c');
%         plot( handles.timeStamps, (m+n_sigma*s)*ones(size(Iprofile)), 'r');
%         title( 'Intensity Profile' );
%         xlabel( 'Time [ms]' );
%         ylabel( 'Intensity [a.u.]' );
%         legend('intensity', 'median', [ num2str(n_sigma), '\times\sigma'], 'Orientation', 'horizontal', 'Location', 'best');
%        
%         subplot(2,1,2)
%         plot( handles.timeStamps, spikes, 'b' );
%         title( 'Number of Spikes' );
%         xlabel( 'Time [ms]' );
%         ylabel( 'Spikes [1]' );
   
% Calcutales spike events for pixel grouping
    else
        m = median( Iprofile ); % median of signal overtime
%          mn = mean( Iprofile, 2 );
        s = std(    Iprofile ); % standard deviation of signal overtime
        
        spikes = zeros( size( handles.timeStamps ) );
        spikes( Iprofile > ( m + n_sigma*s ) ) = 1;  
        
        if isfield(handles, 'load_ROI')
            label = 'Loaded';
        else
            label = num2str(handles.n); % add number of ROI to figure title
        end
%         figure ( 'Name', ['Spike Events - Sigma = ' get(handles.edt_SD_Sigma, 'String')] ,'NumberTitle','off' )
        figure ( 'Name', ['Spike Events - Sigma = ' get(handles.edt_SD_Sigma, 'String') ' - ROI Nº ' label ] ,'NumberTitle','off' )
        set(gcf, 'Units', 'normalized', 'Position', [0.25, 0.25, 0.5, 0.5] );
        
        subplot(2,1,1)
        hold on
        plot( handles.timeStamps, Iprofile, 'b' );
        plot( handles.timeStamps, m*ones(size(Iprofile)), 'c');
        plot( handles.timeStamps, (m +n_sigma*s)*ones(size(Iprofile)), 'r');
        title( 'Intensity Profile' );
        xlabel( 'Time [ms]' );
        ylabel( 'Intensity [a.u.]' );
        legend('intensity', 'median', [ num2str(n_sigma), '\times\sigma'], 'Orientation', 'horizontal', 'Location', 'best');
       
        subplot(2,1,2)
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