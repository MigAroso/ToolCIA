function Img_F_norm = Normalize_DFoF0_2( handles )
% Normalizes the data by calculating the fractional fluorescence change
% DF/F0 = ( F(t) - F(t0) ) / F(t0)
% F(t)  := recorded fluorescence intensity at a given time
% F(t0) := fluorescence intensity at a resting membrane potencial (resting fluorescence) 
% Fbase, or F(t0) is calculated either from the first several frames
% (e.g. 10-20) frames of the experiment for evoked activity, or from the median

% input dialog for checking the frame interval to be analysed
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

% if nframes == -1
%     
%     nframes = size( handles.Img, 3);
% 
% end
nframes = last_frame - first_frame +1;

%  nframes = max( nframes, 3); %at least 3 frames for the estimation

  set( handles.txtStaticText, 'String', 'Calculating F0 and DF/F0');
  drawnow
 
      
 F0 = median( handles.Img( :,:,first_frame:last_frame ), 3 );
%  F0 = mean( handles.Img(:,:,1:nframes), 3 );

 handles.F_norm = ( handles.Img - F0 ) ./ F0; % calculates the fractional fluorescence variation

%  Img_F_norm = handles.F_norm;
 
 figure ('Name', 'F0' ,'NumberTitle','off'); 

 set(gcf, 'Units', 'normalized', 'Position', [0.15, 0.3, 0.5, 0.4] );

 hax = axes('Units','normalized','Position', [0.05 0.15 0.90 0.90] );
    
 imagesc( F0 );
 axis('image');
 xlabel( ['estimation of F0 (using ', num2str(nframes), ' frames)'] );
 
% to visualize with implay 
 handles.med = handles.F_norm / max(handles.F_norm(:));

 % Apply a median filter with a kernel of size 3x3 to every frame
 for f = 1:nframes
    handles.med(:,:,f) = medfilt2( handles.med(:,:,f), [3, 3], 'symmetric' );
 end
 
 Img_F_norm = handles.med;
 
 %Visualize_Tiff_Stack( handles.F_norm / max(handles.F_norm(:)) )
% implay( handles.F_norm / max(handles.F_norm(:)) );

% cm = implay( handles.F_norm / max(handles.F_norm(:)) ); % cm - colormap
 cm = implay( handles.med ); % cm - colormap

% setting size of implay window

    cm.Parent.Position = [550 250 700 350];
    cm.Visual.ColorMap.Map = jet(256);
    cm.Visual.setPropertyValue('DataRangeMin', min( handles.med(:) )); 
    cm.Visual.setPropertyValue('DataRangeMax', max( handles.med(:) ));
    cm.Visual.ColorMap.UserRange = 1;
    

  set( handles.txtStaticText, 'String', 'Done!');
  drawnow
 

end