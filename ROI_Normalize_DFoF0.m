function [ handles ] = ROI_Normalize_DFoF0( handles )
% Applied to ROIs
% Normalizes the data by calculating the fractional fluorescence change
% DF/F0 = ( F(t) - F(t0) ) / F(t0)
% F(t)  := recorded fluorescence intensity at a given time
% F(t0) := fluorescence intensity at a resting membrane potencial (resting fluorescence) 
% Fbase, or F(t0) is calculated either from the first several frames
% (e.g. 10-20) frames of the experiment for evoked activity, or from the median

% input dialog for checking the frames to be used to calculate DF0oF0 
 string = 'Type the number of initial frames, at least 3, for experiments of evoked activity;';
 string = [ string  newline 'Alternatively choose the interval of frames or leave the total number of frames already filled;'];
 string = [ string  newline 'First frame:'];
%  prompt = {'Type the number of initial frames, at least 3, for experiments of evoked activity; Alternatively choose the interval of frames or leave the total number of frames; First frame:', 'Last frame:'};
 prompt = { string, 'Last frame:' };
 dlg_title = 'Resting fluorescence (F0) estimation';
 num_lines = 1;
 last_frame = numel( handles.Img( 1, 1, :) );
 defaultans = { '1', num2str(last_frame) };
 answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
 frames = str2double( answer );
 first_frame = frames( 1, 1 );
 last_frame = frames( 2, 1 );

 nframes = last_frame - first_frame +1;
 
  set( handles.txtStaticText, 'String', 'Calculating F0 and DF/F0');
  drawnow
 
%  F0 = median( handles.ROI(:,:,first_frame:last_frame), 3 );     

 % Creates mask according to selected ROI
 if isfield (handles, 'load_ROI') % indicates that a ROI was loaded and the mask already exists as handles.BW.   
     BW = handles.BW;
     handles.ind = find( BW == 1 );
%      handles = rmfield(handles, 'load_ROI'); % removes the field, so nest time this function analysis drawn ROIs
  else
     BW = createMask( handles.h( handles.n ));
     handles.ind = find( BW == 1 );
 end
  

   % Extract ROI fluorescence intensity values
     ROI = zeros( numel( handles.ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

      for f = 1 : handles.Nframes
          temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
          ROI(:,f) = temp_frame( handles.ind );   % Fluorescence values of ROI 
      end
      
 F0 = median( ROI(:,first_frame:last_frame), 2 );
%  F0 = mean( handles.Img(:,:,1:nframes), 3 );

 handles.ROI_F_norm = ( ROI - F0 ) ./ F0; % calculates the fractional fluorescence variation
 
 handles.Iprofile_ROI = zeros( 1, handles.Nframes );
 for f = 1 : handles.Nframes
     handles.Iprofile_ROI(f) = mean( handles.ROI_F_norm(:, f) );
 end

 % Label ROI
     if isfield(handles, 'load_ROI')
         label = 'Loaded';
%          handles = rmfield(handles, 'load_ROI'); % removes the field, so nest time this function analysis drawn ROIs
     else
         label = num2str(handles.n); % add number of ROI to figure title
     end
 
     
%  ROI_Number = num2str(handles.n);
 figure( 'Name',[ 'DF/FO - ROI Nº ' label ],'NumberTitle','off' )
        set(gcf, 'Units', 'normalized', 'Position', [0.25, 0.25, 0.5, 0.5] );
       
        plot( handles.timeStamps, handles.Iprofile_ROI, 'b' );
        title( 'DF/F0' );
        xlabel( 'Time [ms]' );
        ylabel( 'Intensity [a.u.]' );
        
 set( handles.txtStaticText, 'String', 'Done!');
 drawnow       
        
  % Update Workflow

 action = [ 'Normalized DF/F0 - ROI Nº ' label]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );

end