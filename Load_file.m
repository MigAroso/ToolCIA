function  handles = Load_file(filename, PathName, handles)
%Load data function for TOOlVIA
%   Detailed explanation goes here


% Code to open files sent by Marco Canepari

 [pathstr, name, ext] = fileparts(filename);

   
if ext == '.mat'     
             
    File = fullfile(PathName, filename);
    load(File); 
%     load( [PathName, filename] );
    handles.Nframes = size(Y, 3);
     
     if size(Y, 1) > 80
        % Remove the field called "A", if there is one (in case a file
        % with such field was loaded before).
        % First see if there is a field called "A"
        hasField = isfield(handles, 'A'); % Will be True or False.
        % Now remove it if it's there.
        if hasField
            % Field is there.  Remove it.
            handles = rmfield(handles, 'A');
        end
        
      handles.Img = Y; 
                
     elseif exist('Info','var') == 1
        handles.Img = Y; 
      
     elseif size( Y, 1 ) == 26
         
      handles.Img = Y( :, 1:26, :);
      handles.A = A;
      handles.y = y;
    
     elseif size( Y, 1 ) == 80
      handles.Img = Y( :, :, 16:size(Y,3) ); %remove first frames
      handles.Nframes = size(handles.Img, 3);
      handles.A = A;
      handles.y = y;   
      
     else
        
      handles.Img = Y( :, 27:end, : ); % files from dual camera microscope
      handles.A = A;
      handles.y = y;  
      
     end
    
elseif ext == '.tif' 

    % Code to import tiff stacks     
     
    % IMPORTAR USANDO FUNCOES MAIS RECENTES [PAULO]
%     [Img, SizeX, SizeY, Nstacks, Nframes, z_step , frame_step, px2um] = Import_Microscope_Tiff_Stack( [PathName, filename] );
       
    [ Img, SizeX, SizeY, Nframes ] = New_Import_Tiff_Stack( [PathName, filename] );

    handles.filename = filename;
    handles.PathName = PathName;

    handles.Img = squeeze( Img );
    handles.SizeX = SizeX;
    handles.SizeY = SizeY;
%     handles.Nstacks = Nstacks;
    handles.Nframes = Nframes;
%     handles.z_step = z_step;
%     handles.frame_step = frame_step;
%     handles.px2um = px2um;

else 
    
    Y = Load_bfmatlab( filename );
%     load( Y );
    handles.Img = Y;
    handles.Nframes = size(Y, 3);

 end


end

