function [ handles ] = ROI_FProfile( handles )
% draws the fluorescence profile correspondent to the selected ROI.
% Processes signal accordingly to "Pixel Grouping" option (e.g. Mean)

% Creates mask according to selected ROI
 if isfield (handles, 'load_ROI') % indicates that a ROI was loaded and the mask already exists as handles.BW.   
     BW = handles.BW;
     handles.ind = find( BW == 1 );
%      handles = rmfield(handles, 'load_ROI'); % removes the field, so next time this function analysis drawn ROIs
  else
     BW = createMask( handles.h( handles.n ));
%      handles.ind = find( BW == 1 );
 end

    
    % preallocate container to hold intensity profile
 if get(handles.rbt_SD_None, 'Value' ) == 1 
        Iprofile = zeros( sum( BW(:) ), handles.Nframes );
    else
        Iprofile = zeros( 1, handles.Nframes );
 end
    
    for f = 1:handles.Nframes        
        frame = handles.Img(:,:,f);
        px_val = frame( BW == 1 );

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
            Iprofile(f) = max( px_val );
        end
        % none
        if get(handles.rbt_SD_None, 'Value' ) == 1
            Iprofile(:,f) = px_val;
        end  
        
    end
    
    handles.Iprofile( handles.n, : ) = Iprofile; % store the fluorescence signal in a variable to be able to call it in the Granger Causality function
    
    if isfield(handles, 'load_ROI')
         label = 'Loaded ROI';
%          handles = rmfield(handles, 'load_ROI'); % removes the field, so nest time this function analysis drawn ROIs
     else
         label = num2str(handles.n); % add number of ROI to figure title
     end
    
%       ROI_Number = num2str(handles.n);
      figure ( 'Name',[ 'Fluorescence Profile of ROI Nº ' label ],'NumberTitle','off' )
        set(gcf, 'Units', 'normalized', 'Position', [0.25, 0.25, 0.5, 0.5] );
       
        plot( handles.timeStamps, Iprofile, 'b' );
        title( 'Fluorescence Profile' );
        xlabel( 'Time [ms]' );
        ylabel( 'Intensity [a.u.]' );   
        
  % Update Workflow

 action = [ 'FLuorescence Profile - ROI Nº ' label]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow ); 
 
end