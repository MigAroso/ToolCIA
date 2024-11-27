%% DATA FROM TIFF
% filename = 'G11_F1_706_50_1ms_B2_NoSt_MMStack_Pos0.ome.tif';
filename = '40X_200ms_150f_100MHz_water_MMStack_Pos0.ome.tif';

metadata = imfinfo( filename );

Nframes = numel( metadata );
timestamps_TIFF_ms = zeros( Nframes, 1 );

% template for finding the TimeStampMsec values
expression = 'TimeStampMsec":"(\d+(\.\d*)?|\.\d+)"';

for f = 1:Nframes    
    
    garbage = [ metadata(f).UnknownTags.Value ];    
    % search in garbage using regular expressions
    gems = regexpi( garbage , expression, 'match' );
    gem = gems{1};
    %gem(17:end-1)
    timestamps_TIFF_ms(f) = str2double( gem(17:end-1) );
    
end


%% DATA FROM TIMESTAMPS FILE
filename = 'G11_F1_706_50_1ms_B2_NoSt_MMStack_Pos0_metadata.txt';

garbage = fileread( filename );

% template for finding the TimeStampMsec values
expression = 'TimeStampMsec": "(\d+(\.\d*)?|\.\d+)"';

gems = regexpi( garbage , expression, 'match' );

Nframes = numel( gems );
timestamps_FILE_ms = zeros( Nframes, 1 );

for f = 1:Nframes
    
    gem = gems{f};
    %gem(18:end-1)
    timestamps_FILE_ms(f) = str2double( gem(18:end-1) );
    
end


%% CHECK DIFFERENCES
figure
plot( timestamps_TIFF_ms - timestamps_FILE_ms, 'r' )





