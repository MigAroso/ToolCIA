function [ handles ] = Load_ROI( handles )
% Load the selected ROI
% Open a saved ROI and add it to the handles.ROI to be used in the ROI Analysis

 handles.load_ROI = 1; % to indicate that a ROI was loaded

 [filename_ROI, pathname_ROI] = uigetfile( '.mat', 'Choose ROI' );
 ROI = fullfile(pathname_ROI, filename_ROI);
 load(ROI);
 handles.BW = BW;

if (get(handles.rbt_ROIMIP,'Value') == 0 && ... 
    get(handles.rbt_ROIStDev,'Value') == 0 && ...
    get(handles.rbt_ROIFrame,'Value') == 0)
    
%user did not select any radio button, then this message shows up
    set( handles.txtStaticText, 'String', 'Select first one option to draw ROI, please!' );

 else    
% do this if a user selected a radio button

    switch get(get(handles.btnGroupChooseImg,'SelectedObject'),'Tag')
   
        case 'rbt_ROIMIP'
        
            % Maximum Intensity Projection
%            MIP( handles.Img );
    Img_MIP = max( handles.Img, [], 3 );
    Img_MIP_ROI = Img_MIP;
    Img_MIP_ROI(handles.BW) = min( Img_MIP(:) );
    figure( 'Name', 'Maximum Intensity Projection - MIP' ,'NumberTitle','off' );
    set( gcf, 'Units', 'normalized', 'Position', [0.15, 0.45, 0.5, 0.3] );
    hax = axes('Units','normalized','Position', [0.05 0.15 0.90 0.75] );
    imagesc(Img_MIP_ROI)
%     hold on
    axis 'image'
    colorbar;

             ind = find( handles.BW == 1 );

            % Extract ROI fluorescence intensity values
             handles.ROI = zeros( numel( ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

              for f = 1 : handles.Nframes
               temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
               handles.ROI(:,f) = temp_frame( ind );   % Fluorescence values of ROI 
              end

            %handles.ROI_1c = handles.ROI(:); % transpose to one column

   
        case 'rbt_ROIStDev'

            %Show a StDev image

             Img_double = double( handles.Img );
             Img_StDev = std( Img_double, 0, 3 );
             % add ROI to image
             Img_StDev_ROI = Img_StDev;
             Img_StDev_ROI(handles.BW) = min( Img_StDev(:) );

             figure ('Name', 'Standard Deviation - StDev' ,'NumberTitle','off')
             set(gcf, 'Units', 'normalized', 'Position', [0.15, 0.45, 0.5, 0.3] );

             imagesc( Img_StDev_ROI ); 
             axis 'image'; 
             colorbar;

             set( handles.txtStaticText, 'String', 'Draw ROI');
             drawnow            

             % Define ROI

             handles.ind = find( BW == 1 );

            % Extract ROI fluorescence intensity values
             handles.ROI = zeros( numel( handles.ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

              for f = 1 : handles.Nframes
               temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
               handles.ROI(:,f) = temp_frame( handles.ind );   % Fluorescence values of ROI 
              end
 
       
        case 'rbt_ROIFrame' 
            
            % Visualize_Tiff_Stack( handles.Img )

             f = str2double( get( handles.edtFrameNumber, 'String' ) );
             
            % add ROI to image
             Img_ROI = handles.Img;
             for f_ROI = 1:size(Img_ROI, 3)
                 temp_frame = Img_ROI(:,:,f_ROI);
                 temp_frame(handles.BW) = min( Img_ROI(:) );
                 Img_ROI(:,:,f_ROI) = temp_frame;
%                  Img_ROI(handles.BW) = min( Img_ROI(:) );
             end

             figure ('Name', ['Frame Number = ' num2str(f)] ,'NumberTitle','off')
             set(gcf, 'Units', 'normalized', 'Position', [0.15, 0.3, 0.5, 0.3] );
            %  hax = axes('Units','normalized','Position', [0.05 0.15 0.90 0.90] );
             imagesc( Img_ROI(:,:,f) );
             axis image
             colorbar;

             set( handles.txtStaticText, 'String', 'Draw ROI');
             drawnow

            % Define ROI
             handles.ind = find( BW == 1 );

            % Extract ROI fluorescence intensity values
             handles.ROI = zeros( numel( handles.ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

              for f = 1 : handles.Nframes
               temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
               handles.ROI(:,f) = temp_frame( handles.ind );   % Fluorescence values of ROI 
              end
              
    end
        
 set( handles.txtStaticText, 'String', 'ROI Done');

end 

 % Update Workflow
 
 action = [ 'Loaded ROI = ', filename_ROI ]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );



end