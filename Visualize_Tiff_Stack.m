function [ ] = Visualize_Tiff_Stack( Img )
%Visualize_Tiff_Stack Image stack visualization tool
%   Produces ImageJ-like stack visualization in MATLAB
%   Paulo de Castro Aguiar
%   pauloaguiar@ineb.up.pt
%   NCN - Neuroengineering and Computational Neuroscience
%   i3S / INEB; Jan 2016
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

    Nframes = size( Img, 3);

    figure ('Name', 'Tiff Stack' ,'NumberTitle','off')
    
    clims = [min( Img(:) ) max( Img(:) )];
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
    
    imagesc( Img(:,:,1,1), clims );
    axis image
    %set(gca,'YDir','normal')
    colorbar;
    
%     h_stack = uicontrol('Style', 'slider',...
%             'Min',1,'Max',Nstacks,'Value',1,...  
%             'Units','normalized', ...
%             'Position', [0.05 0.10 0.70 0.05],...
%             'SliderStep', [1/Nstacks, 0.1], ...
%             'Callback', @ChangeStack );

    h_frame = uicontrol('Style', 'slider',...
            'Min',1,'Max',Nframes,'Value',1,...
            'Units','normalized', ...
            'Position', [0.10 0.02 0.70 0.05],...
            'SliderStep', [1/Nframes, 0.1], ...
            'Callback', @ChangeFrame );
        
%     h_txt_s = uicontrol('Style', 'text', ...
%             'Units','normalized', ...
%             'Position', [0.80 0.10 0.15 0.05],...
%             'String', 'stack = 1' );
    
    h_txt_f = uicontrol('Style', 'text', ...
            'Units','normalized', ...
            'Position', [0.80 0.02 0.15 0.05],...
            'String', 'frame = 1' );
        

%     function ChangeStack( hObject, eventdata, handles )
%         s = round( get( h_stack, 'Value' ) );
%         f = round( get( h_frame, 'Value' ) );
%         set( h_txt_s, 'String', ['stack = ', num2str(s)] );
%         imagesc( Img(:,:,s,f) );
%         axis image
%         %set(gca,'YDir','normal')
%         colorbar;
%     end 


    function ChangeFrame( hObject, eventdata, handles )
%         s = round( get( h_stack, 'Value' ) );
        f = round( get( h_frame, 'Value' ) );
        set( h_txt_f, 'String', ['frame = ', num2str(f)] );
%         imagesc( Img(:,:,s,f) );
        imagesc( Img(:,:,f), clims );
        axis image
        %set(gca,'YDir','normal')
        colorbar;
    end 


end

