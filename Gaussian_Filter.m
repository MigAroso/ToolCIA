function [ handles ] = Gaussian_Filter( handles, sigma )
%Applies a gaussian filter accordingly to user input
%   Detailed explanation goes here


kernel = fspecial( 'gaussian', ceil( 3*sigma ) , sigma);



% MELHORAR, OU COM repmat OU COM convn(?)
 h = waitbar(0, 'Please wait...');
 handles.temp_Img = zeros( size( handles.Img, 1 ), size( handles.Img, 2 ), size( handles.Img, 3 ));
 for f = 1:handles.Nframes
%     handles.Img(:,:,f) = imfilter( handles.Img(:,:,f), kernel, 'replicate' ) ;
    handles.temp_Img(:,:,f) = imfilter( handles.Img(:,:,f), kernel, 'replicate' ) ;
    waitbar( f/handles.Nframes, h);
 end
 close(h);


Visualize_Tiff_Stack( handles.temp_Img )


end

