function [GC_test] = Calculate_Granger_Causality( handles )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    % but see also
    % https://physionet.org/physiotools/tewp/
    
    
     % counter of the number of ROIs
    n = handles.n;
        
    if handles.n < 2
       set( handles.txtStaticText, 'String', 'First draw at least 2 ROIs!' );
       drawnow 
       
    else
       
       % choose 2 ROIs to compare    
       % Ask user to define which ROIs will be compared
        number_ROI = num2str(handles.n);
        string = ['Choose 2 ROIs to be compared. From 1 to ' number_ROI '. Order is important'];
        string = [ string  newline 'First ROI:'];
        prompt = {string, 'Last ROI:'};
        dlg_title = 'Granger Causality';
        num_lines = 1;
        defaultans = { '1', num2str( number_ROI) };
        answer = inputdlg( prompt, dlg_title, num_lines, defaultans );
        n = str2double( answer );
        n1 = n( 1, 1 );
        n2 = n( 2, 1 );
               
    end
    
    
%     
%     BW1 = createMask( handles.h( n1 ));
%     BW2 = createMask( handles.h( n2 ));
%     
    
%     y1, y2, freq_rate_Hz 
    y1 = handles.Iprofile( n1, : );
    y2 = handles.Iprofile( n2, : );
    significance_level = str2double( get( handles.edt_PA_SignificanceLevel, 'String' ) );
    max_lag = str2double( get( handles.edt_PA_MaxDelay, 'String' )) * ( 1 / str2double( get(handles.edtFrameStep, 'String')) * 1000) ; % max_delay*1.0e-3 * freq_rate_Hz;% take into account frame rate!
    
    [F, c_v] = granger_cause( y1, y2, significance_level, max_lag );

    
    % if F > c_v reject the null hypothesis that y1 does not Granger Cause
    % y2
    if F > c_v
        GC_test = true;
    else
        GC_test = false;
    end
    
end

