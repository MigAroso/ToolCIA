function [signalprops] = FitSignalParameters( handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % IMPORTANT:
    %   either signal is already form a user-defined ROI (no offset in x)
    %   or ginputs are used to set limits
    %   Check with Miguel best option

    %% Add to toolvia [signalprops] = FitSignalParameters( handles ). 
    
%     Current_Fig_Handle = gcf; %current figure handle
%     [Xdata,Ydata] = Export_Figure_Data(Current_Fig_Handle);
%     close(gcf);

% Creates mask according to selected ROI
 if isfield (handles, 'load_ROI') % indicates that a ROI was loaded and the mask already exists as handles.BW.   
     BW = handles.BW;
     handles.ind = find( BW == 1 );
%      handles = rmfield(handles, 'load_ROI'); % removes the field, so next time this function analysis drawn ROIs
  else
     BW = createMask( handles.h( handles.n ));
%      handles.ind = find( BW == 1 );
 end

    % preallocate container to hold intensity profile
 if get(handles.rbt_SD_None, 'Value' ) == 1 
        Iprofile = zeros( sum( BW(:) ), handles.Nframes );
    else
        Iprofile = zeros( 1, handles.Nframes );
 end
    
    for f = 1:handles.Nframes        
        frame = handles.Img(:,:,f);
        px_val = frame( BW == 1 );

        % Check for selected math function
        % mean
        if get(handles.rbt_SD_Mean, 'Value' ) == 1
            Iprofile(f) = mean( px_val );
        end
        % median
        if get(handles.rbt_SD_Median, 'Value' ) == 1
            Iprofile(f) = median( px_val );
        end
        % maximum
        if get(handles.rbt_SD_Maximum, 'Value' ) == 1
            Iprofile(f) = max( px_val );
        end
        % none
        if get(handles.rbt_SD_None, 'Value' ) == 1
            Iprofile(:,f) = px_val;
        end   
    end
    
     signal.t = handles.timeStamps; % signal.t = Xdata;
     signal.y = Iprofile; % signal.y = Ydata; 
    %%
    
    figure
    plot(signal.t, signal.y)
    
    h = imrect();
    pos = h.getPosition;
    x1 = pos(1);
    x2 = pos(1) + pos(3);
    ind_x1 = round( x1 / (signal.t(2)-signal.t(1)) );
    ind_x2 = round( x2 / (signal.t(2)-signal.t(1)) );
    
    fit_t = signal.t(ind_x1:ind_x2);%signal.t
    fit_t = fit_t - fit_t(1);
    fit_y = signal.y(ind_x1:ind_x2);%signal.t
  
    plot( fit_t, fit_y, '.-r' );
    
    
    % dual exp: g_max/(t_decay - t_rise) * ( exp(-t/t_decay) - exp(-t/t_rise) )
    %           t_rise < t_decay !!!

    
%     %% select region
%     [x1,~] = ginput(1);
%     [x2,~] = ginput(1);
%     
%     ind_x1 = round( x1 / (signal.t(2)-signal.t(1)) );
%     ind_x2 = round( x2 / (signal.t(2)-signal.t(1)) );
%     
%     fit_t = signal.t(ind_x1:ind_x2);signal.t
%     fit_y = signal.y(ind_x1:ind_x2);signal.t
%     
%     %% fit single exp
%     fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [-Inf, 0, -Inf, -Inf], 'Upper', [Inf, Inf, Inf, Inf], 'StartPoint', [1.0, 0.0, 10.0, 0.0] );
%     fit_fun = fittype( 'A * exp( -(t-t0)/tau ) + C0', 'independent', 't', 'options', fit_opt);
%     [fit_obj, gof] = fit( signal.t', signal.y', fit_fun);
% 
%     signalprops.amplitude = fit_obj.A + fit_obj.C0;
%     signalprops.t_decay   = fit_obj.tau;
%     signalprops.duration  = 3.0 * fit_obj.tau;

% a*exp(-t/t1)+b*exp(-t/t2)+c

    %% fit single exp 
    if fit_y(end) > fit_y(1)
        % rising
        fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0, 0, 0], 'Upper', [Inf, Inf, Inf, Inf], 'StartPoint', [1.0, 0.0, 1000.0, 1000.0] );
        fit_fun = fittype( 'A * exp((t-t0)/t_decay) + C0', 'independent', 't', 'options', fit_opt);
    else
        %decaying
        fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0, 0, 0], 'Upper', [Inf, Inf, Inf, Inf], 'StartPoint', [1.0, 0.0, 1000.0, 1000.0] );
        fit_fun = fittype( 'A * exp(-(t-t0)/t_decay) + C0', 'independent', 't', 'options', fit_opt);
    end
    
    [fit_obj, gof] = fit( fit_t', fit_y', fit_fun);

    signalprops.amplitude = max( signal.y ) - fit_obj.C0; %fit_obj.A + fit_obj.C0;
    signalprops.t_decay   = fit_obj.t_decay;
    
    signalprops.fit_t = fit_t;
    signalprops.fit_y = fit_y;

    hold on
    %plot( fit_t, fit_obj.A * exp(-fit_t/fit_obj.t_decay) + fit_obj.C0, 'b' )
    if fit_y(end) > fit_y(1)
        plot( fit_t, fit_obj.A * exp((fit_t-fit_obj.t0)/fit_obj.t_decay) + fit_obj.C0, 'b' )
    else
        plot( fit_t, fit_obj.A * exp(-(fit_t-fit_obj.t0)/fit_obj.t_decay) + fit_obj.C0, 'b' )
    end
    title( num2str( gof.rsquare ) )
    hold off
    
    figure
    findpeaks( fit_y, 'MinPeakProminence', std(fit_y) )

    
    
%     %% fit dual exp
%     fit_opt = fitoptions( 'Method', 'NonlinearLeastSquares', 'Algorithm', 'Trust-Region', 'Lower', [0, 0, 10, 50, -Inf], 'Upper', [Inf, Inf, Inf, Inf, Inf], 'StartPoint', [1.0, 0.0, 1.0, 100.0, 0.0] );
%     fit_fun = fittype( 'A * ( exp(-(t-t0)/t_decay) - exp(-(t-t0)/t_rise) ) + C0', 'independent', 't', 'options', fit_opt);
%     [fit_obj, gof] = fit( fit_t', fit_y', fit_fun);
% 
%     signalprops.amplitude = fit_obj.A + fit_obj.C0;
%     signalprops.t_rise    = fit_obj.t_rise;
%     signalprops.t_decay   = fit_obj.t_decay;
%     signalprops.duration  = 3.0 * ( fit_obj.t_rise + fit_obj.t_decay );
%     
%     signalprops.fit_t = fit_t;
%     signalprops.fit_y = fit_y;


end

