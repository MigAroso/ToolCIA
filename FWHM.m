function [ w ] = FWHM( x, d )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    d = d / max(d);    
    n = numel( x );   
    
    for k = 2:numel( x )
        if d(k-1) < 0.5 && d(k) > 0.5
            ind_0 = k;
        end
        
        if d(k-1) > 0.5 && d(k) < 0.5
            ind_1 = k;
        end
    end
    
    w = x(ind_1) - x(ind_0);
    
end

