function [handles, ppmBinning_value] = Binning(handles)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% Import n from ppmBinning
 contents = get(handles.ppmBinning,'String'); 
 ppmBinning_value = contents{get(handles.ppmBinning,'Value')};
 
 if ppmBinning_value == '2 x 2' 
     n = 2;     
 else     
     n = 4;     
 end
 

% Define function to apply the pixel processing

 fun = @(block_struct) sum( block_struct.data );

 r_Img = blockproc( handles.Img, [n 1], fun);
 handles.Img_bng = blockproc( r_Img, [1 n], fun ); % image with selescted binning (bng)

 Visualize_Tiff_Stack( handles.Img_bng );
 
 handles.Img = handles.Img_bng; % Updates original File
 
 set( handles.txtStaticText, 'String', 'Binning Done' );
 

end

