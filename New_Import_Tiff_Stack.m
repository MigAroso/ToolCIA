function [Img, Img_File, SizeX, SizeY, Nframes ] = New_Import_Tiff_Stack( filename )

 Img_File = filename;

 InfoImage = imfinfo( Img_File );
 InfoImage = rmfield(InfoImage,'UnknownTags');
 
 SizeX = InfoImage(1).Width;
 
 SizeY = InfoImage(1).Height;
 
 Nframes = length( InfoImage );
 
 Img = zeros( SizeY,SizeX,Nframes,'double' );
 
  
%  TifLink = Tiff( Img_File, 'r' );
 

for i=1 : Nframes
    
   Img(:,:,i) = imread(Img_File,'Index',i);
%    Img(:,:,l)=double(Img); 
%    TifLink.setDirectory(i);
   
%    Img(:,:,i) = TifLink.read();
   
end

% TifLink.close();


end