function [  ] = MIP( Img )
% Maximum Intensity Projection (MIP)
%   Projects the voxel with the highest intensity value throughout the volume onto a 2D image

 Img_MIP = max( Img, [], 3 );

figure ('Name', 'Maximum Intensity Projection - MIP' ,'NumberTitle','off');

% Change aspect ratio of figure
%     pos = get(gcf,'Position');
%     w = size( Img, 2 ) * 3;
%     h = size( Img, 1 ) * 7;
%     pos(1:4) = [300, 500, w, h];
%     set(gcf,'Position',pos);
    
    set(gcf, 'Units', 'normalized', 'Position', [0.15, 0.45, 0.5, 0.3] );

    %hax = axes('Units','pixels', 'Position', [30 90 500 300], 'DataAspectRatio', [1, 10, 1]);
    hax = axes('Units','normalized','Position', [0.05 0.15 0.90 0.75] );
    
 imagesc(Img_MIP)
 axis 'image'
 colorbar;

end

