function  [ handles ] = Draw_AnotherROI( handles )

    if isfield(handles, 'load_ROI')
%          label = 'Loaded';
         handles = rmfield(handles, 'load_ROI'); % removes the field, so nest time this function will use drawn ROIs... 
                                                 % or the same field if a
                                                 % new ROI is loaded
    end 

if ~isfield ( handles, 'n' ) || handles.n == 1  
  

    % Confirm that the user selected the type of image and the shape of ROI
 if (get(handles.rbt_ROIMIP,'Value') == 0 && ... 
    get(handles.rbt_ROIStDev,'Value') == 0 && ...
    get(handles.rbt_ROIFrame,'Value') == 0)
    
    % user did not select any radio button, then this message shows up
    set( handles.txtStaticText, 'String', 'Select one option to draw ROI, please!' );

 elseif (get(handles.rbt_Freehand,'Value') == 0 && ... 
    get(handles.rbt_Rectangle,'Value') == 0 && ...
    get(handles.rbt_Pixel,'Value') == 0)
    
    % user did not select any radio button, then this message shows up
    set( handles.txtStaticText, 'String', 'Select shape of the ROI, please!' );
     
    
 else    
    % do this if a user selected a radio button

     switch get(get(handles.btnGroupChooseImg,'SelectedObject'),'Tag')
        
    % Open image 
        
       case 'rbt_ROIMIP'
        
         % Maximum Intensity Projection
             MIP( handles.Img );
             handles.ROIMIP_fig = gcf;
            
            
       case 'rbt_ROIStDev'
 
            %Show a Standar deviation image

             Img_double = double( handles.Img );
             Img_StDev = std( Img_double, 0, 3 );

            handles.Stdev_fig = figure ('Name', 'Standard Deviation - StDev' ,'NumberTitle','off');
             set(gcf, 'Units', 'normalized', 'Position', [0.15, 0.45, 0.5, 0.3] );

             imagesc( Img_StDev );
%              hold on
             axis 'image'; 
             colorbar;
             
             
         case 'rbt_ROIFrame' 
            
            % Visualize_Tiff_Stack( handles.Img )

             f = str2double( get( handles.edtFrameNumber, 'String' ) );

             handles.ROIFrame_fig = figure ('Name', ['Frame Number = ' num2str(f)] ,'NumberTitle','off');
             set(gcf, 'Units', 'normalized', 'Position', [0.15, 0.3, 0.5, 0.3] );
            %  hax = axes('Units','normalized','Position', [0.05 0.15 0.90 0.90] );
             imagesc( handles.Img(:,:,f) );
             axis image
             colorbar;
        
        set( handles.txtStaticText, 'String', 'Draw ROI');
          
     end
     
    % Shape of ROI
     
     handles.n = 1;
     switch get(get(handles.btnGroupROIShape,'SelectedObject'),'Tag')
     
         case 'rbt_Freehand'
            
            handles.h = imfreehand;
            
            handles.BW(:,:, handles.n) = createMask( handles.h );
            handles.ind = find( handles.BW(:,:,handles.n) == 1 );
%             ROI_Boundaries = bwboundaries(BW);
%             handles.rc_f = ROI_Boundaries{1};

            % Extract ROI fluorescence intensity values
             handles.ROI = zeros( numel( handles.ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

              for f = 1 : handles.Nframes
               temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
               handles.ROI(:,f) = temp_frame( handles.ind );   % Fluorescence values of ROI 
              end
           
            % Add ROI labe automatically
            label = num2str( handles.n );
            pos = handles.h.getPosition();
            polyin = polyshape( pos, 'simplify', false );
            polyin = simplify( polyin );
            [ xCentroid, yCentroid ] = centroid( polyin );
            text( xCentroid, yCentroid, label, 'Color','red', 'FontWeight','bold' );
            
        case 'rbt_Rectangle'
            
            handles.h = imrect;
            handles.BW = createMask( handles.h );
            handles.ind = find( handles.BW == 1 );
            
            % Extract ROI fluorescence intensity values
             handles.ROI = zeros( numel( handles.ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

              for f = 1 : handles.Nframes
               temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
               handles.ROI(:,f) = temp_frame( handles.ind );   % Fluorescence values of ROI 
              end
            
              % Add ROI labe automatically
            label = num2str( handles.n );
            pos = handles.h.getPosition();
            xCentroid = pos(1) + pos(3)/2;
            y = pos(2) + pos(4)/2;
            text( xCentroid, y, label, 'Color','red', 'FontWeight','bold' );
              
        case 'rbt_Pixel'
            
            handles.h = impoint;
            handles.BW = createMask( handles.h );
            handles.ind = find( handles.BW == 1 );
            
            % Extract ROI fluorescence intensity values
             handles.ROI = zeros( numel( handles.ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

              for f = 1 : handles.Nframes
               temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
               handles.ROI(:,f) = temp_frame( handles.ind );   % Fluorescence values of ROI 
              end
        
               % Add ROI labe automatically
            label = num2str( handles.n );
            pos = handles.h.getPosition();
            x = pos(1) + 1;
            y = pos(2) + 1;
            text( x, y, label, 'Color','red', 'FontWeight','bold' );
            
     end
    
     set( handles.txtStaticText, 'String', 'ROI Done');

 end 

else
    
     % call the figure that is beeing used to draw ROIs
    switch get(get(handles.btnGroupChooseImg,'SelectedObject'),'Tag')
                    
       case 'rbt_ROIMIP'
          figure( handles.ROIMIP_fig );
           
       case 'rbt_ROIStDev'
          figure( handles.Stdev_fig );
          
       case 'rbt_ROIFrame'
          figure( handles.ROIFrame_fig ); 
    end
    
 
 % counter to be able to add more ROIs
 n = numel(handles.h);
 n = n + 1;
 handles.n = n;
 
    switch get(get(handles.btnGroupROIShape,'SelectedObject'),'Tag')
     
         case 'rbt_Freehand'
            
            handles.h(n) = imfreehand;
            handles.BW(:,:,n) = createMask( handles.h(n) );
            handles.ind = find( handles.BW(:,:,n) == 1 );

            % Extract ROI fluorescence intensity values
             handles.ROI = zeros( numel( handles.ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

              for f = 1 : handles.Nframes
               temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
               handles.ROI(:,f) = temp_frame( handles.ind );   % Fluorescence values of ROI 
              end
              
              
         case 'rbt_Rectangle'
            
            handles.h(n) = imrect;
            BW = createMask( handles.h(n) );
            handles.ind = find( BW == 1 );
            
            % Extract ROI fluorescence intensity values
             handles.ROI = zeros( numel( handles.ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

              for f = 1 : handles.Nframes
               temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
               handles.ROI(:,f) = temp_frame( handles.ind );   % Fluorescence values of ROI 
              end
        
              
          case 'rbt_Pixel'
            
            handles.h(n) = impoint;
            BW = createMask( handles.h(n) );
            handles.ind = find( BW == 1 );
            
            % Extract ROI fluorescence intensity values
             handles.ROI = zeros( numel( handles.ind ), handles.Nframes ); % ROI that will be used for ROI Analysis

              for f = 1 : handles.Nframes
               temp_frame = handles.Img(:,:,f); % all fluorescence values for a certain frame
               handles.ROI(:,f) = temp_frame( handles.ind );   % Fluorescence values of ROI 
              end
    end
    
 
end

end

 
