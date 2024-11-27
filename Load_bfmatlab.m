function [ Y ] = Load_bfmatlab( filename )

Img_raw = bfopen( filename );

Y_f = Img_raw{1,1}( 1 : size(Img_raw{1,1},1), 1 );

Y = zeros(size(Y_f{1,1},1), size(Y_f{1,1},2), size(Y_f,1));

for i = 1 : size(Y_f,1)
    
    Y( :, :, i ) = Y_f{i,1};

end

clearvars -except Y

save ('Y', '-v7.3');


end
