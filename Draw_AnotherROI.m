function  [ handles ] = Draw_AnotherROI( handles )

   if isfield(handles, 'load_ROI')
%          label = 'Loaded';
         handles = rmfield(handles, 'load_ROI'); % removes the field, so nest time this function analysis drawn ROIs
    end

 if ~isfield ( handles, 'h' )
     
    set( handles.txtStaticText, 'String', 'First draw a ROI by choosing the type of Image and ROI shape.' );
    drawnow

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
    
 end
 
 % counter to be able to add more ROIs
 n = numel(handles.h);
 n = n + 1;
 handles.n = n; %keep last 'n' on memory
 
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
              
              % Add ROI label automatically
            label = num2str( handles.n );
            pos = handles.h(n).getPosition();
            polyin = polyshape( pos, 'simplify', false );
            polyin = simplify( polyin );
            [ xCentroid, yCentroid ] = centroid( polyin );
            text( xCentroid, yCentroid, label, 'Color','red', 'FontWeight','bold' );
              
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
              
               % Add ROI label automatically
            label = num2str( handles.n );
            pos = handles.h(n).getPosition();
            xCentroid = pos(1) + pos(3)/2;
            y = pos(2) + pos(4)/2;
            text( xCentroid, y, label, 'Color','red', 'FontWeight','bold' );
        
              
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
              
               % Add ROI label automatically
            label = num2str( handles.n );
            pos = handles.h(n).getPosition();
            x = pos(1) + 1;
            y = pos(2) + 1;
            text( x, y, label, 'Color','red', 'FontWeight','bold' );
    end
    
set( handles.txtStaticText, 'String', 'ROI Done');

end

 
