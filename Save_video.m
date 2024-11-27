function [ ] = Save_video( Img, FrameStep )
% Converts a tiff stack visualized with Visualize_Tiff_Stack.m into a video file 
%   Exports a video file that can be used for e.g. .ppt

% 
%     s = size( Img );
%     if numel(s) > 2
%         Nstacks = s(3);
%     else
%         Nstacks = 1;
%     end
%     if numel(s) > 3
%         Nframes = s(4);
%     else
%         Nframes = 1;
%     end       


  [filename, pathname] = uiputfile('*.avi','Save file name');

  Nframes = size( Img, 3);
  
   v = VideoWriter( filename );
   v.FrameRate = 1000 / str2double( get( FrameStep, 'String' ) ); % calculates de frame rate in frames per second (1000 ms)
   
    figure ('Name', 'Tiff Stack' ,'NumberTitle','off')
    
    clims = [ min( Img(:) ) max( Img(:) ) ];
%       clims = [min( Img(:) ) 0.10 ];
    
% Change aspect ratio of figure
%     pos = get(gcf,'Position');
%     w = size( Img, 2 ) * 3;
%     h = size( Img, 1 ) * 7;
%     pos(1:4) = [300, 500, w, h];
    set(gcf, 'Units', 'normalized', 'Position', [0.15, 0.3, 0.5, 0.3] );
   
    %hax = axes('Units','pixels', 'Position', [30 90 500 300], 'DataAspectRatio', [1, 10, 1]);
    hax = axes('Units','normalized','Position', [0.05 0.15 0.85 0.75] );
    %set(gcf, 'units','normalized','outerposition',[0 0 1 1]); %Fullscreen
    
    open(v);
    for f = 1 : size( Img, 3)
%       imagesc( Img(:,:,s,f) );
        imagesc( Img(:,:,f), clims );
        axis image
        colormap jet
        colorbar;
   frame = getframe(gcf);
   writeVideo(v,frame);
    end
        
    close(v)
    
%    
    end 


